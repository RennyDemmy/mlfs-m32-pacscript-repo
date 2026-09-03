pkgname=grub; pkgver=2.14; source=("https://ftp.gnu.org/gnu/grub/grub-${pkgver}.tar.xz")
build(){ cd grub-${pkgver}; ./configure --prefix=/usr --sysconfdir=/etc --disable-efiemu --disable-werror; make -j$(nproc); }
package(){ cd grub-${pkgver}; make DESTDIR=$pkgdir install; }
