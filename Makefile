
zlib:
	$(MAKE) -C ports/thirdparty/zlib do-install
libressl:
	$(MAKE) -C ports/thirdparty/libressl do-install
python:
	$(MAKE) -C ports/thirdparty/python do-install

# deps

python: zlib libressl

# utils

clean:
	rm -rf staging/*

# disabled
#openssl:
#	$(MAKE) -C ports/thirdparty/openssl do-install
