pkgname=mpfr; pkgver=4.2.2; source=("https://ftp.gnu.org/gnu/mpfr/mpfr-${pkgver}.tar.xz")
build(){ cd mpfr-${pkgver}; CC="gcc -m32" ./configure --prefix=/usr --libdir=/usr/lib32; make; make DESTDIR=$srcdir/m32 install; make clean; ./configure --prefix=/usr; make; }
package(){ cd mpfr-${pkgver}; make DESTDIR=$pkgdir install; cp -a $srcdir/m32/usr/lib32 $pkgdir/usr/; }
