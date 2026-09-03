pkgname=mlfs-m32-meta
pkgver=13.0
pkgrel=1
description="Meta-package to build all MLFS 13.0-m32 packages (Toolchain through E2fsprogs)"
arch=('amd64')
url="https://www.linuxfromscratch.org/mlfs/"
source=()
sha256sums=()

# The exact 110 package names generated previously, in strict MLFS build order.
# Pacstall will resolve these from your repository before ever touching 'apt'.
depends=(
    'binutils-pass1' 'gcc-pass1' 'linux-api-headers' 'glibc-pass1' 'libstdc++-pass1'
    'm4-temp' 'ncurses-temp' 'bash-temp' 'coreutils-temp' 'diffutils-temp'
    'file-temp' 'findutils-temp' 'gawk-temp' 'grep-temp' 'gzip-temp'
    'make-temp' 'patch-temp' 'sed-temp' 'tar-temp' 'xz-temp'
    'binutils-pass2' 'gcc-pass2' 'gettext-temp' 'bison-temp' 'perl-temp'
    'python-temp' 'texinfo-temp' 'util-linux-temp' 'man-pages' 'iana-etc'
    'glibc' 'zlib' 'bzip2' 'xz' 'lz4'
    'zstd' 'file' 'readline' 'pcre2' 'm4'
    'bc' 'flex' 'tcl' 'expect' 'dejagnu'
    'pkgconf' 'binutils' 'gmp' 'mpfr' 'mpc'
    'isl' 'attr' 'acl' 'libcap' 'libxcrypt'
    'shadow' 'gcc' 'ncurses' 'sed' 'psmisc'
    'gettext' 'bison' 'grep' 'bash' 'libtool'
    'gdbm' 'gperf' 'expat' 'inetutils' 'less'
    'perl' 'xml-parser' 'intltool' 'autoconf' 'automake'
    'openssl' 'elfutils' 'libffi' 'sqlite' 'python'
    'flit-core' 'packaging' 'wheel' 'setuptools' 'ninja'
    'meson' 'kmod' 'coreutils' 'diffutils' 'gawk'
    'findutils' 'groff' 'grub' 'gzip' 'iproute2'
    'kbd' 'libpipeline' 'make' 'patch' 'tar'
    'texinfo' 'vim' 'markupsafe' 'jinja2' 'systemd'
    'dbus' 'man-db' 'procps-ng' 'util-linux' 'e2fsprogs'
)

build() {
    # Meta-packages do not compile anything. 
    # The build logic is entirely handled by the dependencies.
    :
}

package() {
    # Meta-packages do not install files themselves.
    :
}
