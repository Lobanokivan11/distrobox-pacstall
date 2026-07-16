pkgname="distrobox"
arch=("any")
pkgver="2.0.0-rc.3"
pkgdesc="Use any linux distribution inside your terminal"
repology=("project: distrobox")
source=("@${pkgname}~${pkgver}::https://github.com/89luca89/distrobox/archive/refs/tags/${pkgver}.tar.gz")
sha256sums=("d3f011429cebb8511ea30e0526216a4cb60b9545b45a8e20fa8852852e484514")
maintainer=("Lobanokivan11 <lobanokivan11@gmail.com>")
gives="${pkgname}"
breaks=("${pkgname}" "${pkgname}-deb" "${pkgname}-app" "${pkgname}-git")
optdepends=(
  "docker.io: enable docker usage"
  "podman: enable podman usage"
)

package() {
  cd "${pkgname}~${pkgver}"
  ./install -P "${pkgdir}/usr" -V "${pkgver}"
}
