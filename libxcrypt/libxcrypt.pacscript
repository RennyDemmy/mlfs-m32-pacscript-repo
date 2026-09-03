pkgname=libxcrypt; pkgver=4.5.2; source=("https://github.com/besser82/libxcrypt/releases/download/v${pkgver}/libxcrypt-${pkgver}.tar.xz")
build(){ cd libxcrypt-${pkgver}; CC="gcc -m32" ./configure --prefix=/usr --libdir=/usr/lib32 --disable-static; make; make DESTDIR=$srcdir/m32 install; make clean; ./configure --prefix=/usr --disable-static; make; }
package(){ cd libxcrypt-${pkgver}; make DESTDIR=$pkgdir install; cp -a $srcdir/m32/usr/lib32 $pkgdir/usr/; }
