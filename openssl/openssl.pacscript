pkgname=openssl; pkgver=3.6.1; source=("https://www.openssl.org/source/openssl-${pkgver}.tar.gz")
build(){ cd openssl-${pkgver}; ./Configure linux-elf --prefix=/usr --libdir=lib32 shared zlib-dynamic; make; make DESTDIR=$srcdir/m32 install; make clean; ./Configure linux-x86_64 --prefix=/usr --libdir=lib shared zlib-dynamic; make; }
package(){ cd openssl-${pkgver}; make DESTDIR=$pkgdir install; cp -a $srcdir/m32/usr/lib32 $pkgdir/usr/; }
