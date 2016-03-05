#!/bin/bash
. ${HOME}/local/setup-env.sh
blasr -h
pbsmrtpipe -h
ccs -h
pbalign -h
rtnV=$? 
echo $rtnV
exit $rtnV
