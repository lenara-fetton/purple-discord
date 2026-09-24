# Copyright 2026 Lenara Fetton
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 toolchain-funcs

DESCRIPTION="Discord protocol plugin for libpurple (Pidgin)"
HOMEPAGE="https://github.com/lenara-fetton/purple-discord"
EGIT_REPO_URI="https://github.com/lenara-fetton/purple-discord.git"

LICENSE="GPL-3+"
SLOT="0"
IUSE="+qrcode"

# Only libpurple 2.14 API is used, so it also loads in the stock Pidgin
# 2.14.14; the pidgin-gtk4 net-im/pidgin uses the extra message metadata.
RDEPEND="
	dev-libs/glib:2
	dev-libs/json-glib
	net-im/pidgin:0
	sys-libs/zlib
	qrcode? (
		dev-libs/nss
		media-gfx/qrencode:=
	)
"
DEPEND="${RDEPEND}"
BDEPEND="
	sys-devel/gettext
	virtual/pkgconfig
"

src_configure() {
	tc-export CC PKG_CONFIG
}

src_compile() {
	emake USE_QRCODE_AUTH=$(usex qrcode 1 0)
}

src_install() {
	emake DESTDIR="${D}" USE_QRCODE_AUTH=$(usex qrcode 1 0) install
	einstalldocs
}
