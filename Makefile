include mk/osdetect.mk
PREFIX ?= deployment

# rules
openssl:
	$(MAKE) -C ports/thirdparty/libressl do-install
ifeq ($(OPSYS),Darwin)
readline: ;
zlib: ;
ncurses: ;
else
readline:
	$(MAKE) -C ports/thirdparty/readline do-install
zlib:
	$(MAKE) -C ports/thirdparty/zlib-cloudflare do-install
ncurses:
	$(MAKE) -C ports/thirdparty/ncurses do-install
endif
openblas:
	$(MAKE) -C ports/thirdparty/openblas do-install
hdf5:
	$(MAKE) -C ports/thirdparty/hdf5 do-install
python:
	$(MAKE) -C ports/thirdparty/python do-install
gtest:
	$(MAKE) -C ports/thirdparty/gtest do-install
boost:
	$(MAKE) -C ports/thirdparty/boost do-install
samtools:
	$(MAKE) -C ports/thirdparty/samtools do-install
cmake:
	$(MAKE) -C ports/thirdparty/cmake do-install
nim:
	$(MAKE) -C ports/thirdparty/nim do-install
ccache:
	$(MAKE) -C ports/thirdparty/ccache do-install

pip:
	$(MAKE) -C ports/python/pip do-install
numpy:
	$(MAKE) -C ports/python/numpy do-install
cython:
	$(MAKE) -C ports/python/cython do-install
xmlbuilder:
	$(MAKE) -C ports/python/xmlbuilder do-install
ipython:
	$(MAKE) -C ports/python/ipython do-install
h5py:
	$(MAKE) -C ports/python/h5py do-install
docopt:
	$(MAKE) -C ports/python/docopt
pysam:
	$(MAKE) -C ports/python/pysam do-install
pyxb:
	$(MAKE) -C ports/python/pyxb do-install

blasr_libcpp:
	$(MAKE) -C ports/pacbio/blasr_libcpp do-install
blasr:
	$(MAKE) -C ports/pacbio/blasr do-install
htslib:
	$(MAKE) -C ports/pacbio/htslib do-install
pbcore:
	$(MAKE) -C ports/pacbio/pbcore do-install
pbdoctorb:
	$(MAKE) -C ports/pacbio/pbdoctorb do-install
pbbam:
	$(MAKE) -C ports/pacbio/pbbam do-install
pbccs:
	$(MAKE) -C ports/pacbio/pbccs do-install

world: \
       zlib     openssl   ncurses      readline python     pip  \
       openblas cython    numpy        hdf5     ipython    h5py \
       pysam    pbcore    blasr_libcpp blasr    xmlbuilder pyxb \
       docopt   pbdoctorb pbccs

# deps that this port would directly use
boost:        ccache
python:       ccache zlib openssl ncurses readline
readline:     ccache ncurses
samtools:     ccache zlib ncurses
cmake:        ccache zlib ncurses
ncurses:      ccache

pip:          python
cython:       pip
numpy:        ccache pip cython openblas
hdf5:         ccache zlib
ipython:      pip
h5py:         ccache pip hdf5 numpy
pysam:        ccache pip
xmlbuilder:   pip
pyxb:         pip
docopt:       pip

htslib:       ccache zlib
pbcore:       pip pysam
blasr_libcpp: ccache hdf5 pbbam
blasr:        ccache blasr_libcpp hdf5
pbdoctorb:    pip docopt pbcore

pbbam:        ccache samtools cmake boost htslib gtest
pbccs:        ccache pbbam htslib cmake boost gtest

# utils
_startover:
	rm -rf $(PREFIX)/* staging/* workspace/* ports/*/*/*.log

# disabled
#openssl:
#	$(MAKE) -C ports/thirdparty/openssl do-install
