pkgname=tcl; pkgver=8.6.17; source=("https://downloads.sourceforge.net/tcl/tcl${pkgver}-src.tar.gz")
build(){ cd tcl${pkgver}/unix; ./configure --prefix=/usr; make -j$(nproc); }
package(){ cd tcl${pkgver}/unix; make DESTDIR=$pkgdir install; }
