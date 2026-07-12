#!/bin/bash
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples


# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# HR=$(printf "\e[1;4m%*s\e[0m\n" "$(tput cols)") # Causing tab to flicker
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\n\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\n\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\n\$ '
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

############################################
#   My Additions
############################################
rm -r /home/guts/Downloads >/dev/null 2>/dev/null # Temporary fix
rm -r /home/guts/Documents >/dev/null 2>/dev/null # Temporary fix

# My Aliases

# Application
alias obsidian="./obsidian >/dev/null 2>/dev/null &"
# Git Alias
alias gs="git status"
alias ga="git add"
alias gap="git add --patch"
alias gc="git commit --template=/home/guts/.config/git/template"
alias gdiff="git difftool -y"
alias gl="git log --graph --abbrev-commit --decorate --pretty=format:\"%C(yellow)%h%Creset %ad - %C(cyan)%an%Creset: %s\" --stat --date=short"
# Tmux
alias tname="tmux rename-window"
alias tmuxa='tmux attach -t 0'
# Python
alias python='python3'
# Docker
alias dbr='source ~/.local/bin/docker-build-run.sh'
alias ddl='source ~/.local/bin/docker-delete-last.sh'
alias dda='source ~/.local/bin/docker-delete-all.sh'
# Navigation
alias navigate='/home/guts/projects/personal/navigate/build/navigate && source /home/guts/projects/personal/navigate/src/navigate_cmd.sh'

#Path
export PATH=$PATH:/bin:/usr/bin:/bin/lesspipe:/usr/bin/lesspipe:/bin/dircolors:/usr/bin/dircolors:/home/efitoli/.local/bin:/home/guts/applications/obsidian/obsidian

# Function for sourcing the python virtual enviorment

# Move to rubbish instead of deleting
rm() {

    # Check if Trash directory exists; create it if it doesn't
    RUBISH_DIR="/home/guts/.rubbish"
    mkdir -p "$RUBISH_DIR"

    # Loop through all arguments passed to rm (files and directories)
    for file in "$@"; do
        if [ -e "$file" ]; then
            # Get the basename of the file and timestamp to avoid overwrites
            filename=$(basename "$file")
            timestamp=$(date +"%Y%m%d%H%M%S")
            mv "$file" "$RUBISH_DIR/${filename}_$timestamp"
            echo "Moved $file to $RUBISH_DIR/${filename}_$timestamp"
        else
            echo "rm: cannot remove '$file': No such file or directory"
        fi
    done
}

# Docker exec alias
dexec() {
    docker exec -it $LAST_DOCKER_IMAGE bash
}

# Display git branch on PS1
parse_git_branch() {

    # if we're in a git repository (bare or non-bare)
    if git rev-parse --git-dir > /dev/null 2>&1; then

        # Ordinary Repo / Worktree
        if [[ $(git rev-parse --is-inside-git-dir 2>/dev/null) == "true" ]]; then
            echo "(bare repository)";

        elif [[ $(basename $(git rev-parse --git-dir 2>/dev/null)) != ".git" ]]; then
            local repo=$(basename $(git rev-parse --git-common-dir));
            local branch=$(git branch --show-current);

            echo "("$repo"/"$branch")";

        else
            local repo=$(basename $(git rev-parse --show-toplevel));
            local branch=$(git branch --show-current);

            echo "("$repo"/"$branch")";

        fi
    fi
}


psrc() {

    if [ -d ".venv" ]; then
        source .venv/bin/activate
    elif [ -d "venv" ]; then
        source venv/bin/activate
    else
        echo "No virtual enviorment in current directory"
    fi
}

PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]: \[\033[01;34m\]\W\[\033[00m\]\[\033[33m\] $(parse_git_branch)\[\033[00m\]\n\$ '

# fnm
FNM_PATH="/home/guts/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "`fnm env`"
fi
export PATH="$HOME/.local/bin:$PATH"


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
