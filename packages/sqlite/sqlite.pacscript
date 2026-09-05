pkgname=sqlite; pkgver=3510200; source=("https://sqlite.org/2026/sqlite-autoconf-${pkgver}.tar.gz")
build(){ cd sqlite-autoconf-${pkgver}; CC="gcc -m32" ./configure --prefix=/usr --libdir=/usr/lib32 --disable-static; make; make DESTDIR=$srcdir/m32 install; make clean; ./configure --prefix=/usr --disable-static; make; }
package(){ cd sqlite-autoconf-${pkgver}; make DESTDIR=$pkgdir install; cp -a $srcdir/m32/usr/lib32 $pkgdir/usr/; }
