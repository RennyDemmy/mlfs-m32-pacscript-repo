pkgname=bc; pkgver=7.0.3; source=("https://github.com/gavinhoward/bc/releases/download/${pkgver}/bc-${pkgver}.tar.xz")
build(){ cd bc-${pkgver}; CC=gcc ./configure --prefix=/usr -G -O3; make -j$(nproc); }
package(){ cd bc-${pkgver}; make DESTDIR=$pkgdir install; }
