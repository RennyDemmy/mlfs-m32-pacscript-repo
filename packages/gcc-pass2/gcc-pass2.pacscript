pkgname=gcc-pass2; pkgver=15.2.0; source=("https://ftp.gnu.org/gnu/gcc/gcc-${pkgver}/gcc-${pkgver}.tar.xz")
build(){ cd gcc-${pkgver}; ./contrib/download_prerequisites; mkdir build; cd build; ../configure --build=$(../config.guess) --host=$LFS_TGT --prefix=/usr --CC_FOR_TARGET=$LFS_TGT-gcc --with-build-sysroot=$LFS --enable-languages=c,c++ --disable-nls --disable-multilib; make -j$(nproc); }
package(){ cd gcc-${pkgver}/build; make DESTDIR=$pkgdir install; }
