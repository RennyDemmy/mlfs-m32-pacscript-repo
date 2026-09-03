pkgname=gperf; pkgver=3.3; source=("https://ftp.gnu.org/gnu/gperf/gperf-${pkgver}.tar.gz")
build(){ cd gperf-${pkgver}; ./configure --prefix=/usr; make -j$(nproc); }
package(){ cd gperf-${pkgver}; make DESTDIR=$pkgdir install; }
