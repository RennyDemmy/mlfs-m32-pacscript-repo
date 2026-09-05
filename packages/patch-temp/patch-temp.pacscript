pkgname=patch-temp; pkgver=2.8; source=("https://ftp.gnu.org/gnu/patch/patch-${pkgver}.tar.xz")
build(){ cd patch-${pkgver}; ./configure --prefix=/usr --host=$LFS_TGT --build=$(build-aux/config.guess); make -j$(nproc); }
package(){ cd patch-${pkgver}; make DESTDIR=$pkgdir install; }
