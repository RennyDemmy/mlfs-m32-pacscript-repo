pkgname=markupsafe; pkgver=3.0.3; source=("https://files.pythonhosted.org/packages/source/M/MarkupSafe/MarkupSafe-${pkgver}.tar.gz")
build(){ cd MarkupSafe-${pkgver}; pip3 wheel -w dist --no-build-isolation --no-deps $PWD; }
package(){ cd MarkupSafe-${pkgver}; pip3 install --no-index --find-links dist --no-cache-dir --no-user --root $pkgdir MarkupSafe; }
