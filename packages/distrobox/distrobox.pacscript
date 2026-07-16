pkgname="distrobox"
arch=("any")
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

package() {
  cd "${pkgname}~${pkgver}"
  ./install -P "${pkgdir}/usr" --v2
}
