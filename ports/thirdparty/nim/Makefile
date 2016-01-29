include ../../../mk/config.mk

# Local variables
_NAME            = nim-0.12.0
_URL             = http://nim-lang.org/download
_WRKSRC          = $(WORKSPACE)/$(_NAME)
_FILE            = $(_NAME).zip

# Local check
_tmpvar:=$(if $(shell which unzip),exists,$(error "unable to run unzip, consider doing yum install unzip"))

# Local works
do-fetch: | $(_FILE)
	@$(MD5SUM) -c MD5SUM
$(_FILE):
	@$(CURL) -L -O $(_URL)/$@
do-extract: | $(_WRKSRC)
$(_WRKSRC):
	@unzip $(_FILE) -d $(WORKSPACE)
do-build: | $(_WRKSRC)/bin/nim
$(_WRKSRC)/bin/nim:
	@cd $(_WRKSRC) && sh build.sh
do-install: | $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME):
	@mkdir -p $(STAGING)/$(_NAME)
	@mkdir -p $(PREFIX)/share/doc
	@cd $(_WRKSRC) && sh install.sh $(STAGING)/$(_NAME)
	@find $(PREFIX) ! -type d > $(_WRKSRC).before.list
	@find $(PREFIX) -type d > $(_WRKSRC).before.dlist
	@cp -a $(STAGING)/$(_NAME)/nim/bin/nim  $(PREFIX)/bin/
	@cp -a $(STAGING)/$(_NAME)/nim/lib      $(PREFIX)/lib/nim
	@cp -a $(STAGING)/$(_NAME)/nim/doc      $(PREFIX)/share/doc/nim
	@cp -a $(STAGING)/$(_NAME)/nim/config/* $(PREFIX)/etc/
	@find $(PREFIX) ! -type d > $(_WRKSRC).after.list
	@find $(PREFIX) -type d > $(_WRKSRC).after.dlist
	@diff -u $(_WRKSRC).before.list $(_WRKSRC).after.list | \
	grep -v '^\++'|awk -F $(PREFIX)/ '/^\+/{print $$2}' >  $(PREFIX)/var/pkg/$(_NAME)
	@diff -u $(_WRKSRC).before.dlist $(_WRKSRC).after.dlist | \
	grep -v '^\++'|awk -F $(PREFIX)/ '/^\+/{print $$2}' >> $(PREFIX)/var/pkg/$(_NAME)
