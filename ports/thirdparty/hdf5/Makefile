include ../../../mk/config.mk

# CXX check
include ../../../mk/chkcxx.mk

# Local variables
_NAME   = hdf5-1.8.16
_URL    = https://www.hdfgroup.org/ftp/HDF5/releases/hdf5-1.8.16/src
_FILE   = $(_NAME).tar.gz
_WRKSRC = $(WORKSPACE)/$(_NAME)

# Local works
do-fetch:
	@test -e $(_FILE) || curl -O $(_URL)/$(_FILE)
	@which $(MD5SUM) >& /dev/null && $(MD5SUM) -c MD5SUM
do-extract:
	@test -d $(_WRKSRC) || tar zxf $(_FILE) -C $(WORKSPACE)
do-config:
	@test -e $(_WRKSRC)/config.log || ( cd $(_WRKSRC) && \
        CFLAGS="$(CFLAGS)" LDFLAGS="$(LDFLAGS)" ./configure --prefix=$(STAGING)/$(_NAME) --enable-cxx \
                    --with-shared --with-zlib=$(PREFIX)) 2>&1 \
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
do-clean:
	@rm -rf $(_WRKSRC) || true
