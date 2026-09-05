#!/bin/bash

OUTDIR="lfs-m32-pacscripts"
mkdir -p "$OUTDIR"
cd "$OUTDIR" || exit 1

echo "Generating 113 MLFS packages (including Kernel and Meta package) targeting /mnt/lfs..."
echo "WARNING: Ensure you export LFS_TGT=\"x86_64-lfs-linux-gnu\" in your terminal before building!"

# Awk parses the EOF block, creates the directory, and writes the pacscript cleanly.
awk '
/^#PKG: / {
    pkg = $2
    system("mkdir -p " pkg)
    out = pkg "/" pkg ".pacscript"
    print "Creating " out "..."
    next
}
{
    if (out) print $0 > out
}
' << 'EOF_DATA'
#PKG: binutils-pass1
pkgname=binutils-pass1
pkgver=2.46.0
source=("https://ftp.gnu.org/gnu/binutils/binutils-${pkgver}.tar.xz")
build(){ cd binutils-${pkgver}; mkdir build; cd build; ../configure --prefix=/mnt/lfs/tools --with-sysroot=/mnt/lfs --target=$LFS_TGT --disable-nls --disable-werror; make -j$(nproc); }
package(){ cd binutils-${pkgver}/build; make DESTDIR=$pkgdir install; }

#PKG: gcc-pass1
pkgname=gcc-pass1
pkgver=15.2.0
source=("https://ftp.gnu.org/gnu/gcc/gcc-${pkgver}/gcc-${pkgver}.tar.xz")
build(){ cd gcc-${pkgver}; ./contrib/download_prerequisites; mkdir build; cd build; ../configure --target=$LFS_TGT --prefix=/mnt/lfs/tools --with-glibc-version=2.43 --with-sysroot=/mnt/lfs --with-newlib --without-headers --disable-nls --disable-shared --disable-multilib --disable-threads --enable-languages=c,c++; make -j$(nproc); }
package(){ cd gcc-${pkgver}/build; make DESTDIR=$pkgdir install; }

#PKG: linux-api-headers
pkgname=linux-api-headers
pkgver=6.18.10
source=("https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-${pkgver}.tar.xz")
build(){ cd linux-${pkgver}; make mrproper; make headers; }
package(){ cd linux-${pkgver}; find usr/include -type f ! -name '*.install' -exec install -D -m644 {} $pkgdir/mnt/lfs/{} \;; }

#PKG: glibc-pass1
pkgname=glibc-pass1
pkgver=2.43
source=("https://ftp.gnu.org/gnu/glibc/glibc-${pkgver}.tar.xz")
build(){ cd glibc-${pkgver}; mkdir build; cd build; ../configure --prefix=/usr --host=$LFS_TGT --build=$(../scripts/config.guess) --enable-kernel=4.19 --with-headers=/mnt/lfs/usr/include libc_cv_slibdir=/usr/lib; make -j$(nproc); }
package(){ cd glibc-${pkgver}/build; make DESTDIR=$pkgdir/mnt/lfs install; }

#PKG: libstdc++-pass1
pkgname=libstdc++-pass1
pkgver=15.2.0
source=("https://ftp.gnu.org/gnu/gcc/gcc-${pkgver}/gcc-${pkgver}.tar.xz")
build(){ cd gcc-${pkgver}; mkdir build; cd build; ../libstdc++-v3/configure --host=$LFS_TGT --build=$(../config.guess) --prefix=/usr --disable-multilib --disable-nls --with-gxx-include-dir=/mnt/lfs/tools/$LFS_TGT/include/c++/${pkgver}; make -j$(nproc); }
package(){ cd gcc-${pkgver}/build; make DESTDIR=$pkgdir/mnt/lfs install; }

#PKG: m4-temp
pkgname=m4-temp
pkgver=1.4.21
source=("https://ftp.gnu.org/gnu/m4/m4-${pkgver}.tar.xz")
build(){ cd m4-${pkgver}; ./configure --prefix=/usr --host=$LFS_TGT --build=$(build-aux/config.guess); make -j$(nproc); }
package(){ cd m4-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs install; }

#PKG: ncurses-temp
pkgname=ncurses-temp
pkgver=6.6
source=("https://invisible-mirror.net/archives/ncurses/ncurses-${pkgver}.tar.gz")
build(){ cd ncurses-${pkgver}; ./configure --prefix=/usr --host=$LFS_TGT --build=$(./config.guess) --with-shared --without-debug --without-ada --enable-widec; make -j$(nproc); }
package(){ cd ncurses-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs install; }

#PKG: bash-temp
pkgname=bash-temp
pkgver=5.3
source=("https://ftp.gnu.org/gnu/bash/bash-${pkgver}.tar.gz")
build(){ cd bash-${pkgver}; ./configure --prefix=/usr --build=$(support/config.guess) --host=$LFS_TGT --without-bash-malloc; make -j$(nproc); }
package(){ cd bash-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs install; }

#PKG: coreutils-temp
pkgname=coreutils-temp
pkgver=9.10
source=("https://ftp.gnu.org/gnu/coreutils/coreutils-${pkgver}.tar.xz")
build(){ cd coreutils-${pkgver}; ./configure --prefix=/usr --host=$LFS_TGT --build=$(build-aux/config.guess) --enable-install-program=hostname --enable-no-install-program=kill,uptime; make -j$(nproc); }
package(){ cd coreutils-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs install; }

#PKG: diffutils-temp
pkgname=diffutils-temp
pkgver=3.12
source=("https://ftp.gnu.org/gnu/diffutils/diffutils-${pkgver}.tar.xz")
build(){ cd diffutils-${pkgver}; ./configure --prefix=/usr --host=$LFS_TGT; make -j$(nproc); }
package(){ cd diffutils-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs install; }

#PKG: file-temp
pkgname=file-temp
pkgver=5.46
source=("https://astron.com/pub/file/file-${pkgver}.tar.gz")
build(){ cd file-${pkgver}; mkdir build; pushd build; ../configure --disable-bzlib --disable-libseccomp --disable-xzlib --disable-zlib; make; popd; ./configure --prefix=/usr --host=$LFS_TGT --build=$(./config.guess); make -j$(nproc); }
package(){ cd file-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs install; }

#PKG: findutils-temp
pkgname=findutils-temp
pkgver=4.10.0
source=("https://ftp.gnu.org/gnu/findutils/findutils-${pkgver}.tar.xz")
build(){ cd findutils-${pkgver}; ./configure --prefix=/usr --host=$LFS_TGT --build=$(build-aux/config.guess); make -j$(nproc); }
package(){ cd findutils-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs install; }

#PKG: gawk-temp
pkgname=gawk-temp
pkgver=5.3.2
source=("https://ftp.gnu.org/gnu/gawk/gawk-${pkgver}.tar.xz")
build(){ cd gawk-${pkgver}; ./configure --prefix=/usr --host=$LFS_TGT --build=$(build-aux/config.guess); make -j$(nproc); }
package(){ cd gawk-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs install; }

