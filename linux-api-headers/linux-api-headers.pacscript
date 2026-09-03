pkgname=linux-api-headers; pkgver=6.18.10; source=("https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-${pkgver}.tar.xz")
build(){ cd linux-${pkgver}; make mrproper; make headers; }
package(){ cd linux-${pkgver}; find usr/include -type f ! -name '*.install' -exec install -D -m644 {} $pkgdir/{} \;; }
