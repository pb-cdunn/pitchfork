-include settings.mk

UNAME   = uname
ARCH   := $(shell $(UNAME) -m)
OPSYS  := $(shell $(UNAME) -s)
SHELL   = /bin/bash -e
PREFIX ?= deployment

default:
	@echo no default rule
	echo ${CCACHE_DIR}
	echo ${PREFIX}

# deps that this port would directly use
openssl:      ccache
zlib:         ccache
boost:        ccache
python:       ccache zlib openssl ncurses readline
readline:     ccache ncurses
samtools:     ccache zlib
cmake:        ccache zlib
ncurses:      ccache
gtest:        ccache
openblas:     ccache
hdf5:         ccache zlib
swig:         ccache python
libpng:       ccache zlib
hmmer:        ccache
gmap:         ccache

pip:          python
cython:       pip
numpy:        pip cython openblas
h5py:         pip hdf5 numpy six
jsonschema:   pip functools32
pydot:        pip pyparsing
fabric:       pip paramiko ecdsa pycrypto
rdflib:       pip six isodate html5lib
matplotlib:   pip numpy libpng pytz six pyparsing python-dateutil
rdfextras:    pip rdflib
scipy:        pip numpy
appnope:      pip
avro:         pip
decorator:    pip
docopt:       pip
ecdsa:        pip
functools32:  pip
gnureadline:  pip
html5lib:     pip
ipython_genutils: pip
iso8601:      pip
isodate:      pip
jinja2:       pip
networkx:     pip
paramiko:     pip
path.py:      pip
pexpect:      pip
pickleshare:  pip
ptyprocess:   pip
pycrypto:     pip
pyparsing:    pip
pysam:        pip
python-dateutil: pip
pytz:            pip
pyxb:            pip
requests:        pip
simplegeneric:   pip
six:             pip
traitlets:       pip
xmlbuilder:      pip
nose:            pip
cram:            pip

#
ipython:      pip traitlets pickleshare appnope decorator gnureadline pexpect ipython_genutils path.py ptyprocess simplegeneric
cogent:       pip numpy
biopython:    pip
nim:          ccache
tcl:          ccache zlib
modules:      ccache tcl

#
htslib:       ccache zlib
blasr_libcpp: ccache boost hdf5 pbbam
blasr:        ccache blasr_libcpp hdf5 cmake
pbbam:        ccache samtools cmake boost htslib gtest
pbccs:        ccache pbbam htslib cmake boost gtest seqan
dazzdb:       ccache
daligner:     ccache dazzdb
pbdagcon:     ccache dazzdb daligner pbbam blasr_libcpp
#
pbcore:           pysam h5py pyxb
pbcoretools:      pbcore pbcommand
pbcommand:        xmlbuilder jsonschema avro requests iso8601
pbsmrtpipe:       pbcommand jinja2 networkx pbcore pbcommand pyparsing pydot jsonschema xmlbuilder requests fabric
falcon_kit:       networkx
pbfalcon:         falcon_kit pbsmrtpipe pypeFLOW
pbreports:        matplotlib cython numpy h5py pysam jsonschema pbcore pbcommand
kineticsTools:    pbcore pbcommand scipy numpy h5py
pypeFLOW:         rdflib rdfextras
pbalign:          pbcore samtools blasr
pbdoctorb:        docopt pbcore
ConsensusCore:    numpy boost swig cmake
ConsensusCore2:   numpy boost swig cmake
GenomicConsensus: pbcore pbcommand numpy h5py ConsensusCore
#
pblaa:         htslib pbbam seqan pbsparse pbccs ConsensusCore2 pbchimera
pbchimera:     seqan cmake
ppa:           boost cmake pbbam htslib
#
world: \
       pbccs     blasr            kineticsTools  pblaa    \
       pbreports GenomicConsensus ConsensusCore2 pbfalcon \
       pbdoctorb ipython          biopython      cogent   \
       nim       modules          cram           nose     \
       hmmer     gmap

# rules
ifeq ($(OPSYS),Darwin)
readline: ;
zlib: ;
ncurses: ;
tcl: ;
libpng: ;
openblas: ;
else
readline:
	$(MAKE) -j1 -C ports/thirdparty/$@ do-install
zlib:
	$(MAKE) -j1 -C ports/thirdparty/$@ do-install
ncurses:
	$(MAKE) -j1 -C ports/thirdparty/$@ do-install
