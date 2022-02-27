PKG    = pkgmanager
PREFIX = /usr

all:

install:
	mkdir $(DESTDIR)$(PREFIX)/bin
	cp $(PKG) $(DESTDIR)$(PREFIX)/bin

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
