<!--
Copyright (c) 2017-2020 NVIDIA Corporation
Reply-To: Bryce Adelstein Lelbach aka wash <brycelelbach@gmail.com>

Distributed under the MIT License (http://www.opensource.org/licenses/mit-license.php)
-->

# `git-p4t`

*Reply-To:* [Bryce Adelstein Lelbach aka wash](brycelelbach@gmail.com)

This repository contains a modified version of `git p4` (which is part of
  the main [Git] distribution) called `git p4t` (`t` for transparent) which is
  designed to submit changes from a Git repository to a Perforce repository
  without modifying Git history (as `git p4` does) and without requiring the
  use of a service like [Perforce GitFusion].
This tool was developed by NVIDIA's CUDA C++ Core Libraries team for use in a
  number of projects such as [CUDA Thrust], [CUDA CUB], and [libcu++].

## Design

`git p4t` is designed for a workflow where Git is the source of truth and all
  changes are made in Git and then submitted to Perforce.

When `git p4` submits a Git commit to Perforce, the original Git commmit is
  deleted and replaced with a new commit containing the same content.
This history rewriting is problematic for Git-centric workflows.
It makes it difficult for downstream Git users to rebase, to tell which
  branches have been merged, and to use GitHub/GitLab pull requests.

Instead, `git p4t` transparently submits Git commits to Perforce without
  modifying Git history in any way.
It also automatically inserts the Git commit hashes and Git author ids into
  the submitted Perforce changelist descriptions.

`git p4t` is not designed for workflows where changes are made in Perforce and
  then pulled into Git.
`git p4t` will *NOT* automatically identify and pull changes made in Perforce
  that are not in the Git tree.

`git p4` has strong mechanisms for enforcing unity between Perforce and Git,
  with the downside that it rewrites Git history.
`git p4t` does not rewrite Git history, but it has much weaker mechanisms for
  ensuring unity between Git and Perforce.

However, `git p4t` does give users greater freedom in manually controlling
  what Git commits are considered submitted to Perforce.
The `git p4t unify` command (which replaces `git p4t init`) manually sets the
  commit that the `git p4t` tool belives Perforce is synchronized with to
  a specified Git commitish (`HEAD` by default).

Unlike [Perforce GitFusion], `git p4t` does not require a service to be running
  on a central server, does not require Perforce administrative access, and does
  not funnel all Perforce submissions through a single account (limiting
  accountability and access mechanisms designed around Perforce user IDs).

## Licensing

Parts of this software are distributed under the
  [GNU Public License version 2 (GPLv2)] and parts of this software are
  distributed under the [MIT License].
See [LICENSE.md](LICENSE.md) for further details.

## Prerequisites

This software is designed to work on Linux-based operating systems.

**Required Software**

| Software                                  | Minimum Version |
| ----------------------------------------- | --------------- |
| [Python]                                  | 2.7.13          |
| [GNU Bash]                                | 4.2             |
| [GNU Make]                                | 4.1             |
| [Git]                                     | 2.6.4           |
| [Perforce Helix Command-Line Client (p4)] | 2017.1          |

**Optional Software**

These are needed to build the git-p4 manpage.

| Software                            | Minimum Version |
| ----------------------------------- | --------------- |
| [AsciiDoc]                          | 8.6.9           |
| [DocBook]                           | 4.5             |
| [xmlto]                             | 0.0.2           |

To install the [Perforce Helix Command-Line Client (p4)] on Debian or Ubuntu
  systems, you'll need to add their Debian package repository to your list of
  Debian package sources:

```bash
deb http://package.perforce.com/apt/ubuntu xenial release
```

The following commands will add Perforce repository and update the list of
  available packages:

```bash
wget -qO - https://package.perforce.com/perforce.pubkey | sudo apt-key add -
sudo bash -c 'echo "deb http://package.perforce.com/apt/ubuntu xenial release" > /etc/apt/sources.list.d/perforce.list'
sudo apt-get update
```

After you've done that, the following will install all of the requried
  prerequisites on Debian or Ubuntu systems:

```bash
sudo apt-get install python bash make git helix-cli asciidoc docbook xmlto
```

## Building and Installing

You can just run `make` to build and install this software:

```bash
sudo make install
```

By default, this will install into `/usr/local`.
You can control the install root with the `INSTALL_ROOT` variable:

```bash
make install INSTALL_ROOT=/my/install/root
```

[CUDA Thrust]:                                  https://github.com/thrust/thrust
[CUDA CUB]:                                     https://github.com/NVlabs/cub
[libcu++]:                                      https://github.com/ogiroux/freestanding
[GNU General Public License version 2 (GPLv2)]: https://opensource.org/licenses/GPL-2.0
[MIT License]:                                  https://opensource.org/licenses/mit-license.php
[Python]:                                       https://python.org
[GNU Bash]:                                     https://www.gnu.org/software/bash
[GNU Make]:                                     https://www.gnu.org/software/make
[Git]:                                          https://git-scm.com
[Perforce Helix Command-Line Client (p4)]:      https://www.perforce.com/downloads/helix-command-line-client-p4
[Perforce GitFusion]:                           https://www.perforce.com/manuals/git-fusion/
[AsciiDoc]:                                     https://asciidoc.org
[DocBook]:                                      https://docbook.org
[xmlto]:                                        https://pagure.io/xmlto

