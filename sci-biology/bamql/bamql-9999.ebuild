# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools git-r3

DESCRIPTION="Extract reads from BAM files"
HOMEPAGE="https://github.com/BoutrosLaboratory/bamql
	https://bmcbioinformatics.biomedcentral.com/articles/10.1186/s12859-016-1162-y"
EGIT_REPO_URI="https://github.com/BoutrosLaboratory/bamql.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="static-libs"

DEPEND="
	sys-devel/llvm:=
	sys-apps/util-linux
	sci-libs/htslib
	dev-libs/libpcre"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}"/bamql-1.6.1_drop_enable_static_llvm.patch )

src_prepare(){
	default
	eautoreconf
}

src_configure(){
	local myeconfargs=()
	use static-libs && myeconfargs+=( "--enable-static=yes" ) || \
		myeconfargs+=( "--enable-static=no" )
	econf ${myeconfargs[@]}
}
