pkgname=make; pkgver=4.4.1; source=("https://ftp.gnu.org/gnu/make/make-${pkgver}.tar.gz")
build(){ cd make-${pkgver}; ./configure --prefix=/usr; make -j$(nproc); }
package(){ cd make-${pkgver}; make DESTDIR=$pkgdir install; }
