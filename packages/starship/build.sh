TERMUX_PKG_HOMEPAGE=https://starship.rs
TERMUX_PKG_DESCRIPTION="A minimal, blazing fast, and extremely customizable prompt for any shell"
TERMUX_PKG_LICENSE="ISC"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=0.58.0
TERMUX_PKG_SRCURL=https://github.com/starship/starship/archive/v$TERMUX_PKG_VERSION.tar.gz
TERMUX_PKG_SHA256=8bd4cfad4bcf9694633f228de0c7dc6cfab6bb6955e2a7299ed28dd8c4d6f5e4
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_DEPENDS="zlib, openssl"
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="--no-default-features --features http"

termux_step_pre_configure() {
	CFLAGS+=" $CPPFLAGS"
	if [ $TERMUX_ARCH = arm ]; then
		CFLAGS+=" -fno-integrated-as"
	fi
}
termux_step_configure() {
	# rust checks libs in PREFIX/lib. It then can't find libc.so and libdl.so because rust program doesn't
	# know where those are. Putting them temporarly in $PREFIX/lib prevents that failure
	mv $TERMUX_PREFIX/lib/libtinfo.so.6 $TERMUX_PREFIX/lib/libtinfo.so.6.tmp
	mv $TERMUX_PREFIX/lib/libz.so.1 $TERMUX_PREFIX/lib/libz.so.1.tmp
	mv $TERMUX_PREFIX/lib/libz.so $TERMUX_PREFIX/lib/libz.so.tmp
}
termux_step_make_install() {
	mv $TERMUX_PREFIX/lib/libtinfo.so.6.tmp $TERMUX_PREFIX/lib/libtinfo.so.6
	mv $TERMUX_PREFIX/lib/libz.so.1.tmp $TERMUX_PREFIX/lib/libz.so.1
	mv $TERMUX_PREFIX/lib/libz.so.tmp $TERMUX_PREFIX/lib/libz.so
}
termux_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!$TERMUX_PREFIX/bin/sh

	# Generating shell completions.
	mkdir -p $TERMUX_PREFIX/share/bash-completion/completions
	mkdir -p $TERMUX_PREFIX/share/zsh/site-functions
	mkdir -p $TERMUX_PREFIX/share/fish/vendor_completions.d

	starship completions bash \
		> "$TERMUX_PREFIX"/share/bash-completion/completions/starship
	starship completions zsh \
		> "$TERMUX_PREFIX"/share/zsh/site-functions/_starship
	starship completions fish \
		> "$TERMUX_PREFIX"/share/fish/vendor_completions.d/starship.fish
	EOF
}
