pkgname=bash-temp; pkgver=5.3; source=("https://ftp.gnu.org/gnu/bash/bash-${pkgver}.tar.gz")
build(){ cd bash-${pkgver}; ./configure --prefix=/usr --build=$(support/config.guess) --host=$LFS_TGT --without-bash-malloc; make -j$(nproc); }
package(){ cd bash-${pkgver}; make DESTDIR=$pkgdir install; }
