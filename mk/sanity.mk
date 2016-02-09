#
_tmpvar:=$(if $(shell which $(CC)),exists,$(error "unable to run $(CC), consider doing yum install gcc"))
_tmpvar:=$(if $(shell which uname),exists,$(error "unable to run uname, consider doing yum install coreutils"))
_tmpvar:=$(if $(shell which curl),exists,$(error "unable to run curl, consider doing yum install curl"))
_tmpvar:=$(if $(shell which git),exists,$(error "unable to run git, consider doing yum install git"))
_tmpvar:=$(if $(shell which rsync),exists,$(error "unable to run rsync, consider doing yum install rsync"))
ifeq ($(OPSYS),Darwin)
_tmpvar:=$(if $(shell which $(MD5SUM)),exists,$(error "unable to run md5sum, consider doing brew install md5sha1sum"))
else
_tmpvar:=$(if $(shell which $(MD5SUM)),exists,$(error "unable to run md5sum, consider doing yum install coreutils"))
endif
