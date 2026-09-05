pkgname=iproute2; pkgver=6.18.0; source=("https://www.kernel.org/pub/linux/utils/net/iproute2/iproute2-${pkgver}.tar.xz")
build(){ cd iproute2-${pkgver}; make -j$(nproc); }
package(){ cd iproute2-${pkgver}; make DESTDIR=$pkgdir SBINDIR=/usr/sbin install; }
