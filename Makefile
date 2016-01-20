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

pip:          python
cython:       pip
numpy:        pip cython openblas
hdf5:         zlib
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
pyxb:         pip
docopt:       pip
biopython:    pip

htslib:       ccache zlib
blasr_libcpp: ccache hdf5 pbbam
blasr:        ccache blasr_libcpp hdf5
pbbam:        ccache samtools cmake boost htslib gtest
pbccs:        ccache pbbam htslib cmake boost gtest

pbcore:       pysam h5py
pbcommand:    xmlbuilder jsonschema avro requests iso8601
pbsmrtpipe:   pbcommand jinja2 networkx pbcore pbcommand pyparsing pydot jsonschema xmlbuilder requests fabric
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
	$(MAKE) -j1 -C ports/thirdparty/readline do-install
zlib:
	$(MAKE) -j1 -C ports/thirdparty/zlib-cloudflare do-install
ncurses:
	$(MAKE) -j1 -C ports/thirdparty/ncurses do-install
endif
openblas:
	$(MAKE) -j1 -C ports/thirdparty/openblas do-install
hdf5:
	$(MAKE) -j1 -C ports/thirdparty/hdf5 do-install
gtest:
	$(MAKE) -j1 -C ports/thirdparty/gtest do-install
boost:
	$(MAKE) -j1 -C ports/thirdparty/boost do-install
samtools:
	$(MAKE) -j1 -C ports/thirdparty/samtools do-install
cmake:
	$(MAKE) -j1 -C ports/thirdparty/cmake do-install
nim:
	$(MAKE) -j1 -C ports/thirdparty/nim do-install
ccache:
	$(MAKE) -j1 -C ports/thirdparty/ccache do-install

ifneq ($(origin PYVE),undefined)
python:
	$(MAKE) -j1 -C ports/python/virtualenv do-install
pip: ;
else
python:
	$(MAKE) -j1 -C ports/thirdparty/python do-install
pip:
	$(MAKE) -j1 -C ports/python/pip do-install
endif

numpy:
	$(MAKE) -j1 -C ports/python/numpy do-install
cython:
	$(MAKE) -j1 -C ports/python/cython do-install
xmlbuilder:
	$(MAKE) -j1 -C ports/python/xmlbuilder do-install
jsonschema:
	$(MAKE) -j1 -C ports/python/jsonschema do-install
avro:
	$(MAKE) -j1 -C ports/python/avro do-install
requests:
	$(MAKE) -j1 -C ports/python/requests do-install
iso8601:
	$(MAKE) -j1 -C ports/python/iso8601 do-install
jinja2:
	$(MAKE) -j1 -C ports/python/jinja2 do-install
networkx:
	$(MAKE) -j1 -C ports/python/networkx do-install
pyparsing:
	$(MAKE) -j1 -C ports/python/pyparsing do-install
pydot:
	$(MAKE) -j1 -C ports/python/pydot do-install
fabric:
	$(MAKE) -j1 -C ports/python/fabric do-install
h5py:
	$(MAKE) -j1 -C ports/python/h5py do-install
docopt:
	$(MAKE) -j1 -C ports/python/docopt
pysam:
	$(MAKE) -j1 -C ports/python/pysam do-install
pyxb:
	$(MAKE) -j1 -C ports/python/pyxb do-install
# Not part of pacbio developers' software collection
ipython:
	$(MAKE) -j1 -C ports/python/ipython do-install
biopython:
	$(MAKE) -j1 -C ports/python/biopython do-install

blasr_libcpp:
	$(MAKE) -j1 -C ports/pacbio/blasr_libcpp do-install
blasr:
	$(MAKE) -j1 -C ports/pacbio/blasr do-install
htslib:
	$(MAKE) -j1 -C ports/pacbio/htslib do-install
seqan:
	$(MAKE) -j1 -C ports/pacbio/seqan do-install
pbcore:
	$(MAKE) -j1 -C ports/pacbio/pbcore do-install
pbcommand:
	$(MAKE) -j1 -C ports/pacbio/pbcommand do-install
pbsmrtpipe:
	$(MAKE) -j1 -C ports/pacbio/pbsmrtpipe do-install
pbdoctorb:
	$(MAKE) -j1 -C ports/pacbio/pbdoctorb do-install
pbbam:
	$(MAKE) -j1 -C ports/pacbio/pbbam do-install
pbccs:
	$(MAKE) -j1 -C ports/pacbio/pbccs do-install

world: \
       pbccs blasr pbcore ipython pbdoctorb 

# utils
_startover:
	rm -rf $(PREFIX)/* $(PREFIX)/.Python staging/* workspace/* ports/*/*/*.log
