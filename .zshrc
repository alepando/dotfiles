 # Don't do anything if not running interactively
[[ $- != *i* ]] && return

# Install antigen if needed
if [ ! -d "$HOME/.antigen" ]; then
	git clone https://github.com/zsh-users/antigen.git $HOME/.antigen
fi

source ~/.antigen/antigen.zsh

antigen bundle zsh-users/zaw
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions

antigen use oh-my-zsh
antigen theme agnoster

antigen apply

# Prefix-based history search with up and down arrow
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search

# Variables

export DEFAULT_USER="thblt"; # ZSH themes uses this to simplify prompt.
export EDITOR="emacsclient -ca ''"
alias bc="bc -l"
alias e="${EDITOR} --no-wait" # Shorthand
alias ee="${EDITOR} --create-frame --no-wait" # Shorthand
alias o=xdg-open

export GREP_COLOR=31
alias grep='grep --color=auto'

# Git aliases
alias ga="git add"
alias gc="git commit"
alias gd="git diff"
alias gp="git push"
alias grm="git rm"

#Pipe aliass
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'
alias -g L="| less"
alias -g M="| most"
alias -g LL="2>&1 | less"
alias -g CA="2>&1 | cat -A"
alias -g NE="2> /dev/null"
alias -g NUL="> /dev/null 2>&1"
alias -g P="2>&1| pygmentize -l pytb"

# Misc aliases
alias apt-what-have-i-installed="comm -23 <(comm -23 <(apt-mark showmanual | sort -u) <(cat ~/.dotfiles/Notes/debian_initial_`hostname`.list | sort -u)) <(debian_base_install.sh list | sort -u)"
alias bc="bc -l"
alias fuck='sudo $(fc -ln -1)' # 'sudo $(history -p \!\!)' is bash-only
alias zbarcam="LD_PRELOAD=/usr/lib/libv4l/v4l1compat.so zbarcam"

function mkcd() {
if mkdir -p "$@"
	then cd "$@"
fi
}

# Moving between directories
alias bd=". bd -s"
alias ..="cd .."
alias ..2="cd ../.."
alias ..3="cd ../../.."
alias ..4="cd ../../../.."
alias ..5="cd ../../../../.."
alias ..6="cd ../../../../../.."

# Virtualenvwrapper

export WORKON_HOME=~/.virtualenvs
source `which virtualenvwrapper.sh` 2> /dev/null
source /usr/share/virtualenvwrapper/virtualenvwrapper.sh 2> /dev/null

# Allow to recall aborted command
# From <https://www.topbug.net/blog/2016/10/03/restore-the-previously-canceled-command-in-zsh/>
function zle-line-init {
  # Your other zle-line-init configuration ...

  # Store the last non-empty aborted line in MY_LINE_ABORTED
  if [[ -n $ZLE_LINE_ABORTED ]]; then
    MY_LINE_ABORTED="$ZLE_LINE_ABORTED"
  fi

  # Restore aborted line on the first undo.
  if [[ -n $MY_LINE_ABORTED ]]; then
    local savebuf="$BUFFER" savecur="$CURSOR"
    BUFFER="$MY_LINE_ABORTED"
    CURSOR="$#BUFFER"
    zle split-undo
    BUFFER="$savebuf" CURSOR="$savecur"
  fi
}
zle -N zle-line-init

# Case-insensitive completion *only* when there's no case sensitive match.
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
source ~/.profile
