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
	@test -e $(PREFIX)/var/pkg/$(_NAME) || $(MAKE) -C $(_WRKSRC)
do-install: do-build pfcheck $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME):
	@find $(PREFIX) ! -type d > $(_WRKSRC).before.list
	@$(MAKE) -C $(_WRKSRC) install
	@install -d $(PREFIX)/include/readline
	@cp $(STAGING)/include/readline/* $(PREFIX)/include/readline/
	@install -m 755 $(STAGING)/lib/libhistory.so.6.3  $(PREFIX)/lib/libhistory.so.6.3
	@install -m 755 $(STAGING)/lib/libreadline.so.6.3 $(PREFIX)/lib/libreadline.so.6.3
	@cd $(PREFIX)/lib && ln -f -s libhistory.so.6.3  libhistory.so.6
	@cd $(PREFIX)/lib && ln -f -s libhistory.so.6    libhistory.so
	@cd $(PREFIX)/lib && ln -f -s libreadline.so.6.3 libreadline.so.6
	@cd $(PREFIX)/lib && ln -f -s libreadline.so.6   libreadline.so
	@find $(PREFIX) ! -type d > $(_WRKSRC).after.list
	@diff -u $(_WRKSRC).before.list $(_WRKSRC).after.list | \
	grep -v '^++'|awk -F $(PREFIX) '/^+/{print $$2}' > $(PREFIX)/var/pkg/$(_NAME)
do-uninstall:
	@cat $(PREFIX)/var/pkg/$(_NAME) | xargs rm -f
	@rm -rf $(PREFIX)/include/readline
	@rm -f $(PREFIX)/var/pkg/$(_NAME)
