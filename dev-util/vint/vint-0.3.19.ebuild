# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_6 )

inherit distutils-r1

DESCRIPTION="Lint tool for Vim script language"
HOMEPAGE="https://github.com/Kuniwak/vint https://pypi.org/project/vim-vint/"
SRC_URI="https://github.com/Kuniwak/vint/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	>=dev-python/ansicolor-0.2.4[${PYTHON_USEDEP}]
	>=dev-python/chardet-2.3.0[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-3.11[${PYTHON_USEDEP}]
	virtual/python-enum34[${PYTHON_USEDEP}]
	virtual/python-pathlib[${PYTHON_USEDEP}]
	virtual/python-typing[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}
	test? (
		>=dev-python/pytest-3.3.2[${PYTHON_USEDEP}]
	)
"

python_test() {
	pytest -vv || die "Test suite failed with ${EPYTHON}"
}
