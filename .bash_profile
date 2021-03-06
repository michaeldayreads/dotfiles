# env vars
export histdir=~/.histlog/
export HISTCONTROL=ignorespace:ignoredups

# Consistent Time Stamp
cts() {
  echo $(date '+%a %b %d %T %Z %Y')
}

export -f cts

# @zancas
function GITBRANCH {
    if [[ `git branch 2>&1` == *"ot a git repository"* ]]
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
    DATE="\033[1;36m`cts` \033[0m||"
    USERHOSTBRANCH='\033[1;34m`hostname -s`\033[0m \033[1;34m`whoami`\033[0m \033[1;35m$(GITBRANCH)\033[0m'
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
    LINE1='[> '$(cat ~/.focus)' -> '$(cat ~/.req)' <]\n'
    # LINE1=$(ssh_key_fps_and_fns)'\n'
    LINE2=$PYTHON_VIRTUALENV' -- '$PWDRC'\n'
    PS1=$LINE0$LINE1$LINE2
}
export PROMPT_COMMAND=set_color_prompt
export PYTHONDONTWRITEBYTECODE=1

# /@zancas

grex() {
	grep --color=always --exclude-dir vendor --exclude-dir ".git*" "$@"
}

export -f grex

# devlog

note() {
        # Add note or finding to developer log; maintain focus.
	STAMP=$(cts)
	echo "${STAMP} -- -- --> ${1}" >> ~/.psycle.log
}

export -f note

craft() {
        # Observe behaviors that form the basis of effective or sub-optimal craft.
	STAMP=$(cts)
	echo "${STAMP} -- -- [*] ${1}" >> ~/.psycle.log
}

export -f craft

gap() {
        # Log gap; an issue needs to be opened, tracked down, followed up on etc.
	STAMP=$(cts)
	echo "${STAMP} -- -- (?) dev ${1}" >> ~/.psycle.log
}

export -f gap

issue() {
        # Story / issue / bug created
	STAMP=$(cts)
	echo "${STAMP} -- -- (.) dev ${1}" >> ~/.psycle.log
}

export -f issue

grok() {
        # Establish, expand, or re-inforce no reference invocations or patterns.
	STAMP=$(cts)
	echo "${STAMP} -- -- {?} dev ${1}" >> ~/.psycle.log
}

export -f grok

hack() {
        # Log refinement.
	STAMP=$(cts)
	echo "${STAMP} -- -- {.} ${1}" >> ~/.psycle.log
}

export -f hack

block() {
        # Log un-anticipated, non-deliverable result.
	STAMP=$(cts)
	echo "${STAMP} -- -- >?< ${1}" >> ~/.psycle.log
}

export -f block

ask() {
        # Peer assist requested.
	STAMP=$(cts)
	echo "${STAMP} -- -- >.< ${1}" >> ~/.psycle.log
}

export -f ask

unex() {
        # Unexpected result, but not yet blocked.
	STAMP=$(cts)
	echo "${STAMP} -- -- [?] ${1}" >> ~/.psycle.log
}

export -f unex

incre() {
        # Log incremental progress of any kind, but definitely when you are unblocked.
	STAMP=$(cts)
	echo "${STAMP} -- -- [.] ${1}" >> ~/.psycle.log
}

export -f incre

merge() {
        # Code landed for internal or external production use.
	STAMP=$(cts)
	echo "${STAMP} -- --  <> ${1}" >> ~/.psycle.log
}

export -f merge

switch() {
        # Interruption 
	STAMP=$(cts)
	echo "${STAMP} -- -- |!| ${1}" >> ~/.psycle.log
}

export -f switch

back() {
       # Back to task prior to interruption
	STAMP=$(cts)
	echo "${STAMP} -- -- |.| Back." >> ~/.psycle.log

}

export -f back

assist() {
        # Requested assist provided.
	STAMP=$(cts)
	echo "${STAMP} -- -- [+] ${1}" >> ~/.psycle.log
}

export -f assist

suggest() {
        # Suggestion offered.
	STAMP=$(cts)
	echo "${STAMP} -- -- [++] ${1}" >> ~/.psycle.log
}

export -f suggest

question() {
        # Proposed idea questioned.
	STAMP=$(cts)
	echo "${STAMP} -- -- [+++] ${1}" >> ~/.psycle.log
}

export -f question

challenge() {
        # Directive challenged.
	STAMP=$(cts)
	echo "${STAMP} -- -- [++++] ${1}" >> ~/.psycle.log
}

export -f challenge

