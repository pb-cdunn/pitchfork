_tmpvar:=$(if $(shell which aclocal),exists,$(error "unable to run aclocal, consider doing yum install automake"))
