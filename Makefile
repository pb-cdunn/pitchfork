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
world: \
       zlib     openssl ncurses readline python  pip \
       openblas cython  numpy   hdf5     ipython

# deps that this port would directly use

python:   zlib openssl ncurses readline
readline: ncurses
pip:      python
cython:   pip
numpy:    pip cython openblas
hdf5:     zlib
ipython:  pip

# utils
startover:
	rm -rf deployment/* staging/* workspace/*

# disabled
#openssl:
#	$(MAKE) -C ports/thirdparty/openssl do-install
