# intoolswetrust/homebrew-tap

Homebrew formulae for [In Tools We Trust](https://github.com/intoolswetrust) projects.

## Install

```shell
brew tap intoolswetrust/tap
brew trust --tap intoolswetrust/tap
brew install jsignpdf
```

Homebrew 5 refuses to load formulae from third-party taps until they are trusted,
hence the `brew trust` step.

## Formulae

### jsignpdf

[JSignPdf](https://github.com/intoolswetrust/jsignpdf) — adds digital signatures to PDF
documents. PKCS#12 keystores and PKCS#11 hardware tokens, RFC 3161 timestamping,
OCSP/CRL long-term validation, drag-to-place visible signatures, and a scriptable CLI.

```shell
jsignpdf                 # desktop UI
jsignpdf --help          # batch signing options
```

The formula installs the cross-platform distribution against Homebrew's `openjdk@21`.
Set `JAVA_HOME` to run it on a different JDK 21+ runtime. Demo keystore and sample PDF
land in `$(brew --prefix)/share/jsignpdf/demo`; the user guide in
`$(brew --prefix)/share/doc/jsignpdf/JSignPdf.pdf`.

Native installers (MSI, DEB, RPM, DMG, Flatpak) are published on
[GitHub Releases](https://github.com/intoolswetrust/jsignpdf/releases).

## Updating a formula

Formulae track final releases. To bump, edit the formula in this checkout and open a PR:

```shell
V=3.3.0
URL="https://github.com/intoolswetrust/jsignpdf/releases/download/JSignPdf_${V//./_}/jsignpdf-${V}-full.zip"
SHA="$(curl -fsSL "$URL" | shasum -a 256 | cut -d' ' -f1)"
sed -i.bak -E "s|^  url \".*\"|  url \"$URL\"|; s|^  sha256 \".*\"|  sha256 \"$SHA\"|" Formula/jsignpdf.rb && rm Formula/jsignpdf.rb.bak
```

`brew bump-formula-pr` also works, but it needs `HOMEBREW_GITHUB_API_TOKEN` (or `gh auth login`)
and edits the installed tap rather than this checkout.
