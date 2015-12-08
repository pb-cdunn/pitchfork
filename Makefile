# rules
openssl: libressl
libressl:
	$(MAKE) -C ports/thirdparty/libressl do-install
python:
	$(MAKE) -C ports/thirdparty/python do-install
readline:
	$(MAKE) -C ports/thirdparty/readline do-install
zlib:
	$(MAKE) -C ports/thirdparty/zlib do-install
ncurses:
	$(MAKE) -C ports/thirdparty/ncurses do-install
pip:
	$(MAKE) -C ports/thirdparty/pip do-install
openblas:
	$(MAKE) -C ports/thirdparty/openblas do-install
numpy:
	$(MAKE) -C ports/thirdparty/numpy do-install
cython:
	$(MAKE) -C ports/thirdparty/cython do-install
hdf5:
	$(MAKE) -C ports/thirdparty/hdf5 do-install
ipython:
	$(MAKE) -C ports/thirdparty/ipython do-install
h5py:
	$(MAKE) -C ports/thirdparty/h5py do-install
pysam:
	$(MAKE) -C ports/thirdparty/pysam do-install
pbcore:
	$(MAKE) -C ports/pacbio/pbcore do-install
xmlbuilder:
	$(MAKE) -C ports/thirdparty/xmlbuilder do-install
blasr_libcpp:
	$(MAKE) -C ports/pacbio/blasr_libcpp do-install
blasr:
	$(MAKE) -C ports/pacbio/blasr do-install
docopt:
	$(MAKE) -C ports/thirdparty/docopt
pbdoctorb:
	$(MAKE) -C ports/pacbio/pbdoctorb do-install
pyxb:
	$(MAKE) -C ports/thirdparty/pyxb do-install
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
h5py:         pip hdf5
pysam:        pip
pbcore:       pip pysam
blasr_libcpp: hdf5
blasr:        blasr_libcpp hdf5
xmlbuilder:   pip
pyxb:         pip
pbdoctorb:    pip docopt pbcore
docopt:       pip

# utils
startover:
	rm -rf deployment/* staging/* workspace/*

# disabled
#openssl:
#	$(MAKE) -C ports/thirdparty/openssl do-install
