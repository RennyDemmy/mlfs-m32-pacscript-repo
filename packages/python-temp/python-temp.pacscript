pkgname=python-temp; pkgver=3.14.3; source=("https://www.python.org/ftp/python/${pkgver}/Python-${pkgver}.tar.xz")
build(){ cd Python-${pkgver}; ./configure --prefix=/usr --enable-shared --without-ensurepip; make -j$(nproc); }
package(){ cd Python-${pkgver}; make DESTDIR=$pkgdir install; }
