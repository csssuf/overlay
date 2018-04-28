EAPI=6

inherit eutils

DESCRIPTION="Rack is the engine for the VCV open-source virtual modular synthesizer."
HOMEPAGE="https://vcvrack.com/"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

NANOSVG_COMMIT="9a74da4db5ac74083e444010d75114658581b9c7"
NANOVG_COMMIT="98e551351d020087b01ae0b1d3d2d1593e3ad01f"
OSDIALOG_COMMIT="015d020615e8169d2f227ad385c5f2aa1e091fd1"
OUI_BLENDISH_COMMIT="b7066201022a757cbcbd986d8c91d565e4daef90"

SRC_URI="https://github.com/vcvrack/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/vcvrack/Fundamental/archive/v${PV}.tar.gz -> Fundamental-${PV}.tar.gz
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
	media-libs/libsamplerate
	>=media-libs/rtaudio-5.0.0
	media-libs/rtmidi
	|| (
		<media-libs/speex-1.2.0
		media-libs/speexdsp
	)
	net-misc/curl
	sys-libs/zlib"
RDEPEND="${DEPEND}"


src_unpack() {
	unpack ${A}
	mv -f Rack-${PV} ${S}

	mkdir -p ${S}/plugins/Fundamental/
	cp -r Fundamental-${PV}/* ${S}/plugins/Fundamental/

	cp -r nanosvg-${NANOSVG_COMMIT}/* ${S}/dep/nanosvg/
	cp -r nanovg-${NANOVG_COMMIT}/* ${S}/dep/nanovg/
	cp -r osdialog-${OSDIALOG_COMMIT}/* ${S}/dep/osdialog/
	cp -r oui-blendish-${OUI_BLENDISH_COMMIT}/* ${S}/dep/oui-blendish/
	mkdir ${S}/dep/include
}

src_prepare() {
	epatch "${FILESDIR}/0001-remove-system-provided-deps-for-packaging.patch"
	epatch "${FILESDIR}/0002-window-don-t-handle-pixel-scaling.patch"
	epatch "${FILESDIR}/0003-include-audio-fix-rtaudio-include-path.patch"
	epatch "${FILESDIR}/0004-Makefile-don-t-link-with-jack-fix-glfw-linkage.patch"
	epatch "${FILESDIR}/0005-asset-load-global-assets-from-usr-share-vcvrack.patch"
	epatch "${FILESDIR}/0006-plugin-load-plugins-from-global-resources-too.patch"

	pushd ${S}/plugins/Fundamental/
	epatch "${FILESDIR}/0001-remove-system-dependencies-from-build-process.patch"
	popd

	eapply_user
}

src_compile() {
	BITS=64 ARCH=lin TARGET=rack RELEASE=1 emake
	BITS=64 ARCH=lin TARGET=plugin.so RELEASE=1 emake -C plugins/Fundamental
}

src_install() {
	dobin Rack

	insinto /usr/share/vcvrack
	doins -r res/

	insinto /usr/share/vcvrack/plugins/Fundamental
	doins plugins/Fundamental/plugin.so
	doins -r plugins/Fundamental/res/

	einstalldocs
}
