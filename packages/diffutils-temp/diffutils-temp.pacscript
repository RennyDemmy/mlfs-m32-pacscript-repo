pkgname=diffutils-temp; pkgver=3.12; source=("https://ftp.gnu.org/gnu/diffutils/diffutils-${pkgver}.tar.xz")
build(){ cd diffutils-${pkgver}; ./configure --prefix=/usr --host=$LFS_TGT; make -j$(nproc); }
package(){ cd diffutils-${pkgver}; make DESTDIR=$pkgdir install; }
