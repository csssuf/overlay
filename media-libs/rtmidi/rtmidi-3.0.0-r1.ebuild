# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="6"

inherit autotools eutils multilib

DESCRIPTION="RtMidi provide a common C++ API for realtime MIDI input/output across ALSA and JACK."
HOMEPAGE="http://www.music.mcgill.ca/~gary/rtmidi/"
SRC_URI="http://www.music.mcgill.ca/~gary/rtmidi/release/${P}.tar.gz"
RESTRICT="mirror"

LICENSE="Rt-Midi"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+alsa doc jack"
RDEPEND="alsa? ( media-libs/alsa-lib )
	jack? ( media-sound/jack-audio-connection-kit )"

DEPEND="${RDEPEND}"

src_configure() {
	econf --libdir="/usr/$(get_libdir)" \
	$(use_with alsa) \
	$(use_with jack) || die "./configure failed"
}

src_compile() {
	emake -j1 || die "make failed"
}
