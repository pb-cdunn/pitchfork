include ../../../mk/pitchfork.mk

# Local variables
_NAME            = gtest-1.7.0
_URL             = https://github.com/google/googletest
_FILE            = release-1.7.0.tar.gz
_WRKSRC          = $(WORKSPACE)/$(_NAME)

# Local works
do-fetch: | $(_FILE)
$(_FILE):
	$(CURL) -L -O $(_URL)/archive/$@
do-extract: | $(_WRKSRC)
$(_WRKSRC):
	$(MD5SUM) -c MD5SUM || exit
	mkdir -p $(_WRKSRC) && tar zxf $(_FILE) --strip=1 -C $(_WRKSRC)
do-install: | $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME):
	mkdir -p $(PREFIX)/src && cp -a $(_WRKSRC) $(PREFIX)/src/gtest
	find $(_WRKSRC) ! -type d|awk -F '$(_WRKSRC)/' '{print "src/gtest/"$$2}' > $@
do-clean:
	rm -rf $(_WRKSRC) || true
