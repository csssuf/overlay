EAPI=6
inherit cmake-utils

DESCRIPTION="library for managing hardware of Lenovo/IBM ThinkPad laptops"
HOMEPAGE="https://github.com/libthinkpad/libthinkpad"
SRC_URI="https://github.com/libthinkpad/libthinkpad/archive/${PV}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="virtual/libudev
	>=sys-apps/systemd-221"
RDEPEND="${DEPEND}
	sys-power/acpid"

PATCHES="${FILESDIR}/cmakelists-use-LIB_SUFFIX-when-installing.patch"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX=/usr
	)

	cmake-utils_src_configure
}
