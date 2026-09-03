pkgname=tar; pkgver=1.35; source=("https://ftp.gnu.org/gnu/tar/tar-${pkgver}.tar.xz")
build(){ cd tar-${pkgver}; ./configure --prefix=/usr; make -j$(nproc); }
package(){ cd tar-${pkgver}; make DESTDIR=$pkgdir install; }
