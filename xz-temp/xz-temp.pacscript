pkgname=xz-temp; pkgver=5.8.2; source=("https://github.com/tukaani-project/xz/releases/download/v${pkgver}/xz-${pkgver}.tar.xz")
build(){ cd xz-${pkgver}; ./configure --prefix=/usr --host=$LFS_TGT --build=$(build-aux/config.guess) --disable-static; make -j$(nproc); }
package(){ cd xz-${pkgver}; make DESTDIR=$pkgdir install; }
