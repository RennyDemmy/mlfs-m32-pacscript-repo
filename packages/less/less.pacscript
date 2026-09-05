pkgname=less; pkgver=692; source=("https://www.greenwoodsoftware.com/less/less-${pkgver}.tar.gz")
build(){ cd less-${pkgver}; ./configure --prefix=/usr; make -j$(nproc); }
package(){ cd less-${pkgver}; make DESTDIR=$pkgdir install; }
