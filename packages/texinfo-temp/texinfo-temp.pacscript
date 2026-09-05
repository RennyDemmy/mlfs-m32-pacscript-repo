pkgname=texinfo-temp; pkgver=7.2; source=("https://ftp.gnu.org/gnu/texinfo/texinfo-${pkgver}.tar.xz")
build(){ cd texinfo-${pkgver}; ./configure --prefix=/usr; make -j$(nproc); }
package(){ cd texinfo-${pkgver}; make DESTDIR=$pkgdir install; }
