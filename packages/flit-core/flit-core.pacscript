pkgname=flit-core; pkgver=3.12.0; source=("https://files.pythonhosted.org/packages/source/f/flit_core/flit_core-${pkgver}.tar.gz")
build(){ cd flit_core-${pkgver}; pip3 wheel -w dist --no-build-isolation --no-deps $PWD; }
package(){ cd flit_core-${pkgver}; pip3 install --no-index --find-links dist --no-cache-dir --no-user --root $pkgdir flit_core; }
