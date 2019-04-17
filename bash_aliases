# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

if which lsd > /dev/null; then
    alias ll='lsd -alF --date relative'
    alias la='lsd -a'
    alias l='lsd -F'
fi

alias m="make LIBDIR=../../build/libmira"

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias gc="git commit"
alias rebase="git fetch origin develop; git rebase -i FETCH_HEAD"

function gcd()
{
   local top=$(git rev-parse --show-toplevel 2>/dev/null || echo ~/src/work/mira)
   cd "$top/$1"
}

function _gcd()
{
   local top=$(git rev-parse --show-toplevel 2>/dev/null || echo ~/src/work/mira)
   pushd "$top" > /dev/null
   _cd $*
   popd > /dev/null
}
complete -o nospace -F _gcd gcd

function reload_aliases()
{
    . $HOME/.bash_aliases
}

function gg()
{
    if which rg >/dev/null; then
        rg -p "$*" | less -FRX
    else
        git grep "$*"
    fi
}

function gga()
{
    pushd $(git rev-parse --show-toplevel 2>/dev/null || echo ~/src/mira) > /dev/null
    gg $*
    popd >/dev/null
}

function gst()
{
    git status $*
}


function gcd()
{
    local top=$(git rev-parse --show-toplevel 2>/dev/null || echo ~/src/mira)
    cd "$top/$1"
}
function _gcd()
{
    local top=$(git rev-parse --show-toplevel 2>/dev/null || echo ~/src/mira)
    pushd "$top" > /dev/null
    _cd $*
    popd > /dev/null
}
complete -o nospace -F _gcd gcd

function gvi()
{
    local top=$(git rev-parse --show-toplevel 2>/dev/null || echo ~/src/mira)
    vi "$top/$1"
}
function _gvi()
{
    local top=$(git rev-parse --show-toplevel 2>/dev/null || echo ~/src/mira)
    pushd "$top" > /dev/null
    _longopt $*
    popd > /dev/null
}
complete -o nospace -o dirnames -o filenames -F _gvi gvi

function fd()
{
  if [ -t 1 ]; then
    env fd -c always $* | less -XRF
  else
    env fd $*
  fi
}
