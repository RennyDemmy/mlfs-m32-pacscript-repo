pkgname=coreutils; pkgver=9.10; source=("https://ftp.gnu.org/gnu/coreutils/coreutils-${pkgver}.tar.xz")
build(){ cd coreutils-${pkgver}; autoreconf -fiv; FORCE_UNSAFE_CONFIGURE=1 ./configure --prefix=/usr --enable-no-install-program=kill,uptime; make -j$(nproc); }
package(){ cd coreutils-${pkgver}; make DESTDIR=$pkgdir install; }
