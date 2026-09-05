pkgname=coreutils-temp; pkgver=9.10; source=("https://ftp.gnu.org/gnu/coreutils/coreutils-${pkgver}.tar.xz")
build(){ cd coreutils-${pkgver}; ./configure --prefix=/usr --host=$LFS_TGT --build=$(build-aux/config.guess) --enable-install-program=hostname --enable-no-install-program=kill,uptime; make -j$(nproc); }
package(){ cd coreutils-${pkgver}; make DESTDIR=$pkgdir install; }
