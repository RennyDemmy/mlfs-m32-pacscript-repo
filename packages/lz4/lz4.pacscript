pkgname=lz4; pkgver=1.10.0; source=("https://github.com/lz4/lz4/archive/v${pkgver}/lz4-${pkgver}.tar.gz")
build(){ cd lz4-${pkgver}; make BUILD_STATIC=no CC="gcc -m32"; make DESTDIR=$srcdir/m32 PREFIX=/usr LIBDIR=/usr/lib32 install; make clean; make BUILD_STATIC=no; }
package(){ cd lz4-${pkgver}; make DESTDIR=$pkgdir PREFIX=/usr install; cp -a $srcdir/m32/usr/lib32 $pkgdir/usr/; }
