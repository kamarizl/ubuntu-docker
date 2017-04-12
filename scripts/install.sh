#!/bin/bash -eux

SSH_USER=${SSH_USERNAME:-docker}

 # Set up sudo
echo "==> Giving ${SSH_USER} sudo powers"
echo "${SSH_USER}        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers.d/$SSH_USER
chmod 440 /etc/sudoers.d/$SSH_USER

DEBIAN_FRONTEND=noninteractive

#
echo "==> Installing VirtualBox guest additions"
apt-get update -y
apt-get install -y linux-headers-$(uname -r) build-essential perl
apt-get install -y dkms
mount -o loop /home/${SSH_USER}/VBoxGuestAdditions.iso /mnt
sh /mnt/VBoxLinuxAdditions.run
umount /mnt
rm /home/${SSH_USER}/VBoxGuestAdditions.iso
rm /home/${SSH_USER}/.vbox_version

# Fix stdin not being a tty
if grep -q -E "^mesg n$" /root/.profile && sed -i "s/^mesg n$/tty -s \\&\\& mesg n/g" /root/.profile; then
    echo "==> Fixed stdin not being a tty."
fi

echo "==> Cleaning up tmp"
rm -rf /tmp/*

# Cleanup apt cache
apt-get -y autoremove --purge
apt-get -y clean
apt-get -y autoclean

#
# # Remove Bash history
# unset HISTFILE
# rm -f /root/.bash_history
# rm -f /home/${SSH_USER}/.bash_history
#
# Clean up log files
find /var/log -type f | while read f; do echo -ne '' > "${f}"; done;

# echo "==> Clearing last login information"
# >/var/log/lastlog
# >/var/log/wtmp
# >/var/log/btmp