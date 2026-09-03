pkgname=util-linux-temp; pkgver=2.41.3; source=("https://www.kernel.org/pub/linux/utils/util-linux/v2.41/util-linux-${pkgver}.tar.xz")
build(){ cd util-linux-${pkgver}; ./configure --prefix=/usr --without-python --disable-makeinstall-chown --without-systemd --without-ncurses; make -j$(nproc); }
package(){ cd util-linux-${pkgver}; make DESTDIR=$pkgdir install; }
