pkgname=gettext-temp; pkgver=1.0; source=("https://ftp.gnu.org/gnu/gettext/gettext-${pkgver}.tar.xz")
build(){ cd gettext-${pkgver}; ./configure --disable-shared; make -j$(nproc); }
package(){ cd gettext-${pkgver}; make DESTDIR=$pkgdir install; }
