pkgname=file-temp; pkgver=5.46; source=("https://astron.com/pub/file/file-${pkgver}.tar.gz")
build(){ cd file-${pkgver}; mkdir build; pushd build; ../configure --disable-bzlib --disable-libseccomp --disable-xzlib --disable-zlib; make; popd; ./configure --prefix=/usr --host=$LFS_TGT --build=$(./config.guess); make -j$(nproc); }
package(){ cd file-${pkgver}; make DESTDIR=$pkgdir install; }
