pkgname=iana-etc; pkgver=20260202; source=("https://github.com/Mic92/iana-etc/releases/download/${pkgver}/iana-etc-${pkgver}.tar.gz")
build(){ :; }
package(){ cd iana-etc-${pkgver}; install -D -m644 services $pkgdir/etc/services; install -D -m644 protocols $pkgdir/etc/protocols; }