#PKG: grep-temp
pkgname=grep-temp
pkgver=3.12
source=("https://ftp.gnu.org/gnu/grep/grep-${pkgver}.tar.xz")
build(){ cd grep-${pkgver}; ./configure --prefix=/usr --host=$LFS_TGT; make -j$(nproc); }
package(){ cd grep-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs install; }

#PKG: gzip-temp
pkgname=gzip-temp
pkgver=1.14
source=("https://ftp.gnu.org/gnu/gzip/gzip-${pkgver}.tar.xz")
build(){ cd gzip-${pkgver}; ./configure --prefix=/usr --host=$LFS_TGT; make -j$(nproc); }
package(){ cd gzip-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs install; }

#PKG: make-temp
pkgname=make-temp
pkgver=4.4.1
source=("https://ftp.gnu.org/gnu/make/make-${pkgver}.tar.gz")
build(){ cd make-${pkgver}; ./configure --prefix=/usr --without-guile --host=$LFS_TGT --build=$(build-aux/config.guess); make -j$(nproc); }
package(){ cd make-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs install; }

#PKG: patch-temp
pkgname=patch-temp
pkgver=2.8
source=("https://ftp.gnu.org/gnu/patch/patch-${pkgver}.tar.xz")
build(){ cd patch-${pkgver}; ./configure --prefix=/usr --host=$LFS_TGT --build=$(build-aux/config.guess); make -j$(nproc); }
package(){ cd patch-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs install; }

#PKG: sed-temp
pkgname=sed-temp
pkgver=4.9
source=("https://ftp.gnu.org/gnu/sed/sed-${pkgver}.tar.xz")
build(){ cd sed-${pkgver}; ./configure --prefix=/usr --host=$LFS_TGT; make -j$(nproc); }
package(){ cd sed-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs install; }

#PKG: tar-temp
pkgname=tar-temp
pkgver=1.35
source=("https://ftp.gnu.org/gnu/tar/tar-${pkgver}.tar.xz")
build(){ cd tar-${pkgver}; ./configure --prefix=/usr --host=$LFS_TGT --build=$(build-aux/config.guess); make -j$(nproc); }
package(){ cd tar-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs install; }

#PKG: xz-temp
pkgname=xz-temp
pkgver=5.8.2
source=("https://github.com/tukaani-project/xz/releases/download/v${pkgver}/xz-${pkgver}.tar.xz")
build(){ cd xz-${pkgver}; ./configure --prefix=/usr --host=$LFS_TGT --build=$(build-aux/config.guess) --disable-static; make -j$(nproc); }
package(){ cd xz-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs install; }

#PKG: binutils-pass2
pkgname=binutils-pass2
pkgver=2.46.0
source=("https://ftp.gnu.org/gnu/binutils/binutils-${pkgver}.tar.xz")
build(){ cd binutils-${pkgver}; mkdir build; cd build; ../configure --prefix=/usr --build=$(../config.guess) --host=$LFS_TGT --disable-nls --enable-shared --enable-gprofng=no --disable-werror --enable-64-bit-bfd; make -j$(nproc); }
package(){ cd binutils-${pkgver}/build; make DESTDIR=$pkgdir/mnt/lfs install; }

#PKG: gcc-pass2
pkgname=gcc-pass2
pkgver=15.2.0
source=("https://ftp.gnu.org/gnu/gcc/gcc-${pkgver}/gcc-${pkgver}.tar.xz")
build(){ cd gcc-${pkgver}; ./contrib/download_prerequisites; mkdir build; cd build; ../configure --build=$(../config.guess) --host=$LFS_TGT --prefix=/usr --CC_FOR_TARGET=$LFS_TGT-gcc --with-build-sysroot=/mnt/lfs --enable-languages=c,c++ --disable-nls --disable-multilib; make -j$(nproc); }
package(){ cd gcc-${pkgver}/build; make DESTDIR=$pkgdir/mnt/lfs install; }

#PKG: gettext-temp
pkgname=gettext-temp
pkgver=1.0
source=("https://ftp.gnu.org/gnu/gettext/gettext-${pkgver}.tar.xz")
build(){ cd gettext-${pkgver}; ./configure --disable-shared; make -j$(nproc); }
package(){ cd gettext-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs install; }

#PKG: bison-temp
pkgname=bison-temp
pkgver=3.8.2
source=("https://ftp.gnu.org/gnu/bison/bison-${pkgver}.tar.xz")
build(){ cd bison-${pkgver}; ./configure --prefix=/usr; make -j$(nproc); }
package(){ cd bison-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs install; }

#PKG: perl-temp
pkgname=perl-temp
pkgver=5.42.0
source=("https://www.cpan.org/src/5.0/perl-${pkgver}.tar.gz")
build(){ cd perl-${pkgver}; sh Configure -des -Dprefix=/usr -Dvendorprefix=/usr; make -j$(nproc); }
package(){ cd perl-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs install; }

#PKG: python-temp
pkgname=python-temp
pkgver=3.14.3
source=("https://www.python.org/ftp/python/${pkgver}/Python-${pkgver}.tar.xz")
build(){ cd Python-${pkgver}; ./configure --prefix=/usr --enable-shared --without-ensurepip; make -j$(nproc); }
package(){ cd Python-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs install; }

#PKG: texinfo-temp
pkgname=texinfo-temp
pkgver=7.2
source=("https://ftp.gnu.org/gnu/texinfo/texinfo-${pkgver}.tar.xz")
build(){ cd texinfo-${pkgver}; ./configure --prefix=/usr; make -j$(nproc); }
package(){ cd texinfo-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs install; }

#PKG: util-linux-temp
pkgname=util-linux-temp
pkgver=2.41.3
source=("https://www.kernel.org/pub/linux/utils/util-linux/v2.41/util-linux-${pkgver}.tar.xz")
build(){ cd util-linux-${pkgver}; ./configure --prefix=/usr --without-python --disable-makeinstall-chown --without-systemd --without-ncurses; make -j$(nproc); }
package(){ cd util-linux-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs install; }

#PKG: man-pages
pkgname=man-pages
pkgver=6.17
source=("https://www.kernel.org/pub/linux/docs/man-pages/man-pages-${pkgver}.tar.xz")
build(){ :; }
package(){ cd man-pages-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs prefix=/usr install; }

#PKG: iana-etc
pkgname=iana-etc
pkgver=20260202
source=("https://github.com/Mic92/iana-etc/releases/download/${pkgver}/iana-etc-${pkgver}.tar.gz")
build(){ :; }
package(){ cd iana-etc-${pkgver}; install -D -m644 services $pkgdir/mnt/lfs/etc/services; install -D -m644 protocols $pkgdir/mnt/lfs/etc/protocols; }

