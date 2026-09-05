pkgname=zlib; pkgver=1.3.2; source=("https://zlib.net/zlib-${pkgver}.tar.gz")
build(){ cd zlib-${pkgver}; CC="gcc -m32" ./configure --prefix=/usr --libdir=/usr/lib32; make; make DESTDIR=$srcdir/m32 install; make clean; ./configure --prefix=/usr; make; }
package(){ cd zlib-${pkgver}; make DESTDIR=$pkgdir install; cp -a $srcdir/m32/usr/lib32 $pkgdir/usr/; }
