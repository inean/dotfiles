#!/usr/bin/env bash

# Modified from https://gist.github.com/vikytech/f28c5480c1e1d8c2688981803b45a29a#file-cleaner-sh
#
# Ask for the administrator password upfront
sudo -v

GREEN="\033[32m 🧹 "
YELLOW="\033[33m 🗑 "
BLUE="\033[36m ✅ "
HOST=$( whoami )

# Keep-alive sudo until `clean-my-mac.sh` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

logInfo() {
  echo "$BLUE $1\n"
}

delog() {
  echo "$YELLOW $1\n"
}

doneLog() {
  echo "$GREEN $1\n"
}

sudoDelete() {
    delog "Deleting $1"
    sudo rm -rf $1 &>/dev/null || true
}

deleteApplication() {
    logInfo "Deleting $1 Application"
    sudoDelete "/Applications/$1*.app"
    sudoDelete "/Users/${HOST}/Library/ApplicationSupport/$1*"
    sudoDelete "/Users/${HOST}/Library/Caches/$1*"
}

bytesToHuman() {
    b=${1:-0}; d=''; s=0; S=(Bytes {K,M,G,T,E,P,Y,Z}iB)
    while ((b > 1024)); do
        d="$(printf ".%02d" $((b % 1024 * 100 / 1024)))"
        b=$((b / 1024))
        (( s++ ))
    done
    doneLog "$b$d ${S[$s]} of space was cleaned up"
}

deleteCaches() {
    local cacheName=$1
    shift
    local paths=("$@")
    logInfo "Initiating cleanup ${cacheName} cache..."
    for folderPath in "${paths[@]}"; do
        if [[ -d ${folderPath} ]]; then
            dirSize=$(du -hs "${folderPath}" | awk '{print $1}')
            delog "Deleting ${folderPath} to free up ${dirSize}..."
            sudoDelete "${folderPath}"
        fi
    done
}

