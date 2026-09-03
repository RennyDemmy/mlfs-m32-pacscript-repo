pkgname=dejagnu; pkgver=1.6.3; source=("https://ftp.gnu.org/gnu/dejagnu/dejagnu-${pkgver}.tar.gz")
build(){ cd dejagnu-${pkgver}; ./configure --prefix=/usr; make -j$(nproc); }
package(){ cd dejagnu-${pkgver}; make DESTDIR=$pkgdir install; }
