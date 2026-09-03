pkgname=expect; pkgver=5.45.4; source=("https://downloads.sourceforge.net/expect/expect${pkgver}.tar.gz")
build(){ cd expect${pkgver}; ./configure --prefix=/usr --with-tcl=/usr/lib; make -j$(nproc); }
package(){ cd expect${pkgver}; make DESTDIR=$pkgdir install; }
