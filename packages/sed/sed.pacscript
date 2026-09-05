pkgname=sed; pkgver=4.9; source=("https://ftp.gnu.org/gnu/sed/sed-${pkgver}.tar.xz")
build(){ cd sed-${pkgver}; ./configure --prefix=/usr; make -j$(nproc); }
package(){ cd sed-${pkgver}; make DESTDIR=$pkgdir install; }
