pkgname=libtool; pkgver=2.5.4; source=("https://ftp.gnu.org/gnu/libtool/libtool-${pkgver}.tar.xz")
build(){ cd libtool-${pkgver}; CC="gcc -m32" ./configure --prefix=/usr --libdir=/usr/lib32; make; make DESTDIR=$srcdir/m32 install; make clean; ./configure --prefix=/usr; make; }
package(){ cd libtool-${pkgver}; make DESTDIR=$pkgdir install; cp -a $srcdir/m32/usr/lib32 $pkgdir/usr/; }
