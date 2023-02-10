#!/usr/bin/env bash

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
#sudo -v

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
#while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

###############################################################################
# Terminal & iTerm 2                                                          #
###############################################################################

# Only use UTF-8 in Terminal.app
defaults write com.apple.terminal StringEncodings -array 4

# Use a modified version of the Solarized Dark theme by default in Terminal.app
osascript <<EOD

tell application "Terminal"

	local allOpenedWindows
	local initialOpenedWindows
	local windowID
	set themeName to "Atom"
	
	(* Store the IDs of all the open terminal windows. *)
	set initialOpenedWindows to id of every window

	(* Open the custom theme so that it gets added to the list
	   of available terminal themes (note: this will open two
	   additional terminal windows). *)
	do shell script "open '${HOME}/.config/themes/" & themeName & "/terminal/" & themeName & ".terminal'"

	(* Wait a little bit to ensure that the custom theme is added. *)
	delay 1

	(* Change default font and size  *)
    set font name of settings set themeName to "MesloLGS NF Regular"
    set font size of settings set themeName to 12
	set font antialiasing of settings set to true

	(* Change background *)
	set background color of settings set to {5685, 6032, 6420}

	(* Use a vertical cursor *)
	(* set cursor type of settings set themeName to 2 *)
	
	(* Window size *)
	set number of columns of settings set themeName to 88
	set number of rows of settings set themeName to 25
	
	(* Title displays *)
	set title displays settings name of settings set themeName to false
	set title displays custom title of settings set themeName to true
	set title displays window size of settings set themeName to false
	set title displays device name of settings set themeName to false
	set title displays shell path of settings set themeName to false 
  
	(* Set the custom theme as the default terminal theme. *)
	set default settings to settings set themeName

	(* Get the IDs of all the currently opened terminal windows. *)
	set allOpenedWindows to id of every window

	repeat with windowID in allOpenedWindows

		(* Close the additional windows that were opened in order
		   to add the custom theme to the list of terminal themes. *)
		if initialOpenedWindows does not contain windowID then
			close (every window whose id is windowID)

		(* Change the theme for the initial opened terminal windows
		   to remove the need to close them in order for the custom
		   theme to be applied. *)
		else
			set current settings of tabs of (every window whose id is windowID) to settings set themeName
		end if

	end repeat

end tell

EOD

# Enable “focus follows mouse” for Terminal.app and all X11 apps
# i.e. hover over a window and start typing in it without clicking first
#defaults write com.apple.terminal FocusFollowsMouse -bool true
#defaults write org.x.X11 wm_ffm -bool true

# Enable Secure Keyboard Entry in Terminal.app
# See: https://security.stackexchange.com/a/47786/8918
defaults write com.apple.terminal SecureKeyboardEntry -bool true

# Disable the annoying line marks
defaults write com.apple.Terminal ShowLineMarks -int 0

# Install the Solarized Dark theme for iTerm
open "${HOME}/.config/themes/Atom/iterm2/Atom.itermcolors"

# Don’t display the annoying prompt when quitting iTerm
defaults write com.googlecode.iterm2 PromptOnQuit -bool false
