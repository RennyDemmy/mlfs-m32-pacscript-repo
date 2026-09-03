pkgname=procps-ng; pkgver=4.0.6; source=("https://sourceforge.net/projects/procps-ng/files/Production/procps-ng-${pkgver}.tar.xz")
build(){ cd procps-ng-${pkgver}; ./configure --prefix=/usr --docdir=/usr/share/doc/procps-ng-${pkgver} --disable-static --disable-kill; make -j$(nproc); }
package(){ cd procps-ng-${pkgver}; make DESTDIR=$pkgdir install; }
