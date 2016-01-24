include mk/osdetect.mk
PREFIX ?= deployment

# deps that this port would directly use
openssl:      ccache
zlib:         ccache
boost:        ccache
python:       ccache zlib openssl ncurses readline
readline:     ccache ncurses
samtools:     ccache zlib ncurses
cmake:        ccache zlib ncurses
ncurses:      ccache
gtest:        ccache
openblas:     ccache
hdf5:         ccache zlib
#
pip:          python
cython:       pip
numpy:        pip cython openblas
ipython:      pip
h5py:         pip hdf5 numpy
pysam:        pip
xmlbuilder:   pip
jsonschema:   pip
iso8601:      pip
jinja2:       pip
networkx:     pip
pyparsing:    pip
pydot:        pip pyparsing
fabric:       pip
avro:         pip
requests:     pip
docopt:       pip
rdflib:       pip
# TODO add six
rdfextras:    pip rdflib
pyxb:         pip
# pyxb is required by smrttools-python
biopython:    pip
#
htslib:       ccache zlib
blasr_libcpp: ccache hdf5 pbbam
blasr:        ccache blasr_libcpp hdf5
pbbam:        ccache samtools cmake boost htslib gtest
pbccs:        ccache pbbam htslib cmake boost gtest
dazzdb:       ccache
daligner:     ccache dazzdb
pbdagcon:     ccache dazzdb daligner pbbam blasr_libcpp
#
pbcore:       pysam h5py
pbcommand:    xmlbuilder jsonschema avro requests iso8601
pbsmrtpipe:   pbcommand jinja2 networkx pbcore pbcommand pyparsing pydot jsonschema xmlbuilder requests fabric
falcon_kit:   networkx
pbfalcon:     falcon_kit pbsmrtpipe
pypeFLOW:     rdflib rdfextras
pbdoctorb:    docopt pbcore

# rules
openssl:
	$(MAKE) -j1 -C ports/thirdparty/libressl do-install
ifeq ($(OPSYS),Darwin)
readline: ;
zlib: ;
ncurses: ;
else
readline:
	$(MAKE) -j1 -C ports/thirdparty/$@ do-install
zlib:
	$(MAKE) -j1 -C ports/thirdparty/zlib-cloudflare do-install
ncurses:
	$(MAKE) -j1 -C ports/thirdparty/$@ do-install
endif
openblas:
	$(MAKE) -j1 -C ports/thirdparty/$@ do-install
hdf5:
	$(MAKE) -j1 -C ports/thirdparty/$@ do-install
gtest:
	$(MAKE) -j1 -C ports/thirdparty/$@ do-install
boost:
	$(MAKE) -j1 -C ports/thirdparty/$@ do-install
samtools:
	$(MAKE) -j1 -C ports/thirdparty/$@ do-install
cmake:
	$(MAKE) -j1 -C ports/thirdparty/$@ do-install
nim:
	$(MAKE) -j1 -C ports/thirdparty/$@ do-install
ccache:
	$(MAKE) -j1 -C ports/thirdparty/$@ do-install

ifneq ($(origin PYVE),undefined)
python:
	$(MAKE) -j1 -C ports/python/$@ do-install
pip: ;
else
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
rdflib:
	$(MAKE) -j1 -C ports/python/$@ do-install
rdfextras:
	$(MAKE) -j1 -C ports/python/$@ do-install

# Not part of pacbio developers' software collection
ipython:
	$(MAKE) -j1 -C ports/python/$@ do-install
biopython:
	$(MAKE) -j1 -C ports/python/$@ do-install
pyxb:
	$(MAKE) -j1 -C ports/python/$@ do-install
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
#
world: \
       pbccs blasr pbcore ipython pbdoctorb 

# utils
_startover:
	rm -rf $(PREFIX)/* $(PREFIX)/.Python staging/* workspace/* ports/*/*/*.log
