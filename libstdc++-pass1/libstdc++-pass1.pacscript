pkgname=libstdc++-pass1; pkgver=15.2.0; source=("https://ftp.gnu.org/gnu/gcc/gcc-${pkgver}/gcc-${pkgver}.tar.xz")
build(){ cd gcc-${pkgver}; mkdir build; cd build; ../libstdc++-v3/configure --host=$LFS_TGT --build=$(../config.guess) --prefix=/usr --disable-multilib --disable-nls --with-gxx-include-dir=/tools/$LFS_TGT/include/c++/${pkgver}; make -j$(nproc); }
package(){ cd gcc-${pkgver}/build; make DESTDIR=$pkgdir install; }
