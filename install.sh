#!/usr/bin/env bash
# Bloodfeed — Global Theme (Plasma 6) — install.
#   ./install.sh          copy everything into your home, change nothing
#   ./install.sh --apply  copy, then switch Plasma (and Kvantum) to Bloodfeed
set -euo pipefail
HERE=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
D=${XDG_DATA_HOME:-$HOME/.local/share}
C=${XDG_CONFIG_HOME:-$HOME/.config}
put() { rm -rf "$2"; mkdir -p "$(dirname "$2")"; cp -a "$1" "$2"; }

put "$HERE/contents" "$D/plasma/look-and-feel/scorn.bloodfeed/contents"
cp "$HERE/metadata.json" "$D/plasma/look-and-feel/scorn.bloodfeed/"
install -Dm644 "$HERE/extras/colors/Bloodfeed.colors" "$D/color-schemes/Bloodfeed.colors"
put "$HERE/extras/plasma/Bloodfeed"  "$D/plasma/desktoptheme/Bloodfeed"
put "$HERE/extras/aurorae/Bloodfeed" "$D/aurorae/themes/Bloodfeed"
put "$HERE/extras/icons/Bloodfeed"   "$D/icons/Bloodfeed"
put "$HERE/extras/kvantum/Bloodfeed" "$C/Kvantum/Bloodfeed"
echo "Installed: global theme, colour scheme, Plasma style, Aurorae, icons, Kvantum."

if [[ ${1:-} == --apply ]]; then
    kwriteconfig6 --file Kvantum/kvantum.kvconfig --group General --key theme Bloodfeed
    plasma-apply-lookandfeel -a scorn.bloodfeed
    qdbus6 org.kde.KWin /KWin reconfigure >/dev/null 2>&1 || true
    echo "Applied. Restart apps to pick up the Kvantum style."
else
    echo "Apply: System Settings → Colors & Themes → Global Theme → Bloodfeed, or ./install.sh --apply"
fi
