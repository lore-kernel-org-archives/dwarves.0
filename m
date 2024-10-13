Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971B8231CA4
	for <dwarves@vger.kernel.org>; Sun, 13 Oct 2024 10:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728813648; cv=none; b=RM7NfTH3ntAINGXlJ7zK06iusnC0KGwzB97zafCvWoto0nC/V6e1TEKFotZ64FU3cMv6cDtHKWyLKU+EcGehLGHiKLNUdza1/UyeyF+eaks3Ga0TMCSyohG5ipwein2Vmz8dDAAU/CZIs3HuKpxL83G6As40X4cSnFNFMko3aF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728813648; c=relaxed/simple;
	bh=OHadJ8U/ncy/O8zBqV68qg6aUsFbS0YA7oYP1z1ymSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iUgOqySqTK6IwtMh6+AMQ2HusuOu3TtOolh2LEY6SLVjiVqJBmbbyKSnLHZHSUhmAl6I56eqfxH8MQMwallZ+/7IxcByPWBhIVKQCamihDbVWBqZaf0xfh0XsWkZPOZ/pEynzstehJ7r2hfb7SOjIJwLxr0WHZ4ohz/RMhcyEQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 49D9p5Ad028906;
	Sun, 13 Oct 2024 11:51:05 +0200
Date: Sun, 13 Oct 2024 11:51:05 +0200
From: Willy Tarreau <w@1wt.eu>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: dwarves@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>,
        Jiri Olsa <jolsa@kernel.org>, Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH 0/3] Differentiate embedded flexible arrays from flexible
 ones
Message-ID: <20241013095105.GA21823@1wt.eu>
References: <20241008195209.1094299-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008195209.1094299-1-acme@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Arnaldo,

On Tue, Oct 08, 2024 at 04:52:06PM -0300, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Hi Willy, Gustavo,
> 
> 	Now it has even a regression test, this now have what I think is
> needed, take a look at the output of:
> 
>    pahole --with_embedded_flexible_arrays > \
> 	 http://vger.kernel.org/~acme/pahole--with_embedded_flexible_array-6.10.11-200.fc40.x86_64.c

First, thanks for this great work! Please note that above it's
"--with_embedded_flexible_array" (without the trailing 's').

I'm seeing that it seems to catch entries added for padding as well:

  struct mem_cgroup {
  ...
        long unsigned int          move_lock_flags;      /*  1480     8 */

        /* XXX 48 bytes hole, try to pack */

        /* --- cacheline 24 boundary (1536 bytes) --- */
        struct cacheline_padding   _pad1_;               /*  1536     0 */

        /* XXX last struct has a flexible array */

I think that we could avoid emitting it if the entire struct or union is
of size zero, as I don't think we'd be using variable length arrays in
a structure of a single field which is that one anyway.

I also tried to catch this case that we discussed about, which is almost
always wrong: fma at the end of a struct, followed by padding in the
container struct, suggesting that the caller meant for the fma to map
to the next field and failed. But it didn't match it when combined
with "--padding_ge 1".

  $ cat pad1.c
  struct foo {
          void *ptr;
          int number;
          char array[];
  } foo;
  
  struct bar {
          int number;
          struct foo foo;
          char storage[16];
  } bar;
  
  int main(void)
  {
          return 0;
  }

  $ gcc -g pad1.c
  $ ../pahole/build/pahole --with_embedded_flexible_array --padding_ge 1 -E ./a.out 
  $
  $ ../pahole/build/pahole --with_embedded_flexible_array -E ./a.out 
  struct bar {
          int                        number;                                               /*     0     4 */
  
          /* XXX 4 bytes hole, try to pack */
  
          struct foo {
                  void *             ptr;                                                  /*     8     8 */
                  int                number;                                               /*    16     4 */
                  char               array[];                                              /*    20     0 */
          } foo; /*     8    16 */
  
          /* XXX last struct has a flexible array, 4 bytes of padding */
  
          char                       storage[16];                                          /*    24    16 */
  
          /* size: 40, cachelines: 1, members: 3 */
          /* sum members: 36, holes: 1, sum holes: 4 */
          /* paddings: 1, sum paddings: 4 */
          /* flexible array members: end: 1 */
          /* last cacheline: 40 bytes */
  };

I think I can reliably spot it by grepping for 'flexible.*padding' but
that removes some of its beauty and efficiency :-)

Maybe it's a different case and it would need a different option, such
as --with_padded_embedded_flexible_array ?

> And go on searching for 'flexible' :-)

Regardless of the status of the points above, that's still really awesome
and an amazing time-saver! Thanks a lot!

> 	Now I'm flexibly moving to other final issues to release pahole 1.28.

Since you're speaking about final issues, I noticed this:
  - forgetting to pass -g to gcc yields:

    $ ../pahole/build/pahole --with_embedded_flexible_array -E ./a.out
    libbpf: failed to find '.BTF' ELF section in ./a.out
    pahole: file './a.out' has no supported type information.

    For me that was not clear, I thought I faced an incompatibility
    related to bpf or something, plus my working binaries don't seem
    to have such a '.BTF' section either. Maybe just asking "were debug
    symbols omitted?" would be clearer.

  - on my laptop, starting 'pahole' segfaults. I traced it to trying to
    open(NULL) after failing to find vmlinux:

    $ strace ./build/pahole
    ...
    access("/sys/kernel/btf/vmlinux", R_OK) = -1 ENOENT (No such file or directory)
    uname({sysname="Linux", nodename="wtap.local", ...}) = 0
    openat(AT_FDCWD, "/sys/kernel/notes", O_RDONLY) = 3
    read(3, "\4\0\0\0\24\0\0\0\3\0\0\0", 12) = 12
    read(3, "GNU\0", 4)                     = 4
    read(3, "\350N\202\23\31g9\302VB(\17u\251\245\"O Xq", 20) = 20
    close(3)                                = 0
    openat(AT_FDCWD, "vmlinux", O_RDONLY)   = -1 ENOENT (No such file or directory)
    openat(AT_FDCWD, "/boot/vmlinux", O_RDONLY) = -1 ENOENT (No such file or directory)
    openat(AT_FDCWD, "/boot/vmlinux-6.1.91", O_RDONLY) = -1 ENOENT (No such file or directory)
    openat(AT_FDCWD, "/usr/lib/debug/boot/vmlinux-6.1.91", O_RDONLY) = -1 ENOENT (No such file or directory)
    openat(AT_FDCWD, "/lib/modules/6.1.91/build/vmlinux", O_RDONLY) = -1 ENOENT (No such file or directory)
    openat(AT_FDCWD, "/usr/lib/debug/lib/modules/6.1.91/vmlinux", O_RDONLY) = -1 ENOENT (No such file or directory)
    openat(AT_FDCWD, "/usr/lib/debug/boot/vmlinux-6.1.91.debug", O_RDONLY) = -1 ENOENT (No such file or directory)
    openat(AT_FDCWD, NULL, O_RDONLY)        = -1 EFAULT (Bad address)
    --- SIGSEGV {si_signo=SIGSEGV, si_code=SEGV_MAPERR, si_addr=NULL} ---
    +++ killed by SIGSEGV +++

    I've bisected it to this recent commit:

      commit c08046f98a3f84881133f9172f6bb417add61879
      Author: Arnaldo Carvalho de Melo <acme@redhat.com>
      Date:   Wed Aug 28 16:19:17 2024 -0300

          core: Add function to return the path to the running kernel vmlinux

Hoping this helps!
Willy
