#!/bin/bash

# macOS System Settings
# Run this on your new Mac, then log out and back in (or restart)

echo "Applying macOS settings..."

# =============================================================================
# DOCK
# =============================================================================

# Auto-hide dock
defaults write com.apple.dock autohide -bool true

# No delay when showing dock
defaults write com.apple.dock autohide-delay -float 0

# No animation when hiding/showing dock
defaults write com.apple.dock autohide-time-modifier -float 0

# Dock icon size (77 pixels)
defaults write com.apple.dock tilesize -int 77

# Enable magnification
defaults write com.apple.dock magnification -bool true

# Don't show recent apps in dock
defaults write com.apple.dock show-recents -bool false

# =============================================================================
# KEYBOARD
# =============================================================================

# Fast key repeat (lower = faster, default is 6)
defaults write -g KeyRepeat -int 1

# Short delay before key repeat starts (lower = shorter, default is 25)
defaults write -g InitialKeyRepeat -int 10

# Disable press-and-hold for special characters (enables key repeat everywhere)
defaults write -g ApplePressAndHoldEnabled -bool false

# =============================================================================
# TRACKPAD
# =============================================================================

# Enable tap to click
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true

# Enable two-finger right click
defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick -bool true

# =============================================================================
# FINDER
# =============================================================================

# Show path bar at bottom
defaults write com.apple.finder ShowPathbar -bool true

# Show status bar at bottom
defaults write com.apple.finder ShowStatusBar -bool true

# Use column view by default
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"

# =============================================================================
# MOUSE
# =============================================================================

# Mouse tracking speed (0.6875)
defaults write -g com.apple.mouse.scaling -float 0.6875

# =============================================================================
# MISC
# =============================================================================

# Disable auto-correct
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false
defaults write -g WebAutomaticSpellingCorrectionEnabled -bool false

defaults write -g NSAutomaticCapitalizationEnabled -bool false

defaults write -g NSAutomaticDashSubstitutionEnabled -bool false

defaults write -g NSAutomaticQuoteSubstitutionEnabled -bool false

defaults write -g NSAutomaticPeriodSubstitutionEnabled -bool false

defaults write -g AppleShowScrollBars -string "WhenScrolling"

# =============================================================================
# SCREENSHOTS
# =============================================================================

mkdir -p "$HOME/Pictures/Screenshots"
defaults write com.apple.screencapture location -string "$HOME/Pictures/Screenshots"

defaults write com.apple.screencapture type -string "png"

# =============================================================================
# MENU BAR
# =============================================================================

defaults write com.apple.controlcenter "NSStatusItem Visible Battery" -bool true

# =============================================================================
# SPOTLIGHT
# =============================================================================

# Disable Spotlight keyboard shortcut (Cmd+Space) — Raycast replaces it
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 64 "<dict><key>enabled</key><false/></dict>"

# =============================================================================
# APPLY CHANGES
# =============================================================================

# Restart Dock to apply changes
killall Dock

# Restart Finder to apply changes
killall Finder

echo "Done! Some settings may require logout/restart to take effect."
