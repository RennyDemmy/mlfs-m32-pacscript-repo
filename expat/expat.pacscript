pkgname=expat; pkgver=2.7.4; source=("https://github.com/libexpat/libexpat/releases/download/R_${pkgver//./_}/expat-${pkgver}.tar.xz")
build(){ cd expat-${pkgver}; CC="gcc -m32" ./configure --prefix=/usr --libdir=/usr/lib32 --disable-static; make; make DESTDIR=$srcdir/m32 install; make clean; ./configure --prefix=/usr --disable-static; make; }
package(){ cd expat-${pkgver}; make DESTDIR=$pkgdir install; cp -a $srcdir/m32/usr/lib32 $pkgdir/usr/; }
