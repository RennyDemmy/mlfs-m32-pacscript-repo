pkgname=grep; pkgver=3.12; source=("https://ftp.gnu.org/gnu/grep/grep-${pkgver}.tar.xz")
build(){ cd grep-${pkgver}; ./configure --prefix=/usr; make -j$(nproc); }
package(){ cd grep-${pkgver}; make DESTDIR=$pkgdir install; }
