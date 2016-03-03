#!/bin/bash
. ${HOME}/local/setup-env.sh
blasr -h
rtnV=$? 
echo $rtnV
exit $rtnV
