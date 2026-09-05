pkgname=xml-parser; pkgver=2.47; source=("https://cpan.metacpan.org/authors/id/T/TO/TODDR/XML-Parser-${pkgver}.tar.gz")
build(){ cd XML-Parser-${pkgver}; perl Makefile.PL; make -j$(nproc); }
package(){ cd XML-Parser-${pkgver}; make DESTDIR=$pkgdir install; }
