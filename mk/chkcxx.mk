ifeq ($(OPSYS),Darwin)
_tmpvar:=$(if $(shell which $(CXX)),exists,$(error "unable to run $(CXX), did you install xcode correctly?"))
else
_tmpvar:=$(if $(shell which $(CXX)),exists,$(error "unable to run $(CXX), consider doing yum install gcc-c++"))
endif

