pkgname=glibc-pass1; pkgver=2.43; source=("https://ftp.gnu.org/gnu/glibc/glibc-${pkgver}.tar.xz")
build(){ cd glibc-${pkgver}; mkdir build; cd build; ../configure --prefix=/usr --host=$LFS_TGT --build=$(../scripts/config.guess) --enable-kernel=4.19 --with-headers=$LFS/usr/include libc_cv_slibdir=/usr/lib; make -j$(nproc); }
package(){ cd glibc-${pkgver}/build; make DESTDIR=$pkgdir install; }
