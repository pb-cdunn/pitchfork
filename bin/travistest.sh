#!/bin/bash
. ${HOME}/local/setup-env.sh
set -ex

bam2bax -h
bamSieve -h
bax2bam -h
blasr -h
ccs -h
dataset -h
pbalign -h
pbindex -h
pbmerge -h
pbservice -h
pbsmrtpipe -h
pbtestkit-runner -h
pbtools-runner -h
pbvalidate -h
#sawriter
python -c "from pbcore.io import *"
for myfile in bin/pitchfork; do
    pep8 --ignore=E221,E226,E501,E701 $myfile
done
