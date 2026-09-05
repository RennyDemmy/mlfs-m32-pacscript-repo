pkgname=ncurses; pkgver=6.6; source=("https://invisible-mirror.net/archives/ncurses/ncurses-${pkgver}.tar.gz")
build(){ cd ncurses-${pkgver}; CC="gcc -m32" CXX="g++ -m32" ./configure --prefix=/usr --libdir=/usr/lib32 --with-shared --without-debug --enable-widec; make; make DESTDIR=$srcdir/m32 install; make clean; ./configure --prefix=/usr --with-shared --without-debug --enable-widec; make; }
package(){ cd ncurses-${pkgver}; make DESTDIR=$pkgdir install; cp -a $srcdir/m32/usr/lib32 $pkgdir/usr/; }
