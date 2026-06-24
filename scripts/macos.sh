#!/usr/bin/env bash
#
# macos.sh — replicate the macOS System Settings customizations from the old Mac.
#
# Every value below was read off the live machine. Comment out anything you
# don't want on the new Mac. Re-running is safe.
#
# NOTE: Caps Lock -> Control is NOT done here. It is handled by Karabiner-Elements
#       (config/karabiner/karabiner.json: caps_lock -> left_control, and
#       left_control -> fn). Don't also remap it via hidutil/System Settings or
#       you'll get a double remap.

set -euo pipefail

DOTFILES="${DOTFILES:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"

echo "==> [macos] keyboard repeat speed"
# Fast key repeat; short delay before repeat begins. (live: 2 / 9)
defaults write -g KeyRepeat -int 2
defaults write -g InitialKeyRepeat -int 9

echo "==> [macos] global menu shortcuts (all apps)"
# Ctrl-N / Ctrl-P to move between tabs in any app that has these menu items.
defaults write -g NSUserKeyEquivalents -dict-add "Show Next Tab"     '^n'
defaults write -g NSUserKeyEquivalents -dict-add "Show Previous Tab" '^p'

echo "==> [macos] Safari tab-group shortcuts"
# Cmd-Ctrl-J / Cmd-Ctrl-K to cycle Safari tab groups.
defaults write com.apple.Safari NSUserKeyEquivalents -dict-add "Go to Next Tab Group"     '@^j'
defaults write com.apple.Safari NSUserKeyEquivalents -dict-add "Go to Previous Tab Group" '@^k'

# ── Extras discovered on the old Mac (comment out any you don't want) ──────────

echo "==> [macos] trackpad / scrolling"
defaults write -g com.apple.swipescrolldirection -bool false        # natural scrolling OFF
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true # tap to click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true

echo "==> [macos] Dock"
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock tilesize -int 48
defaults write com.apple.dock mru-spaces -bool false   # don't auto-rearrange Spaces

echo "==> [macos] Finder"
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"  # list view

echo "==> [macos] text input"
defaults write -g NSAutomaticDashSubstitutionEnabled -bool false     # no smart dashes

# ── iTerm2: load preferences straight from this repo ──────────────────────────
echo "==> [macos] iTerm2 custom prefs folder"
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "$DOTFILES/iterm2"
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true

echo "==> [macos] restarting affected apps"
for app in Dock Finder SystemUIServer; do killall "$app" >/dev/null 2>&1 || true; done

echo "==> [macos] done. Some settings need a logout/restart to fully apply."
