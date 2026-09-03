pkgname=ncurses-temp; pkgver=6.6; source=("https://invisible-mirror.net/archives/ncurses/ncurses-${pkgver}.tar.gz")
build(){ cd ncurses-${pkgver}; ./configure --prefix=/usr --host=$LFS_TGT --build=$(./config.guess) --with-shared --without-debug --without-ada --enable-widec; make -j$(nproc); }
package(){ cd ncurses-${pkgver}; make DESTDIR=$pkgdir install; }
