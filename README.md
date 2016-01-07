# Pitchfork [![Build Status](https://travis-ci.org/mhsieh/pitchfork.svg)](https://travis-ci.org/mhsieh/pitchfork)
Prototyping github source building while having a dumb file (Makefile) to describe a software component.

# Usages

## using pitchfork to build blasr locally
```
$ git clone https://github.com/mhsieh/pitchfork
$ cd pitchfork
$ make PREFIX=/tmp/pitchfork startover
$ make PREFIX=/tmp/pitchfork blasr
```

## other possible target to build:
1. ipython
2. pbcore
3. pbccs

# Developing pitchfork ports

## Style guide

1. use tar + staging folder to deploy/install to PREFIX
2. use staging folder as much as possible

