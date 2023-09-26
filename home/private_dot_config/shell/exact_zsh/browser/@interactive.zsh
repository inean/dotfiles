# Browser settings

xsh load browser -s posix interactive

# Shortcut to open the default browser.
function open-browser {
  case $BROWSER in
    firefox*) browse 'about:newtab' ;;
    *) browse ;;
  esac
}
zle -N open-browser
bindkey "$keys[Control]O$keys[Control]B" open-browser
