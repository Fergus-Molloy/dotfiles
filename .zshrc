# random exports
export TERMINAL="terminator"
export TERM="terminator"
export GIT="git@github.com:Fergus-Molloy"

# Path to your oh-my-zsh installation.
export ZSH="/home/fergus/.oh-my-zsh"

# Add user bin to PATH
export PATH="/home/fergus/bin:$PATH"

# Add packages installed by cabal to path
export PATH="/home/fergus/.cabal/bin:$PATH"
#
# Add cargo packages to path
export PATH="/home/fergus/.cargo/bin:$PATH"

# Add installs for this user to path
export PATH="/home/fergus/.local/bin:$PATH"

# Configure tags for rust
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src/"

# Set theme
#ZSH_THEME="spaceship"
ZSH_THEME="gruvbox"
SOLARIZED_THEME="dark"

# Uncomment the following line to use case-sensitive completion.
#CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="dd.mm.yyyy"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(git zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# ------------------------------------------------------------------------------------
# User configuration

# Remove the need to type cd to change directory
setopt autocd
KEYTIMEOUT=1
# enable vi mode
bindkey -v

# Better searching in command mode
bindkey -M vicmd '?' history-incremental-search-backward
bindkey -M vicmd '/' history-incremental-search-forward

# Beginning search with arrow keys
bindkey "^[OA" up-line-or-beginning-search
bindkey "^[OB" down-line-or-beginning-search
bindkey -M vicmd "k" up-line-or-beginning-search
bindkey -M vicmd "j" down-line-or-beginning-search

# Updates editor information when the keymap changes.
function zle-keymap-select() {
  zle reset-prompt
  zle -R
}

zle -N zle-keymap-select

function vi_mode_prompt_info() {
  echo "${${KEYMAP/vicmd/[% NORMAL]%}/(main|viins)/[% INSERT]%}"
}

# define right prompt, regardless of whether the theme defined it
RPS1='$(vi_mode_prompt_info)'
RPS2=$RPS1


# aliases
alias cl=clear
alias v=nvim
alias rm="rm -rv"
alias pik=pikaur
alias restart-wifi="sudo systemctl restart NetworkManager"
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias brightness="xrandr --output eDP-1 --brightness"
alias sudo="sudo "
alias s=startx
alias mkdir="mkdir -p"
alias volume=pulsemixer
alias :q="exit"
alias grep=rg
alias latexmk="latexmk -lualatex -synctex=1 -shell-escape"
alias google-chrome=firefox
# better ls
alias ls="exa -lh -s=name --git --group-directories-first --no-permissions --no-user"
alias lsg="exa -lh -s=name --git --group-directories-first --no-permissions --no-user --git-ignore"
# cargo stuff
alias cc="cargo-root check"
alias cr="cargo-root run"
alias ct="cargo-root test"
alias cb="cargo-root build"
alias cbr="cargo-root build --release"

# functions
mkcdir(){
    mkdir -p -- "$1" &&
        cd -P -- "$1"
}

lls(){
    clear
    ls
}

cn(){
    cargo new "$@" &&
        cd -P -- "${@: -1}"
}
