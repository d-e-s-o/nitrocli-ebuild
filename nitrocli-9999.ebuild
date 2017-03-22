#/***************************************************************************
# *   Copyright (C) 2017 Daniel Mueller (deso@posteo.net)                   *
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

EAPI=5

DESCRIPTION="A command line application for interfacing with the Nitrokey Storage"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

# We require gnupg for /usr/bin/gpg-connect-agent.
RDEPEND="
  app-crypt/gnupg
  dev-libs/hidapi
"
DEPEND="
  >=dev-lang/rust-1.15
  dev-util/cargo
  ${RDEPEND}
"

inherit git-2

EGIT_BRANCH="devel"
EGIT_REPO_URI="https://github.com/d-e-s-o/nitrocli.git"


src_compile() {
  cd nitrocli || die
  cargo build --release --verbose || die
}

src_install() {
  dobin nitrocli/target/release/nitrocli
}
