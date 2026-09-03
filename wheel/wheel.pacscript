pkgname=wheel; pkgver=0.46.3; source=("https://files.pythonhosted.org/packages/source/w/wheel/wheel-${pkgver}.tar.gz")
build(){ cd wheel-${pkgver}; pip3 wheel -w dist --no-build-isolation --no-deps $PWD; }
package(){ cd wheel-${pkgver}; pip3 install --no-index --find-links dist --no-cache-dir --no-user --root $pkgdir wheel; }
