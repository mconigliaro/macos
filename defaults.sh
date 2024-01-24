#!/usr/bin/env bash

set -eu

# Configure clock
defaults write com.apple.menuextra.clock DateFormat -string "EEE MMM d  h:mm:ss a"

# Configure menu bar (FIXME: how to show volume immediately?)
defaults write com.apple.airplay showInMenuBarIfPresent -int 0
defaults write com.apple.menuextra.battery ShowPercent -string YES
defaults write com.apple.systemuiserver "NSStatusItem Visible com.apple.menuextra.volume" -int 1
defaults write com.apple.controlcenter "NSStatusItem Visible Sound" -int 1
defaults write com.apple.systemuiserver menuExtras -array "/System/Library/CoreServices/Menu Extras/Clock.menu" "/System/Library/CoreServices/Menu Extras/Battery.menu" "/System/Library/CoreServices/Menu Extras/AirPort.menu" "/System/Library/CoreServices/Menu Extras/Displays.menu" "/System/Library/CoreServices/Menu Extras/Volume.menu"
defaults write com.apple.TextInputMenu visible -int 0

# Always show scroll bars
defaults write -g AppleShowScrollBars -string "Always"

# Expand "save" dialog
defaults write -g NSNavPanelExpandedStateForSaveMode -bool true
defaults write -g NSNavPanelExpandedStateForSaveMode2 -bool true

# Expand "print" dialog
defaults write -g PMPrintingExpandedStateForPrint -bool true
defaults write -g PMPrintingExpandedStateForPrint2 -bool true

# Configure keyboard (FIXME: how to apply immediately?)
defaults write -g KeyRepeat -int 2
defaults write -g InitialKeyRepeat -int 15
defaults write -g ApplePressAndHoldEnabled -bool false
defaults write NSAutomaticQuoteSubstitutionEnabled -int 0
defaults write NSAutomaticDashSubstitutionEnabled -int 0

# Configure mouse
defaults write -g com.apple.mouse.scaling -float 1.5

# Configure trackpad
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -int 0

# Disable touch bar
defaults write com.apple.touchbar.agent PresentationModeGlobal functionKeys
killall ControlStrip || true

# Configure dock
defaults write com.apple.dock tilesize -int 32
defaults write com.apple.dock show-recents -int 0
defaults write com.apple.dock mru-spaces -int 0
defaults delete com.apple.dock persistent-apps
for app in "/Applications/Brave Browser.app" "/System/Applications/Mail.app" "/Applications/Visual Studio Code.app" "/Applications/iTerm.app"; do
  defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>$app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
done

# Enable hot corner (start screen saver in bottom left)
defaults write com.apple.dock wvous-bl-corner -int 5
defaults write com.apple.dock wvous-bl-modifier -int 0

# Apply dock changes
killall Dock

# Configure finder
defaults write com.apple.finder AppleShowAllExtensions -int 1
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
defaults write com.apple.finder FXDefaultSearchScope -string SCcf
defaults write com.apple.finder FXEnableExtensionChangeWarning -int 0
defaults write com.apple.finder FXPreferredViewStyle -string Nlsv
defaults write com.apple.finder NewWindowTarget -string PfHm
defaults write com.apple.finder NewWindowTargetPath -string "file://$HOME"

# Apply Finder changes
killall Finder

# Configure screen saver
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 5
defaults write com.apple.screensaver idleTime -int 300
defaults write com.apple.screensaver moduleDict -dict-add moduleName -string "Computer Name"
defaults write com.apple.screensaver moduleDict -dict-add path -string "/System/Library/Frameworks/ScreenSaver.framework/Resources/Computer Name.saver"
defaults -currentHost write com.apple.ScreenSaver.Computer-Name MESSAGE -string "Hey kid, I'm a computer."
