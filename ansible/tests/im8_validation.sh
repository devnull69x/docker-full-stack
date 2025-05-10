#!/bin/bash
# tests/im8_validation.sh - Singapore IM8 Compliance Checks
# Version: 1.0
# Usage: ./im8_validation.sh [--verbose] [--remediate]
# # Basic validation
# ./tests/im8_validation.sh

# # Verbose output
# ./tests/im8_validation.sh --verbose

# # Auto-remediate failures
# ./tests/im8_validation.sh --remediate

# # View logs
# tail -f /var/log/im8_validation_*.log

# Configuration
AUDIT_RULES_MIN=5
DOCKER_PROFILE="docker-hardened"
LOG_FILE="/var/log/im8_validation_$(date +%Y%m%d).log"

# Initialize counters
PASS=0
FAIL=0
REMEDIATED=0

# Parse arguments
VERBOSE=false
REMEDIATE=false
while [[ $# -gt 0 ]]; do
    case $1 in
        --verbose) VERBOSE=true ;;
        --remediate) REMEDIATE=true ;;
        *) echo "Unknown option: $1" >&2; exit 1 ;;
    esac
    shift
done

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a $LOG_FILE
}

check_im8_4_1() {
    # IM8 4.1 - System Hardening
    local passed=true
    
    # Check kernel parameters
    if ! sysctl kernel.yama.ptrace_scope | grep -q "1"; then
        log "FAIL [IM8-4.1] kernel.yama.ptrace_scope not set to 1"
        passed=false
        if $REMEDIATE; then
            sysctl -w kernel.yama.ptrace_scope=1
            log "REMEDIATED: Set kernel.yama.ptrace_scope=1"
            ((REMEDIATED++))
        fi
    fi

    # Check Docker AppArmor profile
    if docker info --format '{{.SecurityOptions}}' | grep -q "apparmor=$DOCKER_PROFILE"; then
        log "PASS [IM8-4.1] Docker AppArmor profile enabled"
    else
        log "FAIL [IM8-4.1] Missing Docker AppArmor profile"
        passed=false
    fi

    $passed && ((PASS++)) || ((FAIL++))
}

check_im8_6_2() {
    # IM8 6.2 - Audit Logging
    local audit_rules=$(auditctl -l | grep -c 'docker')
    if [ $audit_rules -ge $AUDIT_RULES_MIN ]; then
        log "PASS [IM8-6.2] Found $audit_rules Docker audit rules"
        ((PASS++))
    else
        log "FAIL [IM8-6.2] Insufficient Docker audit rules ($audit_rules/$AUDIT_RULES_MIN)"
        ((FAIL++))
        if $REMEDIATE; then
            cp templates/etc/audit/rules.d/im8.j2 /etc/audit/rules.d/im8.rules
            augenrules --load
            log "REMEDIATED: Reinstalled IM8 audit rules"
            ((REMEDIATED++))
        fi
    fi
}

# Main execution
echo "Starting IM8 Compliance Validation at $(date)" > $LOG_FILE

check_im8_4_1
check_im8_6_2

# Summary report
log "RESULTS: $PASS passed, $FAIL failed, $REMEDIATED remediated"
exit $FAIL