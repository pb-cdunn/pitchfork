#
_tmpvar:=$(if $(shell which $(CC)),exists,$(error "unable to run $(CC), consider doing yum install gcc"))
