#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

PS1=' \W ❯ '

#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias python='python3'
PS1=' \W ❯ '
killport() {
    if [ $# -eq 0 ]; then
        echo "الرجاء تحديد رقم البورت"
        echo "مثال: killport 8089"
        return 1
    fi
    
    for port in "$@"; do
        pid=$(lsof -ti:$port)
        if [ ! -z "$pid" ]; then
            echo "جاري إيقاف العملية على البورت $port (PID: $pid)"
            kill -9 $pid
        else
            echo "لا توجد عملية تعمل على البورت $port"
        fi
    done
}

export PATH="$HOME/.local/bin:$PATH"

export CHROMIUM_FLAGS="--enable-features=UseOzonePlatform --ozone-platform=wayland"
export PATH="$HOME/.cargo/bin:$PATH"
