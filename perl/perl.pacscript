pkgname=perl; pkgver=5.42.0; source=("https://www.cpan.org/src/5.0/perl-${pkgver}.tar.gz")
build(){ cd perl-${pkgver}; sh Configure -des -Dprefix=/usr -Dvendorprefix=/usr -Dprivlib=/usr/lib/perl5/${pkgver}/core_perl -Darchlib=/usr/lib/perl5/${pkgver}/core_perl -Dsitelib=/usr/lib/perl5/${pkgver}/site_perl -Dsitearch=/usr/lib/perl5/${pkgver}/site_perl -Dvendorlib=/usr/lib/perl5/${pkgver}/vendor_perl -Dvendorarch=/usr/lib/perl5/${pkgver}/vendor_perl; make -j$(nproc); }
package(){ cd perl-${pkgver}; make DESTDIR=$pkgdir install; }
