TERMUX_PKG_HOMEPAGE=https://github.com/octobanana/peaclock
TERMUX_PKG_DESCRIPTION="A responsive and customizable clock, timer, and stopwatch for the terminal."
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@efreak"
TERMUX_PKG_VERSION=0.4.3
TERMUX_PKG_SRCURL=https://github.com/octobanana/peaclock/archive/0.4.3.tar.gz
TERMUX_PKG_SHA256=3de32486e45ddf6a62c591619b5373d23c8eaf885975441ae581ca7241c48012
TERMUX_PKG_DEPENDS="libicu"
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_make() {
	cmake . -DCMAKE_BUILD_TYPE=release -DCMAKE_INSTALL_PREFIX="$TERMUX_PREFIX"
	make
}

termux_step_make_install() {
	make install PREFIX="$TERMUX_PREFIX"
}
