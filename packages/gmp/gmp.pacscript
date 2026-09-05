pkgname=gmp; pkgver=6.3.0; source=("https://ftp.gnu.org/gnu/gmp/gmp-${pkgver}.tar.xz")
build(){ cd gmp-${pkgver}; ABI=32 ./configure --prefix=/usr --libdir=/usr/lib32 --host=i686-pc-linux-gnu; make; make DESTDIR=$srcdir/m32 install; make clean; ./configure --prefix=/usr --enable-cxx; make; }
package(){ cd gmp-${pkgver}; make DESTDIR=$pkgdir install; cp -a $srcdir/m32/usr/lib32 $pkgdir/usr/; }
