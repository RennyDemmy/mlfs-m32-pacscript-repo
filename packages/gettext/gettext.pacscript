pkgname=gettext; pkgver=1.0; source=("https://ftp.gnu.org/gnu/gettext/gettext-${pkgver}.tar.xz")
build(){ cd gettext-${pkgver}; CC="gcc -m32" ./configure --prefix=/usr --libdir=/usr/lib32 --disable-static; make; make DESTDIR=$srcdir/m32 install; make clean; ./configure --prefix=/usr --disable-static; make; }
package(){ cd gettext-${pkgver}; make DESTDIR=$pkgdir install; cp -a $srcdir/m32/usr/lib32 $pkgdir/usr/; }
