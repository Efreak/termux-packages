TERMUX_PKG_HOMEPAGE=https://github.com/mozilla/sccache/
TERMUX_PKG_DESCRIPTION="Sccache is a ccache-like tool. It is used as a compiler wrapper and avoids compilation when possible, storing a cache in a remote storage using the S3 API."
TERMUX_PKG_LICENSE="Apache-2.0"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=0.2.15
TERMUX_PKG_SRCURL=https://github.com/mozilla/sccache/archive/v$TERMUX_PKG_VERSION.tar.gz
TERMUX_PKG_SHA256=7dbe71012f9b0b57d8475de6b36a9a3b4802e44a135e886f32c5ad1b0eb506e0
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_BUILD_IN_SRC=true

# maybe notify user that sccache is installed but not configured?
# e.g. to configure cargo to use sccache, need to edit ~/.cargo/config.toml
# alternatively, just link user to homepage
