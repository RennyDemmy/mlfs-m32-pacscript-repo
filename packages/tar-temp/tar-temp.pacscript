pkgname=tar-temp; pkgver=1.35; source=("https://ftp.gnu.org/gnu/tar/tar-${pkgver}.tar.xz")
build(){ cd tar-${pkgver}; ./configure --prefix=/usr --host=$LFS_TGT --build=$(build-aux/config.guess); make -j$(nproc); }
package(){ cd tar-${pkgver}; make DESTDIR=$pkgdir install; }
