include ../../../mk/pitchfork.mk

# Local variables
_NAME   = Cython-0.23.4
_URL    = http://cython.org/release
_WRKSRC = $(WORKDIR)/$(_NAME)
LDFLAGS = -L$(PREFIX)/lib
export LDFLAGS

# Local works
do-extract: | $(_WRKSRC)
$(_WRKSRC):
	$(MD5SUM) -c MD5SUM || exit
	tar zxf $(_NAME).tar.gz -C $(WORKDIR)
do-fetch: | $(_NAME).tar.gz
$(_NAME).tar.gz:
	$(PFHOME)/bin/pitchfork fetch --url $(_URL)/$@
do-install: | $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME):
	rm -rf $(STAGING)/$(_NAME)
	mkdir -p $(STAGING)/$(_NAME)
	$(PIP) install --root $(STAGING)/$(_NAME) --no-deps $(_WRKSRC)/
	rsync -aKx $(STAGING)/$(_NAME)/$(PREFIX)/ $(PREFIX)/
	cd $(STAGING)/$(_NAME)$(PREFIX) && find * |grep -v '^$$'|sort -r > $@
do-clean:
	rm -rf $(STAGING)/$(_NAME)
do-flush:
	rm -rf $(_WRKSRC)
