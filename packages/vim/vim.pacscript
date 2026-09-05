pkgname=vim; pkgver=9.2.0078; source=("https://github.com/vim/vim/archive/v${pkgver}/vim-${pkgver}.tar.gz")
build(){ cd vim-${pkgver}; echo '#define SYS_VIMRC_FILE "/etc/vimrc"' >> src/feature.h; ./configure --prefix=/usr; make -j$(nproc); }
package(){ cd vim-${pkgver}; make DESTDIR=$pkgdir install; }
