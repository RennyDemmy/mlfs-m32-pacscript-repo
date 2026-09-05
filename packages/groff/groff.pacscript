pkgname=groff; pkgver=1.23.0; source=("https://ftp.gnu.org/gnu/groff/groff-${pkgver}.tar.gz")
build(){ cd groff-${pkgver}; PAGE=A4 ./configure --prefix=/usr; make -j$(nproc); }
package(){ cd groff-${pkgver}; make DESTDIR=$pkgdir install; }