#PKG: glibc
pkgname=glibc
pkgver=2.43
source=("https://ftp.gnu.org/gnu/glibc/glibc-${pkgver}.tar.xz")
build(){ cd glibc-${pkgver}; mkdir build32 build64; cd build32; echo "rootsbindir=/usr/sbin" > configparms; CC="gcc -m32" CXX="g++ -m32" ../configure --prefix=/usr --host=i686-pc-linux-gnu --build=$(../scripts/config.guess) --enable-kernel=4.19 --with-headers=/mnt/lfs/usr/include libc_cv_slibdir=/usr/lib32 libdir=/usr/lib32; make -j$(nproc); cd ../build64; echo "rootsbindir=/usr/sbin" > configparms; ../configure --prefix=/usr --enable-kernel=4.19 --with-headers=/mnt/lfs/usr/include libc_cv_slibdir=/usr/lib; make -j$(nproc); }
package(){ cd glibc-${pkgver}/build32; make DESTDIR=$srcdir/m32 install; cd ../build64; make DESTDIR=$pkgdir/mnt/lfs install; cp -a $srcdir/m32/usr/lib32 $pkgdir/mnt/lfs/usr/; }

#PKG: zlib
pkgname=zlib
pkgver=1.3.2
source=("https://zlib.net/zlib-${pkgver}.tar.gz")
build(){ cd zlib-${pkgver}; CC="gcc -m32" ./configure --prefix=/usr --libdir=/usr/lib32; make; make DESTDIR=$srcdir/m32 install; make clean; ./configure --prefix=/usr; make; }
package(){ cd zlib-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs install; cp -a $srcdir/m32/usr/lib32 $pkgdir/mnt/lfs/usr/; }

#PKG: bzip2
pkgname=bzip2
pkgver=1.0.8
source=("https://www.sourceware.org/pub/bzip2/bzip2-${pkgver}.tar.gz")
build(){ cd bzip2-${pkgver}; make -f Makefile-libbz2_so CC="gcc -m32"; make CC="gcc -m32" libbz2.a; mkdir m32; cp libbz2.so* libbz2.a m32/; make clean; make -f Makefile-libbz2_so; make; }
package(){ cd bzip2-${pkgver}; make PREFIX=$pkgdir/mnt/lfs/usr install; cp -a libbz2.so* $pkgdir/mnt/lfs/usr/lib/; mkdir -p $pkgdir/mnt/lfs/usr/lib32; cp -a m32/libbz2.so* m32/libbz2.a $pkgdir/mnt/lfs/usr/lib32/; }

#PKG: xz
pkgname=xz
pkgver=5.8.2
source=("https://github.com/tukaani-project/xz/releases/download/v${pkgver}/xz-${pkgver}.tar.xz")
build(){ cd xz-${pkgver}; CC="gcc -m32" ./configure --prefix=/usr --libdir=/usr/lib32 --disable-static; make; make DESTDIR=$srcdir/m32 install; make clean; ./configure --prefix=/usr --disable-static; make; }
package(){ cd xz-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs install; cp -a $srcdir/m32/usr/lib32 $pkgdir/mnt/lfs/usr/; }

#PKG: lz4
pkgname=lz4
pkgver=1.10.0
source=("https://github.com/lz4/lz4/archive/v${pkgver}/lz4-${pkgver}.tar.gz")
build(){ cd lz4-${pkgver}; make BUILD_STATIC=no CC="gcc -m32"; make DESTDIR=$srcdir/m32 PREFIX=/usr LIBDIR=/usr/lib32 install; make clean; make BUILD_STATIC=no; }
package(){ cd lz4-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs PREFIX=/usr install; cp -a $srcdir/m32/usr/lib32 $pkgdir/mnt/lfs/usr/; }

#PKG: zstd
pkgname=zstd
pkgver=1.5.7
source=("https://github.com/facebook/zstd/releases/download/v${pkgver}/zstd-${pkgver}.tar.gz")
build(){ cd zstd-${pkgver}; make CC="gcc -m32" prefix=/usr libdir=/usr/lib32; make DESTDIR=$srcdir/m32 prefix=/usr libdir=/usr/lib32 install; make clean; make prefix=/usr; }
package(){ cd zstd-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs prefix=/usr install; cp -a $srcdir/m32/usr/lib32 $pkgdir/mnt/lfs/usr/; }

#PKG: file
pkgname=file
pkgver=5.46
source=("https://astron.com/pub/file/file-${pkgver}.tar.gz")
build(){ cd file-${pkgver}; CC="gcc -m32" ./configure --prefix=/usr --libdir=/usr/lib32; make; make DESTDIR=$srcdir/m32 install; make clean; ./configure --prefix=/usr; make; }
package(){ cd file-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs install; cp -a $srcdir/m32/usr/lib32 $pkgdir/mnt/lfs/usr/; }

#PKG: readline
pkgname=readline
pkgver=8.3
source=("https://ftp.gnu.org/gnu/readline/readline-${pkgver}.tar.gz")
build(){ cd readline-${pkgver}; CC="gcc -m32" ./configure --prefix=/usr --libdir=/usr/lib32 --disable-static; make SHLIB_LIBS="-lncursesw"; make DESTDIR=$srcdir/m32 install; make clean; ./configure --prefix=/usr --disable-static; make SHLIB_LIBS="-lncursesw"; }
package(){ cd readline-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs install; cp -a $srcdir/m32/usr/lib32 $pkgdir/mnt/lfs/usr/; }

#PKG: pcre2
pkgname=pcre2
pkgver=10.47
source=("https://github.com/PCRE2Project/pcre2/releases/download/pcre2-${pkgver}/pcre2-${pkgver}.tar.bz2")
build(){ cd pcre2-${pkgver}; CC="gcc -m32" ./configure --prefix=/usr --libdir=/usr/lib32 --enable-unicode --enable-jit --enable-pcre2-16 --enable-pcre2-32; make; make DESTDIR=$srcdir/m32 install; make clean; ./configure --prefix=/usr --enable-unicode --enable-jit --enable-pcre2-16 --enable-pcre2-32; make; }
package(){ cd pcre2-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs install; cp -a $srcdir/m32/usr/lib32 $pkgdir/mnt/lfs/usr/; }

#PKG: m4
pkgname=m4
pkgver=1.4.21
source=("https://ftp.gnu.org/gnu/m4/m4-${pkgver}.tar.xz")
build(){ cd m4-${pkgver}; ./configure --prefix=/usr; make -j$(nproc); }
package(){ cd m4-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs install; }

#PKG: bc
pkgname=bc
pkgver=7.0.3
source=("https://github.com/gavinhoward/bc/releases/download/${pkgver}/bc-${pkgver}.tar.xz")
build(){ cd bc-${pkgver}; CC=gcc ./configure --prefix=/usr -G -O3; make -j$(nproc); }
package(){ cd bc-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs install; }

#PKG: flex
pkgname=flex
pkgver=2.6.4
source=("https://github.com/westes/flex/releases/download/v${pkgver}/flex-${pkgver}.tar.gz")
build(){ cd flex-${pkgver}; CC="gcc -m32" ./configure --prefix=/usr --libdir=/usr/lib32 --disable-static; make; make DESTDIR=$srcdir/m32 install; make clean; ./configure --prefix=/usr --disable-static; make; }
package(){ cd flex-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs install; cp -a $srcdir/m32/usr/lib32 $pkgdir/mnt/lfs/usr/; }

