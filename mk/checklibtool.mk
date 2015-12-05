_tmpvar:=$(if $(shell which libtool),exists,$(error "unable to run autoreconf, consider doing yum install autoconf"))
