pkgname=file; pkgver=5.46; source=("https://astron.com/pub/file/file-${pkgver}.tar.gz")
build(){ cd file-${pkgver}; CC="gcc -m32" ./configure --prefix=/usr --libdir=/usr/lib32; make; make DESTDIR=$srcdir/m32 install; make clean; ./configure --prefix=/usr; make; }
package(){ cd file-${pkgver}; make DESTDIR=$pkgdir install; cp -a $srcdir/m32/usr/lib32 $pkgdir/usr/; }
