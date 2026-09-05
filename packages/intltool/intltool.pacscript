pkgname=intltool; pkgver=0.51.0; source=("https://launchpad.net/intltool/trunk/${pkgver}/+download/intltool-${pkgver}.tar.gz")
build(){ cd intltool-${pkgver}; ./configure --prefix=/usr; make -j$(nproc); }
package(){ cd intltool-${pkgver}; make DESTDIR=$pkgdir install; }
