pkgname=setuptools; pkgver=82.0.0; source=("https://files.pythonhosted.org/packages/source/s/setuptools/setuptools-${pkgver}.tar.gz")
build(){ cd setuptools-${pkgver}; pip3 wheel -w dist --no-build-isolation --no-deps $PWD; }
package(){ cd setuptools-${pkgver}; pip3 install --no-index --find-links dist --no-cache-dir --no-user --root $pkgdir setuptools; }
