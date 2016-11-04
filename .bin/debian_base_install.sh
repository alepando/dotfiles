#alias apti="apt install -y"
add() {
    packages="$packages $@"
}

packages=""

# Drivers
add firmware-linux-free firmware-linux-nonfree smartmontools
# Misc system utilities
add apt-file netselect-apt psmisc sudo whois wipe
# Compression
add zip unzip
# Shell
add zsh
# Encryption keys management
add keychain
# Stuff for programming
add build-essential git python-setuptools python-pip python python3 virtualenvwrapper nodejs npm 
# Printing!
add cups
# Auto mounting
add udiskie

#
# Desktop environment
# 

# Xorg
add xserver-xorg-core xserver-xorg-input-libinput x11-xserver-utils \
     mesa-utils mesa-va-drivers mesa-vdpau-drivers
# Display manager & session locker
add lightdm-gtk-greeter light-locker \
# Dbus
add dbus-x11
# Notification system
add libnotify-bin
# Make some noise!
add alsa-base alsa-utils
# Window manager
add xmonad libghc-xmonad-contrib-doc libghc-dbus-dev
# Compositing manager
add compton 
# Misc DE utilities
add dunst keynav feh scrot synapse wmctrl xsel
# Font manager and fonts
add font-manager fonts-roboto

#
# Desktop tools
#

# Terminal emulator and multiplexer
add rxvt-unicode-256color tmux
# Browsers
add chromium chromium-l10n firefox-esr firefox-esr-l10n-fr lynx
# Text-editors (with CLI versions as well)
add emacs vim vim-gtk
# Email client
add maildir-utils mu4e isync
# File managers
add mc
# Media player
add vlc
# Bad office suite
add libreoffice

# And the texlive monster and tex utilities
add texlive-full lyx \

if [ "anna" = `hostname` ]; then
    echo "I'm running on Anna.  I'm assuming a MacBook Air 2011.  Interrupt me if I'm wrong."
	add acpid
	add task-laptop # Should have been installed automatically
	add xserver-xorg-video-intel  
	add firmware-brcm80211 # Wifi
fi
if [ "rudiger" = `hostname` ]; then
    echo "I'm running on Rudiger.  I'm assuming a Mac Pro 2008.  Interrupt me if I'm wrong."
fi



# qt: qt5-default fournit qt et le configure comme installation par défaut pour qtchooser.

echo $packages
apt install $packages

echo "Advice on how to install some extra packages in the file"
