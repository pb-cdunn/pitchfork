#
_tmpvar:=$(if $(shell which $(CC)),exists,$(error "unable to run $(CC), consider doing yum install gcc"))
_tmpvar:=$(if $(shell which arch),exists,$(error "unable to run arch, consider doing yum install coreutils"))
