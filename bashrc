# ~/.bashrc — portable, machine-specifics go in ~/.bashrc.local

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# --- history ---
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000

shopt -s checkwinsize

# make less friendly for non-text input (no-op where absent)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# --- prompt ---
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac
if [ "$color_prompt" = yes ]; then
    PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='\u@\h:\w\$ '
fi
unset color_prompt
case "$TERM" in
    xterm*|rxvt*) PS1="\[\e]0;\u@\h: \w\a\]$PS1";;
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
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    elif [ -f /opt/homebrew/etc/profile.d/bash_completion.sh ]; then
        . /opt/homebrew/etc/profile.d/bash_completion.sh
    fi
fi

# --- tools (all guarded) ---
export PATH="$HOME/.local/bin:$PATH"                      # uv et al.
[ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env" # uv env

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

set -o vi

# --- machine-specific overrides ---
[ -f ~/.bashrc.local ] && . ~/.bashrc.local
