pkgname=jinja2; pkgver=3.1.6; source=("https://files.pythonhosted.org/packages/source/J/Jinja2/jinja2-${pkgver}.tar.gz")
build(){ cd jinja2-${pkgver}; pip3 wheel -w dist --no-build-isolation --no-deps $PWD; }
package(){ cd jinja2-${pkgver}; pip3 install --no-index --find-links dist --no-cache-dir --no-user --root $pkgdir Jinja2; }
