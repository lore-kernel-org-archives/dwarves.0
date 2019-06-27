From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: ANNOUNCE: pahole v1.14 (Bug fixes)
Date: Thu, 27 Jun 2019 08:03:34 -0300
Message-ID: <20190627110334.GC9599@kernel.org>
References: <20190626211613.GE3902@kernel.org>
 <20190627014906.GA6181@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190627014906.GA6181@mit.edu>
Sender: linux-kernel-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, dwarves@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: dwarves@vger.kernel.org

Em Wed, Jun 26, 2019 at 09:49:06PM -0400, Theodore Ts'o escreveu:
> On Wed, Jun 26, 2019 at 06:16:13PM -0300, Arnaldo Carvalho de Melo wrote:
> > 	The v1.14 release of pahole and its friends is out, available at
> > the usual places
> 
> Looks like you forgot to update the version number.

Sigh, I tested 'pahole --version' locally, but forgot to commit it,
stupid mistake, thanks for pointing it out.

I bumped the version to v1.15 and pushed it out, should be ok now:

[acme@quaco pahole]$ git remote update origin
Fetching origin
From git://git.kernel.org/pub/scm/devel/pahole/pahole
   7005757fd573..529903571037  master     -> origin/master
[acme@quaco pahole]$ git log --oneline -5
529903571037 (HEAD -> master, tag: v1.15, origin/master, origin/HEAD, github/master, acme.korg/master) v1.15: New release
3ed9a67967cf (tag: v1.14) fprintf: Avoid null dereference with NULL configs
568dae4bd498 printf: Fixup printing "const" early with "const void"
68f261d8dfff fprintf: Fix recursively printing named structs in --expand_types
139a3b337381 ostra: Initial python3 conversion
[acme@quaco pahole]$
[acme@quaco pahole]$ rpm -q dwarves
dwarves-1.15-1.fc29.x86_64
[acme@quaco pahole]$ rpm -qf /usr/bin/pahole
dwarves-1.15-1.fc29.x86_64
[acme@quaco pahole]$ /usr/bin/pahole --version
v1.15
[acme@quaco pahole]$

- Arnaldo
