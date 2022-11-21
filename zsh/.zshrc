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
# Auto loads                                                           #
#======================================================================#
# better tab completion (case insensitve always)
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'

# if node version manager exists add it's required script
[ -f /usr/share/nvm/init-nvm.sh ] && source /usr/share/nvm/init-nvm.sh

# if fzf exists add it's autocompletion
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# if terraform exists add it's autocompletion
command -v terraform > /dev/null && autoload -U +X bashcompinit && bashcompinit
command -v terraform > /dev/null && complete -o nospace -C /usr/bin/terraform terraform

# load work scripts
[ -f "$HOME/work.zsh" ] && source "$HOME/work.zsh"

# setup zsh hist file
if [[ ! -e ~/.cache/zsh/histfile ]]; then
  mkdir -p ~/.cache/zsh
  touch ~/.cache/zsh/histfile
fi

#======================================================================#
# Exports                                                              #
#======================================================================#
export SHELL="/usr/bin/zsh"
export EDITOR="/usr/bin/nvim"
# Fixes cursor glitch in vim
export TERMINAL="kitty"
export TERM="kitty"
# For GPG
export GPG_TTY=$(tty)

# For fzf
export FZF_DEFAULT_OPTIONS="-i --border=rounded --layout=reverse --prompt='-> ' --marker=* --info=inline --preview='bat fn {}'"
export FZF_DEFAULT_COMMAND="fd . --strip-cwd-prefix --color never"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd -t d . $HOME"

# For dir env in nixos
eval "$(direnv hook zsh)"

#======================================================================#
# Path                                                                 #
#======================================================================#
export PATH="/home/fergus/bin:$PATH"
export PATH="/home/fergus/.cargo/bin:$PATH"

#======================================================================#
# Theme                                                                #
#======================================================================#
export STARSHIP_CONFIG="$HOME/.config/starship.toml"
command -v starship > /dev/null && eval "$(starship init zsh)"

#======================================================================#
# Aliases                                                              #
#======================================================================#
# General aliases
alias cl=clear
alias rm="rm -vr"
alias cp="cp -r"
alias sudo="sudo "
alias mkdir="mkdir -p"
alias :q="exit"
alias reflector-update="reflector --verbose --latest 200 --protocol http --protocol https --sort rate --save /etc/pacman.d/mirrorlist"
alias sd="cd ~ && cd \$(fd . -t d | fzf)"
alias c=cargo
alias cr="cargo run"
alias ghc="ghc -dynamic"
# vim aliases
alias v=nvim
alias vc="nvim ~/.config/nvim/init.lua"
alias sv="sudoedit "
alias vim="nvim"
# better tools
alias grep=rg
alias top=bpytop
alias cat=bat
alias man=batman
# better ls
alias ls="exa -lh -s=name --git --group-directories-first --no-permissions --no-user --icons"
alias lsa="exa -lha -s=name --git --group-directories-first --no-permissions --no-user --icons"
alias lsp="exa -lha -s=name --git --group-directories-first --icons"
alias lsg="exa -lh -s=name --git --group-directories-first --git-ignore --no-permissions --no-user --icons"
# git aliases
alias gaa="git add --all"
alias gc="git commit"
alias gcm="git commit -m"
alias gp="git pull"
alias gpu="git push"
alias gs="git switch"
alias gsc="git switch -c"


#======================================================================#
# Startup                                                              #
#======================================================================#
command -v neofetch > /dev/null && neofetch
