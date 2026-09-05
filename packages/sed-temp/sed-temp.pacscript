pkgname=sed-temp; pkgver=4.9; source=("https://ftp.gnu.org/gnu/sed/sed-${pkgver}.tar.xz")
build(){ cd sed-${pkgver}; ./configure --prefix=/usr --host=$LFS_TGT; make -j$(nproc); }
package(){ cd sed-${pkgver}; make DESTDIR=$pkgdir install; }
