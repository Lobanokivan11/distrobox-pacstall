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
  "golang"
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
  make build
  install -d "${pkgdir}/usr/bin"
  install -d "${pkgdir}/usr/share/man/man1"
  install -d "${pkgdir}/usr/share/bash-completion/completions"
  install -d "${pkgdir}/usr/share/zsh/site-functions"
  install -m 0755 distrobox "${pkgdir}/usr/bin/distrobox"
  for cmd in assemble create enter ephemeral generate-entry list ls rm stop upgrade; do
    ln -sf distrobox "${pkgdir}/usr/bin/distrobox-${cmd}"
  done
  for helper in init export host-exec; do
    if [ -f "distrobox-${helper}" ]; then
      install -m 0755 "distrobox-${helper}" "${pkgdir}/usr/bin/"
    fi
  done
  if [ -d "man/man1" ]; then
    install -m 0644 man/man1/*.1 "${pkgdir}/usr/share/man/man1/"
  fi
  if [ -f "completions/bash/distrobox" ]; then
    install -m 0644 completions/bash/distrobox "${pkgdir}/usr/share/bash-completion/completions/"
  fi
  if [ -f "completions/zsh/_distrobox" ]; then
    install -m 0644 completions/zsh/_distrobox "${pkgdir}/usr/share/zsh/site-functions/"
  fi
  if [ -d "icons" ]; then
    install -d "${pkgdir}/usr/share/icons/hicolor/scalable/apps"
    if [ -f "icons/terminal-distrobox-icon.svg" ]; then
      install -m 0644 icons/terminal-distrobox-icon.svg "${pkgdir}/usr/share/icons/hicolor/scalable/apps/"
    fi
    for size in 16 22 24 32 36 48 64 72 96 128 256; do
      if [ -d "icons/${size}x${size}" ]; then
        install -d "${pkgdir}/usr/share/icons/hicolor/${size}x${size}/apps"
        install -m 0644 icons/${size}x${size}/*.png "${pkgdir}/usr/share/icons/hicolor/${size}x${size}/apps/" 2>/dev/null || true
      fi
    done
  fi
}