clean () {
  logInfo "Empty the Trash on all mounted volumes and the main HDD..."
  sudoDelete "/Volumes/*/.Trashes/*"
  sudoDelete "/Users/${HOST}/.Trash/*"

  logInfo "Clear System Log Files..."
  sudoDelete "/private/var/log/asl/*.asl"
  sudoDelete "/Library/Logs/DiagnosticReports/*"
  sudoDelete "/Library/Logs/Adobe/*"
  sudoDelete "/Users/${HOST}/Library/Containers/com.apple.mail/Data/Library/Logs/Mail/*"
  sudoDelete "/Users/${HOST}/Library/Logs/CoreSimulator/*"

  logInfo "Clear Adobe Cache Files..."
  sudoDelete "/Users/${HOST}/Library/ApplicationSupport/Adobe/Common/Media\ Cache\ Files/*"

  logInfo "Cleanup iOS Applications..."
  sudoDelete "/Users/${HOST}/Music/iTunes/iTunes\ Media/Mobile\ Applications/*"

  logInfo "Remove iOS Device Backups..."
  sudoDelete "/Users/${HOST}/Library/ApplicationSupport/MobileSync/Backup/*"

  logInfo "Cleanup XCode..."
  sudoDelete "/Users/${HOST}/Library/Developer/Xcode/DerivedData/*"
  sudoDelete "/Users/${HOST}/Library/Developer/Xcode/Archives/*"
  deleteApplication "Xcode"

  if type "xcrun"; then
    logInfo "Cleanup iOS Simulators..."
    osascript -e 'tell application "com.apple.CoreSimulator.CoreSimulatorService" to quit'
    osascript -e 'tell application "iOS Simulator" to quit'
    osascript -e 'tell application "Simulator" to quit'
    sudoDelete "/Users/${HOST}/Library/Developer"
  fi

  if [ -d "/Users/${HOST}/Library/Caches/CocoaPods" ]; then
      logInfo "Cleanup CocoaPods cache..."
      sudoDelete "/Users/${HOST}/Library/Caches/CocoaPods/*"
  fi

  # Delete Android Studio
  logInfo "Cleanup Android Studio..."
  deleteApplication "Android"

  if type "emulator"; then
    logInfo "Cleanup Android SDK and Emulators..."
    sudoDelete "/Users/${HOST}/.android"
  fi

  # Delete Google Chrome
  logInfo "Cleanup Google Chrome..."
  chromePaths=(
      "/Users/${HOST}/Library/Caches/Google"
      "/Users/${HOST}/Library/ApplicationSupport/Google" 
      "/Users/${HOST}/Library/Caches/com.google.Chrome"
      "/Users/${HOST}/Library/Google"
  )
  deleteCaches "Google Chrome" "${chromePaths[@]}"
  deleteApplication "Google"

  # Delete Mozilla Firefox
  logInfo "Cleanup Firefox..."
  firefoxPaths=(
      "/Users/${HOST}/Library/Caches/Firefox/"
      "/Users/${HOST}/Library/Caches/org.mozilla.firefox/"
      "/Users/${HOST}/Library/ApplicationSupport/Firefox"
  )
  deleteCaches "Mozilla Firefox" "${firefoxPaths[@]}"
  deleteApplication "Firefox"

  #OtherApplication
  deleteApplication "AppCode"
  deleteApplication "Adobe"
  deleteApplication "Beyond"
  deleteApplication "Charles"
  deleteApplication "Chat"
  deleteApplication "Citrix"
  deleteApplication "DB"
  deleteApplication "Docker"
  deleteApplication "IntelliJ"
  deleteApplication "iTerm"
  deleteApplication "Microsoft"
  deleteApplication "OpenShot"
  deleteApplication "Postman"
  deleteApplication "Sublime"
  deleteApplication "Visual"
  deleteApplication "VLC"
  deleteApplication "zoom.us"

  # Delete gradle caches
  if [ -d "/Users/${HOST}/.gradle/caches" ]; then
      logInfo "Cleanup Gradle cache..."
      sudoDelete "/Users/${HOST}/.gradle/caches/"
  fi

  # Delete Dropbox Cache
  if [ -d "/Users/${HOST}/Dropbox" ]; then
    logInfo "Clear Dropbox 📦 Cache Files..."
    sudoDelete /Users/${HOST}/Dropbox/.dropbox.cache/*
  fi

  if type "composer" &> /dev/null; then
      logInfo "Cleanup composer..."
      composer clearcache &> /dev/null
  fi

  if type "gem" &> /dev/null; then
      logInfo "Cleanup any old versions of gems"
      gem cleanup
  fi

  if type "docker" &> /dev/null; then
      logInfo "Cleanup Docker"
      docker system prune -af
  fi

  logInfo "Cleanup pip cache..."
  sudoDelete /Users/${HOST}/Library/Caches/pip

  if [ "$PYENV_VIRTUALENV_CACHE_PATH" ]; then
      logInfo "Removing Pyenv-VirtualEnv Cache..."
      sudoDelete $PYENV_VIRTUALENV_CACHE_PATH
  fi

  if type "npm" &> /dev/null; then
      logInfo "Cleanup npm cache..."
      npm cache clean --force
  fi

  if type "yarn" &> /dev/null; then
      logInfo "Cleanup Yarn Cache..."
      yarn cache clean --force
  fi

  #Clean Up dot(.) files
  logInfo "Cleanup dot(.) files..."
  sudoDelete "/Users/${HOST}/.android"
  sudoDelete "/Users/${HOST}/.cocoapods"
  sudoDelete "/Users/${HOST}/.bash_history"
  sudoDelete "/Users/${HOST}/.bundle"
  sudoDelete "/Users/${HOST}/.config"
  sudoDelete "/Users/${HOST}/.docker"
  sudoDelete "/Users/${HOST}/.emulator_console_auth_token"
  sudoDelete "/Users/${HOST}/.fastlane"
  sudoDelete "/Users/${HOST}/.gem"
  sudoDelete "/Users/${HOST}/.gitconfig"
  sudoDelete "/Users/${HOST}/.gradle"
  sudoDelete "/Users/${HOST}/.lesshst"
  sudoDelete "/Users/${HOST}/.localhost-ssl"
  sudoDelete "/Users/${HOST}/.m2"
  sudoDelete "/Users/${HOST}/.npm"
  sudoDelete "/Users/${HOST}/.oh-my-zsh"
  sudoDelete "/Users/${HOST}/.openshot_qt"
  sudoDelete "/Users/${HOST}/.sonarlint"
  sudoDelete "/Users/${HOST}/.ssh"
  sudoDelete "/Users/${HOST}/.tig_history"
  sudoDelete "/Users/${HOST}/.vim"
  sudoDelete "/Users/${HOST}/.viminfo"
  sudoDelete "/Users/${HOST}/.vscode"
  sudoDelete "/Users/${HOST}/.zcompdump-OF060ZP1JNMD6NH-5.7.1"
  sudoDelete "/Users/${HOST}/.zcompdump-OF060ZP1JNMD6NM-5.7.1"
  sudoDelete "/Users/${HOST}/.zsh_history"
  sudoDelete "/Users/${HOST}/.zshrc"
  sudoDelete "/Users/${HOST}/.zshrc.pre-oh-my-zsh"

  if type "brew"; then
      logInfo "Cleanup Homebrew..."
      brew cleanup -s
      #brew cask cleanup
      sudoDelete $(brew --cache)
      sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall.sh)"
      sudoDelete "/usr/local/Cellar"
      sudoDelete "/usr/local/Caskroom"
      sudoDelete "/Users/${HOST}/Library/Caches/Homebrew" 
  fi

  logInfo "Removing Project Source files..."
  sudoDelete $PROJECT_DIR

  logInfo "Cleanup Desktop..."
  sudoDelete "/Users/${HOST}/Desktop/*"

  logInfo "Cleanup Documents..."
  sudoDelete "/Users/${HOST}/Documents/*"

  logInfo "Cleanup Movies..."
  sudoDelete "/Users/${HOST}/Movies/*"

  logInfo "Cleanup Music..."
  sudoDelete "/Users/${HOST}/Music/*"

  logInfo "Cleanup Downloads..."
  sudoDelete "/Users/${HOST}/Downloads/*"

  logInfo "Cleanup Pictures..."
  sudoDelete "/Users/${HOST}/Pictures/*"

  logInfo "Cleanup Public..."
  sudoDelete "/Users/${HOST}/Public/*"

  logInfo "Cleanup Downloads..."
  sudoDelete "/Users/${HOST}/Downloads/*"

  logInfo "Purge inactive memory..."
  sudo purge
}

logInfo "Make sure you have atleast 50% of Battery backup 🔋(Better with AC Adapter pluged in 🔌)"
logInfo "This is going to take time so make sure you have your caffine ☕️ handy"
logInfo "Close all the application from the dock and Navigation bar and Run this script from \"Terminal\" ✅ not iTerm 🚫"

printf "Are you sure you want to cleanup everything on your mac ? 🤔"
  PS3="Please enter your choice: "
	options=("Yes" "No")
	select opt in "${options[@]}"
		do
		    case $opt in
		        "Yes")
		            printf "$GREEN Cleaning... 👨🏻‍💻\n"
                cd ~
                oldAvailable=$(df / | tail -1 | awk '{print $4}')
                clean
		            sleep 0.5
                
                logInfo "Success!"

                newAvailable=$(df / | tail -1 | awk '{print $4}')
                count=$((oldAvailable - newAvailable))
                bytesToHuman $count
		            
                logInfo "Remember to clear keychain creds, Notes, Sticky and reset Safari"
                logInfo "Please manually delete if anything has been left out..."
                sleep 0.5
		            exit
		            ;;
		        "No")
		            printf "\E[35;m Bye 👋🏻 Bye 👋🏻\n"
		            sleep 0.5
		            exit
		            ;;		        
		        *) printf "\E[31;m Invalid option 🚫\n";;
		    esac
		done

logInfo "🙏🏻"
