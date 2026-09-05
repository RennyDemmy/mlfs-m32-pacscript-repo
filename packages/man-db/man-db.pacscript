pkgname=man-db; pkgver=2.13.1; source=("https://download.savannah.gnu.org/releases/man-db/man-db-${pkgver}.tar.xz")
build(){ cd man-db-${pkgver}; ./configure --prefix=/usr --docdir=/usr/share/doc/man-db-${pkgver} --sysconfdir=/etc --disable-setuid; make -j$(nproc); }
package(){ cd man-db-${pkgver}; make DESTDIR=$pkgdir install; }
