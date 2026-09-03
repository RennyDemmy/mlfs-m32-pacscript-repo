pkgname=gcc-pass1; pkgver=15.2.0; source=("https://ftp.gnu.org/gnu/gcc/gcc-${pkgver}/gcc-${pkgver}.tar.xz")
build(){ cd gcc-${pkgver}; ./contrib/download_prerequisites; mkdir build; cd build; ../configure --target=$LFS_TGT --prefix=$LFS/tools --with-glibc-version=2.43 --with-sysroot=$LFS --with-newlib --without-headers --disable-nls --disable-shared --disable-multilib --disable-threads --enable-languages=c,c++; make -j$(nproc); }
package(){ cd gcc-${pkgver}/build; make DESTDIR=$pkgdir install; }