tcl:
	$(MAKE) -j1 -C ports/thirdparty/$@ do-install
libpng:
	$(MAKE) -j1 -C ports/thirdparty/$@ do-install
openblas:
	$(MAKE) -j1 -C ports/thirdparty/$@ do-install
endif
ifeq ($(origin HAVE_HDF5),undefined)
hdf5:
	$(MAKE) -j1 -C ports/thirdparty/$@ do-install
else
hdf5: ;
endif
gtest:
	$(MAKE) -j1 -C ports/thirdparty/$@ do-install
boost:
	$(MAKE) -j1 -C ports/thirdparty/$@ do-install
samtools:
	$(MAKE) -j1 -C ports/thirdparty/$@ do-install
ifeq ($(origin HAVE_CMAKE),undefined)
cmake:
	$(MAKE) -j1 -C ports/thirdparty/$@ do-install
else
cmake: ;
endif
ifeq ($(origin HAVE_CCACHE),undefined)
ccache:
	$(MAKE) -j1 -C ports/thirdparty/$@ do-install
else
ccache:
	bin/checkCCACHE $(HAVE_CCACHE)
	$(MAKE) -j1 -C ports/thirdparty/$@ useSystem CCACHE=`bin/checkCCACHE $(HAVE_CCACHE)`
endif
swig:
	$(MAKE) -j1 -C ports/thirdparty/$@ do-install
hmmer:
	$(MAKE) -j1 -C ports/thirdparty/$@ do-install
gmap:
	$(MAKE) -j1 -C ports/thirdparty/$@ do-install

ifneq ($(origin HAVE_PYTHON),undefined)
openssl: ;
python:
	$(MAKE) -j1 -C ports/python/virtualenv do-install
pip: ;
else
openssl:
	$(MAKE) -j1 -C ports/thirdparty/libressl do-install
python:
	$(MAKE) -j1 -C ports/thirdparty/$@ do-install
pip:
	$(MAKE) -j1 -C ports/python/$@ do-install
endif

numpy:
	$(MAKE) -j1 -C ports/python/$@ do-install
cython:
	$(MAKE) -j1 -C ports/python/$@ do-install
xmlbuilder:
	$(MAKE) -j1 -C ports/python/$@ do-install
jsonschema:
	$(MAKE) -j1 -C ports/python/$@ do-install
avro:
	$(MAKE) -j1 -C ports/python/$@ do-install
requests:
	$(MAKE) -j1 -C ports/python/$@ do-install
iso8601:
	$(MAKE) -j1 -C ports/python/$@ do-install
jinja2:
	$(MAKE) -j1 -C ports/python/$@ do-install
networkx:
	$(MAKE) -j1 -C ports/python/$@ do-install
pyparsing:
	$(MAKE) -j1 -C ports/python/$@ do-install
pydot:
	$(MAKE) -j1 -C ports/python/$@ do-install
fabric:
	$(MAKE) -j1 -C ports/python/$@ do-install
h5py:
	$(MAKE) -j1 -C ports/python/$@ do-install
docopt:
	$(MAKE) -j1 -C ports/python/$@ do-install
pysam:
	$(MAKE) -j1 -C ports/python/$@ do-install
six:
	$(MAKE) -j1 -C ports/python/$@ do-install
rdflib:
	$(MAKE) -j1 -C ports/python/$@ do-install
rdfextras:
	$(MAKE) -j1 -C ports/python/$@ do-install
matplotlib:
	$(MAKE) -j1 -C ports/python/$@ do-install
cogent:
	$(MAKE) -j1 -C ports/python/$@ do-install
scipy:
	$(MAKE) -j1 -C ports/python/$@ do-install
traitlets:
	$(MAKE) -j1 -C ports/python/$@ do-install
pickleshare:
	$(MAKE) -j1 -C ports/python/$@ do-install
appnope:
	$(MAKE) -j1 -C ports/python/$@ do-install
decorator:
	$(MAKE) -j1 -C ports/python/$@ do-install
gnureadline:
	$(MAKE) -j1 -C ports/python/$@ do-install
pexpect:
	$(MAKE) -j1 -C ports/python/$@ do-install
ipython_genutils:
	$(MAKE) -j1 -C ports/python/$@ do-install
path.py:
	$(MAKE) -j1 -C ports/python/$@ do-install
ptyprocess:
	$(MAKE) -j1 -C ports/python/$@ do-install
