#
# This file is sourced automatically by xsh if the current shell has no
# dedicated initialization file.
#
# It should merely register the modules to be loaded for each runcom:
# env, login, interactive and logout.
# The order in which the modules are registered defines the order in which
# they will be loaded. Try `xsh help` for more information.
#

xsh module core

# Load application-specific modules that have no specific requirements.
xsh module pager interactive:env

# Load additional application-specific modules that provide and bind ZLE widgets.
xsh module browser interactive:env
