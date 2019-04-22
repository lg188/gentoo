# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3
EGIT_REPO_URI="https://github.com/kwhat/libuiohook"

DESCRIPTION="A library to provide global keyboard and mouse hooks from userland."
HOMEPAGE="https://github.com/kwhat/libuiohook"
SRC_URI="https://github.com/kwhat/libuiohook"

LICENSE="GPL-3"
SLOT="0"

src_configure(){
	./bootstrap.sh
	econf
}
