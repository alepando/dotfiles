#!/bin/sh

add() {
    packages="$packages $@"
}

remove() {
    removed_packages="$removed_packages $@"
}

packages=""

# Drivers and hardware
add efivar firmware-linux-free firmware-linux-nonfree smartmontools
# Misc system utilities
add file info less man-db powertop psmisc rename sudo time wipe
# Networking fundamentals
add ca-certificates curl dnsutils lynx rsync wget whois
# Debian/APT utilities
add apt-file aptitude debian-keyring netselect-apt
#                     ^ Need this to verify release ISOs
# Shell and terminal multiplexing
add fish tmux tmux-plugin-manager zsh
#   ^ Better out of the box than zsh, cool for root or new users.
# Compression
add unrar zip unzip
# Misc
add policykit-1 # Everything needs this.

###############################################################
# At this point, the base system is usable interactively.     #
# Need to run this in a server? Wrap everything below in a if #
###############################################################

#
# Base programming
# Diff tools are in desktop tools
#

# General programming tools
add autoconf automake cmake exuberant-ctags git gpp
# Debian-specific
add build-essential checkinstall
# Language-specific build systems are with their language.
# Debuggers
# Language-specific debuggers are with their language.
add gdb lldb
# C-family
add clang clang-format
# Go
add golang
# Haskell
add cabal-install haskell-stack ghc ghc-mod hlint stylish-haskell
# Java (?)
add openjdk-8-jdk
# Javascript
add nodejs npm
# Python
add python-setuptools python3-setuptools python-pip python python3 virtualenvwrapper
# Rust
add cargo rustc
# Some deps
add libclang-dev sqlite3
#                ^ for helm-dash/counsel-dash
#   ^ for emacs irony-mode (also needs cmake)

#
# Desktop environment
#

# Tools for computers with an attached keyboard and screen
add fbset
# Filesystems (exfat is pointless outside the desktop)
add exfat-fuse exfat-utils

# Xorg
add xserver-xorg-core xserver-xorg-input-libinput x11-xserver-utils \
     mesa-utils mesa-va-drivers mesa-vdpau-drivers \
	 libgl1-mesa-dri

add xfonts-base # XMonad decorations fail without this.
add gnome-themes-standard gtk2-engines-pixbuf # pixbuf required for Adwaita on GTK2 apps
add desktop-base # Wallpaper and Plymouth themes
# Window and compositing manager
add xmonad libghc-xmonad-contrib-dev libghc-xmonad-contrib-doc libghc-dbus-dev
add compton
# Display manager & session locker
add lightdm-gtk-greeter light-locker
add policykit-1 # LightDM depends on this to handle shutdown/reboot/etc
remove nodm slock
# Dbus
add dbus-x11
# Notification system
add dunst libnotify-bin
# Audio
add alsa-base alsa-utils

# Printing
add cups
add printer-driver-brlaser
add ghostscript # Also required by djvu2pdf.  Probably installed automatically
# add printer-driver-splix # For the Samsung - doesn't work

# Misc desktop utilities
add feh scrot suckless-tools synapse udiskie wmctrl xsel zenity
# Font manager and fonts
add font-manager fonts-dejavu fonts-noto fonts-noto-cjk fonts-roboto fonts-symbola

#
# Desktop (not necessarily X) tools
#

# Terminal emulator
add rxvt-unicode-256color
# Browsers
add chromium chromium-l10n firefox-esr firefox-esr-l10n-fr torbrowser-launcher
# Text editors (with CLI versions as well)
remove vim-gtk
add emacs24 emacs25 vim vim-gtk3
# These are the dependencies of Emacs pdf-tools
add imagemagick libpng-dev libpoppler-glib-dev libpoppler-private-dev libz-dev
# And the Emacs non-free documentation
add emacs25-common-non-dfsg
# Text editing tools
add meld
# Spell checking
add aspell aspell-fr
# Email client
add maildir-utils mu4e isync
# File managers
add mc pcmanfm
# Media player
add vlc
# Crypto
add gpa keychain
# Bad office suite
add libreoffice-calc libreoffice-writer libreoffice-gtk3 libreoffice-l10n-fr
# The texlive monster and tex utilities
add texlive-base texlive-lang-french texlive-xetex lmodern lyx
#                                                  ^ not part of the base distribution.
# Handling misc formats
add djvulibre-bin # Required (with ghostscript) for .bin/djvu2pdf
# Misc
add barcode qrencode zbar-tools
add pandoc
add qalculate-gtk
add transmission

if [ "anna" = `hostname` ]; then
    >&2 echo "I'm running on Anna."
	add acpid
	add network-manager rfkill # TODO move to a "laptop" group
	add task-laptop # Should have been installed automatically
	add xserver-xorg-video-intel
	add firmware-brcm80211 # Wifi
    # TODO apt suggests for powertop: cpufrequtils laptop-mode-tools
elif [ "rudiger" = `hostname` ]; then
    >&2 echo "I'm running on Rudiger."
	add xserver-xorg-video-radeon
    add numlockx
fi

if [ "$1" = "list" ]; then
    echo $packages | tr " " "\n" | sort -u
    exit 0
fi

echo
echo "I'm about to install"
echo "--------------------"
echo
echo $packages
echo
echo "I'm about to mark as automatically installed"
echo "--------------------------------------------"
echo $removed_packages
echo
echo "Please review the FULL output above and press enter"
echo "to proceed or C-c to abort."
read dummy

sudo apt-mark auto $removed_packages
sudo apt autoremove --purge
sudo apt install $packages
