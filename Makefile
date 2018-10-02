# Copyright (c) 2017-8 NVIDIA Corporation
# Reply-To: Bryce Adelstein Lelbach aka wash <brycelelbach@gmail.com>
# 
# Distributed under the MIT License (http://www.opensource.org/licenses/mit-license.php)

BUILD_ROOT ?= build

INSTALL_ROOT ?= /usr/local

GIT_VERSION ?= 2.15.1-thrust

.PHONY: install

install: git-p4.1 git-p4t.1 $(BUILD_ROOT)/
	mkdir -p $(INSTALL_ROOT)/bin
	cp git-p4.py $(INSTALL_ROOT)/bin/git-p4
	cp git-p4t.py $(INSTALL_ROOT)/bin/git-p4t
	mkdir -p $(INSTALL_ROOT)/share/man/man1
	cp $(BUILD_ROOT)/git-p4.1 $(INSTALL_ROOT)/share/man/man1
	cp $(BUILD_ROOT)/git-p4t.1 $(INSTALL_ROOT)/share/man/man1

$(BUILD_ROOT)/:
	mkdir -p $(BUILD_ROOT)/

clean:
	rm -f $(BUILD_ROOT)/*.xml
	rm -f $(BUILD_ROOT)/*.tmp.xml
	rm -f $(BUILD_ROOT)/*.1
	rmdir $(BUILD_ROOT)

%.xml: %.txt $(BUILD_ROOT)/
	asciidoc -a git-asciidoc-no-roff -f asciidoc.conf -agit_version=$(GIT_VERSION) -b docbook -d manpage -o $(BUILD_ROOT)/$*.tmp.xml $< 
	mv $(BUILD_ROOT)/$*.tmp.xml $(BUILD_ROOT)/$@

%.1: %.xml $(BUILD_ROOT)/ manpage-normal.xsl manpage-bold-literal.xsl
	xmlto -m manpage-normal.xsl -m manpage-bold-literal.xsl -o $(BUILD_ROOT) man $(BUILD_ROOT)/$<
	chmod 644 $(BUILD_ROOT)/$@