#PKG: tcl
pkgname=tcl
pkgver=8.6.17
source=("https://downloads.sourceforge.net/tcl/tcl${pkgver}-src.tar.gz")
build(){ cd tcl${pkgver}/unix; ./configure --prefix=/usr; make -j$(nproc); }
package(){ cd tcl${pkgver}/unix; make DESTDIR=$pkgdir/mnt/lfs install; }

#PKG: expect
pkgname=expect
pkgver=5.45.4
source=("https://downloads.sourceforge.net/expect/expect${pkgver}.tar.gz")
build(){ cd expect${pkgver}; ./configure --prefix=/usr --with-tcl=/usr/lib; make -j$(nproc); }
package(){ cd expect${pkgver}; make DESTDIR=$pkgdir/mnt/lfs install; }

#PKG: dejagnu
pkgname=dejagnu
pkgver=1.6.3
source=("https://ftp.gnu.org/gnu/dejagnu/dejagnu-${pkgver}.tar.gz")
build(){ cd dejagnu-${pkgver}; ./configure --prefix=/usr; make -j$(nproc); }
package(){ cd dejagnu-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs install; }

#PKG: pkgconf
pkgname=pkgconf
pkgver=2.5.1
source=("https://distfiles.dereferenced.org/pkgconf/pkgconf-${pkgver}.tar.xz")
build(){ cd pkgconf-${pkgver}; ./configure --prefix=/usr; make -j$(nproc); }
package(){ cd pkgconf-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs install; }

#PKG: binutils
pkgname=binutils
pkgver=2.46.0
source=("https://ftp.gnu.org/gnu/binutils/binutils-${pkgver}.tar.xz")
build(){ cd binutils-${pkgver}; mkdir build; cd build; ../configure --prefix=/usr --enable-gold --enable-ld=default --enable-plugins --enable-shared --disable-werror --enable-64-bit-bfd --enable-multilib --with-system-zlib; make -j$(nproc) tooldir=/usr; }
package(){ cd binutils-${pkgver}/build; make DESTDIR=$pkgdir/mnt/lfs tooldir=/usr install; }

#PKG: gmp
pkgname=gmp
pkgver=6.3.0
source=("https://ftp.gnu.org/gnu/gmp/gmp-${pkgver}.tar.xz")
build(){ cd gmp-${pkgver}; ABI=32 ./configure --prefix=/usr --libdir=/usr/lib32 --host=i686-pc-linux-gnu; make; make DESTDIR=$srcdir/m32 install; make clean; ./configure --prefix=/usr --enable-cxx; make; }
package(){ cd gmp-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs install; cp -a $srcdir/m32/usr/lib32 $pkgdir/mnt/lfs/usr/; }

#PKG: mpfr
pkgname=mpfr
pkgver=4.2.2
source=("https://ftp.gnu.org/gnu/mpfr/mpfr-${pkgver}.tar.xz")
build(){ cd mpfr-${pkgver}; CC="gcc -m32" ./configure --prefix=/usr --libdir=/usr/lib32; make; make DESTDIR=$srcdir/m32 install; make clean; ./configure --prefix=/usr; make; }
package(){ cd mpfr-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs install; cp -a $srcdir/m32/usr/lib32 $pkgdir/mnt/lfs/usr/; }

#PKG: mpc
pkgname=mpc
pkgver=1.3.1
source=("https://ftp.gnu.org/gnu/mpc/mpc-${pkgver}.tar.gz")
build(){ cd mpc-${pkgver}; CC="gcc -m32" ./configure --prefix=/usr --libdir=/usr/lib32; make; make DESTDIR=$srcdir/m32 install; make clean; ./configure --prefix=/usr; make; }
package(){ cd mpc-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs install; cp -a $srcdir/m32/usr/lib32 $pkgdir/mnt/lfs/usr/; }

#PKG: isl
pkgname=isl
pkgver=0.27
source=("https://libisl.sourceforge.io/isl-${pkgver}.tar.xz")
build(){ cd isl-${pkgver}; CC="gcc -m32" ./configure --prefix=/usr --libdir=/usr/lib32; make; make DESTDIR=$srcdir/m32 install; make clean; ./configure --prefix=/usr; make; }
package(){ cd isl-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs install; cp -a $srcdir/m32/usr/lib32 $pkgdir/mnt/lfs/usr/; }

#PKG: attr
pkgname=attr
pkgver=2.5.2
source=("https://savannah.nongnu.org/download/attr/attr-${pkgver}.tar.gz")
build(){ cd attr-${pkgver}; CC="gcc -m32" ./configure --prefix=/usr --libdir=/usr/lib32 --disable-static; make; make DESTDIR=$srcdir/m32 install; make clean; ./configure --prefix=/usr --disable-static; make; }
package(){ cd attr-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs install; cp -a $srcdir/m32/usr/lib32 $pkgdir/mnt/lfs/usr/; }

#PKG: acl
pkgname=acl
pkgver=2.3.2
source=("https://savannah.nongnu.org/download/acl/acl-${pkgver}.tar.xz")
build(){ cd acl-${pkgver}; CC="gcc -m32" ./configure --prefix=/usr --libdir=/usr/lib32 --disable-static; make; make DESTDIR=$srcdir/m32 install; make clean; ./configure --prefix=/usr --disable-static; make; }
package(){ cd acl-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs install; cp -a $srcdir/m32/usr/lib32 $pkgdir/mnt/lfs/usr/; }

#PKG: libcap
pkgname=libcap
pkgver=2.77
source=("https://www.kernel.org/pub/linux/libs/security/linux-privs/libcap2/libcap-${pkgver}.tar.xz")
build(){ cd libcap-${pkgver}; make CC="gcc -m32" lib=lib32; make DESTDIR=$srcdir/m32 lib=lib32 install; make clean; make lib=lib; }
package(){ cd libcap-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs lib=lib install; cp -a $srcdir/m32/usr/lib32 $pkgdir/mnt/lfs/usr/; }

#PKG: libxcrypt
pkgname=libxcrypt
pkgver=4.5.2
source=("https://github.com/besser82/libxcrypt/releases/download/v${pkgver}/libxcrypt-${pkgver}.tar.xz")
build(){ cd libxcrypt-${pkgver}; CC="gcc -m32" ./configure --prefix=/usr --libdir=/usr/lib32 --disable-static; make; make DESTDIR=$srcdir/m32 install; make clean; ./configure --prefix=/usr --disable-static; make; }
package(){ cd libxcrypt-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs install; cp -a $srcdir/m32/usr/lib32 $pkgdir/mnt/lfs/usr/; }

#PKG: shadow
pkgname=shadow
pkgver=4.19.3
source=("https://github.com/shadow-maint/shadow/releases/download/v${pkgver}/shadow-${pkgver}.tar.xz")
build(){ cd shadow-${pkgver}; ./configure --prefix=/usr --sysconfdir=/etc --with-group-name-max-length=32; make -j$(nproc); }
package(){ cd shadow-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs install; }

