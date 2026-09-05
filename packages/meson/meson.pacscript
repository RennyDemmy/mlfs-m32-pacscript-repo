pkgname=meson; pkgver=1.10.1; source=("https://github.com/mesonbuild/meson/releases/download/${pkgver}/meson-${pkgver}.tar.gz")
build(){ cd meson-${pkgver}; pip3 wheel -w dist --no-build-isolation --no-deps $PWD; }
package(){ cd meson-${pkgver}; pip3 install --no-index --find-links dist --no-cache-dir --no-user --root $pkgdir meson; }
