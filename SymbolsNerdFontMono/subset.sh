#!/usr/bin/env bash

set -eu -o pipefail

SOURCE_FONT_URL="https://raw.githubusercontent.com/ryanoasis/nerd-fonts/refs/heads/gh-pages/assets/fonts/Symbols-2048-em%20Nerd%20Font%20Complete.woff2"

DOWNLOAD=$(mktemp -t tmp.XXXXXX.woff2)

function subset() {
	local dst=${1:?}.woff2
	local unicodes=${2:?}

	echo make ${dst:?}

	pyftsubset "${DOWNLOAD:?}" \
	  --output-file="${dst:?}" \
	  --unicodes="${unicodes:?}" \
	  --flavor=woff2 \
	  --layout-features='*' \
	  --glyph-names \
	  --symbol-cmap \
	  --notdef-glyph \
	  --notdef-outline \
	  --name-IDs='*' \
	  --name-languages='*' \
	  --drop-tables+=DSIG,FFTM,FFTM2,FFTM3
}

curl -sSfL -o "${DOWNLOAD:?}" "${SOURCE_FONT_URL:?}"

subset "nf-s01" "U+2300-E0FF"
subset "nf-s02" "U+E200-E2FF"
subset "nf-s03" "U+E300-E5FF"
subset "nf-s04" "U+E600-E6FF"
subset "nf-s05" "U+E700-E8FF"
subset "nf-s06" "U+EA00-ECFF"
subset "nf-s07" "U+ED00-EFFF"
subset "nf-s08" "U+F000-F2FF"
subset "nf-s09" "U+F300-F3FF"
subset "nf-s10" "U+F400-F5FF"
subset "nf-s11" "U+F0000-F07FF"
subset "nf-s12" "U+F0800-F0FFF"
subset "nf-s13" "U+F1000-F17FF"
subset "nf-s14" "U+F1800-F1FFF"

rm -f "${DOWNLOAD:?}"
