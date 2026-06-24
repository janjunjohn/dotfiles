#!/usr/bin/env bash
#
# backup.sh — snapshot the CURRENT machine's settings to an external SSD.
#
# Usage:
#   ./scripts/backup.sh                 # defaults to /Volumes/SSD/mac-backup
#   ./scripts/backup.sh /Volumes/MyDisk/wherever
#
# Creates a timestamped folder so old snapshots are never overwritten. This is a
# safety net / archive — the dotfiles repo itself is the thing you restore from.

set -euo pipefail

DEST_ROOT="${1:-/Volumes/SSD/mac-backup}"
STAMP="$(date +%Y%m%d-%H%M%S)"
DEST="$DEST_ROOT/$STAMP"

if [ ! -d "$(dirname "$DEST_ROOT")" ] && [ ! -d "$DEST_ROOT" ]; then
  echo "!! Destination parent does not exist: $DEST_ROOT"
  echo "   Plug in the SSD or pass a path:  ./scripts/backup.sh /Volumes/<DISK>/<dir>"
  exit 1
fi

mkdir -p "$DEST"/{defaults,config,vscode,iterm2,home}
echo "==> Backing up to: $DEST"

echo "==> defaults (key domains)"
defaults read -g                              > "$DEST/defaults/GlobalPreferences.txt" 2>/dev/null || true
for d in com.apple.dock com.apple.finder com.apple.Safari \
         com.apple.AppleMultitouchTrackpad \
         com.apple.driver.AppleBluetoothMultitouch.trackpad \
         com.googlecode.iterm2 com.apple.symbolichotkeys; do
  defaults export "$d" "$DEST/defaults/$d.plist" 2>/dev/null || true
done
# Active hidutil remaps + Karabiner-managed remaps live in their own files (below).
hidutil property --get "UserKeyMapping" > "$DEST/defaults/hidutil-UserKeyMapping.txt" 2>/dev/null || true

echo "==> ~/.config (nvim, tmux, karabiner, raycast, git, colors, iterm2)"
rsync -a --exclude='.git' \
  --exclude='iterm2/AppSupport' \
  --exclude='*/SavedState' \
  "$HOME/.config/" "$DEST/config/" 2>/dev/null || true

echo "==> home dotfiles"
for f in .zshrc .p10k.zsh .tmux.conf .gitconfig; do
  [ -f "$HOME/$f" ] && cp "$HOME/$f" "$DEST/home/$f"
done

echo "==> VSCode user settings + extension list"
VSC="$HOME/Library/Application Support/Code/User"
[ -f "$VSC/settings.json" ]    && cp "$VSC/settings.json"    "$DEST/vscode/"
[ -f "$VSC/keybindings.json" ] && cp "$VSC/keybindings.json" "$DEST/vscode/"
[ -d "$VSC/snippets" ]         && rsync -a "$VSC/snippets/"  "$DEST/vscode/snippets/" 2>/dev/null || true
command -v code >/dev/null 2>&1 && code --list-extensions > "$DEST/vscode/extensions.txt" 2>/dev/null || true

echo "==> iTerm2 full prefs plist"
cp "$HOME/Library/Preferences/com.googlecode.iterm2.plist" "$DEST/iterm2/" 2>/dev/null || true

echo "==> Brewfile (current install state)"
command -v brew >/dev/null 2>&1 && brew bundle dump --force --describe --file="$DEST/Brewfile" 2>/dev/null || true

echo "==> done. Snapshot at: $DEST"
