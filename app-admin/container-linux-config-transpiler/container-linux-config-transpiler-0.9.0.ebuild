# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit golang-base

DESCRIPTION="Container Linux config-to-ignition config transpiler"
HOMEPAGE="https://coreos.com/os/docs/latest/overview-of-ct.html"
SRC_URI="https://github.com/coreos/${PN}/archive/v${PV}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

EGO_PN="github.com/coreos/container-linux-config-transpiler"

src_prepare() {
	default

	# We don't want to use a git checkout.
	sed -e "s:^\(VERSION=\).*:\1v${PV}:" -i Makefile || die
}

src_install() {
	dobin bin/ct
}
