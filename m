Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 101EAC4361B
	for <linux-dwarves@archiver.kernel.org>; Mon,  7 Dec 2020 15:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4A3C23731
	for <linux-dwarves@archiver.kernel.org>; Mon,  7 Dec 2020 15:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725814AbgLGPpw (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Mon, 7 Dec 2020 10:45:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:41870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbgLGPpw (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Mon, 7 Dec 2020 10:45:52 -0500
Date:   Mon, 7 Dec 2020 12:45:20 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607355911;
        bh=aO/krXU+fHLMFIel22duskcphOTHYkgVsU9GL1yexRM=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=hjXEs4Veu8sAHrKA6u71/2cgIzA4Fg73eV9mMSvIr2hiRXDjz8V0be49KYtcnxybj
         yNrK9nXMqlqUWtOYMupth9MdgpZFvnTWny/TyVczbUFb2+rzg/8sWl/vtGOawpp3jn
         1zGTFSgNDUhO7LZbfPVN7LV9d8n6FtnNs0I7X4Sr7oQFLQR1m+nefrzuygarKFCHOE
         qwMKihrVkq0og5MynAVtdeVj6vEehQfITRDSFiADfxkHFqY51fBrahPjLyS7Dhpdw+
         ETOSU59awxBw9Ybqhm3o396RDDOaKKfWQ06wuChlUs1iKVZq9k0EoZMDOgffC6HG0b
         2F+UD7FBQqnkQ==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>, dwarves@vger.kernel.org,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>
Subject: Re: [PATCH 2/3] btf_encoder: Use address size based on ELF's class
Message-ID: <20201207154520.GA125383@kernel.org>
References: <20201203220625.3704363-1-jolsa@kernel.org>
 <20201203220625.3704363-3-jolsa@kernel.org>
 <CAEf4BzbdB4DUJ2BKVsVdpcZHunNxb_6FvAWOFt_be=81Jyxmnw@mail.gmail.com>
 <20201203233750.GG3613628@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203233750.GG3613628@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Fri, Dec 04, 2020 at 12:37:50AM +0100, Jiri Olsa escreveu:
> On Thu, Dec 03, 2020 at 03:22:18PM -0800, Andrii Nakryiko wrote:
> > On Thu, Dec 3, 2020 at 2:08 PM Jiri Olsa <jolsa@kernel.org> wrote:
> > >
> > > We can't assume the address size is always size of unsigned
> > > long, we have to use directly the ELF's address size.
> > >
> > > Changing addrs array to __u64 and convert 32 bit address
> > > values when copying from ELF section.
> > >
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > 
> > It looks ok to me, but I didn't expect that changes would be so
> > numerous... Makes me wonder if pahole ever supported working with ELF
> > files of different bitness. I'll defer to Arnaldo to make a call on
> > whether this is necessary.
> 
> so to test this I built 32bit vmlinux and used 64bit pahole
> to generate BTF data on both vmlinux and modules, which I
> thought was valid use case

It is valid, yeah.

- Arnaldo
 
> jirka
> 
> > 
> > >  btf_encoder.c | 24 +++++++++++++++++-------
> > >  1 file changed, 17 insertions(+), 7 deletions(-)
> > >
> > 
> > [...]
> > 
> 

-- 

- Arnaldo
