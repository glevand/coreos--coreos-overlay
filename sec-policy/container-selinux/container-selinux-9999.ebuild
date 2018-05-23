# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit coreos-sec-policy eutils

DESCRIPTION="SELinux policy for container-selinux"
HOMEPAGE="https://github.com/projectatomic/container-selinux"
LICENSE="GPL-2"
SLOT="0"

if [[ ${PV} == 9999* ]]; then
	EGIT_REPO_URI="https://github.com/projectatomic/container-selinux.git"
	EGIT_BRANCH="master"
	EGIT_CHECKOUT_DIR="${WORKDIR}/refpolicy"
	inherit git-r3
else
	SRC_URI="https://github.com/projectatomic/container-selinux/archive/v${PV}.tar.gz"
	KEYWORDS="amd64 arm64"
fi

IUSE=""

DEPEND="sec-policy/selinux-base"

src_prepare() {
	local config="${EROOT}"/usr/lib/selinux/config

	SELINUX_TYPE=$(awk -F'=' '/SELINUXTYPE=/ {print $2}' ${config} 2>/dev/null)
	[ -n "${SELINUX_TYPE}" ] || die "Can't determine SELINUXTYPE from ${config}"

	SELINUX_MAKEFILE="${EROOT}"/usr/share/selinux/${SELINUX_TYPE}/include/Makefile
	[ -f  ${SELINUX_MAKEFILE} ] || die "Can't find ${SELINUX_MAKEFILE}"

	epatch "${FILESDIR}"/0001-2.46.0-Fixups-for-Container-Linux.patch
	eapply_user
}

src_compile() {
	emake NAME=${SELINUX_TYPE} -f "${SELINUX_MAKEFILE}" container.pp \
		|| die "compile failed"
}

src_install() {
	die "TODO"
}
