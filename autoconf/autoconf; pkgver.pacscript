pkgname=autoconf; pkgver=2.72; source=("https://ftp.gnu.org/gnu/autoconf/autoconf-${pkgver}.tar.xz")
build(){ cd autoconf-${pkgver}; ./configure --prefix=/usr; make -j$(nproc); }
package(){ cd autoconf-${pkgver}; make DESTDIR=$pkgdir install; }