#PKG: gcc
pkgname=gcc
pkgver=15.2.0
source=("https://ftp.gnu.org/gnu/gcc/gcc-${pkgver}/gcc-${pkgver}.tar.xz")
build(){ cd gcc-${pkgver}; sed -e '/m64=/s/lib64/lib/' -i.orig gcc/config/i386/t-linux64; mkdir build; cd build; ../configure --prefix=/usr LD=ld --enable-languages=c,c++ --enable-default-pie --enable-default-ssp --disable-nls --enable-multilib --with-multilib-list=m64,m32 --with-system-zlib; make -j$(nproc); }
package(){ cd gcc-${pkgver}/build; make DESTDIR=$pkgdir/mnt/lfs install; ln -sv gcc $pkgdir/mnt/lfs/usr/bin/cc; }

#PKG: ncurses
pkgname=ncurses
pkgver=6.6
source=("https://invisible-mirror.net/archives/ncurses/ncurses-${pkgver}.tar.gz")
build(){ cd ncurses-${pkgver}; CC="gcc -m32" CXX="g++ -m32" ./configure --prefix=/usr --libdir=/usr/lib32 --with-shared --without-debug --enable-widec; make; make DESTDIR=$srcdir/m32 install; make clean; ./configure --prefix=/usr --with-shared --without-debug --enable-widec; make; }
package(){ cd ncurses-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs install; cp -a $srcdir/m32/usr/lib32 $pkgdir/mnt/lfs/usr/; }

#PKG: sed
pkgname=sed
pkgver=4.9
source=("https://ftp.gnu.org/gnu/sed/sed-${pkgver}.tar.xz")
build(){ cd sed-${pkgver}; ./configure --prefix=/usr; make -j$(nproc); }
package(){ cd sed-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs install; }

#PKG: psmisc
pkgname=psmisc
pkgver=23.7
source=("https://downloads.sourceforge.net/psmisc/psmisc-${pkgver}.tar.xz")
build(){ cd psmisc-${pkgver}; ./configure --prefix=/usr; make -j$(nproc); }
package(){ cd psmisc-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs install; }

#PKG: gettext
pkgname=gettext
pkgver=1.0
source=("https://ftp.gnu.org/gnu/gettext/gettext-${pkgver}.tar.xz")
build(){ cd gettext-${pkgver}; CC="gcc -m32" ./configure --prefix=/usr --libdir=/usr/lib32 --disable-static; make; make DESTDIR=$srcdir/m32 install; make clean; ./configure --prefix=/usr --disable-static; make; }
package(){ cd gettext-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs install; cp -a $srcdir/m32/usr/lib32 $pkgdir/mnt/lfs/usr/; }

#PKG: bison
pkgname=bison
pkgver=3.8.2
source=("https://ftp.gnu.org/gnu/bison/bison-${pkgver}.tar.xz")
build(){ cd bison-${pkgver}; ./configure --prefix=/usr; make -j$(nproc); }
package(){ cd bison-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs install; }

#PKG: grep
pkgname=grep
pkgver=3.12
source=("https://ftp.gnu.org/gnu/grep/grep-${pkgver}.tar.xz")
build(){ cd grep-${pkgver}; ./configure --prefix=/usr; make -j$(nproc); }
package(){ cd grep-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs install; }

#PKG: bash
pkgname=bash
pkgver=5.3
source=("https://ftp.gnu.org/gnu/bash/bash-${pkgver}.tar.gz")
build(){ cd bash-${pkgver}; ./configure --prefix=/usr --without-bash-malloc --with-installed-readline; make -j$(nproc); }
package(){ cd bash-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs install; }

#PKG: libtool
pkgname=libtool
pkgver=2.5.4
source=("https://ftp.gnu.org/gnu/libtool/libtool-${pkgver}.tar.xz")
build(){ cd libtool-${pkgver}; CC="gcc -m32" ./configure --prefix=/usr --libdir=/usr/lib32; make; make DESTDIR=$srcdir/m32 install; make clean; ./configure --prefix=/usr; make; }
package(){ cd libtool-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs install; cp -a $srcdir/m32/usr/lib32 $pkgdir/mnt/lfs/usr/; }

#PKG: gdbm
pkgname=gdbm
pkgver=1.26
source=("https://ftp.gnu.org/gnu/gdbm/gdbm-${pkgver}.tar.gz")
build(){ cd gdbm-${pkgver}; CC="gcc -m32" ./configure --prefix=/usr --libdir=/usr/lib32 --disable-static --enable-libgdbm-compat; make; make DESTDIR=$srcdir/m32 install; make clean; ./configure --prefix=/usr --disable-static --enable-libgdbm-compat; make; }
package(){ cd gdbm-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs install; cp -a $srcdir/m32/usr/lib32 $pkgdir/mnt/lfs/usr/; }

#PKG: gperf
pkgname=gperf
pkgver=3.3
source=("https://ftp.gnu.org/gnu/gperf/gperf-${pkgver}.tar.gz")
build(){ cd gperf-${pkgver}; ./configure --prefix=/usr; make -j$(nproc); }
package(){ cd gperf-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs install; }

#PKG: expat
pkgname=expat
pkgver=2.7.4
source=("https://github.com/libexpat/libexpat/releases/download/R_${pkgver//./_}/expat-${pkgver}.tar.xz")
build(){ cd expat-${pkgver}; CC="gcc -m32" ./configure --prefix=/usr --libdir=/usr/lib32 --disable-static; make; make DESTDIR=$srcdir/m32 install; make clean; ./configure --prefix=/usr --disable-static; make; }
package(){ cd expat-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs install; cp -a $srcdir/m32/usr/lib32 $pkgdir/mnt/lfs/usr/; }

#PKG: inetutils
pkgname=inetutils
pkgver=2.7
source=("https://ftp.gnu.org/gnu/inetutils/inetutils-${pkgver}.tar.xz")
build(){ cd inetutils-${pkgver}; ./configure --prefix=/usr --disable-servers; make -j$(nproc); }
package(){ cd inetutils-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs install; }

#PKG: less
pkgname=less
pkgver=692
source=("https://www.greenwoodsoftware.com/less/less-${pkgver}.tar.gz")
build(){ cd less-${pkgver}; ./configure --prefix=/usr; make -j$(nproc); }
package(){ cd less-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs install; }

#PKG: perl
pkgname=perl
pkgver=5.42.0
source=("https://www.cpan.org/src/5.0/perl-${pkgver}.tar.gz")
build(){ cd perl-${pkgver}; sh Configure -des -Dprefix=/usr -Dvendorprefix=/usr -Dprivlib=/usr/lib/perl5/${pkgver}/core_perl -Darchlib=/usr/lib/perl5/${pkgver}/core_perl -Dsitelib=/usr/lib/perl5/${pkgver}/site_perl -Dsitearch=/usr/lib/perl5/${pkgver}/site_perl -Dvendorlib=/usr/lib/perl5/${pkgver}/vendor_perl -Dvendorarch=/usr/lib/perl5/${pkgver}/vendor_perl; make -j$(nproc); }
package(){ cd perl-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs install; }

#PKG: xml-parser
pkgname=xml-parser
pkgver=2.47
source=("https://cpan.metacpan.org/authors/id/T/TO/TODDR/XML-Parser-${pkgver}.tar.gz")
build(){ cd XML-Parser-${pkgver}; perl Makefile.PL; make -j$(nproc); }
package(){ cd XML-Parser-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs install; }

