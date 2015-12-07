include ../../../mk/config.mk

# Local variables
_NAME   = ncurses-6.0
_URL    = ftp://ftp.gnu.org/gnu/ncurses
_FILE   = $(_NAME).tar.gz
_WRKSRC = $(WORKSPACE)/$(_NAME)

# Local works
do-extract: wscheck
	@test -e $(_FILE) || curl -O $(_URL)/$(_FILE)
	@which $(MD5SUM) >& /dev/null && $(MD5SUM) -c MD5SUM
	@test -d $(_WRKSRC) || tar zxf $(_FILE) -C $(WORKSPACE)
do-clean-distfile:
	@rm -f $(_FILE)
do-clean:
	@test -d $(_WRKSRC) && rm -rf $(_WRKSRC) || true
do-config: do-extract
	@cd $(_WRKSRC) && (test -e config.log \
     || CFLAGS="$(CFLAGS)" ./configure --prefix=$(STAGING) --with-shared)
do-build: do-config
	@test ! -e config.log || exit 1
	@test -e $(PREFIX)/var/pkg/$(_NAME) || $(MAKE) -C $(_WRKSRC)
do-install: do-build pfcheck $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME):
	@find $(PREFIX) ! -type d > $(_WRKSRC).before.list
	@$(MAKE) -C $(_WRKSRC) install
	@install -m 755 $(STAGING)/lib/libncurses.so.6.0 $(PREFIX)/lib/libncurses.so.6.0
	@install -m 755 $(STAGING)/lib/libpanel.so.6.0   $(PREFIX)/lib/libpanel.so.6.0
	@install -m 755 $(STAGING)/lib/libmenu.so.6.0    $(PREFIX)/lib/libmenu.so.6.0
	@install -m 755 $(STAGING)/lib/libform.so.6.0    $(PREFIX)/lib/libform.so.6.0
	@install -d $(PREFIX)/include/ncurses
	@cp -a $(STAGING)/include/ncurses/* $(PREFIX)/include/ncurses/
	@install -d $(PREFIX)/share/terminfo
	@cp -a $(STAGING)/share/terminfo/* $(PREFIX)/share/terminfo/
	@cd $(PREFIX)/lib && ln -f -s ../share/terminfo terminfo
	@cd $(PREFIX)/lib && ln -f -s libncurses.so.6.0 libncurses.so.6
	@cd $(PREFIX)/lib && ln -f -s libncurses.so.6   libncurses.so
	@cd $(PREFIX)/lib && ln -f -s libpanel.so.6.0   libpanel.so.6
	@cd $(PREFIX)/lib && ln -f -s libpanel.so.6     libpanel.so
	@cd $(PREFIX)/lib && ln -f -s libmenu.so.6.0    libmenu.so.6
	@cd $(PREFIX)/lib && ln -f -s libmenu.so.6      libmenu.so
	@cd $(PREFIX)/lib && ln -f -s libform.so.6.0    libform.so.6
	@cd $(PREFIX)/lib && ln -f -s libform.so.6      libform.so
	@find $(PREFIX) ! -type d > $(_WRKSRC).after.list
	@diff -u $(_WRKSRC).before.list $(_WRKSRC).after.list | \
	grep -v '^++'|awk -F $(PREFIX)/ '/^+/{print $$2}' > $(PREFIX)/var/pkg/$(_NAME)
do-uninstall:
	@cd $(PREFIX) && cat var/pkg/$(_NAME) | xargs rm -f
	@rm -f $(PREFIX)/var/pkg/$(_NAME)
	@rm -rf $(PREFIX)/include/ncurses
	@rm -rf $(PREFIX)/share/terminfo
