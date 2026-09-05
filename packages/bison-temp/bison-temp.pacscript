pkgname=bison-temp; pkgver=3.8.2; source=("https://ftp.gnu.org/gnu/bison/bison-${pkgver}.tar.xz")
build(){ cd bison-${pkgver}; ./configure --prefix=/usr; make -j$(nproc); }
package(){ cd bison-${pkgver}; make DESTDIR=$pkgdir install; }
