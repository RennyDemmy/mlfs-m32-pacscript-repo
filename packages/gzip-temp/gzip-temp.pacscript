pkgname=gzip-temp; pkgver=1.14; source=("https://ftp.gnu.org/gnu/gzip/gzip-${pkgver}.tar.xz")
build(){ cd gzip-${pkgver}; ./configure --prefix=/usr --host=$LFS_TGT; make -j$(nproc); }
package(){ cd gzip-${pkgver}; make DESTDIR=$pkgdir install; }
