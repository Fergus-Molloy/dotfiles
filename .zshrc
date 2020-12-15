# Lines configured by zsh-newuser-install
HISTFILE=~/.cache/zsh/histfile
HISTSIZE=1000
SAVEHIST=1000
HIST_STAMPS="dd.mm.yyyy"
setopt autocd
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install
autoload -Uz compinit
compinit -d "$HOME/.cache/zsh/zcompdump"

# Random exports
export TERMINAL="alacritty"
export TERM="alacritty"
export GIT="git@github.com:Fergus-Molloy"
export EDITOR="/usr/bin/nvim"
# Path to your oh-my-zsh installation.
export ZSH="/home/fergus/.oh-my-zsh"

# exports for argos3 ----
export LD_LIBRARY_PATH=/usr/local/lib/argos3/:$LD_LIBRARY_PATH
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig/:$PKG_CONFIG_PATH
# -----------------------

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
source ~/.cache/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.cache/zsh/compinstall
# enable autojump
[[ -s /etc/profile.d/autojump.sh ]] && source /etc/profile.d/autojump.sh
# Aliases
alias cl=clear
alias v=nvim
alias rm="remove-git"
alias pik=pikaur
alias brightness="xrandr --output eDP-1 --brightness"
alias sudo="sudo "
alias mkdir="mkdir -p"
alias volume=pulsemixer
alias :q="exit"
alias grep=rg
alias latexmk="latexmk -lualatex -synctex=1 -shell-escape"
alias top=bpytop
alias reflector-update="reflector --verbose --latest 200 --protocol http --protocol https --sort rate --save /etc/pacman.d/mirrorlist"
# better ls
#--no-permissions --no-user
alias ls="exa -lh -s=name --git --group-directories-first --no-permissions --no-user"
alias lsa="exa -lha -s=name --git --group-directories-first --no-permissions --no-user"
alias lsg="exa -lh -s=name --git --group-directories-first --git-ignore --no-permissions --no-user"
# cargo stuff
alias cc="cargo-root check"
alias cr="cargo-root run"
alias ct="cargo-root test"
alias cb="cargo-root build"
alias cbr="cargo-root build --release"
# git aliases
alias ga="git add"
alias gaa="git add ."
alias gc="git commit"
alias gcm="git commit -m"
alias gp="git push"
alias gpo="git push origin"

neofetch

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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
