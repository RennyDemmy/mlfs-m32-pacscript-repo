pkgname=gdbm; pkgver=1.26; source=("https://ftp.gnu.org/gnu/gdbm/gdbm-${pkgver}.tar.gz")
build(){ cd gdbm-${pkgver}; CC="gcc -m32" ./configure --prefix=/usr --libdir=/usr/lib32 --disable-static --enable-libgdbm-compat; make; make DESTDIR=$srcdir/m32 install; make clean; ./configure --prefix=/usr --disable-static --enable-libgdbm-compat; make; }
package(){ cd gdbm-${pkgver}; make DESTDIR=$pkgdir install; cp -a $srcdir/m32/usr/lib32 $pkgdir/usr/; }
