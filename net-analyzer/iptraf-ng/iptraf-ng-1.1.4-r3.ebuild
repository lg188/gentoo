# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit flag-o-matic toolchain-funcs

DESCRIPTION="A console-based network monitoring utility"
HOMEPAGE="https://github.com/iptraf-ng/iptraf-ng/"
SRC_URI="https://github.com/iptraf-ng/iptraf-ng/archive/v${PV}.tar.gz -> ${P}-github.tar.gz"

LICENSE="GPL-2 doc? ( FDL-1.1 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="doc"

RDEPEND="
	>=sys-libs/ncurses-5.7-r7:0=
"
DEPEND="
	${RDEPEND}
	virtual/os-headers
	!net-analyzer/iptraf
"
PATCHES=(
	"${FILESDIR}"/${P}-printf-format.patch
	"${FILESDIR}"/${P}-sprintf-format.patch
	"${FILESDIR}"/${P}-tcplog_flowrate_msg.patch
)
RESTRICT="test"

src_prepare() {
	sed -i \
		-e '/^CC =/d' \
		-e '/^CFLAGS/s:= -g -O2:+= :' \
		-e '/^LDFLAGS =/d' \
		-e 's|$(QUIET_[[:alpha:]]*)||g' \
		Makefile || die
	sed -i \
		-e 's|IPTRAF|&-NG|g' \
		-e 's|IPTraf|&-NG|g' \
		-e 's|iptraf|&-ng|g' \
		-e 's|rvnamed|&-ng|g' \
		-e 's|RVNAMED|&-NG|g' \
		src/*.8 || die

	default
}

src_configure() {
	# The configure script does not do very much we do not already control
	append-cppflags '-DLOCKDIR=\"/run/lock/iptraf-ng\"'
	tc-export CC
}

src_install() {
	dosbin {iptraf,rvnamed}-ng

	doman src/*.8
	dodoc AUTHORS CHANGES FAQ README* RELEASE-NOTES

	if use doc; then
		docinto html
		dodoc -r Documentation/*
	fi

	keepdir /var/{lib,log}/iptraf-ng #376157
}
