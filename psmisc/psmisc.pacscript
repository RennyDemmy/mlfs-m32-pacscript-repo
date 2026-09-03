pkgname=psmisc; pkgver=23.7; source=("https://downloads.sourceforge.net/psmisc/psmisc-${pkgver}.tar.xz")
build(){ cd psmisc-${pkgver}; ./configure --prefix=/usr; make -j$(nproc); }
package(){ cd psmisc-${pkgver}; make DESTDIR=$pkgdir install; }
