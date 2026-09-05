pkgname=grub-efi
pkgver=2.14
pkgrel=1
description="GRUB bootloader with EFI support (Installs only EFI modules over LFS GRUB)"
arch=('amd64')
url="https://www.gnu.org/software/grub/"
source=("https://ftp.gnu.org/gnu/grub/grub-${pkgver}.tar.xz")
sha256sums=('SKIP')

build() {
    cd "${srcdir}/grub-${pkgver}"

    # BLFS Warning: Unset any environment variables which may affect the build.
    # Aggressive optimizations will break the bootloader.
    unset CFLAGS CPPFLAGS CXXFLAGS LDFLAGS

    # Configure specifically for x86_64 EFI platform
    ./configure --prefix=/usr \
                --sysconfdir=/etc \
                --disable-efiemu \
                --with-platform=efi \
                --target=x86_64 \
                --disable-werror
    
    make -j$(nproc)
}

package() {
    cd "${srcdir}/grub-${pkgver}"

    # "If you've not skipped LFS GRUB package, as the root user, only install 
    # the components not installed from the LFS GRUB package instead:"
    make -C grub-core DESTDIR="${pkgdir}" install
}
