pkgname=pcre2; pkgver=10.47; source=("https://github.com/PCRE2Project/pcre2/releases/download/pcre2-${pkgver}/pcre2-${pkgver}.tar.bz2")
build(){ cd pcre2-${pkgver}; CC="gcc -m32" ./configure --prefix=/usr --libdir=/usr/lib32 --enable-unicode --enable-jit --enable-pcre2-16 --enable-pcre2-32; make; make DESTDIR=$srcdir/m32 install; make clean; ./configure --prefix=/usr --enable-unicode --enable-jit --enable-pcre2-16 --enable-pcre2-32; make; }
package(){ cd pcre2-${pkgver}; make DESTDIR=$pkgdir install; cp -a $srcdir/m32/usr/lib32 $pkgdir/usr/; }
