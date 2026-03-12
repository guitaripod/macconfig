# macconfig

macOS dotfiles and system configuration. Apple Silicon (M4 MacBook Air, Sequoia).

## Prerequisites

- Apple ID signed in
- SSH key added to GitHub

## Fresh Install

```bash
git clone git@github.com:guitaripod/macconfig.git ~/macconfig
cd ~/macconfig
./scripts/install.sh
```

Reboot after install completes.

## Syncing Changes

**Pull** (apply latest configs from repo):
```bash
cd ~/macconfig && git pull && ./scripts/link.sh
```

**Push** (sync system changes to repo):
```bash
cd ~/macconfig && ./scripts/update-from-system.sh
git add -A && git commit -m "Update configs"
git push
```

## What's Included

**Shell**: bash with git-aware prompt, aliases, PATH config

**Editors**: Neovim ([rawdog.ml.nvim](https://github.com/guitaripod/rawdog.ml.nvim)), Vim

**Terminal**: Ghostty ([ghostty-config](https://github.com/guitaripod/ghostty-config))

**Git**: aliases, rebase on pull, LFS

**AI**: Claude Code with LSP plugins (pyright, vtsls, rust-analyzer, sourcekit-lsp), custom skills

**Keyboard**: Karabiner (ctrl+hjkl vim arrows), fast key repeat, no press-and-hold

**Mouse**: LinearMouse (Logitech settings)

**Window Management**: Rectangle

**Apps** (via Homebrew): Ghostty, Raycast, 1Password, Docker Desktop, Android Studio, Discord, Steam, Vivaldi, OBS, CleanShot X, Tailscale, Telegram, Flux, and more

**Dev Tools**: Go, Node, Python, Swift, Rust, Bun, Deno, Zig, Neovim, Docker, Supabase, Google Cloud SDK

**AI/ML Tools**: whisper-cpp, llama.cpp, tesseract

**System Settings**: Dock auto-hide, tap-to-click, column Finder, screenshots to ~/Pictures/Screenshots, Spotlight shortcut disabled (Raycast replaces it)

## Secrets

API keys and tokens live in `~/.secrets` (not tracked). Create it manually:
```bash
touch ~/.secrets && chmod 600 ~/.secrets
```

## Related Repos

- [archconfig](https://github.com/guitaripod/archconfig) — Arch Linux dotfiles
- [rawdog.ml.nvim](https://github.com/guitaripod/rawdog.ml.nvim) — Neovim config
- [ghostty-config](https://github.com/guitaripod/ghostty-config) — Ghostty terminal config
