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
dnf -y install git-core git-core-doc hunspell.x86_64 iw wlwifi-dvm-firmware.noarch iw.x86_64 iwlwifi-mvm-firmware.noarch kernel-modules-extra.x86_64 \
wpa_supplicant.x86_64
dnf -y remove gnome-calculator.x86_64 gnome-characters.x86_64 gnome-clocks.x86_64 gnome-color-manager.x86_64 \
gnome-font-viewer.x86_64 gnome-remote-desktop.x86_64 gnome-system-monitor.x86_64 \
gnome-text-editor.x86_64 gnome-tour.x86_64 gnome-user-docs.noarch sane-backends.x86_64

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging


dnf -y autoremove

#### Example for enabling a System Unit File

systemctl enable podman.socket
