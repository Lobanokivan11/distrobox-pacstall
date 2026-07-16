pkgname="distrobox"
arch=("amd64")
pkgver="4c334118a1334f1616e7c8d24e974c6bbf872d84"
pkgdesc="Use any linux distribution inside your terminal"
repology=("project: distrobox")
source=("@${pkgname}~${pkgver}::https://github.com/89luca89/distrobox/archive/${pkgver}.tar.gz")
sha256sums=("c256b5511a8cfacf3d450a7c21b341d229e24a5d7a62bb7cafc78ce32bdfa712")
maintainer=("Lobanokivan11 <lobanokivan11@gmail.com>")
gives="${pkgname}"
breaks=("${pkgname}" "${pkgname}-deb" "${pkgname}-app" "${pkgname}-git")
optdepends=(
  "docker.io: enable docker usage"
  "podman: enable podman usage"
)

makedepends=(
  "go"
  "make"
)

depends=(
  "curl"
  "tar"
  "gzip"
  "wget"
  "coreutils"
)

package() {
  cd "${pkgname}~${pkgver}"
  export PATH="${PATH}:/usr/lib/go/bin:/usr/lib/go-bin/bin:/usr/local/go/bin"
  export GOTOOLCHAIN=local
  export GOROOT="/usr/lib/go-bin"
  make build
  make install DESTDIR="${pkgdir}" PREFIX="/usr"
  install -d "${pkgdir}/usr/share/bash-completion/completions"
  install -d "${pkgdir}/usr/share/zsh/site-functions"
  if [ -f "completions/bash/distrobox" ]; then
    install -m 0644 completions/bash/distrobox "${pkgdir}/usr/share/bash-completion/completions/"
  fi
  if [ -f "completions/zsh/_distrobox" ]; then
    install -m 0644 completions/zsh/_distrobox "${pkgdir}/usr/share/zsh/site-functions/"
  fi
}
