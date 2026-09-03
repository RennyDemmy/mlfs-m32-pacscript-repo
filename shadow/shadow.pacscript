pkgname=shadow; pkgver=4.19.3; source=("https://github.com/shadow-maint/shadow/releases/download/v${pkgver}/shadow-${pkgver}.tar.xz")
build(){ cd shadow-${pkgver}; ./configure --prefix=/usr --sysconfdir=/etc --with-group-name-max-length=32; make -j$(nproc); }
package(){ cd shadow-${pkgver}; make DESTDIR=$pkgdir install; }
