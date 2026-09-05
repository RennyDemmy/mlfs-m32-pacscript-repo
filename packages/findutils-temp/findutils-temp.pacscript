pkgname=findutils-temp; pkgver=4.10.0; source=("https://ftp.gnu.org/gnu/findutils/findutils-${pkgver}.tar.xz")
build(){ cd findutils-${pkgver}; ./configure --prefix=/usr --host=$LFS_TGT --build=$(build-aux/config.guess); make -j$(nproc); }
package(){ cd findutils-${pkgver}; make DESTDIR=$pkgdir install; }
