pkgname=dbus; pkgver=1.16.2; source=("https://dbus.freedesktop.org/releases/dbus/dbus-${pkgver}.tar.xz")
build(){ cd dbus-${pkgver}; mkdir build; cd build; meson setup --prefix=/usr --sysconfdir=/etc --localstatedir=/var --buildtype=release ..; ninja; }
package(){ cd dbus-${pkgver}/build; DESTDIR=$pkgdir ninja install; }
