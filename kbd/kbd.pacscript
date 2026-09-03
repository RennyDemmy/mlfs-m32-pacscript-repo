pkgname=kbd; pkgver=2.9.0; source=("https://www.kernel.org/pub/linux/utils/kbd/kbd-${pkgver}.tar.xz")
build(){ cd kbd-${pkgver}; ./configure --prefix=/usr --disable-vlock; make -j$(nproc); }
package(){ cd kbd-${pkgver}; make DESTDIR=$pkgdir install; }