simplegeneric:
	$(MAKE) -j1 -C ports/python/$@ do-install
paramiko:
	$(MAKE) -j1 -C ports/python/$@ do-install
ecdsa:
	$(MAKE) -j1 -C ports/python/$@ do-install
pycrypto:
	$(MAKE) -j1 -C ports/python/$@ do-install
isodate:
	$(MAKE) -j1 -C ports/python/$@ do-install
html5lib:
	$(MAKE) -j1 -C ports/python/$@ do-install
functools32:
	$(MAKE) -j1 -C ports/python/$@ do-install
pytz:
	$(MAKE) -j1 -C ports/python/$@ do-install
python-dateutil:
	$(MAKE) -j1 -C ports/python/$@ do-install
nose:
	$(MAKE) -j1 -C ports/python/$@ do-install
cram:
	$(MAKE) -j1 -C ports/python/$@ do-install

# Not part of pacbio developers' software collection
ipython:
	$(MAKE) -j1 -C ports/python/$@ do-install
biopython:
	$(MAKE) -j1 -C ports/python/$@ do-install
pyxb:
	$(MAKE) -j1 -C ports/python/$@ do-install
nim:
	$(MAKE) -j1 -C ports/thirdparty/$@ do-install
modules:
	$(MAKE) -j1 -C ports/thirdparty/$@ do-install

#
blasr_libcpp:
	$(MAKE) -j1 -C ports/pacbio/$@ do-install
blasr:
	$(MAKE) -j1 -C ports/pacbio/$@ do-install
htslib:
	$(MAKE) -j1 -C ports/pacbio/$@ do-install
seqan:
	$(MAKE) -j1 -C ports/pacbio/$@ do-install
pbbam:
	$(MAKE) -j1 -C ports/pacbio/$@ do-install
pbccs:
	$(MAKE) -j1 -C ports/pacbio/$@ do-install
dazzdb:
	$(MAKE) -j1 -C ports/pacbio/$@ do-install
daligner:
	$(MAKE) -j1 -C ports/pacbio/$@ do-install
pbdagcon:
	$(MAKE) -j1 -C ports/pacbio/$@ do-install
#
pbcore:
	$(MAKE) -j1 -C ports/pacbio/$@ do-install
pbcommand:
	$(MAKE) -j1 -C ports/pacbio/$@ do-install
pbsmrtpipe:
	$(MAKE) -j1 -C ports/pacbio/$@ do-install
falcon_kit:
	$(MAKE) -j1 -C ports/pacbio/$@ do-install
pbfalcon:
	$(MAKE) -j1 -C ports/pacbio/$@ do-install
pypeFLOW:
	$(MAKE) -j1 -C ports/pacbio/$@ do-install
pbdoctorb:
	$(MAKE) -j1 -C ports/pacbio/$@ do-install
ConsensusCore:
	$(MAKE) -j1 -C ports/pacbio/$@ do-install
ConsensusCore2:
	$(MAKE) -j1 -C ports/pacbio/$@ do-install
GenomicConsensus:
	$(MAKE) -j1 -C ports/pacbio/$@ do-install
pbreports:
	$(MAKE) -j1 -C ports/pacbio/$@ do-install
kineticsTools:
	$(MAKE) -j1 -C ports/pacbio/$@ do-install
pbalign:
	$(MAKE) -j1 -C ports/pacbio/$@ do-install
pbcoretools:
	$(MAKE) -j1 -C ports/pacbio/$@ do-install
#
pbchimera:
	$(MAKE) -j1 -C ports/pacbio/$@ do-install
pbsparse:
	$(MAKE) -j1 -C ports/pacbio/$@ do-install
pblaa:
	$(MAKE) -j1 -C ports/pacbio/$@ do-install
#
ppa:
	$(MAKE) -j1 -C ports/pacbio/$@ do-install

# utils
_startover:
	@echo "This will erase everything in $(PREFIX), staging/ and workspace/ directories."
	@read -p "Are you sure? " -n 1 -r; \
        echo; \
        if [[ $$REPLY =~ ^[Yy]$$ ]]; then \
           echo "rm -rf $(PREFIX)/* $(PREFIX)/.Python staging/* workspace/* ports/*/*/*.log"; \
           rm -rf $(PREFIX)/* $(PREFIX)/.Python staging/* workspace/* ports/*/*/*.log; \
        fi
