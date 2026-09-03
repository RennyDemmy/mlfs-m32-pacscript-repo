pkgname=binutils-pass2; pkgver=2.46.0; source=("https://ftp.gnu.org/gnu/binutils/binutils-${pkgver}.tar.xz")
build(){ cd binutils-${pkgver}; mkdir build; cd build; ../configure --prefix=/usr --build=$(../config.guess) --host=$LFS_TGT --disable-nls --enable-shared --enable-gprofng=no --disable-werror --enable-64-bit-bfd; make -j$(nproc); }
package(){ cd binutils-${pkgver}/build; make DESTDIR=$pkgdir install; }
