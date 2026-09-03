pkgname=automake; pkgver=1.18.1; source=("https://ftp.gnu.org/gnu/automake/automake-${pkgver}.tar.xz")
build(){ cd automake-${pkgver}; ./configure --prefix=/usr; make -j$(nproc); }
package(){ cd automake-${pkgver}; make DESTDIR=$pkgdir install; }
