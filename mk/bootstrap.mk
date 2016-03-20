override SELF_DIR:=$(dir $(lastword $(MAKEFILE_LIST)))
-include $(SELF_DIR)/../initialized.o

$(SELF_DIR)/../initialized.o:
	$(MAKE) -f mk/init.mk init
	touch $@

_startover::
	rm -f $(SELF_DIR)/../initialized.o
