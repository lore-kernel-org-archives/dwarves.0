Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420224A987
	for <dwarves@vger.kernel.org>; Tue,  5 Dec 2023 18:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mVnS17Vn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99FD4C433CA;
	Tue,  5 Dec 2023 18:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701801967;
	bh=NZn2lJTOoAWnj7aJwxbFyayt2gDAlY4Qku/+8i6t2u4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mVnS17VnKJkbFGn9w0nUhLSwAyiyVnqkve7HD068q4PQDMuFfAZlRbNdZDSrnbSSQ
	 FT2/W/EgBHadjRpM4oeQ/k1EW1tQnYw8WW/pkXndTaccoVn8QGA8pcy3YQRK0eeAfI
	 34FnvYuOGlz5DM58Pbj7Eqtr2KEPjgvH35688+6oiU+Ht2/y89DETsSWlFDV47HZKv
	 nKkwdW1lPsa3g8vACdR2VMph3nt9+WLxYCFkHamo6Np270I9crHZ0KWHUADZM4xyT6
	 oYnklIQ3nBO/hBZ6f+uB3sSp2hubv/EvSx1kfJSl5cbJPDXEUj/BuUr85iGbiaSbhW
	 rGoDrbwy/L/2w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 14FAB40094; Tue,  5 Dec 2023 15:46:04 -0300 (-03)
Date: Tue, 5 Dec 2023 15:46:04 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Cc: dwarves@vger.kernel.org, elfutils-devel@sourceware.org, mark@klomp.org
Subject: Re: Porting pahole from dwarf_next_unit() to dwarf_get_units()
Message-ID: <ZW9v7F4xa4TDcJXl@kernel.org>
References: <CADWks+b06hpoBJpVdtd4HXdC0w24hObq0WOGCdfMGkpC7k=2vQ@mail.gmail.com>
 <ZW9GKNPpEU1M3vYp@kernel.org>
 <CADWks+bxFgT0e8vA0MaX2aXsLDzawU2kyhiOXBm_bP3UOxw_dA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADWks+bxFgT0e8vA0MaX2aXsLDzawU2kyhiOXBm_bP3UOxw_dA@mail.gmail.com>
X-Url: http://acmel.wordpress.com

Em Tue, Dec 05, 2023 at 04:11:06PM +0000, Dimitri John Ledkov escreveu:
> I
> 
> On Tue, 5 Dec 2023, 15:47 Arnaldo Carvalho de Melo, <acme@kernel.org> wrote:
> >
> > Em Tue, Dec 05, 2023 at 01:03:01PM +0000, Dimitri John Ledkov escreveu:
> > > Currently pahole warns and does nothing upon hitting
> > > DW_TAG_skeleton_unit as implemented at
> > > https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?id=0135ccd632796ab3aff65b7c99b374c4682c2bcf
> > >
> > > In elfutils, a while back a new API got added that aids with discovery
> > > and processing of such tags -
> > > https://sourceware.org/git/?p=elfutils.git;a=commitdiff;h=79f0e623dcde4b042bb72f636a2211d67d5c0ade
> > >
> > > It seems to me if pahole is ported from using dwarf_next_unit() to
> > > instead use dwarf_get_units() native support can be added for
> > > split-dwarf (dwo) files.
> >
> > That would be awesome!
> >
> > > I am trying to write such a port, but it is proving to be very
> > > difficult.
> >
> > I did some work on supporting split-dwarf months ago, but got
> > sidetracked with other work, BTF related and then the code bitrotted, I
> > have to go back looking at it to swap back the details into my brain:
> >
> > https://git.kernel.org/pub/scm/devel/pahole/pahole.git/log/?h=alt_dwarf
> >
> > The patches after:
> >
> > 45c044860c2abce7 dwarf_loader: Sync with LINUX_ELFNOTE_LTO_INFO macro from kernel
> >
> > Are the ones to suport alt dwarf.
> 
> I will read into those thanks.

Hopefully what you've been work ends up less convoluted by using
new elfutils functions, but it may be useful to help understand how the
internal pahole code deals with Dwarf offsets to reduce them to 32 bits
for conversion to CTF/BTF (where it is not really that important as
libbpf does this work).
 
> > > I am entirely unfamiliar with neither pahole nor libdw nor
> > > the dwarf file format. Thus it is very confusing when both pahole and
> > > dwarf library use very similar type names and structs. For example
> > > libdw has struct Dwarf_CU and pahole has unrelated dwarf_cu struct.
> >
> > > What are the differences between dwarf_nextcu(), dwarf_next_unit(),
> > > dwarf_get_units() and when should one use each one of them? (or nest
> > > them?)
> >
> > > Is a port of https://git.kernel.org/pub/scm/devel/pahole/pahole.git/tree/dwarf_loader.c?id=0135ccd632796ab3aff65b7c99b374c4682c2bcf
> > > to use dwarf_get_units() a right approach and would be welcomed?
> >
> > Yes, we need to support DWARF5 fully.

> ack
 
> > > Is anyone else interested in providing any help, or guidance?
> >
> > I'm interested, and I think if Mark could help it would be great as
> > well.
> 
> I have something that sort of works, but then like aboarts with
> invalid free's on exit - which the purist in me cares, but not sure if
> it is of practical value or not.
> And eu-readelf code also mentions that it deliberary leaks memory,
> because life is hard.

Off course ;-) Frees on exit are interesting to try to evaluate if
things that are not just frees on exit are leaking, when we're sure that
is the case, don't free on exit, as its just overhead.

> I will try to address or warn about memory leaks to see if stuff
> works, and post and RFC.

Great, thanks a lot for working on this!

- Arnaldo
