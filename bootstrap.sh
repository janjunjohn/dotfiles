#!/usr/bin/env bash
#
# bootstrap.sh — one-command setup for a fresh Mac.
#
#   git clone <repo> ~/dotfiles && cd ~/dotfiles && ./bootstrap.sh
#
# Runs, in order: install (brew + tools) -> link (symlinks) -> macos (defaults).
# Safe to re-run: every step is idempotent.

set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export DOTFILES

echo "════════════════════════════════════════════"
echo "  Dotfiles bootstrap"
echo "  Source: $DOTFILES"
echo "════════════════════════════════════════════"

bash "$DOTFILES/scripts/install.sh"
bash "$DOTFILES/scripts/link.sh"
bash "$DOTFILES/scripts/macos.sh"

cat <<'EOF'

════════════════════════════════════════════
  Bootstrap complete.
════════════════════════════════════════════

A few things still need a manual touch (GUI-only, can't be scripted):

  1. Raycast   : open Raycast → Settings → import
                 config/raycast/*.rayconfig  (may ask for the export password)
  2. iTerm2    : prefs are loaded from this repo automatically (see macos.sh).
                 Just (re)start iTerm2. If colors are missing, import
                 config/colors/color_for_Blue_One.itermcolors via
                 Settings → Profiles → Colors → Color Presets → Import.
  3. Karabiner : launch Karabiner-Elements once and grant Input Monitoring
                 permission in System Settings → Privacy & Security.
  4. Log out / restart so all keyboard & Dock defaults take effect.

EOF
