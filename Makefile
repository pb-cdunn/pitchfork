
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

# deps

python: zlib openssl readline ncurses
readline: ncurses
pip: python

# utils

startover:
	rm -rf deployment/* staging/* workspace/*

# disabled
#openssl:
#	$(MAKE) -C ports/thirdparty/openssl do-install
