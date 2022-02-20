PKG    = pkgmanager
PREFIX = /usr

all:

install:
	mkdir $(DESTDIR)$(PREFIX)/bin
	cp $(PKG) $(DESTDIR)$(PREFIX)/bin

test:
	./Tests/tester.sh
