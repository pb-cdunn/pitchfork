include ../../../mk/config.mk

# Local variables
_NAME            = pip-7.1.2
_URL             = https://raw.githubusercontent.com/pypa/pip
_REV             = 3dfa1f9a55d25587e9e97a27d8c87943e4b6aa54
_WRKSRC          = $(WORKSPACE)/$(_NAME)
_FILE            = get-pip.py

# Local works
do-fetch:
	@test -e $(_FILE) || $(CURL) -O $(_URL)/$(_REV)/contrib/$(_FILE)
do-install: | $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME):
	@find $(PREFIX) ! -type d > $(_WRKSRC).before.list
	@$(PREFIX)/bin/python $(_FILE)
	@find $(PREFIX) ! -type d > $(_WRKSRC).after.list
	@diff -u $(_WRKSRC).before.list $(_WRKSRC).after.list | \
	grep -v '^\++'|awk -F $(PREFIX)/ '/^\+/{print $$2}' > $(PREFIX)/var/pkg/$(_NAME)
do-uninstall:
	@cd $(PREFIX) && cat var/pkg/$(_NAME) | xargs rm -f
	@rm -f $(PREFIX)/var/pkg/$(_NAME)
