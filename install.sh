#!/usr/bin/env bash
# Install: sudo ./install.sh [PREFIX]   (default PREFIX=/usr/local)
# Uninstall: sudo ./install.sh --uninstall [PREFIX]
set -euo pipefail

uninstall=0
if [[ "${1:-}" == --uninstall ]]; then uninstall=1; shift; fi
PREFIX="${1:-/usr/local}"
SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SHARE="$PREFIX/share/nespawn"
BIN="$PREFIX/bin/nespawn"

if ((uninstall)); then
    rm -rf -- "$SHARE"
    rm -f -- "$BIN"
    echo "nespawn dihapus dari $PREFIX (config /etc/nespawn dibiarkan)"
    exit 0
fi

install -d "$SHARE" "$PREFIX/bin"
cp -r "$SRC/lib" "$SRC/nespawn" "$SHARE/"
chmod 755 "$SHARE/nespawn"
ln -sf "$SHARE/nespawn" "$BIN"

if [[ ! -e /etc/nespawn/nespawn.conf ]]; then
    install -Dm644 "$SRC/etc/nespawn.conf" /etc/nespawn/nespawn.conf
fi
echo "nespawn terpasang di $BIN"
