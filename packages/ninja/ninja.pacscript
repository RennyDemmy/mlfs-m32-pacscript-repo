pkgname=ninja; pkgver=1.13.2; source=("https://github.com/ninja-build/ninja/archive/v${pkgver}/ninja-${pkgver}.tar.gz")
build(){ cd ninja-${pkgver}; python3 configure.py --bootstrap; }
package(){ cd ninja-${pkgver}; install -D -m755 ninja $pkgdir/usr/bin/ninja; }
