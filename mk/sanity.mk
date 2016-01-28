#
_tmpvar:=$(if $(shell which $(CC)),exists,$(error "unable to run $(CC), consider doing yum install gcc"))
_tmpvar:=$(if $(shell which arch),exists,$(error "unable to run arch, consider doing yum install coreutils"))
_tmpvar:=$(if $(shell which curl),exists,$(error "unable to run curl, consider doing yum install curl"))
_tmpvar:=$(if $(shell which unzip),exists,$(error "unable to run unzip, consider doing yum install unzip"))
ifeq ($(OPSYS),Darwin)
_tmpvar:=$(if $(shell which $(MD5SUM)),exists,$(error "unable to run md5sum, consider doing brew install md5sha1sum"))
else
_tmpvar:=$(if $(shell which $(MD5SUM)),exists,$(error "unable to run md5sum, consider doing yum install coreutils"))
endif
