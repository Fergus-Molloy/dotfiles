# Source manjaro-zsh-configuration
if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
  source /usr/share/zsh/manjaro-zsh-config
fi

export SHELL=/usr/bin/zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

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

source <(kubectl completion zsh)

# =============================================================
# FUNCTIONS
# =============================================================
vimfind() {
    nvim -o `fzf`
} 

# =============================================================
# EXPORTS
# =============================================================
export EDITOR="/usr/bin/nvim"
export TERMINAL="wezterm"
export TERM="wezterm"
# for cloning git repos
export GIT="git@github.com:Fergus-Molloy"
# make docker build better
export DOCKER_BUILDKIT=1
export DOCKER_TLS_VERIFY="1"
export DOCKER_HOST="tcp://192.168.39.177:2376"
export DOCKER_CERT_PATH="/home/fergus/.minikube/certs"
export MINIKUBE_ACTIVE_DOCKERD="minikube"
# fzf options
export FZF_DEFAULT_OPTS="-i --border=rounded --layout=reverse --prompt='-> ' --marker=* --info=inline --preview='bat -fn {}'"
export FZF_DEFAULT_COMMAND="fd . --strip-cwd-prefix --color never"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd -t d . $HOME"

# =============================================================
# PATH
# =============================================================
export PATH="/home/fergus/bin:$PATH"
export PATH="/home/fergus/.cargo/bin:$PATH"
export PATH="/home/fergus/.emacs.d/bin:$PATH"

# =============================================================
# THEME
# =============================================================
export STARSHIP_CONFIG="~/.config/starship/starship.toml"
eval "$(starship init zsh)"

# =============================================================
# ALIASES
# =============================================================
alias cl=clear
alias ff="fzf"
alias v="nvim"
alias vj="nvim -u ~/.config/nvim/java/init.lua"
alias vf="vimfind"
alias vim="nvim"
alias rm="rm -vr"
alias cp="cp -r"
alias sudo="sudo "
alias mkdir="mkdir -p"
alias grep=rg
alias top=bpytop
alias :q="exit"
alias reflector-update="reflector --verbose --latest 200 --protocol http --protocol https --sort rate --save /etc/pacman.d/mirrorlist"
alias c=cargo
alias cat=bat
alias man=batman
alias cr="cargo run"
alias ghc="ghc -dynamic"
alias emacsd="/usr/bin/emacs --bg-daemon"
alias emac="/usr/bin/emacs"
alias emacs="emacsclient -c -a 'emac'"
alias em="emacs -nw"
alias e="emacsclient -c -a 'emac'"

# better ls

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
alias gpu="git push"
alias gpl="git pull"
alias gpo="git push origin"
alias gb="git branch"
alias gs="git switch"
alias gsc="git switch -c"


neofetch
