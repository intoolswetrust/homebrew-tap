# intoolswetrust/homebrew-tap

Homebrew formulae for [In Tools We Trust](https://github.com/intoolswetrust) projects.

## Install

```shell
brew tap intoolswetrust/tap
brew install jsignpdf
```

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

Formulae track final releases. To bump:

```shell
V=3.3.0
URL="https://github.com/intoolswetrust/jsignpdf/releases/download/JSignPdf_${V//./_}/jsignpdf-${V}-full.zip"
brew bump-formula-pr --url="$URL" --sha256="$(curl -sL "$URL" | sha256sum | cut -d' ' -f1)" jsignpdf
```
