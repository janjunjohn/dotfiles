# インストール済みアプリ一覧（移行リファレンス）

旧Mac（`/Applications`）にあったアプリの棚卸し。新Macで「前は何を使っていたか」を
確認し、**必要なものだけ手動でインストール**するための参照用。
バージョンは旧Mac時点のもの（記録用）。

> 自動化はしていない。各 `brew install --cask …` はそのままコピペで入れられる。

---

## ✅ Brewfile で自動インストール済み

`./bootstrap.sh`（= `brew bundle`）で入るので個別作業は不要。

| アプリ | cask | 旧ver |
|---|---|---|
| Anki | `anki` | 25.09 |
| Discord | `discord` | 0.0.290 |
| iTerm2 | `iterm2` | 3.6.x（Hyperから移行・設定は `iterm2/`） |
| Postman | `postman` | 10.24.26 |
| Raycast | `raycast` | 1.70.2 |
| Visual Studio Code | `visual-studio-code` | 1.107.1 |

---

## 🍺 Homebrew cask で入る（手動・コピペ可）

```sh
brew install --cask istat-menus@6        # iStat Menus 6  ⚠️ ライセンスキーは手動入力
brew install --cask surfshark            # Surfshark      ⚠️ アカウントでログイン必要
brew install --cask docker               # Docker Desktop
brew install --cask microsoft-teams      # Microsoft Teams
brew install --cask zoom                 # Zoom
brew install --cask appcleaner           # AppCleaner
brew install --cask claude               # Claude
brew install --cask karabiner-elements   # Karabiner-Elements（dotfilesの設定と連動）
brew install --cask logi-options-plus    # Logi Options+
brew install --cask tempbox              # TempBox
```

| アプリ | cask | 旧ver | 備考 |
|---|---|---|---|
| **iStat Menus 6** | `istat-menus@6` | 6.72 | ⚠️ ライセンスキー手動入力。最新は `istat-menus`(v7) |
| Surfshark | `surfshark` | 4.25.0 | ⚠️ ログイン必要 |
| Docker | `docker` | 4.46.0 | |
| Microsoft Teams | `microsoft-teams` | — | |
| Zoom | `zoom` | 6.6.11 | |
| AppCleaner | `appcleaner` | 3.6.8 | |
| Claude | `claude` | 1.15200.0 | |
| Karabiner-Elements | `karabiner-elements` | 15.5.0 | 設定は `config/karabiner/` |
| Logi Options+ | `logi-options-plus` | 1.98.x | Logicool マウス/キーボード |
| TempBox | `tempbox` | 1.1 | 使い捨てメール |

---

## 🛍 Mac App Store（App Store アプリから手動インストール）

サインイン中の Apple ID で App Store を開き、名前で検索して入れる。
（`mas` CLI を使えば自動化も可能だが、今回はリスト化のみ）

| アプリ | 旧ver | 種別 |
|---|---|---|
| Slack | 4.40.128 | アプリ |
| LINE | 9.5.0 | アプリ |
| Numbers | 13.1 | Apple純正 |
| Flow | 4.2.2 | ポモドーロタイマー |
| BetterSnapTool | 1.9.9 | ウィンドウ管理 |
| Vimari | 2.1.1 | Safari拡張（vim風操作） |
| Keyword Search | 2.2 | Safari拡張 |
| Dark Reader for Safari | 2.1.1 | Safari拡張 |

---

## 🖥 システム / 対象外

| アプリ | 備考 |
|---|---|
| Safari | macOS 同梱 |

---

## ❓ 要確認

| アプリ | 備考 |
|---|---|
| **PasswordManager** | Bundle ID が `PasswordManager`・バージョン `0.0.0` と異常。配布元不明。新Macに入れる前に**正体を確認**すること（純正のパスワード管理アプリではない可能性）。 |
