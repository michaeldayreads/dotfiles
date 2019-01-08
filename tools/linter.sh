#!/bin/bash

YEL='\033[0;33m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

if [ "$1" == "" ]; then
    echo "[ERROR] directory or file to check expected as argument"
    exit 1
fi

# use numbers to drive modes
pl_flag=1

if [ "$3" == "-q" ] || [ "$3" == "--quick" ];then
    pl_flag=0
    printf "${YEL}pylint turned off -- flake8 && pep257 only${NC}\n"
fi

pylinter() {
    pylint $1
    pylint_rc=$?
    if [ $pylint_rc -gt 28 ]; then
        printf "${RED}${1}${NC}\n"
        exit $pylint_rc
    fi    
}

lint() {
    flake8 --max-complexity=10 --count $1
    flake8_rc=$?
    pep257 --count $1
    pep257_rc=$?
    if [ $flake8_rc != 0 ] || [ $pep257_rc != 0 ]; then
        printf "${RED}${1}${NC}\n"
        exit 1
    fi
}

# fixme: determine how to encapsulate command containing ' to dry this out
if [ "$2" == "" ]; then
    echo "No tag/sha provided. Using 'find' method."
    find $1 -type f -name '*.py' | while read -r line; do
        lint $line
        if [ $pl_flag -gt 0 ]; then
            pylinter $1
        fi
        printf "${GREEN}${line}${NC}\n"
    done
else
    git diff --name-only $2 | grep '.py$' | while read -r line; do
        lint $line
        if [ $pl_flag -gt 0 ]; then
            pylinter $1
        fi
        printf "${GREEN}${line}${NC}\n"
    done
fi

