#/***************************************************************************
# *   Copyright (C) 2018 Daniel Mueller (deso@posteo.net)                   *
# *                                                                         *
# *   This program is free software: you can redistribute it and/or modify  *
# *   it under the terms of the GNU General Public License as published by  *
# *   the Free Software Foundation, either version 3 of the License, or     *
# *   (at your option) any later version.                                   *
# *                                                                         *
# *   This program is distributed in the hope that it will be useful,       *
# *   but WITHOUT ANY WARRANTY; without even the implied warranty of        *
# *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *
# *   GNU General Public License for more details.                          *
# *                                                                         *
# *   You should have received a copy of the GNU General Public License     *
# *   along with this program.  If not, see <http://www.gnu.org/licenses/>. *
# ***************************************************************************/

EAPI=6

CRATES="
cc-1.0.25
hid-0.4.1
hidapi-sys-0.1.4
libc-0.2.45
nitrocli-0.1.3
pkg-config-0.3.14
"

inherit cargo

DESCRIPTION="A command line tool for interacting with the Nitrokey Storage device."
HOMEPAGE="https://github.com/d-e-s-o/nitrocli"
SRC_URI="$(cargo_crate_uris ${CRATES})"
RESTRICT="mirror"
LICENSE="GPL-3.0+"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

# We require gnupg for /usr/bin/gpg-connect-agent.
RDEPEND="
	app-crypt/gnupg
	dev-libs/hidapi
"
DEPEND="
	>=dev-lang/rust-1.31
	${RDEPEND}
"

src_install() {
	cargo install -j $(makeopts_jobs) --path=. --root="${D}/usr" $(usex debug --debug "") \
		|| die "cargo install failed"
	rm -f "${D}/usr/.crates.toml"

	doman "${S}/doc/nitrocli.1"
}
