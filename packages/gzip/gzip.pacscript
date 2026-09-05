pkgname=gzip; pkgver=1.14; source=("https://ftp.gnu.org/gnu/gzip/gzip-${pkgver}.tar.xz")
build(){ cd gzip-${pkgver}; ./configure --prefix=/usr; make -j$(nproc); }
package(){ cd gzip-${pkgver}; make DESTDIR=$pkgdir install; }
