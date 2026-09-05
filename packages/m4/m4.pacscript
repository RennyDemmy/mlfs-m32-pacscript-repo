pkgname=m4; pkgver=1.4.21; source=("https://ftp.gnu.org/gnu/m4/m4-${pkgver}.tar.xz")
build(){ cd m4-${pkgver}; ./configure --prefix=/usr; make -j$(nproc); }
package(){ cd m4-${pkgver}; make DESTDIR=$pkgdir install; }
