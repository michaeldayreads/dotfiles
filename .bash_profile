HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S: "

# @zancas
function GITBRANCH {
    if [[ `git branch 2>&1` == *"Not a git repository"* ]]
    then
        echo No git repo
    else
        STATUS=''
        for S in `git status -s | cut -c 1-3`;
        do
            STATUS=$STATUS$S
        done
        echo `git branch | grep ^\* | sed s"/^\* //"`': '$STATUS
    fi
}


# TODO identify why the ssh check works on devmachine but not deck
#function ssh_key_fps_and_fns {
#    if [[ `ssh-add 2>&1` == *"Could not open a connection"* ]]
#    then
#        echo No ssh-agent
#    else
#        KEYFNAMES=''
#        for FNAME in `ssh-add -l | cut -d ' ' -f 3`;
#        do
#            KEYFNAMES=$KEYFNAMES' '${FNAME##*/}
#        done
#        echo $KEYFNAMES
#    fi
#}


function set_color_prompt {
    RC=$?;
    DATE="\033[1;36m`date` \033[0m||"
    USERHOSTBRANCH='\033[1;34m`hostname`\033[0m \033[1;34m`whoami`\033[0m \033[1;35m$(GITBRANCH)\033[0m'
    if [  ${RC} -eq 0 ]
    then
        PWDRC='\033[1;32m${PWD}\033[0m\033[1;31m: ${RC} \033[0m$'
    else
        PWDRC='\033[1;31m${PWD}\033[0m RC\033[1;32m: ${RC} \033[0m$'
    fi

    # virtualenv details
    # from http://stackoverflow.com/questions/23399183
    # modified 2016-11-22 11:11
    if test -z "$VIRTUAL_ENV"
    then
        PYTHON_VIRTUALENV=""
    else
        PYTHON_VIRTUALENV="${YELLOW}[`basename \"$VIRTUAL_ENV\"`]${COLOR_NONE}"
    fi

    LINE0=$DATE' '$USERHOSTBRANCH'\n'
#    LINE1=$(ssh_key_fps_and_fns)'\n'
    LINE2=$PYTHON_VIRTUALENV' -- '$PWDRC'\n'
    PS1=$LINE0$LINE1$LINE2
}
export PROMPT_COMMAND=set_color_prompt
export PYTHONDONTWRITEBYTECODE=1

# Setting PATH for Python 3.5
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.5/bin:${PATH}"
export PATH

export PATH=/bin:/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin:$PATH
export EDITOR='subl -w'

# virtualenv
# TODO pip install virtualenvwrapper ??
# export WORKON_HOME=~/.virtualenvs
# source /usr/local/bin/virtualenvwrapper.sh

# histash="~/0_deck_dojo/00/stash/hist/"


# aliases
alias grep="grep --color"
alias ls="ls -al -G"

## cd (navigation)
alias awg="cd ~/00/awg"
alias auto="cd ~/00/zz-autodidact"
alias comp="cd ~/00/competitive/"
alias d0="cd ~/0_deck_dojo/"
alias d1="cd ~/1_deck_dojo/"
alias d2="cd ~/2_deck_dojo/"
alias dot="cd ~/00/dotfiles"
alias misc="cd ~/0_deck_dojo/misc-debris/"
alias ref="cd ~/00/reference/"

## vim etc. (quick edit, source etc.)
alias b.v="vim ~/.bash_profile"
alias b.s="source ~/.bash_profile"
alias b.c="cp ~/.bash_profile ~/00/dotfiles/.bash_profile"
alias da="vim ~/00/awg/importer/ud/0/dojo.txt"
alias db="vim ~/00/awg/importer/ud/w2016/dojo.txt"
alias zto="vim ~/00/awg/zto/roadmap.txt"

## the rest
alias aa="alias -p"
alias dev="ssh -A 10.190.25.35"
alias f.n="find . -name"
alias g.b="git branch"
alias g.co="git checkout"
alias g.e="vim .git/info/exclude"
alias g.l="git log --format=\"%C(auto)%h %s %an %cd\" --date=local"
alias g.g="git log --graph --decorate --oneline --color"
alias g.rbm="git rebase master"
alias g.s="git status"
alias hist="history | grep"
alias py2="python"
alias py3="python3"
alias rcl=". ~/00/day-openrc.sh"
alias ve="ls -l ~/00/ve"

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

