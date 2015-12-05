
zlib:
	$(MAKE) -C ports/thirdparty/zlib do-install
#openssl:
#	$(MAKE) -C ports/thirdparty/openssl do-install
libressl:
	$(MAKE) -C ports/thirdparty/libressl do-install
python: zlib libressl
	$(MAKE) -C ports/thirdparty/python do-install
clean:
	rm -rf staging/*
