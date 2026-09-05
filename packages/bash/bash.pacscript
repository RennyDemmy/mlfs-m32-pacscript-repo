pkgname=bash; pkgver=5.3; source=("https://ftp.gnu.org/gnu/bash/bash-${pkgver}.tar.gz")
build(){ cd bash-${pkgver}; ./configure --prefix=/usr --without-bash-malloc --with-installed-readline; make -j$(nproc); }
package(){ cd bash-${pkgver}; make DESTDIR=$pkgdir install; }
