pkgname=flex; pkgver=2.6.4; source=("https://github.com/westes/flex/releases/download/v${pkgver}/flex-${pkgver}.tar.gz")
build(){ cd flex-${pkgver}; CC="gcc -m32" ./configure --prefix=/usr --libdir=/usr/lib32 --disable-static; make; make DESTDIR=$srcdir/m32 install; make clean; ./configure --prefix=/usr --disable-static; make; }
package(){ cd flex-${pkgver}; make DESTDIR=$pkgdir install; cp -a $srcdir/m32/usr/lib32 $pkgdir/usr/; }
