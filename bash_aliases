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
    alias ll='lsd -alF --date=relative'
    alias la='lsd -a'
    alias l='lsd -F'
fi

if which JLinkGDBServer > /dev/null; then
  alias gdbserver_mkw41z='JLinkGDBServer -device MKW41Z512xxx4 -endian little -if SWD -speed 4000'
  alias gdbserver_nrf52832='JLinkGDBServer -device nRF52832_xxAA -endian little -if SWD -speed 4000'
  alias gdbserver_nrf52833='JLinkGDBServer -device nRF52833_xxAA -endian little -if SWD -speed 4000'
  alias gdbserver_nrf52840='JLinkGDBServer -device nRF52840_xxAA -endian little -if SWD -speed 4000'
fi

alias m='make LIBDIR="$(git rev-parse --show-toplevel 2>/dev/null)/build/libmira"'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias gc="git commit"
alias gpull="git-disable-filter; git pull; git-enable-filter"
alias rebase="git-disable-filter; git fetch origin develop; git rebase -i FETCH_HEAD; git-enable-filter"

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
        rg -p $* | less -FRX
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

function connect_openocd_nrf()
{
    openocd -f interface/jlink.cfg -c "transport select swd" -f target/nrf52.cfg
}

# cd activates virtualenv if is exists
function cd() {
   builtin cd "$@"

   if [ $(dirname "$VIRTUAL_ENV") == $(pwd) ] ; then
        # Already at the active virtual env
        return
   fi

   if [[ -d ./venv ]] ; then
        if type deactivate > /dev/null 2>&1 ; then
           printf "Deactivating virtualenv %s\n" "$VIRTUAL_ENV"
            deactivate
        fi

        source ./venv/bin/activate
        printf "Setting up   virtualenv %s\n" "$VIRTUAL_ENV"
   fi
}