#PKG: intltool
pkgname=intltool
pkgver=0.51.0
source=("https://launchpad.net/intltool/trunk/${pkgver}/+download/intltool-${pkgver}.tar.gz")
build(){ cd intltool-${pkgver}; ./configure --prefix=/usr; make -j$(nproc); }
package(){ cd intltool-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs install; }

#PKG: autoconf
pkgname=autoconf
pkgver=2.72
source=("https://ftp.gnu.org/gnu/autoconf/autoconf-${pkgver}.tar.xz")
build(){ cd autoconf-${pkgver}; ./configure --prefix=/usr; make -j$(nproc); }
package(){ cd autoconf-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs install; }

#PKG: automake
pkgname=automake
pkgver=1.18.1
source=("https://ftp.gnu.org/gnu/automake/automake-${pkgver}.tar.xz")
build(){ cd automake-${pkgver}; ./configure --prefix=/usr; make -j$(nproc); }
package(){ cd automake-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs install; }

#PKG: openssl
pkgname=openssl
pkgver=3.6.1
source=("https://www.openssl.org/source/openssl-${pkgver}.tar.gz")
build(){ cd openssl-${pkgver}; ./Configure linux-elf --prefix=/usr --libdir=lib32 shared zlib-dynamic; make; make DESTDIR=$srcdir/m32 install; make clean; ./Configure linux-x86_64 --prefix=/usr --libdir=lib shared zlib-dynamic; make; }
package(){ cd openssl-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs install; cp -a $srcdir/m32/usr/lib32 $pkgdir/mnt/lfs/usr/; }

#PKG: elfutils
pkgname=elfutils
pkgver=0.194
source=("https://sourceware.org/elfutils/ftp/${pkgver}/elfutils-${pkgver}.tar.bz2")
build(){ cd elfutils-${pkgver}; CC="gcc -m32" ./configure --prefix=/usr --libdir=/usr/lib32 --disable-debuginfod --disable-libdebuginfod; make; make DESTDIR=$srcdir/m32 install; make clean; ./configure --prefix=/usr --disable-debuginfod --disable-libdebuginfod; make; }
package(){ cd elfutils-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs install; cp -a $srcdir/m32/usr/lib32 $pkgdir/mnt/lfs/usr/; }

#PKG: libffi
pkgname=libffi
pkgver=3.5.2
source=("https://github.com/libffi/libffi/releases/download/v${pkgver}/libffi-${pkgver}.tar.gz")
build(){ cd libffi-${pkgver}; CC="gcc -m32" ./configure --prefix=/usr --libdir=/usr/lib32 --disable-static; make; make DESTDIR=$srcdir/m32 install; make clean; ./configure --prefix=/usr --disable-static; make; }
package(){ cd libffi-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs install; cp -a $srcdir/m32/usr/lib32 $pkgdir/mnt/lfs/usr/; }

#PKG: sqlite
pkgname=sqlite
pkgver=3510200
source=("https://sqlite.org/2026/sqlite-autoconf-${pkgver}.tar.gz")
build(){ cd sqlite-autoconf-${pkgver}; CC="gcc -m32" ./configure --prefix=/usr --libdir=/usr/lib32 --disable-static; make; make DESTDIR=$srcdir/m32 install; make clean; ./configure --prefix=/usr --disable-static; make; }
package(){ cd sqlite-autoconf-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs install; cp -a $srcdir/m32/usr/lib32 $pkgdir/mnt/lfs/usr/; }

#PKG: python
pkgname=python
pkgver=3.14.3
source=("https://www.python.org/ftp/python/${pkgver}/Python-${pkgver}.tar.xz")
build(){ cd Python-${pkgver}; ./configure --prefix=/usr --enable-shared --with-system-expat --with-system-ffi --enable-optimizations; make -j$(nproc); }
package(){ cd Python-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs install; }

#PKG: flit-core
pkgname=flit-core
pkgver=3.12.0
source=("https://files.pythonhosted.org/packages/source/f/flit_core/flit_core-${pkgver}.tar.gz")
build(){ cd flit_core-${pkgver}; pip3 wheel -w dist --no-build-isolation --no-deps $PWD; }
package(){ cd flit_core-${pkgver}; pip3 install --no-index --find-links dist --no-cache-dir --no-user --root $pkgdir/mnt/lfs flit_core; }

#PKG: packaging
pkgname=packaging
pkgver=26.0
source=("https://files.pythonhosted.org/packages/source/p/packaging/packaging-${pkgver}.tar.gz")
build(){ cd packaging-${pkgver}; pip3 wheel -w dist --no-build-isolation --no-deps $PWD; }
package(){ cd packaging-${pkgver}; pip3 install --no-index --find-links dist --no-cache-dir --no-user --root $pkgdir/mnt/lfs packaging; }

#PKG: wheel
pkgname=wheel
pkgver=0.46.3
source=("https://files.pythonhosted.org/packages/source/w/wheel/wheel-${pkgver}.tar.gz")
build(){ cd wheel-${pkgver}; pip3 wheel -w dist --no-build-isolation --no-deps $PWD; }
package(){ cd wheel-${pkgver}; pip3 install --no-index --find-links dist --no-cache-dir --no-user --root $pkgdir/mnt/lfs wheel; }

#PKG: setuptools
pkgname=setuptools
pkgver=82.0.0
source=("https://files.pythonhosted.org/packages/source/s/setuptools/setuptools-${pkgver}.tar.gz")
build(){ cd setuptools-${pkgver}; pip3 wheel -w dist --no-build-isolation --no-deps $PWD; }
package(){ cd setuptools-${pkgver}; pip3 install --no-index --find-links dist --no-cache-dir --no-user --root $pkgdir/mnt/lfs setuptools; }

#PKG: ninja
pkgname=ninja
pkgver=1.13.2
source=("https://github.com/ninja-build/ninja/archive/v${pkgver}/ninja-${pkgver}.tar.gz")
build(){ cd ninja-${pkgver}; python3 configure.py --bootstrap; }
package(){ cd ninja-${pkgver}; install -D -m755 ninja $pkgdir/mnt/lfs/usr/bin/ninja; }

#PKG: meson
pkgname=meson
pkgver=1.10.1
source=("https://github.com/mesonbuild/meson/releases/download/${pkgver}/meson-${pkgver}.tar.gz")
build(){ cd meson-${pkgver}; pip3 wheel -w dist --no-build-isolation --no-deps $PWD; }
package(){ cd meson-${pkgver}; pip3 install --no-index --find-links dist --no-cache-dir --no-user --root $pkgdir/mnt/lfs meson; }

#PKG: kmod
pkgname=kmod
pkgver=34.2
source=("https://www.kernel.org/pub/linux/utils/kernel/kmod/kmod-${pkgver}.tar.xz")
build(){ cd kmod-${pkgver}; CC="gcc -m32" ./configure --prefix=/usr --libdir=/usr/lib32 --sysconfdir=/etc --with-xz --with-zstd --with-zlib; make; make DESTDIR=$srcdir/m32 install; make clean; ./configure --prefix=/usr --sysconfdir=/etc --with-xz --with-zstd --with-zlib; make; }
package(){ cd kmod-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs install; cp -a $srcdir/m32/usr/lib32 $pkgdir/mnt/lfs/usr/; }

