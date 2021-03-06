# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_{6,7,8} pypy3 )
inherit distutils-r1

DESCRIPTION="Code specific for Read the Docs and Sphinx"
HOMEPAGE="https://github.com/readthedocs/readthedocs-sphinx-ext"
SRC_URI="mirror://pypi/${PN::1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	>=dev-python/jinja-2.9[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]"
PDEPEND="
	dev-python/sphinx[${PYTHON_USEDEP}]"
BDEPEND="
	test? ( ${PDEPEND} )"

# unittest should be sufficient but tests are very verbose, so pytest's
# output capture is most welcome
distutils_enable_tests pytest

src_prepare() {
	sed -i -e '/find_packages/s:):, exclude=["tests"]):' setup.py || die
	distutils-r1_src_prepare
}
