include mk/osdetect.mk
PREFIX ?= deployment

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
python:
	$(MAKE) -j1 -C ports/thirdparty/python do-install
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

pip:
	$(MAKE) -j1 -C ports/python/pip do-install
numpy:
	$(MAKE) -j1 -C ports/python/numpy do-install
cython:
	$(MAKE) -j1 -C ports/python/cython do-install
xmlbuilder:
	$(MAKE) -j1 -C ports/python/xmlbuilder do-install
ipython:
	$(MAKE) -j1 -C ports/python/ipython do-install
h5py:
	$(MAKE) -j1 -C ports/python/h5py do-install
docopt:
	$(MAKE) -j1 -C ports/python/docopt
pysam:
	$(MAKE) -j1 -C ports/python/pysam do-install
pyxb:
	$(MAKE) -j1 -C ports/python/pyxb do-install

blasr_libcpp:
	$(MAKE) -j1 -C ports/pacbio/blasr_libcpp do-install
blasr:
	$(MAKE) -j1 -C ports/pacbio/blasr do-install
htslib:
	$(MAKE) -j1 -C ports/pacbio/htslib do-install
pbcore:
	$(MAKE) -j1 -C ports/pacbio/pbcore do-install
pbdoctorb:
	$(MAKE) -j1 -C ports/pacbio/pbdoctorb do-install
pbbam:
	$(MAKE) -j1 -C ports/pacbio/pbbam do-install
pbccs:
	$(MAKE) -j1 -C ports/pacbio/pbccs do-install

world: \
       zlib     openssl   ncurses      readline python     pip  \
       openblas cython    numpy        hdf5     ipython    h5py \
       pysam    pbcore    blasr_libcpp blasr    xmlbuilder pyxb \
       docopt   pbdoctorb pbccs

# deps that this port would directly use
zlib:         ccache
boost:        ccache
python:       ccache zlib openssl ncurses readline
readline:     ccache ncurses
samtools:     ccache zlib ncurses
cmake:        ccache zlib ncurses
ncurses:      ccache

pip:          python
cython:       pip
numpy:        pip cython openblas
hdf5:         zlib
ipython:      pip
h5py:         pip hdf5 numpy
pysam:        pip
xmlbuilder:   pip
pyxb:         pip
docopt:       pip

htslib:       ccache zlib
blasr_libcpp: ccache hdf5 pbbam
blasr:        ccache blasr_libcpp hdf5
pbbam:        ccache samtools cmake boost htslib gtest
pbccs:        ccache pbbam htslib cmake boost gtest

pbcore:       pysam
pbdoctorb:    docopt pbcore

# utils
_startover:
	rm -rf $(PREFIX)/* staging/* workspace/* ports/*/*/*.log

# disabled
#openssl:
#	$(MAKE) -j1 -C ports/thirdparty/openssl do-install
