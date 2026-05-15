#!/bin/bash
# macOS system defaults

# ── Dock ─────────────────────────────────────────────────────────────────────
defaults write com.apple.dock tilesize -int 99          # icon size
defaults write com.apple.dock largesize -int 110         # magnified size
defaults write com.apple.dock magnification -bool true   # enable magnification
defaults write com.apple.dock orientation -string bottom # dock position
defaults write com.apple.dock autohide -bool false       # don't auto-hide

# ── Appearance ────────────────────────────────────────────────────────────────
defaults write NSGlobalDomain AppleInterfaceStyle -string Dark  # dark mode

# ── Finder ────────────────────────────────────────────────────────────────────
defaults write com.apple.finder FXPreferredViewStyle -string Nlsv  # list view

# Apply changes
killall Dock
killall Finder