#PKG: coreutils
pkgname=coreutils
pkgver=9.10
source=("https://ftp.gnu.org/gnu/coreutils/coreutils-${pkgver}.tar.xz")
build(){ cd coreutils-${pkgver}; autoreconf -fiv; FORCE_UNSAFE_CONFIGURE=1 ./configure --prefix=/usr --enable-no-install-program=kill,uptime; make -j$(nproc); }
package(){ cd coreutils-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs install; }

#PKG: diffutils
pkgname=diffutils
pkgver=3.12
source=("https://ftp.gnu.org/gnu/diffutils/diffutils-${pkgver}.tar.xz")
build(){ cd diffutils-${pkgver}; ./configure --prefix=/usr; make -j$(nproc); }
package(){ cd diffutils-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs install; }

#PKG: gawk
pkgname=gawk
pkgver=5.3.2
source=("https://ftp.gnu.org/gnu/gawk/gawk-${pkgver}.tar.xz")
build(){ cd gawk-${pkgver}; ./configure --prefix=/usr; make -j$(nproc); }
package(){ cd gawk-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs install; }

#PKG: findutils
pkgname=findutils
pkgver=4.10.0
source=("https://ftp.gnu.org/gnu/findutils/findutils-${pkgver}.tar.xz")
build(){ cd findutils-${pkgver}; ./configure --prefix=/usr --localstatedir=/var/lib/locate; make -j$(nproc); }
package(){ cd findutils-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs install; }

#PKG: groff
pkgname=groff
pkgver=1.23.0
source=("https://ftp.gnu.org/gnu/groff/groff-${pkgver}.tar.gz")
build(){ cd groff-${pkgver}; PAGE=A4 ./configure --prefix=/usr; make -j$(nproc); }
package(){ cd groff-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs install; }

#PKG: grub
pkgname=grub
pkgver=2.14
source=("https://ftp.gnu.org/gnu/grub/grub-${pkgver}.tar.xz")
build(){ cd grub-${pkgver}; ./configure --prefix=/usr --sysconfdir=/etc --disable-efiemu --disable-werror; make -j$(nproc); }
package(){ cd grub-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs install; }

#PKG: grub-efi
pkgname=grub-efi
pkgver=2.14
source=("https://ftp.gnu.org/gnu/grub/grub-${pkgver}.tar.xz")
build(){ cd grub-${pkgver}; unset CFLAGS CPPFLAGS CXXFLAGS LDFLAGS; ./configure --prefix=/usr --sysconfdir=/etc --disable-efiemu --with-platform=efi --target=x86_64 --disable-werror; make -j$(nproc); }
package(){ cd grub-${pkgver}; make -C grub-core DESTDIR=$pkgdir/mnt/lfs install; }

#PKG: gzip
pkgname=gzip
pkgver=1.14
source=("https://ftp.gnu.org/gnu/gzip/gzip-${pkgver}.tar.xz")
build(){ cd gzip-${pkgver}; ./configure --prefix=/usr; make -j$(nproc); }
package(){ cd gzip-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs install; }

#PKG: iproute2
pkgname=iproute2
pkgver=6.18.0
source=("https://www.kernel.org/pub/linux/utils/net/iproute2/iproute2-${pkgver}.tar.xz")
build(){ cd iproute2-${pkgver}; make -j$(nproc); }
package(){ cd iproute2-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs SBINDIR=/usr/sbin install; }

#PKG: kbd
pkgname=kbd
pkgver=2.9.0
source=("https://www.kernel.org/pub/linux/utils/kbd/kbd-${pkgver}.tar.xz")
build(){ cd kbd-${pkgver}; ./configure --prefix=/usr --disable-vlock; make -j$(nproc); }
package(){ cd kbd-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs install; }

#PKG: libpipeline
pkgname=libpipeline
pkgver=1.5.8
source=("https://download.savannah.gnu.org/releases/libpipeline/libpipeline-${pkgver}.tar.gz")
build(){ cd libpipeline-${pkgver}; ./configure --prefix=/usr; make -j$(nproc); }
package(){ cd libpipeline-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs install; }

#PKG: make
pkgname=make
pkgver=4.4.1
source=("https://ftp.gnu.org/gnu/make/make-${pkgver}.tar.gz")
build(){ cd make-${pkgver}; ./configure --prefix=/usr; make -j$(nproc); }
package(){ cd make-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs install; }

#PKG: patch
pkgname=patch
pkgver=2.8
source=("https://ftp.gnu.org/gnu/patch/patch-${pkgver}.tar.xz")
build(){ cd patch-${pkgver}; ./configure --prefix=/usr; make -j$(nproc); }
package(){ cd patch-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs install; }

#PKG: tar
pkgname=tar
pkgver=1.35
source=("https://ftp.gnu.org/gnu/tar/tar-${pkgver}.tar.xz")
build(){ cd tar-${pkgver}; ./configure --prefix=/usr; make -j$(nproc); }
package(){ cd tar-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs install; }

#PKG: texinfo
pkgname=texinfo
pkgver=7.2
source=("https://ftp.gnu.org/gnu/texinfo/texinfo-${pkgver}.tar.xz")
build(){ cd texinfo-${pkgver}; ./configure --prefix=/usr; make -j$(nproc); }
package(){ cd texinfo-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs install; }

#PKG: vim
pkgname=vim
pkgver=9.2.0078
source=("https://github.com/vim/vim/archive/v${pkgver}/vim-${pkgver}.tar.gz")
build(){ cd vim-${pkgver}; echo '#define SYS_VIMRC_FILE "/etc/vimrc"' >> src/feature.h; ./configure --prefix=/usr; make -j$(nproc); }
package(){ cd vim-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs install; }

#PKG: markupsafe
pkgname=markupsafe
pkgver=3.0.3
source=("https://files.pythonhosted.org/packages/source/M/MarkupSafe/MarkupSafe-${pkgver}.tar.gz")
build(){ cd MarkupSafe-${pkgver}; pip3 wheel -w dist --no-build-isolation --no-deps $PWD; }
package(){ cd MarkupSafe-${pkgver}; pip3 install --no-index --find-links dist --no-cache-dir --no-user --root $pkgdir/mnt/lfs MarkupSafe; }

#PKG: jinja2
pkgname=jinja2
pkgver=3.1.6
source=("https://files.pythonhosted.org/packages/source/J/Jinja2/jinja2-${pkgver}.tar.gz")
build(){ cd jinja2-${pkgver}; pip3 wheel -w dist --no-build-isolation --no-deps $PWD; }
package(){ cd jinja2-${pkgver}; pip3 install --no-index --find-links dist --no-cache-dir --no-user --root $pkgdir/mnt/lfs Jinja2; }