ulog() {
        # Log event significant to unit state in unit log.
	STAMP=$(cts)
	echo "$STAMP -- ${1}" >> ~/.unit.log
	vi ~/.unit.log
}

export -f ulog

focus() {
        # Change focus and note in developer log.
	STAMP=$(cts)
	echo "${STAMP} -- -- ${1}" >> ~/.psycle.log
	echo $1 > ~/.focus
        echo "--" > ~/.req
}

export -f focus

req () {
        # Log current requirement / sub task to complete.
	STAMP=$(cts)
	echo "${STAMP} -- -- >> ${1}" >> ~/.psycle.log
	echo $1 > ~/.req
}

export -f req

today() {
    TODAY=$(cts | awk '{print $1" "$2" "$3}')
    clear && echo $TODAY
    cat ~/.psycle.log | grep "$TODAY"
    inflight
}

export -f today

# FIXME: this is mac specific, presumes gdate, should test for gdate/darwin
yesterday() {
    YESTERDAY=$(gdate '+%a %b %d %T %Z %Y' -d "yesterday" | awk '{print $1" "$2" "$3}')
    echo $YESTERDAY
    cat ~/.psycle.log | grep "$YESTERDAY"
}

export -f yesterday

task() {
        # Add task to deliverables.
        sed --in-place --follow-symlinks "2 i\ [] $1" ~/.deliverables.md
        STAMP=$(cts)
	echo "${STAMP} -- -- <.> ${1}" >> ~/.psycle.log
}

export -f task

inflight() {
  echo
  cat ~/.deliverables.md | grep "\[\]"
  echo
}

export -f inflight

landed() {
  echo
  cat ~/.deliverables.md | grep "<>\|{}\|()"
  echo
}

export -f landed

tasks() {
  vi ~/.deliverables.md
}

export -f tasks

psycle() {
  echo
  cat ${dot}docs/focus_help.md
  echo
}

export -f psycle

PATH="$PATH:/usr/local/go/bin"
export GOPATH=/Users/day/code

# host / context specific rc
if [[ -f ~/.context_bash_rc ]]; then
    source ~/.context_bash_rc
fi

# git autocompletion
if [[ -f ~/.git-completion.bash ]]; then
    source ~/.git-completion.bash
fi

# other aliases
alias grep="grep --color"
alias ls="ls -al -G"
alias histlog="history > ~/.histlog/$TERM_SESSION_ID.log"
alias tb="clear && cat ~/.focus &&  ~/code/rc/dotfiles/tools/timebox.sh"
alias toc="clear && ls -l -G"

# python
# alias bpylog="cp ~/.pythonhist ~/.pythonhistlog/$TERM_SESSION_ID.log"
# alias py.lint="clear && ~/dotfiles/tools/linter.sh"

## navigation vars
shopt -s cdable_vars
export grok=~/code/rc/grok/
export comp=~/code/rc/competitive/
export dot=~/code/rc/dotfiles/
export misc=~/code/misc-debris/
export ref=~/code/rc/reference/
export rc=~/code/rc/
# export src=~/Go/src

## k8s
alias k.all='kubectl get ing,po,deploy,cm,rs,rc,svc --all-namespaces'
alias k.t='kubectl get ing,po,deploy,cm,rs,rc,svc --all-namespaces | grep -P " \ds| \d\ds| \dh| \d\dh| \d\dm| \dm"'
alias gr.today='grep -P " \ds| \d\ds| \dh| \d\dh| \d\dm| \dm"'

## vi etc. (quick edit, source etc.)
alias b.v="vi ~/.bash_profile"
alias b.s="source ~/.bash_profile"

## the rest
alias aa="alias -p"
alias f.n="find . -name"
alias hist="history | grep"
alias pyl="clear && flake8 . && pep257 ."
alias ve="ls -l ~/.venv"

## git
alias g="git"
alias g.a="git add"
alias g.b="git branch"
alias g.bv="git branch --all -vvv"
alias g.C="git commit"
alias g.co="git checkout"
alias g.d="git diff"
alias g.d.n="git diff --name-only"
alias g.f="git fetch --all"
alias g.e="vi .git/info/exclude"
alias g.l="git log --format=\"%C(auto)%h %s %an %cd\" --date=local"
alias g.g="git log --graph --decorate --oneline --color"
alias g.m="git merge"
alias g.mff="git merge --ff-only"
alias g.p="git push"
alias g.r="git rebase"
alias g.rv="git remote -v"
alias g.s="git status"
alias g.smu="git submodule update"
alias show="git show --name-only"
alias stash="git stash"

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi
