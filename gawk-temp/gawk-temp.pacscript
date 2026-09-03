pkgname=gawk-temp; pkgver=5.3.2; source=("https://ftp.gnu.org/gnu/gawk/gawk-${pkgver}.tar.xz")
build(){ cd gawk-${pkgver}; ./configure --prefix=/usr --host=$LFS_TGT --build=$(build-aux/config.guess); make -j$(nproc); }
package(){ cd gawk-${pkgver}; make DESTDIR=$pkgdir install; }
