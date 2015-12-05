include ../../../mk/config.mk

# Local variables
_NAME   = readline-6.3p8
_URL    = http://git.savannah.gnu.org/r/readline.git
_REV    = a73b98f779b388a5d0624e02e8bb187246e3e396
_WRKSRC = $(WORKSPACE)/$(_NAME)
_CFLAGS = $(CFLAGS)

# Local works
do-extract: do-gitclone
do-gitclone: wscheck
	@test -d $(_WRKSRC) || $(GIT) clone -o $(_REV) $(_URL) $(_WRKSRC)
do-clean:
	@test -d $(_WRKSRC) && rm -rf $(_WRKSRC) || true
do-config: do-extract
	@cd $(_WRKSRC) && test -e config.log || CFLAGS="$(_CFLAGS)" ./configure --prefix=$(STAGING)
do-build: do-config
	@test -f $(_WRKSRC)/config.log || exit 1
	@$(MAKE) -C $(_WRKSRC)
do-install: do-build pfcheck
	@$(MAKE) -C $(_WRKSRC) install
	@install -d $(PREFIX)/include/readline
	@cp $(STAGING)/include/readline/* $(PREFIX)/include/readline/
	@install -m 755 $(STAGING)/lib/libhistory.so.6.3  $(PREFIX)/lib/libhistory.so.6.3
	@install -m 755 $(STAGING)/lib/libreadline.so.6.3 $(PREFIX)/lib/libreadline.so.6.3
	@ln -f -s $(PREFIX)/lib/libhistory.so.6.3         $(PREFIX)/lib/libhistory.so.6
	@ln -f -s $(PREFIX)/lib/libhistory.so.6           $(PREFIX)/lib/libhistory.so
	@ln -f -s $(PREFIX)/lib/libreadline.so.6.3        $(PREFIX)/lib/libreadline.so.6
	@ln -f -s $(PREFIX)/lib/libreadline.so.6          $(PREFIX)/lib/libreadline.so
do-uninstall:
	@rm -rf $(PREFIX)/include/readline
	@rm -f $(PREFIX)/lib/libhistory.so.6.3
	@rm -f $(PREFIX)/lib/libhistory.so.6
	@rm -f $(PREFIX)/lib/libhistory.so
	@rm -f $(PREFIX)/lib/libreadline.so.6.3
	@rm -f $(PREFIX)/lib/libreadline.so.6
	@rm -f $(PREFIX)/lib/libreadline.so
