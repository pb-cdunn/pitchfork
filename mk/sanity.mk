#
ifeq ($(OPSYS),Darwin)
_tmpvar:=$(if $(shell which $(MD5SUM)),exists,$(error "unable to run md5sum, consider doing brew install md5sha1sum"))
else
_tmpvar:=$(if $(shell which $(MD5SUM)),exists,$(error "unable to run md5sum, consider doing yum install coreutils"))
endif

sanity:
	@$(PFHOME)/bin/checkSystem
	@$(PFHOME)/bin/checkCC $(CC)
checkBOOST:
	@$(PFHOME)/bin/checkBoost $(BOOST_INC)
