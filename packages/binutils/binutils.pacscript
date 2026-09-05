pkgname=binutils; pkgver=2.46.0; source=("https://ftp.gnu.org/gnu/binutils/binutils-${pkgver}.tar.xz")
build(){ cd binutils-${pkgver}; mkdir build; cd build; ../configure --prefix=/usr --enable-gold --enable-ld=default --enable-plugins --enable-shared --disable-werror --enable-64-bit-bfd --enable-multilib --with-system-zlib; make -j$(nproc) tooldir=/usr; }
package(){ cd binutils-${pkgver}/build; make DESTDIR=$pkgdir tooldir=/usr install; }
