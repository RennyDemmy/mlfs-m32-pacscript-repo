pkgname=inetutils; pkgver=2.7; source=("https://ftp.gnu.org/gnu/inetutils/inetutils-${pkgver}.tar.xz")
build(){ cd inetutils-${pkgver}; ./configure --prefix=/usr --disable-servers; make -j$(nproc); }
package(){ cd inetutils-${pkgver}; make DESTDIR=$pkgdir install; }
