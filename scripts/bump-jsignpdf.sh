#!/usr/bin/env bash
# Point Formula/jsignpdf.rb at a JSignPdf release.
# Usage: scripts/bump-jsignpdf.sh VERSION [SHA256]
# Without SHA256 the release asset is downloaded and hashed.
set -euo pipefail

V="${1:?usage: $0 VERSION [SHA256]}"
[[ "$V" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]] || { echo "Invalid version: $V" >&2; exit 1; }

URL="https://github.com/intoolswetrust/jsignpdf/releases/download/JSignPdf_${V//./_}/jsignpdf-${V}-full.zip"
SHA="${2:-$(curl -fsSL "$URL" | shasum -a 256 | cut -d' ' -f1)}"
[[ "$SHA" =~ ^[0-9a-f]{64}$ ]] || { echo "Invalid sha256: $SHA" >&2; exit 1; }

F="$(dirname "$0")/../Formula/jsignpdf.rb"
sed -i.bak -E "s|^  url \".*\"|  url \"$URL\"|; s|^  sha256 \".*\"|  sha256 \"$SHA\"|" "$F"
rm "$F.bak"
echo "jsignpdf $V $SHA"
