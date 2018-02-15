EAPI=6
inherit cmake-utils

DESCRIPTION="Thinkpad dock management daemon"
HOMEPAGE="https://thinkpads.org/projects/dockd/"
SRC_URI="https://github.com/libthinkpad/dockd/archive/${PV}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-libs/libthinkpad
	x11-libs/libXrandr"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX=/usr
	)

	cmake-utils_src_configure
}
