pkgname=elfutils; pkgver=0.194; source=("https://sourceware.org/elfutils/ftp/${pkgver}/elfutils-${pkgver}.tar.bz2")
build(){ cd elfutils-${pkgver}; CC="gcc -m32" ./configure --prefix=/usr --libdir=/usr/lib32 --disable-debuginfod --disable-libdebuginfod; make; make DESTDIR=$srcdir/m32 install; make clean; ./configure --prefix=/usr --disable-debuginfod --disable-libdebuginfod; make; }
package(){ cd elfutils-${pkgver}; make DESTDIR=$pkgdir install; cp -a $srcdir/m32/usr/lib32 $pkgdir/usr/; }
