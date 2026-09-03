pkgname=libffi; pkgver=3.5.2; source=("https://github.com/libffi/libffi/releases/download/v${pkgver}/libffi-${pkgver}.tar.gz")
build(){ cd libffi-${pkgver}; CC="gcc -m32" ./configure --prefix=/usr --libdir=/usr/lib32 --disable-static; make; make DESTDIR=$srcdir/m32 install; make clean; ./configure --prefix=/usr --disable-static; make; }
package(){ cd libffi-${pkgver}; make DESTDIR=$pkgdir install; cp -a $srcdir/m32/usr/lib32 $pkgdir/usr/; }
