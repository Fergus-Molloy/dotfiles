# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh/histfile
HISTSIZE=1000
SAVEHIST=1000
HIST_STAMPS="dd.mm.yyyy"
setopt autocd
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install

# Random exports
export TERMINAL="terminator"
export TERM="terminator"
export GIT="git@github.com:Fergus-Molloy"
export EDITOR="/usr/bin/nvim"
# Path to your oh-my-zsh installation.
export ZSH="/home/fergus/.oh-my-zsh"

# Configure PATH
export PATH="/home/fergus/bin:$PATH"
export PATH="/home/fergus/.gem/ruby/2.7.0/gems/bundler-2.1.4/exe:$PATH"
export PATH="/home/fergus/.cabal/bin:$PATH"
export PATH="/home/fergus/.cargo/bin:$PATH"
export PATH="/home/fergus/.local/bin:$PATH"

# Configure tags for rust
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src/"

# Set theme
eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/.config/starship/starship.toml

# Enable command auto-correction.
ENABLE_CORRECTION="true"

# Add plugins
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/compinstall

# Aliases
alias cl=clear
alias v=nvim
alias rm="remove-git"
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
alias top=bpytop
# better ls
#--no-permissions --no-user
alias ls="exa -lh -s=name --git --group-directories-first"
alias lsg="exa -lh -s=name --git --group-directories-first --git-ignore"
# cargo stuff
alias cc="cargo-root check"
alias cr="cargo-root run"
alias ct="cargo-root test"
alias cb="cargo-root build"
alias cbr="cargo-root build --release"
# git aliases
alias ga="git add"
alias gc="git commit"
alias gcm="git commit -m"
alias gp="git push"
alias gpo="git push origin"

# Functions
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
