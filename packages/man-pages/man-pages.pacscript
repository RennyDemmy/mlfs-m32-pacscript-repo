pkgname=man-pages; pkgver=6.17; source=("https://www.kernel.org/pub/linux/docs/man-pages/man-pages-${pkgver}.tar.xz")
build(){ :; }
package(){ cd man-pages-${pkgver}; make DESTDIR=$pkgdir prefix=/usr install; }
