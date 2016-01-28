include ../../../mk/config.mk

# Local variables
_NAME            = Python-2.7.10
_URL             = https://www.python.org/ftp/python/2.7.10
_FILE            = Python-2.7.10.tgz
_WRKSRC          = $(WORKSPACE)/$(_NAME)
_CONFIGURE_ARGS  = --prefix=$(STAGING)/$(_NAME)
_CONFIGURE_ARGS += --enable-unicode=ucs4
_CFLAGS          = $(CFLAGS)
_CFLAGS         += -I$(PREFIX)/include/ncurses

# Local works
do-fetch:
	@test -e $(_FILE) || $(CURL) -O $(_URL)/$(_FILE)
	@which $(MD5SUM) >& /dev/null && $(MD5SUM) -c MD5SUM
do-extract:
	@test -d $(_WRKSRC) || tar zxf $(_FILE) -C $(WORKSPACE)
	@$(SED) -i -e "s|@@PREFIX@@|$(PREFIX)|g" $(_WRKSRC)/Lib/cgi.py $(_WRKSRC)/Lib/ctypes/macholib/dyld.py
do-config:
	@test -e $(_WRKSRC)/config.log \
     || (cd $(_WRKSRC) \
         && CFLAGS="$(_CFLAGS)" LDFLAGS="$(LDFLAGS)" ./configure $(_CONFIGURE_ARGS) 2>&1) \
        | tee config.log | $(PFHOME)/bin/activity
do-build:
	@test -e $(PREFIX)/var/pkg/$(_NAME) \
     || $(MAKE) -C $(_WRKSRC) 2>&1 | tee build.log | $(PFHOME)/bin/activity
do-install: | $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME):
	@find $(PREFIX) ! -type d > $(_WRKSRC).before.list
	@$(MAKE) -C $(_WRKSRC) install 2>&1 | tee install.log | $(PFHOME)/bin/activity
	@cd $(STAGING)/$(_NAME) && tar cf - * | tar xf - -C $(PREFIX)
	@find $(PREFIX) ! -type d > $(_WRKSRC).after.list
	@diff -u $(_WRKSRC).before.list $(_WRKSRC).after.list | \
	grep -v '^\++'|awk -F $(PREFIX)/ '/^\+/{print $$2}' > $(PREFIX)/var/pkg/$(_NAME)
do-clean:
	@rm -rf $(_WRKSRC) || true
