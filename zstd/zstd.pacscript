pkgname=zstd; pkgver=1.5.7; source=("https://github.com/facebook/zstd/releases/download/v${pkgver}/zstd-${pkgver}.tar.gz")
build(){ cd zstd-${pkgver}; make CC="gcc -m32" prefix=/usr libdir=/usr/lib32; make DESTDIR=$srcdir/m32 prefix=/usr libdir=/usr/lib32 install; make clean; make prefix=/usr; }
package(){ cd zstd-${pkgver}; make DESTDIR=$pkgdir prefix=/usr install; cp -a $srcdir/m32/usr/lib32 $pkgdir/usr/; }
