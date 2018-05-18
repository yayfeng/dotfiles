[ -n "$PS1" ] && source ~/.bash_profile;


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
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

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

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
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

alias terminator='terminator --maximise --borderless --layout=myLayout&'
alias vi=vim
# where to store our virtual envs
export WORKON_HOME=$HOME/virtenvs
# where projects will reside
export PROJECT_HOME=$HOME/Projects-Active
# where is the virtualenvwrapper.sh
#source $HOME/.local/bin/virtualenvwrapper.sh

source /home/yayun/workspace/envs/watty.env.bash

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTFILE=/home/$USER/.bash_history_nondefault
HISTSIZE=91000
HISTFILESIZE=912000

shopt -s histappend
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

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

function macvendor () {
    if ! [ -f "/tmp/oui.txt" ]; then
        wget https://raw.githubusercontent.com/royhills/arp-scan/master/ieee-oui.txt -O /tmp/oui.txt
    fi
    OUI=$(echo ${1//[:.- ]/} | tr "[a-f]" "[A-F]" | egrep -o "[0-9A-F]{6}")
    grep $OUI /usr/share/nmap/nmap-mac-prefixes
}
alias macv="python -c \"import sh, sys;fin=[ '\t'.join([ x[0], x[1], str( sh.grep( x[1].upper().replace(':','')[:6], '/tmp/oui.txt', _ok_code=[0,1] ) )[7:] ]) for x in [y.split() for y in sys.stdin.readlines() if y.count(':') > 4]]; print('\n'.join(fin).replace('\n\n', '\n'))\""

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
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

# Git aliases
alias gs='git status'
alias gsubll='git submodule foreach git pull origin master'
alias gsubup='git submodule foreach --recursive git pull origin master && git submodule foreach --recursive git submodule update'
alias gsu='git submodule update'

alias fzf='/home/yayun/programs/fzf-0.15.9-linux_amd64'

# fzf git commit [diff] browser
glg() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}

# fzf list and checkout git branches
gren() {
  local branches branch
  branches=$(git branch -vv | while IFS= read li; do x=$(printf "$li" | sed 's/\*//' | awk '{print $2}' | xargs git show --no-patch --date='short' --format='%ad'); printf "$x $li\n"; done | sort | tac)
  branch=$(echo "$branches" | fzf +m) &&
  git checkout $(echo "$branch" | sed "s/\*//" | awk '{print $2}' | sed "s/.* //")
}


alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias lstree="ls -R | grep \":$\" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/   /' -e 's/-/|/'"
alias grepr="grep -R"
alias g="grep --color=auto"
alias fat='pygmentize -g'  # Colorized cat
alias ra="ranger"
alias dri='docker run --rm -it '

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
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi


GIT_BRANCH="git rev-parse --abbrev-ref HEAD 2> /dev/null"
GIT_REMOTE_BRANCH="git rev-parse --symbolic-full-name --abbrev-ref @{u} 2> /dev/null"

PS1="\[\033[0;37m\]\342\224\214\342\224\200\$([[ \$? != 0 ]] && echo \"[\[\033[0;31m\]\342\234\227\[\033[0;37m\]]\342\224\200\")[$(if [[ ${EUID} == 0 ]]; then echo '\[\033[0;31m\]\h'; else echo '\[\033[1;33m\]\u\[\033[0;37m\]@\[\033[1;96m\]\h'; fi)\[\033[0;37m\]]\342\224\200[\[\033[1;32m\]\w\[\033[0;37m\]]\342\224\200[\[\033[1;31m\]\$(${GIT_BRANCH})\[\033[0;37m\]->\[\033[1;31m\]\$(${GIT_REMOTE_BRANCH})\[\033[0;37m\]]\342\224\200\n\[\033[0;37m\]\342\224\224\342\225\274 \[\033[0m\]"

alias mosh="mosh --server='mosh-server new -l LC_ALL=en_US.UTF-8'"
alias rednose='nosetests --rednose'
alias p8="ping 8.8.8.8"

# Package manager aliases
alias sap="sudo apt-get "
alias sapi="sudo apt-get install "
alias sapu="sudo apt-get update"
# Tmux aliases
alias td="tmux detach"
alias ta="tmux a"
alias tls="tmux list-sessions"
# Shorthand for moving up file tree
alias f='cd ..'
# Shorthand for returning to previous directory
alias c='cd -'
function d () { cd "$1"; ls -la; }

# Shorthand for finding
function hit () { arg2=$2; find . -maxdepth ${arg2:=999} -type f -iname "*$1*" | grep -i "$1"; }
function hitdir () { arg2=$2; find . -maxdepth ${arg2:=999} -type d -iname "*$1*" | grep -i "$1"; }
function fin () { grep -n "$1" $(find . -type f -name "*$2*"); }

# Replace a string in non-hidden files
function replacer () {
    if [[ -z "$1" ]]; then
        echo "Function requires at least one argument"
        return 1
    fi
    files=`find . \( ! -regex '.*/\..*' \) -name "*" -type f -exec grep -l "$1" {} +`;
    if [[ -z "$files" ]]; then
        echo "No files found containing '$1'"
        return 0
    fi
    echo "Files containing '$1':"
    echo "------"
    echo "$files"
    echo "------"
    read -p ">>> Replace '$1' --> '$2' in the above files? [Y/n]: " RESP;
    if [[ "$RESP" == "y" || "$RESP" == "Y" || "$RESP" == "" ]]; then
        echo "$files" | xargs sed -i "s/$1/$2/g"
    fi
}

# Find python imports in current directory that are not part of the python standard library
function non-stdlib-imports () {
    # Requires isort to be pip-installed
    stdlib_mods=`python -c "import isort, sys; sys.stdout.write('|'.join(isort.settings.default['known_standard_library']))"`
    non_stdlib_used_mods=`grep "import " $(find . -name "*.py") | cut -f2 -d ' ' | cut -f1 -d'.' | sort | uniq | grep -v -E $stdlib_mods`
    grep -nRE "$non_stdlib_used_mods" | grep -e "import.* " -e "from.* "
}


# Shorthand for trash, which also of course can be used in place of rm -r
alias rem='trash'
# Trash all pyc-files in directory and sub-directories
alias rempyc='find . -name "*.pyc" | xargs trash'
# Open file from the command line with the program associated with the filetype
alias op='xdg-open'
# Display nice-looking calendar
alias cal='ncal -bM'

# Command for stripping trailing white spaces in file
alias rm_trail_wp="sed --in-place 's/[[:space:]]\+$//'"

COL_RED='\033[1;31m'
NOCOLOR='\033[0m'

# source ~/.bash_alias_completion
function clrdiff () { colordiff -y -W $(tput cols) "$@" | less -R;}
#function hgrep () { history | grep -P -- "$1" | grep -P -- "$2" | grep -P -- "$3"; }
function hgrep () { ( cat --number /home/yayun/.bash_history_2016-10-30; history; ) | grep -P -- "$1" | grep -P -- "$2" | grep -P -- "$3"; }
function outdated_reqs () {
  echo "Checking installed outdated modules in $1 ..."
  local modules=$(cat $1 | sed 's/==.*//' | sed -e '{:q;N;s/\n/\|/g;t q}')
  pip list --outdated 2>/dev/null | grep -i -E $modules
}
function sshrc () { /usr/bin/ssh -t $* "echo '`base64 -i ~/.bash_remote_rc`' | base64 --decode > /tmp/bash_remote_rc; bash --rcfile /tmp/bash_remote_rc" 
}


eval 'map () {    if [ $# -le 1 ]; then      return ;   else      local f=$1 ;     local x=$2 ;     shift 2 ;     local xs=$@ ;      eval $f $x ;      map "$f" $xs ;   fi ; }'
dirfunc () { 
    orgpwd=`pwd`
    echo ""
    echo -e "$COL_RED---------> $2 <---------$NOCOLOR"
    cd $2
    eval $func $1
    cd $orgpwd
}


# ls variation aliases
alias ll='ls -alF'
alias la='ls -A'
alias lh='ls -lFh'
alias l='ls -lF'
alias lsize='ls -lAhr --sort=size'

# ----------------------------------
# Display ls filesizes with decimals
# ----------------------------------
lsMB="--color=always | awk ""'"'BEGIN{mega=1048576} { sz = sprintf("%0.3f", $5/mega)} {gsub("^0*", "", sz)} {$1 = sprintf("%s %+3s %-8s %-8s %+9s M %+3s %+2s %+5s ", $1, $2, $3, $4, sz, $6, $7, $8)} {$2=""}{$3=""}{$4=""}{$5=""}{$6=""}{$7=""}{$8=""}{print}'"'"
lsKB="--color=always | awk ""'"'BEGIN{kilo=1024} { sz = sprintf("%0.3f", $5/kilo)} {gsub("^0*", "", sz)} {$1 = sprintf("%s %+3s %-8s %-8s %+12s K %+3s %+2s %+5s ", $1, $2, $3, $4, sz, $6, $7, $8)} {$2=""}{$3=""}{$4=""}{$5=""}{$6=""}{$7=""}{$8=""}{print}'"'"
alias lk="ls -l $lsKB"
alias lks="ls -l -r --sort=size $lsKB"
alias lksr="ls -l --sort=size $lsKB"
alias lm="ls -l $lsMB"
alias lms="ls -l -r --sort=size $lsMB"
alias lmsr="ls -l --sort=size $lsMB"


# -----------------------------------------------------------------------------------
# User-specific and more opinionated settings (delete if undesired or malfunctioning)
# -----------------------------------------------------------------------------------

alias xm='xmodmap modmap && exit'
alias xin='sudo xinput set-prop "SynPS/2 Synaptics TouchPad" "Synaptics Finger" 38, 43, 0 && sudo xinput set-prop "SynPS/2 Synaptics TouchPad" "Synaptics Area" 1500, 4600, 2400, 0 && sudo xinput set-prop "SynPS/2 Synaptics TouchPad" "Synaptics Noise Cancellation" 12, 12 && sudo xinput set-prop "SynPS/2 Synaptics TouchPad" "Synaptics Soft Button Areas" 3650, 4826, 0, 2400, 0, 0, 0, 0 && sudo xinput set-prop "SynPS/2 Synaptics TouchPad" "Device Accel Profile" 1'

if [ -d $HOME/.homesick ]; then
    source $HOME/.homesick/repos/homeshick/homeshick.sh
fi

function hostgrep () { cat ~/.ssh/config | grep -A1 $1 | grep -A1 $2 | grep -v '\-\-' | tee /dev/fd/2 | grep -v "Host " | awk '{print $2}'; }

#if [ -f "$HOME/google-cloud-sdk/path.bash.inc" ]; then
#    # The next line updates PATH for the Google Cloud SDK.
#    source "$HOME/google-cloud-sdk/path.bash.inc"
#    # The next line enables bash completion for gcloud.
#    source "$HOME/google-cloud-sdk/completion.bash.inc"
#fi
export PATH=$PATH:$HOME/opt/terraform
export PATH=$PATH:$HOME/.local/bin
alias vew='source /usr/local/bin/virtualenvwrapper.sh'
#source /usr/local/bin/virtualenvwrapper_lazy.sh


 
alias xbl='rfkill unblock all && sleep 1 &&  nmcli con up uuid 1bf224a9-c005-4c6f-ae37-f5134504cc37 && exit'
alias xwl='nmcli con up id "LiPhoneN" && exit'

export FZF_CTRL_R_OPTS='--sort'
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
bind '"\C-r": reverse-search-history' 
bind '"\C-n": " \C-e\C-u`__fzf_history__`\e\C-e\e^\er"'

# Expand aliases by Ctrl+p
bind '"\C-p": alias-expand-line'

# fco - checkout git branch/tag
fco() {
  local tags branches target
  tags=$(
    git tag | awk '{print "\x1b[31;1mtag\x1b[m\t" $1}') || return
  branches=$(
    git branch --all | grep -v HEAD             |
    sed "s/.* //"    | sed "s#remotes/[^/]*/##" |
    sort -u          | awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}') || return
  target=$(
    (echo "$tags"; echo "$branches") |
    fzf-tmux -l30 -- --no-hscroll --ansi +m -d "\t" -n 2) || return
  git checkout $(echo "$target" | awk '{print $2}')
}

# fh - repeat history
fh() {
  print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}

# virtualenv
export WORKON_HOME=~/virtualenvs
source /usr/share/virtualenvwrapper/virtualenvwrapper.sh

alias watty_vpn='sudo openvpn --config /home/yayun/watty_office.ovpn'
export PATH=$PATH:$HOME/workspace/infrastructure/infrastructure.kubernetes/

alias kpdp='kubectl  --context=prod-system --namespace=dataprocessing'
alias kpdc='kubectl  --context=prod-system --namespace=datacollection'
alias ksdp='kubectl  --context=staging-system --namespace=dataprocessing'
alias ksdc='kubectl  --context=staging-system --namespace=datacollection'
alias kubelogs='kpdp logs -f --tail=300 $(kpdp get pods -o wide | grep -v NAME | fzf | cut -f1 -d " ")'
alias kubelogs-datacollection='kpdc logs -f --tail=300 $(kpdc get pods | grep -v NAME | fzf | cut -f1 -d " ")'
alias kubelogs-staging='ksdp logs -f --tail=300 $(ksdp get pods | grep -v NAME | fzf | cut -f1 -d " ")'



export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export VAULT_ADDR='https://vault.watty.io'

alias auth_myself='~/auth_myself.sh'

export PATH=$PATH:$HOME/Android/Sdk/tools
export PATH=$PATH:$HOME/Android/Sdk/platform-tools


export ANDROID_SDK_HOME=$HOME/Android/Sdk

export PATH=$PATH:/usr/local/go/bin
