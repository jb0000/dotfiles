# General

# auto cd
setopt autocd

# vi like command line editing
setopt vi 

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
export PATH=$PATH:$HOME/.bin

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
[[ -f "$HOME/.zsh-work" ]] && source "$HOME/.zsh-work"

# Aliases
alias g='git'
alias gwa='f() { git worktree add -b $1 ~/work/worktree/$2 && cd ~/work/worktree/$2 }; f'
alias gwar='f() { git worktree add ~/work/worktree/$2 $1 && cd ~/work/worktree/$2 }; f'
# alias review='f() { git worktree add ~/work/worktree/review/$1 $1 && cd ~/work/worktree/review/$1 && v -c Review }; f'
alias clone='cloner "/Users/jorg/go/src/gitlab.com"'

alias gl='glab'
alias glco='glab mr checkout'
alias gll='glab mr list -a@me'
alias gllr='glab mr list -r@me'
alias glv='glab mr view -c'
alias glo='glab mr view --web'
alias glsq='glab mr update --squash-before-merge'
alias glt='glab mr update -t'
alias gld='glab mr update -d-'
alias glr="glab mr update --ready --reviewer $GLABTEAM"
alias glp='glab ci view'
alias glma="glab mr approve"

alias doneAllReviews='echo $(date -u "+%Y-%m-%dT%H:%M:%SZ") > ~/.bin/latest; open xbar://app.xbarapp.com/refreshAllPlugins'
alias doneRevision='echo $(date -u "+%Y-%m-%dT%H:%M:%SZ") > ~/.bin/latest-mine; open xbar://app.xbarapp.com/refreshAllPlugins'

alias pss='git pss && glsq && gld && glp'

alias goc='f(){ go test -race -coverprofile=.coverage.out $1 && go tool cover -html=.coverage.out;  unset -f f; }; f'
alias got='go test -race -short ./...'
alias gol='golangci-lint run --print-issued-lines=false --max-issues-per-linter=0 --max-same-issues=0'

alias vi='nvim'
alias v='nvim'
alias vv='nvim `fzf`'

alias c='cd $(find . -type d -print | fzf)'

alias x='xargs '
alias al='aws sso login --profile '

alias jsonFormat="pbpaste | jq . | pbcopy"

# bare dotfiles repo setup
alias config='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'


# Styling

# remove user and computer name from shell
PS1="%F{112}%1~%f\$vcs_info_msg_0_ "
#%F{112}%1~
# add git branch
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
# RPROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:git:*' formats ' %F{7}%F{208}%b%F{7}%f'
zstyle ':vcs_info:*' enable git

eval "$(atuin init zsh --disable-up-arrow)"
