include mk/osdetect.mk
# rules
openssl:
	$(MAKE) -C ports/thirdparty/libressl do-install
ifeq ($(OPSYS),Darwin)
readline: ;
else
readline:
	$(MAKE) -C ports/thirdparty/readline do-install
endif
ifeq ($(OPSYS),Darwin)
zlib: ;
else
zlib:
	$(MAKE) -C ports/thirdparty/zlib-cloudflare do-install
endif
ncurses:
	$(MAKE) -C ports/thirdparty/ncurses do-install
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
       docopt   pbdoctorb

# deps that this port would directly use
python:       zlib openssl ncurses readline
readline:     ncurses
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
samtools:     zlib ncurses
cmake:        zlib ncurses

htslib:       zlib
pbcore:       pip pysam
blasr_libcpp: hdf5 pbbam
blasr:        blasr_libcpp hdf5
pbdoctorb:    pip docopt pbcore

pbbam:        samtools cmake boost htslib gtest
pbccs:        pbbam htslib cmake boost gtest

# utils
startover:
	rm -rf deployment/* staging/* workspace/* ports/*/*/*.log

# disabled
#openssl:
#	$(MAKE) -C ports/thirdparty/openssl do-install
