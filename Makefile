# Distributed under the MIT License
# http://www.opensource.org/licenses/mit-license.php

# `git-p4.py` is installed to $(INSTALL_ROOT)/bin
# `git-p4.1` is installed to $(INSTALL_ROOT)/share/man/man1
INSTALL_ROOT ?= /usr/local

GIT_VERSION ?= 2.15.1

.PHONY: install

install: git-p4.1
	mkdir -p $(INSTALL_ROOT)/bin
	cp git-p4.py $(INSTALL_ROOT)/bin/git-p4
	mkdir -p $(INSTALL_ROOT)/share/man/man1
	cp git-p4.1 $(INSTALL_ROOT)/share/man/man1

clean:
	rm -f *.xml
	rm -f *.tmp.xml
	rm -f *.1

%.xml: %.txt
	asciidoc -a git-asciidoc-no-roff -f asciidoc.conf -agit_version=$(GIT_VERSION) -b docbook -d manpage -o $*.tmp.xml $< 
	mv $*.tmp.xml $@

%.1: %.xml
	xmlto -m manpage-normal.xsl -m manpage-bold-literal.xsl man $@

