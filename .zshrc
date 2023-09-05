# General

# auto cd
setopt autocd

# fast syntzs highlighting:
source $HOME/.config/zshPlugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

# z
source $HOME/.config/zshPlugins/zsh-z/zsh-z.plugin.zsh
autoload -U compinit && compinit
zstyle ':completion:*' menu select

# Set editor
export EDITOR="nvim"
export VISUAL="nvim"

# Use history search when going up
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end

# Go Env
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

# Mac specific
if [[ $(uname) == "Darwin" ]]; then
    # fix my broken C
    export SDKROOT="$(xcrun --sdk macosx --show-sdk-path)"

    # find my custom psql
    alias psql='$HOME/.bin/pgsql/bin/psql'

    # nice little uuid generator
    alias uuid='uuidgen | tr "[:upper:]" "[:lower:]" | tr -d "\n" | pbcopy'
fi

# load work config if exists
[[ -f "$HOME/.work-cfg" ]] && source "$HOME/.work-cfg"

# Aliases
alias g='git'

alias gl='glab'
alias glco='glab mr checkout'
alias gll='glab mr list -a@me'
alias gllr='glab mr list -r@me'
alias glv='glab mr view'
alias glo='glab mr view --web'
alias glsq='glab mr update --squash-before-merge'
alias glt='glab mr update -t'
alias gld='glab mr update -d-'
alias glr="glab mr update --ready --reviewer $GLABTEAM"
alias glp='glab ci view'

alias pss='git pss && glsq && gld && glp'

alias goc='f(){ go test -race -coverprofile=.coverage.out $1 && go tool cover -html=.coverage.out;  unset -f f; }; f'
alias got='go test -race -short ./...'
alias gol='golangci-lint run --print-issued-lines=false --max-issues-per-linter=0 --max-same-issues=0'

alias vi='nvim'
alias v='nvim'

alias al='aws sso login --profile '

alias jsonFormat="pbpaste | jq . | pbcopy"

# bare dotfiles repo setup
alias config='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'


# Styling

# remove user and computer name from shell
PS1="%F{112}%1~%f\$vcs_info_msg_0_ "

# add git branch
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
# RPROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:git:*' formats ' %F{7}%F{208}%b%F{7}%f'
zstyle ':vcs_info:*' enable git

