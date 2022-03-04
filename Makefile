PKG    = pkgmanager
PREFIX = /usr

all:

install:
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp $(PKG) $(DESTDIR)$(PREFIX)/bin

install-ext:
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp $(PKG)-* $(DESTDIR)$(PREFIX)/bin

install-hooks:
	mkdir -p $(DESTDIR)/etc/pkgmanger/hooks.d/
	cp hooks/* $(DESTDIR)/etc/pkgmanger/hooks.d/

install-compatibility:
	mkdir -p $(DESTDIR)/etc/pkgmanger/
	cp compatibility/source_fix $(DESTDIR)/etc/pkgmanger/

install-all: install install-ext install-hooks install-compatibility

test: unittest inttest functionaltest edgetest

unittest:
	./Tests/tester.sh 00

inttest: unittest
	./Tests/tester.sh 01

functionaltest: inttest
	./Tests/tester.sh 10

edgetest: functionaltest
	./Tests/tester.sh 11

.PHONY: test unittest inttest functionaltest edgetest
