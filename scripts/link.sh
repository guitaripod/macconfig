#!/bin/bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"
HOME_DIR="$REPO_DIR/home"

link_file() {
    local src="$HOME_DIR/$1"
    local dest="$HOME/$1"
    if [ ! -e "$src" ]; then
        echo "  SKIP $1 (not in repo)"
        return
    fi
    mkdir -p "$(dirname "$dest")"
    if [ -L "$dest" ]; then
        rm "$dest"
    elif [ -e "$dest" ]; then
        mv "$dest" "$dest.bak"
        echo "  BACKUP $dest → $dest.bak"
    fi
    ln -s "$src" "$dest"
    echo "  LINK $1"
}

copy_file() {
    local src="$1"
    local dest="$2"
    if [ ! -e "$src" ]; then
        echo "  SKIP $src (not in repo)"
        return
    fi
    mkdir -p "$(dirname "$dest")"
    cp "$src" "$dest"
    echo "  COPY $src → $dest"
}

echo "=== Linking Shell Configs ==="
link_file .bashrc
link_file .bash_profile
link_file .hushlogin
link_file .vimrc

echo "=== Linking Git Configs ==="
link_file .gitconfig
link_file .gitignore_global

echo "=== Linking Dev Tools ==="
link_file .swift-format

echo "=== Linking SSH Config ==="
link_file .ssh/config

echo "=== Linking Claude Code ==="
link_file .claude/CLAUDE.md
link_file .claude/settings.json
link_file .claude/statusline-command.sh
link_file .claude/skills/video-comparison/SKILL.md
link_file .claude/skills/xcodebuild/SKILL.md

echo "=== Linking App Configs ==="
link_file .config/karabiner/karabiner.json
link_file .config/btop/btop.conf
link_file .config/gh/config.yml
link_file .config/gh/hosts.yml

echo "=== Copying Configs (apps that overwrite symlinks) ==="
copy_file "$HOME_DIR/.config/linearmouse/linearmouse.json" "$HOME/.config/linearmouse/linearmouse.json"

echo ""
echo "Done. Restart your terminal for changes to take effect."
