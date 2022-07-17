# Lines configured by zsh-newuser-install
HISTFILE=~/.cache/zsh/histfile
HISTSIZE=1000
SAVEHIST=1000
HIST_STAMPS="dd.mm.yyyy"
setopt autocd
setopt MULTIOS
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
export TEXMFLOCAL="~/.texmf"
# For easy cloning of my repos
export GIT="git@github.com:Fergus-Molloy"
# For argos3
export LD_LIBRARY_PATH=/usr/local/lib/argos3/:$LD_LIBRARY_PATH
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig/:$PKG_CONFIG_PATH
# Configure tags for rust
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src/"
# For theme
export STARSHIP_CONFIG=~/.config/starship/starship.toml
# For GPG
export GPG_TTY=$(tty)
#======================================================================#
# Path                                                                 #
#======================================================================#
export PATH="/home/fergus/bin:$PATH"
export PATH="/home/fergus/.gem/ruby/2.7.0/gems/bundler-2.1.4/exe:$PATH"
export PATH="/home/fergus/.cabal/bin:$PATH"
export PATH="/home/fergus/.cargo/bin:$PATH"
export PATH="/home/fergus/.local/bin:$PATH"
export PATH="/home/fergus/.dotnet/tools:$PATH"
export PATH="/home/fergus/.rustup/toolchains/<toolchain>/lib/rustlib/<target-triple>/bin:$PATH"

#======================================================================#
# Theme                                                                #
#======================================================================#
eval "$(starship init zsh)"


#======================================================================#
# Completion                                                           #
#======================================================================#

_dotnet_zsh_complete()
{
  local completions=("$(dotnet complete "$words")")

  reply=( "${(ps:\n:)completions}" )
}

compctl -K _dotnet_zsh_complete dotnet

#======================================================================#
# Plugins                                                              #
#======================================================================#
# better git
source ~/bin/git.sh
# auto suggestions
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
alias sv="sudoedit "
alias rm="remove-git"
alias cp="cp -r"
#alias cd=z
#alias cdi=zi
alias sudo="sudo "
alias mkdir="mkdir -p"
alias grep=rg
alias top=bpytop
alias :q="exit"
alias volume=pulsemixer
alias latexmk="latexmk -lualatex -synctex=1 -shell-escape"
alias reflector-update="reflector --verbose --latest 200 --protocol http --protocol https --sort rate --save /etc/pacman.d/mirrorlist"
alias mountj="ecryptfs-mount-private"
alias umountj="ecryptfs-umount-private"
alias copy="xclip -selection clipboard"
alias c="cargo"
alias clion="sh /home/fergus/.local/share/JetBrains/Toolbox/apps/CLion/ch-0/203.7148.70/bin/clion.sh"
alias cat=bat
alias man=batman
alias tlmgr='/usr/share/texmf-dist/scripts/texlive/tlmgr.pl --usermode'
alias cr="cargo run"
alias ghc="ghc -dynamic"
#alias cb="clipcatctl"

# better ls
#--no-permissions --no-user
alias ls="exa -lh -s=name --git --group-directories-first --no-permissions --no-user"
alias lsa="exa -lha -s=name --git --group-directories-first --no-permissions --no-user"
alias lsp="exa -lha -s=name --git --group-directories-first"
alias lsg="exa -lh -s=name --git --group-directories-first --git-ignore --no-permissions --no-user"

# git aliases
alias ga="git add"
alias gaa="git add --all"
alias gc="git commit"
alias gam="git commit -am"
alias gcm="git commit -m"
alias gp="git push"
alias gpo="git push origin"
alias gb="git branch"


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

if [ -n "$DESKTOP_SESSION" ];then
    eval $(gnome-keyring-daemon --start)
    export SSH_AUTH_SOCK
fi

# Clipcat
#if type clipcat-menu >/dev/null 2>&1; then
#    alias clipedit=' clipcat-menu --finder=builtin edit'
#    alias clipdel=' clipcat-menu --finder=builtin remove'
#
#    bindkey -s '^[' "^Q clipcat-menu --finder=builtin insert ^J"
#    bindkey -s '^]' "^Q clipcat-menu --finder=builtin remove ^J"
#fi


#======================================================================#
# Startup                                                              #
#======================================================================#
neofetch
