# dotfiles

My Mac setup as code. Clone on a fresh machine, run one command, get the same
shell, editors, key bindings, and System Settings as the old Mac.

## New machine — one command

```sh
git clone <this-repo> ~/dotfiles
cd ~/dotfiles
./bootstrap.sh
```

`bootstrap.sh` runs three idempotent steps (you can run them individually too):

| Step | Script | What it does |
|------|--------|--------------|
| install | `scripts/install.sh` | Homebrew, everything in `Brewfile` (CLI tools, casks **and** VSCode extensions), oh-my-zsh + powerlevel10k + zsh-autosuggestions, fzf integration, default shell → zsh |
| link | `scripts/link.sh` | Symlinks every config from this repo to where each app reads it (backs up anything in the way to `*.backup`) |
| macos | `scripts/macos.sh` | Replays System Settings customizations via `defaults` (key repeat, shortcuts, trackpad, Dock, Finder, iTerm2 prefs folder) |

After it finishes, do the few GUI-only steps `bootstrap.sh` prints (Raycast
import, Karabiner permission, log out/in).

## What's tracked

```
home/        .zshrc .p10k.zsh .tmux.conf .gitconfig   → symlinked into ~/
config/      nvim tmux karabiner git                  → symlinked into ~/.config/
config/      colors raycast                           → imported manually (see below)
vscode/      settings.json keybindings.json extensions.txt
iterm2/      com.googlecode.iterm2.plist (full prefs) + Blue_One.json profile
Brewfile     formulae + casks + fonts + VSCode extensions
scripts/     install.sh link.sh macos.sh backup.sh
```

Fonts (SauceCodePro Nerd Font, Source Code Pro, Meslo LG Nerd Font) are
installed via the `Brewfile` casks — they are required for the powerlevel10k
prompt and the iTerm2/VSCode terminal glyphs to render correctly.

### Things that can't be symlinked (do once, by hand)

- **Raycast** — Settings → import `config/raycast/*.rayconfig` (may need the export password).
- **iTerm2 colors** — usually loaded with the prefs folder; if a profile is
  missing its theme, import `config/colors/color_for_Blue_One.itermcolors`.
- **Karabiner** — first launch needs Input Monitoring permission in
  System Settings → Privacy & Security.

## Keyboard remaps live in Karabiner, not macOS

Caps Lock → Control (and Left Control → fn), Ctrl-`[` → Esc, and fn+h/j/k/l →
arrows are all handled by **Karabiner-Elements**
(`config/karabiner/karabiner.json`). `macos.sh` deliberately does *not* remap
Caps Lock so there's no double remap.

## Backup to SSD

Snapshot the current machine before/while migrating:

```sh
./scripts/backup.sh /Volumes/<YOUR_SSD>/mac-backup
```

Writes a timestamped folder containing exported `defaults`, `~/.config`, home
dotfiles, VSCode settings, the iTerm2 plist, and a fresh `Brewfile`. It's an
archive/safety net — the repo itself is what you restore from.

## Updating the repo from the current Mac

Configs under `home/` and `config/` are symlinks, so editing them in place
updates the repo automatically — just `git commit`. To refresh the generated
lists:

```sh
brew bundle dump --force --describe --file=Brewfile
code --list-extensions > vscode/extensions.txt
cp ~/Library/Preferences/com.googlecode.iterm2.plist iterm2/
```
