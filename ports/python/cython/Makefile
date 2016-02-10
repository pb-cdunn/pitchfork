include ../../../mk/pitchfork.mk

# Local variables
_NAME   = Cython-0.23.4
_URL    = http://cython.org/release
_WRKSRC = $(WORKSPACE)/$(_NAME)

# Local works
do-extract: | $(_WRKSRC)
$(_WRKSRC):
	$(MD5SUM) -c MD5SUM || exit
	tar zxf $(_NAME).tar.gz -C $(WORKSPACE)
do-fetch: | $(_NAME).tar.gz
$(_NAME).tar.gz:
	$(CURL) -O -L $(_URL)/$@
do-install: | $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME):
	rm -rf $(STAGING)/$(_NAME)
	mkdir -p $(STAGING)/$(_NAME)
	$(PIP) install --root $(STAGING)/$(_NAME) --no-deps $(_WRKSRC)/
	rsync -aKx $(STAGING)/$(_NAME)/$(PREFIX)/ $(PREFIX)/
	find $(STAGING)/$(_NAME)|awk -F $(STAGING)/$(_NAME)$(PREFIX)/ '{print $$2}'|grep -v '^$$'|sort -r > $@
