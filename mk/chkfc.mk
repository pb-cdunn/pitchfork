ifeq ($(OPSYS),Darwin)
_tmpvar:=$(if $(shell which $(FC)),exists,$(error "unable to run $(FC), consider doing brew install gfortran"))
else
_tmpvar:=$(if $(shell which $(FC)),exists,$(error "unable to run $(FC), consider doing yum install gcc-gfortran"))
endif
