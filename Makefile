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

# deps that this port would directly use

python:   zlib openssl ncurses readline
readline: ncurses
pip:      python
cython:   pip
numpy:    pip cython openblas

world:    zlib openssl ncurses readline python pip openblas cython numpy

# utils
startover:
	rm -rf deployment/* staging/* workspace/*

# disabled
#openssl:
#	$(MAKE) -C ports/thirdparty/openssl do-install
