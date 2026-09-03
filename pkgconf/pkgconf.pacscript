pkgname=pkgconf; pkgver=2.5.1; source=("https://distfiles.dereferenced.org/pkgconf/pkgconf-${pkgver}.tar.xz")
build(){ cd pkgconf-${pkgver}; ./configure --prefix=/usr; make -j$(nproc); }
package(){ cd pkgconf-${pkgver}; make DESTDIR=$pkgdir install; }
