# Define the root path
$rootPath = "F:\github\docker-full-stack\ansible"

# Create the directory structure
$structure = @(
    # Inventory
    "inventories\production\group_vars",
    "inventories\staging",
    
    # Roles
    "roles\alpine_base\tasks",
    "roles\alpine_base\templates",
    "roles\alpine_hardening\tasks",
    "roles\alpine_hardening\templates",
    "roles\user_admin\tasks",
    "roles\user_admin\vars",
    "roles\docker_ce\tasks",
    
    # Playbooks and other files
    "playbooks",
    "group_vars",
    "files\ssh",
    "files\banners"
)

# Create all directories
foreach ($dir in $structure) {
    $fullPath = Join-Path -Path $rootPath -ChildPath $dir
    if (-not (Test-Path $fullPath)) {
        New-Item -ItemType Directory -Path $fullPath -Force | Out-Null
    }
}

# Create empty files
$files = @(
    # Inventory files
    "inventories\production\hosts.ini",
    "inventories\production\group_vars\alpine_nodes.yml",
    
    # Role files
    "roles\alpine_base\tasks\main.yml",
    "roles\alpine_base\tasks\timezone.yml",
    "roles\alpine_base\tasks\motd.yml",
    "roles\alpine_base\templates\hosts.j2",
    "roles\alpine_hardening\tasks\sshd.yml",
    "roles\alpine_hardening\tasks\fail2ban.yml",
    "roles\alpine_hardening\tasks\sudoers.yml",
    "roles\alpine_hardening\templates\sshd_config.j2",
    "roles\alpine_hardening\templates\banner.j2",
    "roles\user_admin\tasks\main.yml",
    "roles\user_admin\tasks\keys.yml",
    "roles\user_admin\vars\main.yml",
    "roles\docker_ce\tasks\main.yml",
    
    # Playbooks and config files
    "playbooks\provision.yml",
    "playbooks\secure.yml",
    "group_vars\all.yml",
    "ansible.cfg",
    "README.md"
)

# Create all empty files
foreach ($file in $files) {
    $fullPath = Join-Path -Path $rootPath -ChildPath $file
    if (-not (Test-Path $fullPath)) {
        New-Item -ItemType File -Path $fullPath -Force | Out-Null
    }
}

Write-Host "Ansible file structure created successfully at $rootPath" -ForegroundColor Green