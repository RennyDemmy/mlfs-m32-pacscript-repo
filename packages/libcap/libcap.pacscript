pkgname=libcap; pkgver=2.77; source=("https://www.kernel.org/pub/linux/libs/security/linux-privs/libcap2/libcap-${pkgver}.tar.xz")
build(){ cd libcap-${pkgver}; make CC="gcc -m32" lib=lib32; make DESTDIR=$srcdir/m32 lib=lib32 install; make clean; make lib=lib; }
package(){ cd libcap-${pkgver}; make DESTDIR=$pkgdir lib=lib install; cp -a $srcdir/m32/usr/lib32 $pkgdir/usr/; }
