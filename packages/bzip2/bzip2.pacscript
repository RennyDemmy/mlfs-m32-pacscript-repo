pkgname=bzip2; pkgver=1.0.8; source=("https://www.sourceware.org/pub/bzip2/bzip2-${pkgver}.tar.gz")
build(){ cd bzip2-${pkgver}; make -f Makefile-libbz2_so CC="gcc -m32"; make CC="gcc -m32" libbz2.a; mkdir m32; cp libbz2.so* libbz2.a m32/; make clean; make -f Makefile-libbz2_so; make; }
package(){ cd bzip2-${pkgver}; make PREFIX=$pkgdir/usr install; cp -a libbz2.so* $pkgdir/usr/lib/; mkdir -p $pkgdir/usr/lib32; cp -a m32/libbz2.so* m32/libbz2.a $pkgdir/usr/lib32/; }
