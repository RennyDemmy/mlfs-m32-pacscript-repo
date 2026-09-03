pkgname=attr; pkgver=2.5.2; source=("https://savannah.nongnu.org/download/attr/attr-${pkgver}.tar.gz")
build(){ cd attr-${pkgver}; CC="gcc -m32" ./configure --prefix=/usr --libdir=/usr/lib32 --disable-static; make; make DESTDIR=$srcdir/m32 install; make clean; ./configure --prefix=/usr --disable-static; make; }
package(){ cd attr-${pkgver}; make DESTDIR=$pkgdir install; cp -a $srcdir/m32/usr/lib32 $pkgdir/usr/; }
