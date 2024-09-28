Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE07815D5CF
	for <dwarves@vger.kernel.org>; Sat, 28 Sep 2024 04:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727498211; cv=none; b=pbRzebmp/9n3MEKdDHtYomMAF5h+GqcjjH+yQfhxtmFZdNSlYhKD6GOfFFl+OEBhuywUyvxxcMdL9GiK032sQENeaX0ygHMINAQ8zv2zBOX44b7emVz7Cwm6HQm5tGV9/0OkzeJJ8oWxQ03ImxGlvENh25WWmUh4WuZk77l87ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727498211; c=relaxed/simple;
	bh=Ql1XeFf5ZCgkOshHCvQU8d/LYF6aEOHZJdBmLhrpRHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AHdKuM3yRJQo5k7wKIzVsIcsE3xy4gTuZSz+gWc2v4vvokrVNsqvG5GOn2CNpbZ+1wEju5Kd/dJZ9Li/37DdGdDrsAPuNOUdx19XiKLDCLZHjUH4BldUunfCeCUDIkH1hCBgolftu9QYLMyhEYuFnQeLwSco7CseJjZg2H/FJt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 48S4acsX004790;
	Sat, 28 Sep 2024 06:36:38 +0200
Date: Sat, 28 Sep 2024 06:36:38 +0200
From: Willy Tarreau <w@1wt.eu>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: dwarves@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>,
        Jiri Olsa <jolsa@kernel.org>, Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH 0/2] --padding option to combine with
 --with_flexible_array
Message-ID: <20240928043638.GA4774@1wt.eu>
References: <20240927185958.37310-1-acme@kernel.org>
 <20240927211503.GA4031@1wt.eu>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240927211503.GA4031@1wt.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Sep 27, 2024 at 11:15:03PM +0200, Willy Tarreau wrote:
> Hi Arnaldo!
> 
> On Fri, Sep 27, 2024 at 03:59:56PM -0300, Arnaldo Carvalho de Melo wrote:
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > 
> > Hi,
> > 
> > 	This implements --padding, that combined with the already
> > available --with_flexible_array option may catch some questionable
> > structs.
> > 
> > 	This comes from a quick discussion I had with Willy Tareau after
> > Gustavo's talk at this year's Kernel Recipes.
> > 
> > 	I have this in the 'next' branch of:
> > 
> > https://git.kernel.org/pub/scm/devel/pahole/pahole.git
> > 
> > 	Willy, is that what you had in mind?
> 
> Oh that was fast!
> 
> I'm looking at the output here:
> 
>    http://oldvger.kernel.org/~acme/pahole--padding_ge_1_--with_flexible_array.6.10.10-200.fc40.x86_64.txt
> 
> I'm seeing in the output above that mem_cgroup was reported due to 48
> bytes padding being caused by extra alignment. I'm not sure what to
> think about it to be honest, there could be pros and cons. However it's
> true that if this struct is embedded inside another one, it starts to
> smell nevertheless, and such a case is not much frequent so it should
> be a low rate of false positives in the worst case.
> 
> The output is clearly reviewable by hand, that's really cool!

So I tried it on haproxy. The first good news is that it didn't spot
anything, indicating that it doesn't seem to trigger false-positives
(the second good news being that I don't have to fix anything there :-)).

For example I have such a struct that contains a forced alignment hole
before the flex array and it rightfully didn't catch it:

  struct ebmb_node {
        struct eb_node             node;                 /*     0    36 */

        /* XXX 4 bytes hole, try to pack */

        union {
        } __attribute__((__aligned__(8)));               /*    40     0 */
        unsigned char              key[];                /*    40     0 */

        /* size: 40, cachelines: 1, members: 3 */
        /* sum members: 36, holes: 1, sum holes: 4 */
        /* forced alignments: 1, forced holes: 1, sum forced holes: 4 */
        /* last cacheline: 40 bytes */
  } __attribute__((__aligned__(8)));

But it correctly spots this one that we imagined during our discussion:

  struct foo {
        void *                     ptr;                  /*     0     8 */
        int                        number;               /*     8     4 */
        char                       array[];              /*    12     0 */

        /* size: 16, cachelines: 1, members: 3 */
        /* padding: 4 */
        /* last cacheline: 16 bytes */
  };

So that looks all good to me!

BTW, while building the -next branch (ubuntu 22 arm64 gcc11.4), I faced
this warning that you might be interested in, and that didn't appear in
the master branch:

  In file included from /usr/include/string.h:535,
                   from /usr/include/obstack.h:136,
                   from /home/willy/pahole/dwarves.h:13,
                   from /home/willy/pahole/btf_encoder.c:13:
  In function strncpy,
      inlined from btf_encoder__add_func_proto at /home/willy/pahole/btf_encoder.c:749:4:
  /usr/include/aarch64-linux-gnu/bits/string_fortified.h:95:10: warning: __builtin_strncpy specified bound 128 equals destination size [-Wstringop-truncation]
     95 |   return __builtin___strncpy_chk (__dest, __src, __len,
        |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     96 |                                   __glibc_objsize (__dest));
        |                                   ~~~~~~~~~~~~~~~~~~~~~~~~~
  In function strncpy,
      inlined from btf_encoder__add_func at /home/willy/pahole/btf_encoder.c:1172:4:
  /usr/include/aarch64-linux-gnu/bits/string_fortified.h:95:10: warning: __builtin_strncpy specified bound 128 equals destination size [-Wstringop-truncation]
     95 |   return __builtin___strncpy_chk (__dest, __src, __len,
        |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     96 |                                   __glibc_objsize (__dest));
        |                                   ~~~~~~~~~~~~~~~~~~~~~~~~~

Do not hesitate to ask me for some tests if needed. I can also bisect
if needed.

Thanks!
Willy
