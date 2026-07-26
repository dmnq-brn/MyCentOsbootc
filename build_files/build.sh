#!/bin/bash

set -ouex pipefail

# Copy the contents of system_files/ of the git repo to /
cp -avf "/ctx/system_files"/. /

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/43/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
# dnf5 install -y tmux
dnf -y --setopt=install_weak_deps=False group install GNOME
dnf -y install NetworkManager-wifi.x86_64 audit.x86_64 bpftool.x86_64 dnsmasq.x86_64 firewalld.noarch git-core.x86_64 git-core-doc.noarch \
hyperv-daemons.x86_64 ibus-typing-booster.noarch iw iwlwifi-dvm-firmware.noarch iw.x86_64 iwlwifi-mvm-firmware.noarch \
kernel-modules-extra.x86_64 mcelog.x86_64 nm-connection-editor.x86_64 open-vm-tools.x86_64 open-vm-tools-desktop.x86_64 \
pcsc-lite.x86_64 pinentry.x86_64 qemu-guest-agent.x86_64 realmd.x86_64 rsync.x86_64 smartmontools.x86_64 \
vim-enhanced.x86_64
# Should exist somwhere to be added later
# dnf -y install NetworkManager-openconnect.x86_64 NetworkManager-openconnect-gnome.x86_64 NetworkManager-openvpn.x86_64 NetworkManager-openvpn-gnome.x86_64

# useful for secure archive.
# dnf -y install restic.x86_64 
dnf -y remove NetworkManager-adsl.x86_64 baobab.x86_64 gnome-calculator.x86_64 gnome-characters.x86_64 gnome-clocks.x86_64 gnome-color-manager.x86_64 papers.x86_64 \
gnome-font-viewer.x86_64 gnome-remote-desktop.x86_64 gnome-system-monitor.x86_64 \
gnome-text-editor.x86_64 gnome-tour.x86_64 gnome-user-docs.noarch sane-backends.x86_64 loupe.x86_64 subscription-manager.x86_64

# intall podman-compose
pip3 install podman-compose

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging


dnf -y autoremove

#### Example for enabling a System Unit File

systemctl enable podman.socket
