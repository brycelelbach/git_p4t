# Distributed under the MIT License
# http://www.opensource.org/licenses/mit-license.php
#
#! /bin/bash

UPSTREAM_REVISION=v2.15.1

FILES="
git-p4.py
Documentation/asciidoc.conf
Documentation/git-p4.txt
Documentation/manpage-base.xsl
Documentation/manpage-normal.xsl
Documentation/manpage-bold-literal.xsl
"

for file in ${FILES}
do
  git cat-file blob ${UPSTREAM_REVISION}:${file} > `basename ${file}`
done

chmod 755 git-p4.py

