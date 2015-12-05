_tmpvar:=$(if $(shell which autoreconf),exists,$(error "unable to run autoreconf, consider doing yum install autoconf"))
