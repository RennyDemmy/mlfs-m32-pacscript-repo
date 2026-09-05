pkgname=kmod; pkgver=34.2; source=("https://www.kernel.org/pub/linux/utils/kernel/kmod/kmod-${pkgver}.tar.xz")
build(){ cd kmod-${pkgver}; CC="gcc -m32" ./configure --prefix=/usr --libdir=/usr/lib32 --sysconfdir=/etc --with-xz --with-zstd --with-zlib; make; make DESTDIR=$srcdir/m32 install; make clean; ./configure --prefix=/usr --sysconfdir=/etc --with-xz --with-zstd --with-zlib; make; }
package(){ cd kmod-${pkgver}; make DESTDIR=$pkgdir install; cp -a $srcdir/m32/usr/lib32 $pkgdir/usr/; }
