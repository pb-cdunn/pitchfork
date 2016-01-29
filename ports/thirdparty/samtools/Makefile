include ../../../mk/config.mk

# Local variables
_NAME   = samtools-1.3
_URL    = https://github.com/samtools/samtools/releases/download/1.3
_WRKSRC = $(WORKSPACE)/$(_NAME)
_FILE   = $(_NAME).tar.bz2

# Local works
do-extract: | $(_WRKSRC)
$(_WRKSRC):
	@tar jxf $(_FILE) -C $(WORKSPACE)
do-fetch: | $(_FILE)
	@$(MD5SUM) -c MD5SUM
$(_FILE):
	@$(CURL) -L -O $(_URL)/$@
do-config: | $(_WRKSRC)/config.log
$(_WRKSRC)/config.log:
ifeq ($(OPSYS),Darwin)
	@test -e $(_WRKSRC)/config.log || cat patch-01 | (cd $(_WRKSRC) && patch -p0)
	@test -e $(_WRKSRC)/config.log || $(SED) -i -e 's/-rdynamic//g' $(_WRKSRC)/Makefile $(_WRKSRC)/htslib-*/configure*
endif
	@(cd $(_WRKSRC) && CFLAGS="$(CFLAGS)" LDFLAGS="$(LDFLAGS)" \
                           ./configure --prefix=$(STAGING)/$(_NAME) 2>&1) \
        | tee config.log | $(PFHOME)/bin/activity
do-build:
	@test -e $(PREFIX)/var/pkg/$(_NAME) || $(MAKE) -C $(_WRKSRC) 2>&1 | tee build.log | $(PFHOME)/bin/activity
do-install: | $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME):
	@find $(PREFIX) ! -type d > $(_WRKSRC).before.list
	@$(MAKE) -C $(_WRKSRC) install 2>&1 | tee install.log | $(PFHOME)/bin/activity
	@cd $(STAGING)/$(_NAME) && tar cf - * | tar xf - -C $(PREFIX)
	@find $(PREFIX) ! -type d > $(_WRKSRC).after.list
	@diff -u $(_WRKSRC).before.list $(_WRKSRC).after.list | \
	grep -v '^\++'|awk -F $(PREFIX)/ '/^\+/{print $$2}' > $(PREFIX)/var/pkg/$(_NAME)
