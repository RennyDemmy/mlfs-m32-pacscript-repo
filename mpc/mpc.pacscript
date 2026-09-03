pkgname=mpc; pkgver=1.3.1; source=("https://ftp.gnu.org/gnu/mpc/mpc-${pkgver}.tar.gz")
build(){ cd mpc-${pkgver}; CC="gcc -m32" ./configure --prefix=/usr --libdir=/usr/lib32; make; make DESTDIR=$srcdir/m32 install; make clean; ./configure --prefix=/usr; make; }
package(){ cd mpc-${pkgver}; make DESTDIR=$pkgdir install; cp -a $srcdir/m32/usr/lib32 $pkgdir/usr/; }
