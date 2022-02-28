PKG    = pkgmanager
PREFIX = /usr

all:

install:
	mkdir $(DESTDIR)$(PREFIX)/bin
	cp $(PKG) $(DESTDIR)$(PREFIX)/bin

install-hooks:
	mkdir $(DESTDIR)/etc/pkgmanger/hooks.d/
	cp hooks/* $(DESTDIR)/etc/pkgmanger/hooks.d/

install-compatibility:
	mkdir $(DESTDIR)/etc/pkgmanger/
	cp source_fix $(DESTDIR)/etc/pkgmanger/

install-all: install install-hooks install-compatibility

test: unittest inttest functionaltest edgetest

unittest:
	./Tests/tester.sh 00

inttest: unittest
	./Tests/tester.sh 01

functionaltest: inttest
	./Tests/tester.sh 10

edgetest: functionaltest
	./Tests/tester.sh 11

unittest:

.PHONY: test unittest inttest functionaltest edgetest
