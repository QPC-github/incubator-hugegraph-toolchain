#!/bin/bash

function abs_path() {
    SOURCE="${BASH_SOURCE[0]}"
    while [ -h "$SOURCE" ]; do
        DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
        SOURCE="$(readlink "$SOURCE")"
        [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
    done
    echo "$( cd -P "$( dirname "$SOURCE" )" && pwd )"
}

TOP=`abs_path`
cd $TOP

. util.sh

SLEEP_INTERVAL_S=2
SHUTDOWN_TIMEOUT_S=10

kill_process      'HugeGraphServer'
wait_for_shutdown 'HugeGraphServer' $SHUTDOWN_TIMEOUT_S
kill_process      'HugeStudio'
wait_for_shutdown 'HugeStudio' $SHUTDOWN_TIMEOUT_S

