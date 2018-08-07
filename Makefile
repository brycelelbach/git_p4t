# Copyright (c) 2017-8 NVIDIA Corporation
# Reply-To: Bryce Adelstein Lelbach aka wash <brycelelbach@gmail.com>
# 
# Distributed under the MIT License (http://www.opensource.org/licenses/mit-license.php)

BUILD_ROOT ?= build

# `git-p4.py` is installed to $(INSTALL_ROOT)/bin
# `git-p4.1` is installed to $(INSTALL_ROOT)/share/man/man1
INSTALL_ROOT ?= /usr/local

GIT_VERSION ?= 2.15.1-thrust

.PHONY: install

$(BUILD_ROOT)/:
	mkdir -p $(BUILD_ROOT)/

install: git-p4.1 $(BUILD_ROOT)/
	mkdir -p $(INSTALL_ROOT)/bin
	cp git-p4.py $(INSTALL_ROOT)/bin/git-p4
	mkdir -p $(INSTALL_ROOT)/share/man/man1
	cp git-p4.1 $(INSTALL_ROOT)/share/man/man1

clean:
	rm -f $(BUILD_ROOT)/*.xml
	rm -f $(BUILD_ROOT)/*.tmp.xml
	rm -f $(BUILD_ROOT)/*.1
	rmdir $(BUILD_ROOT)

%.xml: %.txt $(BUILD_ROOT)/
	asciidoc -a git-asciidoc-no-roff -f asciidoc.conf -agit_version=$(GIT_VERSION) -b docbook -d manpage -o $*.tmp.xml $< 
	mv $*.tmp.xml $@

%.1: %.xml $(BUILD_ROOT)/
	xmlto -m manpage-normal.xsl -m manpage-bold-literal.xsl man $<
	chmod 644 $@

