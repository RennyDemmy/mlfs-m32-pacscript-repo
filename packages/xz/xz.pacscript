pkgname=xz; pkgver=5.8.2; source=("https://github.com/tukaani-project/xz/releases/download/v${pkgver}/xz-${pkgver}.tar.xz")
build(){ cd xz-${pkgver}; CC="gcc -m32" ./configure --prefix=/usr --libdir=/usr/lib32 --disable-static; make; make DESTDIR=$srcdir/m32 install; make clean; ./configure --prefix=/usr --disable-static; make; }
package(){ cd xz-${pkgver}; make DESTDIR=$pkgdir install; cp -a $srcdir/m32/usr/lib32 $pkgdir/usr/; }
