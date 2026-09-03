pkgname=perl-temp; pkgver=5.42.0; source=("https://www.cpan.org/src/5.0/perl-${pkgver}.tar.gz")
build(){ cd perl-${pkgver}; sh Configure -des -Dprefix=/usr -Dvendorprefix=/usr; make -j$(nproc); }
package(){ cd perl-${pkgver}; make DESTDIR=$pkgdir install; }
