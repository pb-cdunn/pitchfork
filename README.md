# pitchfork
Prototyping github source building in a hacky style.

## Kaboomboom

## style guide

1. use ```cd $(PREFIX)/lib && ln -s foo.so.1 foo.so``` instead of ```ln -s $(PREFIX)/lib/foo.so.1 $(PREFIX)/lib/foo.so```, since they are different.
2. use staging folder as much as possible
