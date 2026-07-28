#!/bin/bash

set -ouex pipefail

# Copy the contents of system_files/ of the git repo to /
cp -avf "/ctx/system_files"/. /

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/43/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from centos repos
# dnf5 install -y tmux

# Gnome minimal desktop
dnf -y --setopt=install_weak_deps=False install NetworkManager-wifi PackageKit-command-not-found PackageKit-gtk3-module audit at-spi2-atk at-spi2-core avahi avahi-tools bpftool  \
    centos-backgrounds dconf dnsmasq firewalld.noarch fprintd-pam git-core git-core-doc gdm glib-networking  glibc-all-langpacks gnome-bluetooth gnome-browser-connector  \
    gnome-color-manager gnome-control-center gnome-disk-utility gnome-initial-setup gnome-session-wayland-session gnome-settings-daemon \
    gnome-shell gnome-shell-extension-background-logo gnome-software gvfs-fuse gvfs-goa gvfs-gphoto2 gvfs-mtp gvfs-smb iw iwlwifi-dvm-firmware.noarch \
    iw.x86_64 iwlwifi-mvm-firmware libcanberra-gtk3 librsvg2 mesa-dri-drivers mesa-vulkan-drivers nautilus orca plymouth-system-theme polkit ptyxis rsync realmd \
    smartmontools.x86_64 tracker tracker-miners xdg-desktop-portal xdg-desktop-portal-gnome xdg-desktop-portal-gtk xdg-user-dirs-gtk yelp-tools vim-enhanced.x86_64

# Fonts
dnf -y --setopt=install_weak_deps=False install default-fonts-cjk-mono default-fonts-cjk-sans default-fonts-cjk-serif default-fonts-core-emoji default-fonts-core-math \
   default-fonts-core-mono default-fonts-core-sans default-fonts-core-serif default-fonts-other-mono default-fonts-other-sans default-fonts-other-serif dejavu-sans-fonts \
   dejavu-sans-mono-fonts dejavu-serif-fonts google-carlito-fonts google-crosextra-caladea-fonts google-droid-sans-fonts google-droid-sans-mono-fonts \
   google-droid-serif-fonts google-noto-emoji-fonts google-noto-fonts-all google-noto-sans-cjk-fonts google-roboto-slab-fonts pt-sans-fonts \
   redhat-display-vf-fonts redhat-mono-vf-fonts redhat-text-vf-fonts

# Guest Desktop Agents
dnf -y --setopt=install_weak_deps=False install hyperv-daemons open-vm-tools-desktop qemu-guest-agent spice-vdagent

#  Pacakges to remove
dnf -y remove subscription-manager subscription-manager-rhsm-certificates

# shall be installed from EPEL repository to be added later
# dnf -y install NetworkManager-openconnect.x86_64 NetworkManager-openconnect-gnome.x86_64 NetworkManager-openvpn.x86_64 NetworkManager-openvpn-gnome.x86_64

# useful for secure archive.
# dnf -y install restic.x86_64 

# intall podman-compose
# pip3 install podman-compose

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging


dnf -y autoremove

#### Example for enabling a System Unit File

systemctl enable podman.socket
