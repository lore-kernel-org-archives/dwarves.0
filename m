From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: ANNOUNCE: pahole v1.14 (Bug fixes)
Date: Wed, 26 Jun 2019 18:16:13 -0300
Message-ID: <20190626211613.GE3902@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: dwarves@vger.kernel.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, bpf@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Jan Engelhardt <jengelh@inai.de>, Domenico Andreoli <cavok@debian.org>, Matthias Schwarzott <zzam@gentoo.org>, David Seifert <soap@gentoo.org>, Pavel Borzenkov <pavel.borzenkov@gmail.com>, Matthew Wilcox <willy@infradead.org>, Mark Wieelard <mjw@redhat.com>, Clark Williams <williams@redhat.com>
List-Id: dwarves@vger.kernel.org

Hi,
 
	The v1.14 release of pahole and its friends is out, available at
the usual places:
 
Main git repo:
 
   git://git.kernel.org/pub/scm/devel/pahole/pahole.git

Mirror git repo:
 
   https://github.com/acmel/dwarves.git
 
tarball + gpg signature:
 
   https://fedorapeople.org/~acme/dwarves/dwarves-1.14.tar.xz
   https://fedorapeople.org/~acme/dwarves/dwarves-1.14.tar.bz2
   https://fedorapeople.org/~acme/dwarves/dwarves-1.14.tar.sign
 
Just some bugfixes, notably:

3ed9a67967cf fprintf: Avoid null dereference with NULL configs
568dae4bd498 printf: Fixup printing "const" early with "const void"
68f261d8dfff fprintf: Fix recursively printing named structs in --expand_types

Best Regards,

- Arnaldo
