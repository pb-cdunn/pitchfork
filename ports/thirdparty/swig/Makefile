include ../../../mk/config.mk

# Local variables
_NAME   = swig-3.0.8
_URL    = http://prdownloads.sourceforge.net/swig
_WRKSRC = $(WORKSPACE)/$(_NAME)

# Local works
do-extract:
	@test -d $(_WRKSRC) || tar zxf $(_NAME).tar.gz -C $(WORKSPACE)
do-fetch:
	@test -e $(_NAME).tar.gz || $(CURL) -L -O $(_URL)/$(_NAME).tar.gz
	@which $(MD5SUM) >& /dev/null && $(MD5SUM) -c MD5SUM
do-config: | $(_WRKSRC)/config.log
$(_WRKSRC)/config.log:
	@(cd $(_WRKSRC) && \
          CFLAGS="$(CFLAGS)" \
          LDFLAGS="$(LDFLAGS)" \
            ./configure \
              --prefix=$(PREFIX) \
              --without-java \
              --without-lua \
              --without-perl5 \
              --without-php \
              --without-ruby \
              --without-tcl \
          2>&1) \
        | tee config.log | $(PFHOME)/bin/activity
do-build:
	@test -e $(PREFIX)/var/pkg/$(_NAME) || $(MAKE) -C $(_WRKSRC) 2>&1 | tee build.log | $(PFHOME)/bin/activity
do-install: | $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME):
	@find $(PREFIX) ! -type d > $(_WRKSRC).before.list
	@$(MAKE) -C $(_WRKSRC) prefix=$(STAGING)/$(_NAME) install 2>&1 | tee install.log | $(PFHOME)/bin/activity
	@cd $(STAGING)/$(_NAME) && tar cf - * | tar xf - -C $(PREFIX)
	@find $(PREFIX) ! -type d > $(_WRKSRC).after.list
	@diff -u $(_WRKSRC).before.list $(_WRKSRC).after.list | \
	grep -v '^\++'|awk -F $(PREFIX)/ '/^\+/{print $$2}' > $(PREFIX)/var/pkg/$(_NAME)
