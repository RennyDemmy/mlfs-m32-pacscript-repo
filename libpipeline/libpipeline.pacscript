pkgname=libpipeline; pkgver=1.5.8; source=("https://download.savannah.gnu.org/releases/libpipeline/libpipeline-${pkgver}.tar.gz")
build(){ cd libpipeline-${pkgver}; ./configure --prefix=/usr; make -j$(nproc); }
package(){ cd libpipeline-${pkgver}; make DESTDIR=$pkgdir install; }
