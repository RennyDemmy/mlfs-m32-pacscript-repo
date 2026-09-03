pkgname=systemd; pkgver=259.1; source=("https://github.com/systemd/systemd/archive/v${pkgver}/systemd-${pkgver}.tar.gz")
build(){ cd systemd-${pkgver}; mkdir build; cd build; meson setup --prefix=/usr --buildtype=release -Ddefault-dnssec=no -Dfirstboot=false -Dinstall-tests=false -Dldconfig=false -Dsysusers=false -Db_lto=false -Ddocdir=/usr/share/doc/systemd-${pkgver} ..; ninja; }
package(){ cd systemd-${pkgver}/build; DESTDIR=$pkgdir ninja install; }
