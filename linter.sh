#!/bin/bash

if [ "$1" == "" ]; then
    echo "[ERROR] directory or file to check expected as argument"
    exit 1
fi

set -e

find $1 -type f -name '*.py' | xargs flake8 --max-complexity=10 --count

find $1 -type f -name '*.py' | xargs pep257 --count

set +e

pylint $1
pylint_rc=$?

set -e

if [ $pylint_rc -gt 28 ]; then 
    echo $pylint_rc
fi

