#!/bin/bash

OUTDIR="mlfs-final-chapters-pacscripts"
mkdir -p "$OUTDIR"
cd "$OUTDIR" || exit 1

echo "Generating MLFS Final Chapters (9, 10, 11) packages targeting /mnt/lfs..."

awk '
/^#PKG: / {
    pkg = $2
    system("mkdir -p " pkg)
    out = pkg "/" pkg ".pacscript"
    print "Creating " out "..."
    next
}
{
    if (out) print $0 > out
}
' << 'EOF_DATA'
#PKG: linux-firmware
pkgname=linux-firmware
pkgver=20240811
source=("https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/snapshot/linux-firmware-${pkgver}.tar.gz")
build(){ :; }
package(){ cd linux-firmware-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs FIRMWAREDIR=/usr/lib/firmware install; }

#PKG: lfs-system-config
pkgname=lfs-system-config
pkgver=13.0
description="Generates Chapter 9 System Configurations (network, hosts, locale, fstab)"
source=()
build(){ :; }
package(){ 
    mkdir -p $pkgdir/mnt/lfs/etc/systemd/network
    mkdir -p $pkgdir/mnt/lfs/etc
    
    # Systemd Network DHCP Config
    cat > $pkgdir/mnt/lfs/etc/systemd/network/10-eth-dhcp.network << "EOF"
[Match]
Name=en*
[Network]
DHCP=ipv4
EOF
    
    # Hosts file
    cat > $pkgdir/mnt/lfs/etc/hosts << "EOF"
127.0.0.1  localhost
::1        localhost
EOF
    
    # Hostname, Locale, Console
    echo "lfs-multilib" > $pkgdir/mnt/lfs/etc/hostname
    echo "LANG=en_US.UTF-8" > $pkgdir/mnt/lfs/etc/locale.conf
    echo "KEYMAP=us" > $pkgdir/mnt/lfs/etc/vconsole.conf
    
    # Base fstab
    cat > $pkgdir/mnt/lfs/etc/fstab << "EOF"
# file system  mount-point  type     options             dump  fsck
# /dev/sda2    /            ext4     defaults            1     1
proc           /proc        proc     nosuid,noexec,nodev 0     0
sysfs          /sys         sysfs    nosuid,noexec,nodev 0     0
devpts         /dev/pts     devpts   gid=5,mode=620      0     0
tmpfs          /run         tmpfs    defaults            0     0
devtmpfs       /dev         devtmpfs mode=0755,nosuid    0     0
EOF
}

#PKG: lfs-grub-config
pkgname=lfs-grub-config
pkgver=13.0
description="Generates Chapter 10 GRUB basic configuration file"
source=()
build(){ :; }
package(){
    mkdir -p $pkgdir/mnt/lfs/boot/grub
    cat > $pkgdir/mnt/lfs/boot/grub/grub.cfg << "EOF"
# Begin /boot/grub/grub.cfg
set default=0
set timeout=5

insmod ext2
# set root=(hd0,2)

menuentry "GNU/Linux, Linux From Scratch (Multilib)" {
    linux   /boot/vmlinuz-6.18.10-lfs root=/dev/sda2 ro
}
EOF
}

#PKG: lfs-os-release
pkgname=lfs-os-release
pkgver=13.0
description="Generates Chapter 11 OS Release files"
source=()
build(){ :; }
package(){
    mkdir -p $pkgdir/mnt/lfs/etc
    echo "13.0-m32-systemd" > $pkgdir/mnt/lfs/etc/lfs-release
    cat > $pkgdir/mnt/lfs/etc/os-release << "EOF"
NAME="Linux From Scratch"
VERSION="13.0-m32-systemd"
ID=lfs
PRETTY_NAME="Multilib Linux From Scratch 13.0-systemd"
VERSION_CODENAME="lfs"
EOF
}

#PKG: mlfs-final-meta
pkgname=mlfs-final-meta
pkgver=13.0
description="Installs all final LFS configurations and firmware to /mnt/lfs"
depends=('linux-firmware' 'lfs-system-config' 'lfs-grub-config' 'lfs-os-release')
build(){ :; }
package(){ :; }
EOF_DATA

echo "Done! MLFS final chapters successfully packed into 'mlfs-final-chapters-pacscripts'."
