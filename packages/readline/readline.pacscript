pkgname=readline; pkgver=8.3; source=("https://ftp.gnu.org/gnu/readline/readline-${pkgver}.tar.gz")
build(){ cd readline-${pkgver}; CC="gcc -m32" ./configure --prefix=/usr --libdir=/usr/lib32 --disable-static; make SHLIB_LIBS="-lncursesw"; make DESTDIR=$srcdir/m32 install; make clean; ./configure --prefix=/usr --disable-static; make SHLIB_LIBS="-lncursesw"; }
package(){ cd readline-${pkgver}; make DESTDIR=$pkgdir install; cp -a $srcdir/m32/usr/lib32 $pkgdir/usr/; }
