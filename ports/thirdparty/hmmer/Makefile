include ../../../mk/pitchfork.mk

# Local variables
_NAME   = hmmer-3.1b2
_URL    = http://eddylab.org/software/hmmer3/3.1b2
_WRKSRC = $(WORKSPACE)/$(_NAME)
_FILE   = $(_NAME).tar.gz

# Local works
do-extract: | $(_WRKSRC)
$(_WRKSRC):
	$(MD5SUM) -c MD5SUM || exit
	tar jxf $(_FILE) -C $(WORKSPACE)
do-fetch: | $(_FILE)
$(_FILE):
	$(CURL) -L -O $(_URL)/$@
do-config: | $(_WRKSRC)/config.log
$(_WRKSRC)/config.log:
	(cd $(_WRKSRC) && ./configure --prefix=$(PREFIX) 2>&1) \
        | tee config.log | $(PFHOME)/bin/activity
do-build: | $(_WRKSRC)/src/phmmer
$(_WRKSRC)/src/phmmer:
	$(MAKE) -C $(_WRKSRC) 2>&1 | tee build.log | $(PFHOME)/bin/activity
do-install: | $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME):
	rm -rf $(STAGING)/$(_NAME)
	$(MAKE) -C $(_WRKSRC) prefix=$(STAGING)/$(_NAME) install 2>&1 | tee install.log | $(PFHOME)/bin/activity
	cd $(STAGING)/$(_NAME) && tar cf - * | tar xf - -C $(PREFIX)
	find $(STAGING)/$(_NAME) ! -type d|awk -F $(STAGING)/$(_NAME)/ '{print $$2}' > $@