#PKG: systemd
pkgname=systemd
pkgver=259.1
source=("https://github.com/systemd/systemd/archive/v${pkgver}/systemd-${pkgver}.tar.gz")
build(){ cd systemd-${pkgver}; mkdir build; cd build; meson setup --prefix=/usr --buildtype=release -Ddefault-dnssec=no -Dfirstboot=false -Dinstall-tests=false -Dldconfig=false -Dsysusers=false -Db_lto=false -Ddocdir=/usr/share/doc/systemd-${pkgver} ..; ninja; }
package(){ cd systemd-${pkgver}/build; DESTDIR=$pkgdir/mnt/lfs ninja install; }

#PKG: dbus
pkgname=dbus
pkgver=1.16.2
source=("https://dbus.freedesktop.org/releases/dbus/dbus-${pkgver}.tar.xz")
build(){ cd dbus-${pkgver}; mkdir build; cd build; meson setup --prefix=/usr --sysconfdir=/etc --localstatedir=/var --buildtype=release ..; ninja; }
package(){ cd dbus-${pkgver}/build; DESTDIR=$pkgdir/mnt/lfs ninja install; }

#PKG: man-db
pkgname=man-db
pkgver=2.13.1
source=("https://download.savannah.gnu.org/releases/man-db/man-db-${pkgver}.tar.xz")
build(){ cd man-db-${pkgver}; ./configure --prefix=/usr --docdir=/usr/share/doc/man-db-${pkgver} --sysconfdir=/etc --disable-setuid; make -j$(nproc); }
package(){ cd man-db-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs install; }

#PKG: procps-ng
pkgname=procps-ng
pkgver=4.0.6
source=("https://sourceforge.net/projects/procps-ng/files/Production/procps-ng-${pkgver}.tar.xz")
build(){ cd procps-ng-${pkgver}; ./configure --prefix=/usr --docdir=/usr/share/doc/procps-ng-${pkgver} --disable-static --disable-kill; make -j$(nproc); }
package(){ cd procps-ng-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs install; }

#PKG: util-linux
pkgname=util-linux
pkgver=2.41.3
source=("https://www.kernel.org/pub/linux/utils/util-linux/v2.41/util-linux-${pkgver}.tar.xz")
build(){ cd util-linux-${pkgver}; CC="gcc -m32" ./configure --prefix=/usr --libdir=/usr/lib32 --disable-chfn-chsh --disable-login --disable-nologin --disable-su --disable-setpriv --disable-runuser --disable-pylibmount --disable-static; make; make DESTDIR=$srcdir/m32 install; make clean; ./configure --prefix=/usr --disable-chfn-chsh --disable-login --disable-nologin --disable-su --disable-setpriv --disable-runuser --disable-pylibmount --disable-static; make -j$(nproc); }
package(){ cd util-linux-${pkgver}; make DESTDIR=$pkgdir/mnt/lfs install; cp -a $srcdir/m32/usr/lib32 $pkgdir/mnt/lfs/usr/; }

#PKG: e2fsprogs
pkgname=e2fsprogs
pkgver=1.47.3
source=("https://downloads.sourceforge.net/project/e2fsprogs/e2fsprogs/v${pkgver}/e2fsprogs-${pkgver}.tar.gz")
build(){ cd e2fsprogs-${pkgver}; mkdir build32 build64; cd build32; CC="gcc -m32" ../configure --prefix=/usr --libdir=/usr/lib32 --enable-elf-shlibs --disable-libblkid --disable-libuuid --disable-fsck; make; cd ../build64; ../configure --prefix=/usr --enable-elf-shlibs --disable-libblkid --disable-libuuid --disable-fsck; make; }
package(){ cd e2fsprogs-${pkgver}/build32; make DESTDIR=$srcdir/m32 install; cd ../build64; make DESTDIR=$pkgdir/mnt/lfs install; cp -a $srcdir/m32/usr/lib32 $pkgdir/mnt/lfs/usr/; }

#PKG: linux-kernel
pkgname=linux-kernel
pkgver=6.18.10
source=("https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-${pkgver}.tar.xz")
build(){ cd linux-${pkgver}; make mrproper; make defconfig; make -j$(nproc); }
package(){ cd linux-${pkgver}; make INSTALL_MOD_PATH=$pkgdir/mnt/lfs modules_install; install -D -m644 arch/x86/boot/bzImage $pkgdir/mnt/lfs/boot/vmlinuz-${pkgver}-lfs; install -D -m644 System.map $pkgdir/mnt/lfs/boot/System.map-${pkgver}; install -D -m644 .config $pkgdir/mnt/lfs/boot/config-${pkgver}; install -d -m755 $pkgdir/mnt/lfs/usr/share/doc/linux-${pkgver}; cp -r Documentation/* $pkgdir/mnt/lfs/usr/share/doc/linux-${pkgver}/; }

#PKG: mlfs-m32-meta
pkgname=mlfs-m32-meta
pkgver=13.0
description="Installs all MLFS 13.0-m32 packages to /mnt/lfs sequentially, including kernel and grub-efi."
depends=(
    'binutils-pass1' 'gcc-pass1' 'linux-api-headers' 'glibc-pass1' 'libstdc++-pass1'
    'm4-temp' 'ncurses-temp' 'bash-temp' 'coreutils-temp' 'diffutils-temp'
    'file-temp' 'findutils-temp' 'gawk-temp' 'grep-temp' 'gzip-temp'
    'make-temp' 'patch-temp' 'sed-temp' 'tar-temp' 'xz-temp'
    'binutils-pass2' 'gcc-pass2' 'gettext-temp' 'bison-temp' 'perl-temp'
    'python-temp' 'texinfo-temp' 'util-linux-temp' 'man-pages' 'iana-etc'
    'glibc' 'zlib' 'bzip2' 'xz' 'lz4' 'zstd' 'file' 'readline' 'pcre2' 'm4'
    'bc' 'flex' 'tcl' 'expect' 'dejagnu' 'pkgconf' 'binutils' 'gmp' 'mpfr'
    'mpc' 'isl' 'attr' 'acl' 'libcap' 'libxcrypt' 'shadow' 'gcc' 'ncurses'
    'sed' 'psmisc' 'gettext' 'bison' 'grep' 'bash' 'libtool' 'gdbm' 'gperf'
    'expat' 'inetutils' 'less' 'perl' 'xml-parser' 'intltool' 'autoconf'
    'automake' 'openssl' 'elfutils' 'libffi' 'sqlite' 'python' 'flit-core'
    'packaging' 'wheel' 'setuptools' 'ninja' 'meson' 'kmod' 'coreutils'
    'diffutils' 'gawk' 'findutils' 'groff' 'grub' 'grub-efi' 'gzip' 'iproute2'
    'kbd' 'libpipeline' 'make' 'patch' 'tar' 'texinfo' 'vim' 'markupsafe'
    'jinja2' 'systemd' 'dbus' 'man-db' 'procps-ng' 'util-linux' 'e2fsprogs'
    'linux-kernel'
)
build() { :; }
package() { :; }
EOF_DATA

echo "Done! 113 packages successfully formatted into perfect directory structures inside 'lfs-m32-pacscripts'."
