# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
QT5_MODULE="qttools"
inherit desktop gnome2-utils qt5-build

DESCRIPTION="WYSIWYG tool for designing and building graphical user interfaces with QtWidgets"

if [[ ${QT5_BUILD_TYPE} == release ]]; then
	KEYWORDS="x86"
fi

IUSE="declarative webkit"

DEPEND="
	~dev-qt/qtcore-${PV}
	~dev-qt/qtgui-${PV}
	~dev-qt/qtnetwork-${PV}
	~dev-qt/qtprintsupport-${PV}
	~dev-qt/qtwidgets-${PV}
	~dev-qt/qtxml-${PV}
	declarative? ( ~dev-qt/qtdeclarative-${PV}[widgets] )
	webkit? ( >=dev-qt/qtwebkit-5.9.1:5 )
"
RDEPEND="${DEPEND}"

QT5_TARGET_SUBDIRS=(
	src/designer
)

src_prepare() {
	qt_use_disable_mod declarative quickwidgets \
		src/designer/src/plugins/plugins.pro

	qt_use_disable_mod webkit webkitwidgets \
		src/designer/src/plugins/plugins.pro

	qt5-build_src_prepare
}

src_install() {
	qt5-build_src_install

	doicon -s 128 src/designer/src/designer/images/designer.png
	make_desktop_entry "${QT5_BINDIR}"/designer 'Qt 5 Designer' designer 'Qt;Development;GUIDesigner'
}

pkg_postinst() {
	qt5-build_pkg_postinst
	gnome2_icon_cache_update
}

pkg_postrm() {
	qt5-build_pkg_postrm
	gnome2_icon_cache_update
}
