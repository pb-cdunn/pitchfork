include ../../../mk/config.mk

# Local variables
_NAME            = gtest-1.7.0
_URL             = https://github.com/google/googletest
_FILE            = release-1.7.0.tar.gz
_WRKSRC          = $(WORKSPACE)/$(_NAME)

# Local works
do-fetch: | $(_FILE)
	@$(MD5SUM) -c MD5SUM
$(_FILE):
	@$(CURL) -L -O $(_URL)/archive/$@
do-extract: | $(_WRKSRC)
$(_WRKSRC):
	@mkdir -p $(_WRKSRC) && tar zxf $(_FILE) --strip=1 -C $(_WRKSRC)
do-install: | $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME):
	@find $(PREFIX) ! -type d > $(_WRKSRC).before.list
	@mkdir -p $(PREFIX)/src && cp -a $(_WRKSRC) $(PREFIX)/src/gtest
	@find $(PREFIX) ! -type d > $(_WRKSRC).after.list
	@diff -u $(_WRKSRC).before.list $(_WRKSRC).after.list | \
	grep -v '^\++'|awk -F $(PREFIX)/ '/^\+/{print $$2}' > $(PREFIX)/var/pkg/$(_NAME)
	@echo "done"
do-clean:
	@rm -rf $(_WRKSRC) || true
