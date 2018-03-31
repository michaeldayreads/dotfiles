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


function ssh_key_fps_and_fns {
    if [[ `ssh-add 2>&1` == *"Could not open a connection"* ]]
    then
        echo No ssh-agent
    else
        KEYFNAMES=''
        for FNAME in `ssh-add -l | cut -d ' ' -f 3`;
        do
            KEYFNAMES=$KEYFNAMES' '${FNAME##*/}
        done
        echo $KEYFNAMES
    fi
}


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

# /@zancas

# Setting PATH for Python 3.5
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.5/bin:${PATH}"
export PATH

export PATH=/bin:/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin:$PATH

export GOPATH=/Users/day/0_deck_dojo
export PATH=$PATH:$GOPATH/bin

# champ is a collection of bash/python tiny tools
# as they evolve to 0.1.0, a shim of alisases / functions lets us use them
source ~/0_deck_dojo/champ/.champ_shim

# host / context specific rc
source ~/0_deck_dojo/misc-debris/.context_bash_rc

# git autocompletion
source ~/.git-completion.bash

# other aliases
alias grep="grep --color"
alias ls="ls -al -G"

## cd (navigation)
alias awg="cd ~/00/awg"
alias auto="cd ~/0_deck_dojo/zz-autodidact"
alias champ="cd ~/0_deck_dojo/champ/"
alias comp="cd ~/00/competitive/"
alias d0="cd ~/0_deck_dojo/"
alias d1="cd ~/1_deck_dojo/"
alias d2="cd ~/2_deck_dojo/"
alias da="cd ~/00/awg/importer/ud/0/"
alias db="cd ~/00/awg/importer/ud/w2016/"
alias dot="cd ~/00/dotfiles"
alias misc="cd ~/0_deck_dojo/misc-debris/"
alias ref="cd ~/00/reference/"
alias src="cd ~/0_deck_dojo/src"
alias zd="cd ~/00/zto"

## k8s
alias helm.dry="helm install --debug --dry-run"
alias k.all='kubectl get ing,po,deploy,cm,rs,rc,svc --all-namespaces'
alias k.t='kubectl get ing,po,deploy,cm,rs,rc,svc --all-namespaces | grep -P " \ds| \d\ds| \dh| \d\dh| \d\dm| \dm"'
alias gr.today='grep -P " \ds| \d\ds| \dh| \d\dh| \d\dm| \dm"'

## vim etc. (quick edit, source etc.)
alias b.v="vim ~/.bash_profile"
alias b.s="source ~/.bash_profile"

## the rest
alias aa="alias -p"
alias f.n="find . -name"
alias g="git"
alias g.a="git add"
alias g.b="git branch"
alias g.C="git commit"
alias g.co="git checkout"
alias g.d="git diff"
alias g.f="git fetch --all"
alias g.e="vim .git/info/exclude"
alias g.l="git log --format=\"%C(auto)%h %s %an %cd\" --date=local"
alias g.g="git log --graph --decorate --oneline --color"
alias g.m="git merge"
alias g.mff="git merge --ff-only"
alias g.p="git push"
alias g.r="git rebase"
alias g.rv="git remote -v"
alias g.s="git status"
alias g.st="git stash"
alias hist="history | grep"
alias py2="python"
alias py3="python3"
alias ve="ls -l ~/.venv"

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
