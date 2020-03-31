#!/bin/sh

hostname=$(hostname)

# Helper functions
echoerr() {
    >&2 echo "$@"
}

loadenv() {
    if [ "x$PYENV" != "x" ] ; then
        . $PYENV/bin/activate
    else
        echoerr "PYENV environment variable is not set!"
        exit 1
    fi
}

prepare() {
    echoerr "Running job on ${hostname}..."
    echo $hostname | grep -e "[cg]-[[:digit:]]-[[:digit:]+]"
    iscluster=$?

    if [ $iscluster -eq 0 ] ; then
        echoerr "Running on a cluster node shared filesystem. Not extracting files."
    else
        echoerr "Running on a desktop. Extracting files."
        # Extract our portable environment
        #echoerr "Extracting data files..."
        #tar -xJf data.tar.xz
    fi
}

cleanup() {
    echo $hostname | grep -e "[cg]-[[:digit:]]-[[:digit:]+]"
    iscluster=$?

    if [ $iscluster -eq 0 ]; then
        echoerr "Running on a cluster node shared filesystem. Not removing files."
    else
        echoerr "Running on a desktop. Removing temp files."
        # Cleanup when finished so these files don't transfer back
        #rm *.txt
    fi
}

# Main script
prepare
loadenv
python $@
cleanup
