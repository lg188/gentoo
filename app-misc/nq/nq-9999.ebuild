# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="Unix command line queue utility "
HOMEPAGE="https://github.com/chneukirchen/nq"
EGIT_REPO_URI="https://github.com/chneukirchen/nq"

LICENSE="public-domain"
SLOT="0"
KEYWORDS=""

src_install() {
	emake PREFIX="/usr" DESTDIR="${D}" install
	dodoc README.md
}
