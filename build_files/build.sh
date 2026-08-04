#!/bin/bash

set -ouex pipefail

# Copy the contents of system_files/ of the git repo to /
cp -avf "/ctx/system_files"/. /

### Install / remove packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/43/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from centos repos
# dnf5 install -y tmux

# Install Additional Packages
/ctx/build_files/base/dnf-operation.sh

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
