#!/bin/sh
#
###############################################
# Linode setup requirements (UDF's)
###############################################
#<UDF name="fqdn" Label="Hostname (FQDN)" example="web.example.com" />
#<UDF name="timezone" Label="Your timezone" example="Australia/Sydney (see a list at  https://en.wikipedia.org/wiki/List_of_tz_database_time_zones)" />
#<UDF name="user" Label="Create sudo user" example="username" />
#<UDF name="password" Label="Sudo user password" example="strongPassword" />
#<UDF name="pubkey" Label="SSH pubkey (installed for root and sudo user)?" example="ssh-rsa ..." />
#<UDF name="sshport" Label="SSH port" example="Ports below 1024 are generally considered to be more secure as they require root (or root privileges), whereas ports from 1024 could be run by an untrusted (possibly rogue) user on the server." />
#<UDF name="allowuser" Label="Restrict login to this user [y/n]" default="y" example="" />
#<UDF name="swarminit" Label="Main swarm manager node [y/n]" default="y" example="If this is not setup as the main swarm node you will need to add extra nodes manually once server is spun up." />
###############################################
# Built for Alpine Linux v3.10
###############################################
# Update the package list
apk update && apk upgrade
# Get IP address
IP=`ip route get 1 | egrep -o 'src [[:digit:]]{1,3}\.[[:digit:]]{1,3}\.[[:digit:]]{1,3}\.[[:digit:]]{1,3}' | awk '{print $2;exit}'`
INTERFACE=`cat /etc/network/interfaces | egrep "iface .* static" | awk '{print $2;exit}'`
# Set hostname and FQDN - Source : https://wiki.alpinelinux.org/wiki/Configure_Networking
if [ -n "${FQDN+set}" ]; then
  HOSTNAME=`echo $FQDN | awk -F . '{print $1;exit}'`
  echo $HOSTNAME > /etc/hostname
  hostname -F /etc/hostname
  echo $IP $FQDN $HOSTNAME | tee -a /etc/hosts
fi
# Set timezone - Source : https://wiki.alpinelinux.org/wiki/Setting_the_timezone
apk add tzdata
cp /usr/share/zoneinfo/$TIMEZONE /etc/localtime
echo $TIMEZONE > /etc/timezone
apk del tzdata
# Automatic update
cat > /etc/periodic/daily/auto_update << EOF
#!/bin/sh
apk update -q && apk upgrade -q
EOF
chmod a+x /etc/periodic/daily/auto_update
# Sed - See https://www.grymoire.com/unix/Sed.html#uh-0
#   - The character after the s is the delimiter; eg /
# Add sudo user
apk add sudo
addgroup sudo
adduser -D $USER
adduser $USER sudo
echo "$USER:$PASSWORD" | chpasswd
echo "alpine ALL=(ALL) ALL" >> "/etc/sudoers"
# Security - SSH access
mkdir -p /home/$USER/.ssh
echo "$PUBKEY" >> /home/$USER/.ssh/authorized_keys
chmod -R 700 /home/${USER}/.ssh
chown -R ${USER}:${USER} /home/${USER}/.ssh
sed -i.$(date "+%F_%T").bak "s|#Port 22|Port $SSHPORT|" /etc/ssh/sshd_config # Backup config & change port
sed -i "s|#LogLevel INFO|LogLevel VERBOSE|" /etc/ssh/sshd_config
sed -i -e "s|PermitRootLogin yes|PermitRootLogin no|" /etc/ssh/sshd_config
if [ "$ALLOWUSER" == "y" ] ; then
  sed -i "/PermitRootLogin/ a AllowUsers $USER" /etc/ssh/sshd_config # a: append
fi
sed -i -e "s|#*PasswordAuthentication [no]*[yes]*|PasswordAuthentication no|" /etc/ssh/sshd_config
#echo 'AddressFamily inet' | tee -a /etc/ssh/sshd_config # IPv4 only
sed -i "s|#Banner none|Banner /etc/ssh/banner|" /etc/ssh/sshd_config
# Banner
#cat << EOT > /etc/ssh/banner
cat > /etc/ssh/banner << EOF
###############################################################
#         Welcome to $FQDN
#       All connections are monitored and recorded
#  Disconnect IMMEDIATELY if you are not an authorized user!
###############################################################
EOF
# Remove default Alpine login message
echo "" > /etc/motd
# Security - Fail2Ban
#   [Fail2Ban - Alpine](https://wiki.alpinelinux.org/wiki/Fail2ban)
#   Config Ref: [jail.conf man page, Mankier](https://www.mankier.com/5/jail.conf)
apk add fail2ban
rc-update add fail2ban # Enable service
/etc/init.d/fail2ban start # Start the fail2ban service immediately and create configuration files
rc-status # List services to verify fail2ban is enabled
# Add ssh key filter (part 1)
cat > /etc/fail2ban/jail.d/alpine-ssh.local << EOF
[sshd]
enabled  = true
filter   = alpine-sshd
port     = ssh
logpath  = /var/log/messages
maxretry = 2
[sshd-ddos]
enabled  = true
filter   = alpine-sshd-ddos
port     = ssh
logpath  = /var/log/messages
maxretry = 2
[sshd-key]
enabled  = true
filter   = alpine-sshd-key
port     = ssh
logpath  = /var/log/messages
maxretry = 2
EOF
# Add ssh key filter (part 2)
cat > /etc/fail2ban/filter.d/alpine-sshd-key.local << EOF
# Fail2Ban filter for openssh for Alpine
#
# Filtering login attempts with PasswordAuthentication No in sshd_config.
#
[INCLUDES]
# Read common prefixes. If any customizations available -- read them from
# common.local
before = common.conf
[Definition]
_daemon = sshd
failregex = (Connection closed by|Disconnected from) authenticating user .* <HOST> port \d* \[preauth\]
ignoreregex =
[Init]
# "maxlines" is number of log lines to buffer for multi-line regex searches
maxlines = 10
EOF
# Restart Fail2Ban
/etc/init.d/fail2ban restart
# Restart SSH
rc-service sshd restart
# Install Docker
apk add docker
apk update
rc-update add docker boot # Start the Docker daemon at boot
addgroup $USER docker # Add user to the docker group
service docker start
# Allow Docker daemon to warm up or you get connection error
sleep 10