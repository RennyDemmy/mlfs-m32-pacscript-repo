pkgname=patch; pkgver=2.8; source=("https://ftp.gnu.org/gnu/patch/patch-${pkgver}.tar.xz")
build(){ cd patch-${pkgver}; ./configure --prefix=/usr; make -j$(nproc); }
package(){ cd patch-${pkgver}; make DESTDIR=$pkgdir install; }
