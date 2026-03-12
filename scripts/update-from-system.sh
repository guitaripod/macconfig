#!/bin/bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"
HOME_DIR="$REPO_DIR/home"

sync_file() {
    local src="$HOME/$1"
    local dest="$HOME_DIR/$1"
    if [ ! -e "$src" ]; then
        return
    fi
    if [ -L "$src" ] && [[ "$(readlink "$src")" == "$HOME_DIR"* ]]; then
        return
    fi
    mkdir -p "$(dirname "$dest")"
    cp "$src" "$dest"
    echo "  $1"
}

echo "=== Syncing system → repo ==="

echo "Shell:"
sync_file .bashrc
sync_file .bash_profile
sync_file .hushlogin
sync_file .vimrc

echo "Git:"
sync_file .gitconfig
sync_file .gitignore_global

echo "Dev tools:"
sync_file .swift-format

echo "SSH:"
sync_file .ssh/config

echo "Claude Code:"
sync_file .claude/CLAUDE.md
sync_file .claude/settings.json
sync_file .claude/statusline-command.sh
sync_file .claude/skills/video-comparison/SKILL.md
sync_file .claude/skills/xcodebuild/SKILL.md

echo "App configs:"
sync_file .config/karabiner/karabiner.json
sync_file .config/linearmouse/linearmouse.json
sync_file .config/btop/btop.conf
sync_file .config/gh/config.yml
sync_file .config/gh/hosts.yml

echo ""
echo "Regenerating Brewfile..."
brew bundle dump --force --file="$REPO_DIR/Brewfile"
echo "  Brewfile updated (review before committing)"

echo ""
echo "=== Done ==="
cd "$REPO_DIR"
git status --short
echo ""
echo "Review changes, then: git add -A && git commit -m 'Update configs'"
