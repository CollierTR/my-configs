# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

source "$HOME/.env"

# Color Variables (truecolor — matches alacritty/nvim gruvbox dark)
blk='\[\033[01;30m\]' # Black
red='\[\033[38;2;221;68;68m\]'   # #DD4444
grn='\[\033[38;2;184;187;38m\]'  # #b8bb26 — gruvbox bright green
ylw='\[\033[01;33m\]' # Yellow
blu='\[\033[01;34m\]' # Blue
pur='\[\033[38;2;211;134;155m\]' # #d3869b — gruvbox bright magenta
cyn='\[\033[01;36m\]' # Cyan
wht='\[\033[01;37m\]' # White
clr='\[\033[00m\]'    # Reset

# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

# History settings
shopt -s histappend
PROMPT_COMMAND="history -a; history -n"
HISTCONTROL=ignoreboth
HISTSIZE=4000
HISTFILESIZE=4000
HISTTIMEFORMAT="%F %T "

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color | *-256color) color_prompt=yes ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias dir='dir --color=auto'
  alias vdir='vdir --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

tags() {
  rg -o --no-filename -g '*.md' '#[A-Za-z0-9_]+' . \
    | sort \
    | uniq -c
}

findtag() {
  if [ -z "$1" ]; then
    echo "Usage: tagfind <tag>"
    return 1
  fi

  rg -il -g '*.md' "(^|\\s)#$1\\b" .
}

labels() {
  rg --no-filename -g '*.md' '@[A-Za-z0-9_]+' . \
    | sort
}

# enable programmable completion features
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# ---------------------------------------------------------start BASH PROMPT
find_git_branch() {
  # Based on: http://stackoverflow.com/a/13003854/170413
  local branch
  if branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null); then
    if [[ "$branch" == "HEAD" ]]; then
      branch='detached*'
    fi
    git_branch="($branch"
    git_closer=") "
  else
    git_branch=""
    git_closer=""
  fi
}

find_git_dirty() {
  local status=$(git status --porcelain 2>/dev/null)
  if [[ "$status" != "" ]]; then
    git_dirty="*"
  else
    git_dirty=''
  fi
}

PROMPT_COMMAND="find_git_branch; find_git_dirty; $PROMPT_COMMAND"

export PS1="\${debian_chroot:+(\$debian_chroot)}\n${pur}\$git_branch\$git_dirty\$git_closer${grn}\W \$ ${clr}"
# -------------------------------------------------- end

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Vim Mode!
set -o vi

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

# For Arch on WSL bash completion
[[ -r /usr/share/bash-completion/bash_completion ]] &&
  source /usr/share/bash-completion/bash_completion

# load modular bash files
for file in ~/.bashrc.d/*.sh; do
  [ -r "$file" ] && source "$file"
done
source <(kubectl completion bash)
export PATH="$PATH:$HOME/.dotnet/tools"
export PATH="$HOME/bin:$PATH"
export PATH="$PATH:/mnt/c/Program\ Files/cursor/Cursor.exe"
export PATH="$HOME/.local/share/gem/ruby/3.2.0/bin:$PATH"
export NODE_USE_SYSTEM_CA=1
