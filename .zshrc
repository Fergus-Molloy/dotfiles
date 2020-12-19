# Lines configured by zsh-newuser-install
HISTFILE=~/.cache/zsh/histfile
HISTSIZE=1000
SAVEHIST=1000
HIST_STAMPS="dd.mm.yyyy"
setopt autocd
unsetopt beep
bindkey -e
ENABLE_CORRECTION="true"
# End of lines configured by zsh-newuser-install

#======================================================================#
# Exports                                                              #
#======================================================================#
export EDITOR="/usr/bin/nvim"
# Fixes cursor glitch in vim
export TERMINAL="alacritty"
export TERM="alacritty"
# For easy cloning of my repos
export GIT="git@github.com:Fergus-Molloy"
# For argos3
export LD_LIBRARY_PATH=/usr/local/lib/argos3/:$LD_LIBRARY_PATH
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig/:$PKG_CONFIG_PATH
# Configure tags for rust
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src/"
# For theme
export STARSHIP_CONFIG=~/.config/starship/starship.toml

#======================================================================#
# Path                                                                 #
#======================================================================#
export PATH="/home/fergus/bin:$PATH"
export PATH="/home/fergus/.gem/ruby/2.7.0/gems/bundler-2.1.4/exe:$PATH"
export PATH="/home/fergus/.cabal/bin:$PATH"
export PATH="/home/fergus/.cargo/bin:$PATH"
export PATH="/home/fergus/.local/bin:$PATH"


#======================================================================#
# Theme                                                                #
#======================================================================#
eval "$(starship init zsh)"
neofetch

#======================================================================#
# Plugins                                                              #
#======================================================================#
source ~/.cache/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
# better completion
source ~/.cache/zsh/compinstall
# better cd
eval "$(zoxide init zsh)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#======================================================================#
# Aliases                                                              #
#======================================================================#
# General aliases
# uncomment below if you need to change brightness from the command line (1 is 100%)
# alias brightness="xrandr --output eDP-1 --brightness"
alias cl=clear
alias v=nvim
alias rm="remove-git"
alias cd=z
alias cdi=zi
alias sudo="sudo "
alias mkdir="mkdir -p"
alias grep=rg
alias top=bpytop
alias :q="exit"
alias pik=pikaur
alias volume=pulsemixer
alias latexmk="latexmk -lualatex -synctex=1 -shell-escape"
alias reflector-update="reflector --verbose --latest 200 --protocol http --protocol https --sort rate --save /etc/pacman.d/mirrorlist"

# better ls
#--no-permissions --no-user
alias ls="exa -lh -s=name --git --group-directories-first --no-permissions --no-user"
alias lsa="exa -lha -s=name --git --group-directories-first --no-permissions --no-user"
alias lsg="exa -lh -s=name --git --group-directories-first --git-ignore --no-permissions --no-user"

# cargo aliases
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


#======================================================================#
# Functions                                                            #
#======================================================================#
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

