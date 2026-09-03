pkgname=binutils-pass1; pkgver=2.46.0; source=("https://ftp.gnu.org/gnu/binutils/binutils-${pkgver}.tar.xz")
build(){ cd binutils-${pkgver}; mkdir build; cd build; ../configure --prefix=$LFS/tools --with-sysroot=$LFS --target=$LFS_TGT --disable-nls --disable-werror; make -j$(nproc); }
package(){ cd binutils-${pkgver}/build; make DESTDIR=$pkgdir install; }
