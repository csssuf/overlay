EAPI=6

DESCRIPTION="Rack is the engine for the VCV open-source virtual modular synthesizer."
HOMEPAGE="https://vcvrack.com/"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

NANOSVG_COMMIT="9a74da4db5ac74083e444010d75114658581b9c7"
NANOVG_COMMIT="98e551351d020087b01ae0b1d3d2d1593e3ad01f"
OSDIALOG_COMMIT="015d020615e8169d2f227ad385c5f2aa1e091fd1"
OUI_BLENDISH_COMMIT="b7066201022a757cbcbd986d8c91d565e4daef90"

SRC_URI="https://github.com/vcvrack/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/memononen/nanosvg/archive/${NANOSVG_COMMIT}.tar.gz -> nanosvg-${NANOSVG_COMMIT}.tar.gz
	https://github.com/memononen/nanovg/archive/${NANOVG_COMMIT}.tar.gz -> nanovg-${NANOVG_COMMIT}.tar.gz
	https://github.com/AndrewBelt/osdialog/archive/${OSDIALOG_COMMIT}.tar.gz -> osdialog-${OSDIALOG_COMMIT}.tar.gz
	https://github.com/AndrewBelt/oui-blendish/archive/${OUI_BLENDISH_COMMIT}.tar.gz -> oui-blendish-${OUI_BLENDISH_COMMIT}.tar.gz"

DEPEND="
	dev-libs/jansson
	dev-libs/libzip
	dev-libs/openssl
	media-libs/glew
	media-libs/glfw
	media-libs/rtaudio
	media-libs/rtmidi
	media-libs/speexdsp
	net-misc/curl
	sys-libs/zlib"
RDEPEND="${DEPEND}"

PATCHES="${FILESDIR}/0001-remove-system-provided-deps-for-packaging.patch"

src_unpack() {
	unpack ${A}
	mv -f Rack-${PV} ${S}

	cp -r nanosvg-${NANOSVG_COMMIT}/* ${S}/dep/nanosvg/
	cp -r nanovg-${NANOVG_COMMIT}/* ${S}/dep/nanovg/
	cp -r osdialog-${OSDIALOG_COMMIT}/* ${S}/dep/osdialog/
	cp -r oui-blendish-${OUI_BLENDISH_COMMIT}/* ${S}/dep/oui-blendish/
	mkdir ${S}/dep/include
}

src_compile() {
	emake dep
	TARGET=rack RELEASE=1 emake
}
