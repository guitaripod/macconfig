#!/bin/bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"

echo "=== macOS Fresh Install ==="

if ! xcode-select -p &>/dev/null; then
    echo "Installing Xcode Command Line Tools..."
    xcode-select --install
    echo "Press Enter after the installation completes."
    read -r
fi

if ! command -v brew &>/dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

echo "Homebrew: $(brew --version | head -1)"

if ! command -v rustc &>/dev/null; then
    echo "Installing Rust..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    . "$HOME/.cargo/env"
fi

echo "Rust: $(rustc --version)"

echo "Installing Homebrew packages (this takes 20-30 minutes)..."
brew bundle install --file="$REPO_DIR/Brewfile"

echo "Installing npm globals..."
npm install -g @anthropic-ai/claude-code @redocly/cli @vue/cli aicommits wrangler

echo "Installing Mac App Store apps..."
mas install 1289583905 || echo "Pixelmator Pro: install manually from App Store"

echo "Linking dotfiles..."
"$REPO_DIR/scripts/link.sh"

echo "Applying macOS settings..."
"$REPO_DIR/scripts/macos-settings.sh"

echo ""
echo "=== GitHub Authentication ==="
echo "Authenticate with GitHub to clone editor configs:"
gh auth login

echo "Cloning Neovim config..."
rm -rf ~/.config/nvim
gh repo clone guitaripod/rawdog.ml.nvim ~/.config/nvim

echo "Cloning Ghostty config..."
rm -rf ~/.config/ghostty
gh repo clone guitaripod/ghostty-config ~/.config/ghostty

echo "Switching to bash..."
chsh -s /bin/bash

echo ""
echo "=== Post-install reminders ==="
echo "1. Create ~/.secrets with your API keys"
echo "2. Verify: ssh -T git@github.com"
echo "3. Grant Accessibility permissions to:"
echo "   - Karabiner-Elements (Input Monitoring + Accessibility)"
echo "   - LinearMouse (Accessibility)"
echo "   - Rectangle (Accessibility)"
echo "   - Raycast (Accessibility)"
echo "   - CleanShot X (Screen Recording + Accessibility)"
echo "   - OBS (Screen Recording)"
echo "4. Import Rectangle config: apps/RectangleConfig.json"
echo "5. Import Raycast config from backup"
echo "6. Restart Terminal"
