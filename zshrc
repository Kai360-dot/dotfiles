# ~/.zshrc — portable, machine-specifics go in ~/.zshrc.local

# If not running interactively, don't do anything
[[ -o interactive ]] || return

# --- history ---
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=2000
setopt APPEND_HISTORY          # append, don't overwrite
setopt HIST_IGNORE_DUPS        # ~ ignoreboth (dups)
setopt HIST_IGNORE_SPACE       # ~ ignoreboth (leading space)

# make less friendly for non-text input (no-op where absent)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# --- prompt ---
autoload -Uz colors && colors
case "$TERM" in
    xterm-color|*-256color)
        PROMPT='%B%F{green}%n@%m%f%b:%B%F{blue}%~%f%b%# ' ;;
    *)
        PROMPT='%n@%m:%~%# ' ;;
esac
# terminal title
case "$TERM" in
    xterm*|rxvt*)
        precmd() { print -Pn "\e]0;%n@%m: %~\a" } ;;
esac

# --- colors & ls aliases ---
if command -v dircolors >/dev/null; then       # GNU coreutils (Linux)
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
else                                           # BSD/macOS
    export CLICOLOR=1
    alias grep='grep --color=auto'
fi
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# --- editor ---
command -v nvim >/dev/null && alias vim='nvim'

# --- tmux ---
alias ta='tmux attach'
alias tn='tmux new -s'
alias td='tmux detach'
alias tat='tmux a -t'
alias tl='tmux ls'
alias tks='tmux kill-session -t'

# --- completion ---
autoload -Uz compinit && compinit

# --- tools (all guarded) ---
export PATH="$HOME/.local/bin:$PATH"                      # uv et al.
[ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env" # uv env

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"          # nvm has zsh completion built in via nvm.sh

bindkey -v                                                 # vi mode

# --- machine-specific overrides ---
[ -f ~/.zshrc.local ] && . ~/.zshrc.local
