pkgname=packaging; pkgver=26.0; source=("https://files.pythonhosted.org/packages/source/p/packaging/packaging-${pkgver}.tar.gz")
build(){ cd packaging-${pkgver}; pip3 wheel -w dist --no-build-isolation --no-deps $PWD; }
package(){ cd packaging-${pkgver}; pip3 install --no-index --find-links dist --no-cache-dir --no-user --root $pkgdir packaging; }
