# pitchfork
Prototyping github source building

## style guide

1. use ```cd $(PREFIX)/lib && ln -s foo.so.1 foo.so``` instead of ```ln -s $(PREFIX)/lib/foo.so.1 $(PREFIX)/lib/foo.so```, since they are different.
