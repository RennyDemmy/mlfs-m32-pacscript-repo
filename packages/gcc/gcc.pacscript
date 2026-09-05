pkgname=gcc; pkgver=15.2.0; source=("https://ftp.gnu.org/gnu/gcc/gcc-${pkgver}/gcc-${pkgver}.tar.xz")
build(){ cd gcc-${pkgver}; sed -e '/m64=/s/lib64/lib/' -i.orig gcc/config/i386/t-linux64; mkdir build; cd build; ../configure --prefix=/usr LD=ld --enable-languages=c,c++ --enable-default-pie --enable-default-ssp --disable-nls --enable-multilib --with-multilib-list=m64,m32 --with-system-zlib; make -j$(nproc); }
package(){ cd gcc-${pkgver}/build; make DESTDIR=$pkgdir install; ln -sv gcc $pkgdir/usr/bin/cc; }
