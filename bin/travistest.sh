#!/bin/bash
. ${HOME}/local/setup-env.sh
set -e

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
for myfile in bin/pitchfork; do
    pep8-2.7 --ignore=E221,E226,E501,E701 $myfile
done
