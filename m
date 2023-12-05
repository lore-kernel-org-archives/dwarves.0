Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1305F1FA
	for <dwarves@vger.kernel.org>; Tue,  5 Dec 2023 15:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ikldycaT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA42C433C8;
	Tue,  5 Dec 2023 15:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701791275;
	bh=HQq4YGog+LOH3kxdXhMLmgEr/xV5hXgAGelnepfH6Q4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ikldycaTJMvvsSTXgk1fWETOTwYxL+/MipNQXE9EZx4xFgH85QH1XtFuw7MWQYj8j
	 BrsebEcglYeoHzz5ARhhY8i/FHwzB41JNo/NIFlSKpIJ+sz6Y7bBwlajyQx8D8KuwB
	 lIXOEcvcg9cBR3ieWR7dtv6Z9ICb/iutlg6d6+E8xKYnwhlPMJ2dSWgazhdcwi662h
	 d5JFjOffWWZwge0G+4g8XRxvvWsOhuhpj7/mObUrBGl9uyVPIqL/WkPwkjPBmfq/1j
	 OuHOLsTajBs62qxrNmiqySlDpubXLnAIL037B03kkJ28lKkhi6yNzLC5HQvuKhV8le
	 rUXmoZSPoiGGQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 6F50940094; Tue,  5 Dec 2023 12:47:52 -0300 (-03)
Date: Tue, 5 Dec 2023 12:47:52 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Cc: dwarves@vger.kernel.org, elfutils-devel@sourceware.org, mark@klomp.org
Subject: Re: Porting pahole from dwarf_next_unit() to dwarf_get_units()
Message-ID: <ZW9GKNPpEU1M3vYp@kernel.org>
References: <CADWks+b06hpoBJpVdtd4HXdC0w24hObq0WOGCdfMGkpC7k=2vQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADWks+b06hpoBJpVdtd4HXdC0w24hObq0WOGCdfMGkpC7k=2vQ@mail.gmail.com>
X-Url: http://acmel.wordpress.com

Em Tue, Dec 05, 2023 at 01:03:01PM +0000, Dimitri John Ledkov escreveu:
> Currently pahole warns and does nothing upon hitting
> DW_TAG_skeleton_unit as implemented at
> https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?id=0135ccd632796ab3aff65b7c99b374c4682c2bcf
> 
> In elfutils, a while back a new API got added that aids with discovery
> and processing of such tags -
> https://sourceware.org/git/?p=elfutils.git;a=commitdiff;h=79f0e623dcde4b042bb72f636a2211d67d5c0ade
> 
> It seems to me if pahole is ported from using dwarf_next_unit() to
> instead use dwarf_get_units() native support can be added for
> split-dwarf (dwo) files.

That would be awesome!
 
> I am trying to write such a port, but it is proving to be very
> difficult.

I did some work on supporting split-dwarf months ago, but got
sidetracked with other work, BTF related and then the code bitrotted, I
have to go back looking at it to swap back the details into my brain:

https://git.kernel.org/pub/scm/devel/pahole/pahole.git/log/?h=alt_dwarf

The patches after:

45c044860c2abce7 dwarf_loader: Sync with LINUX_ELFNOTE_LTO_INFO macro from kernel

Are the ones to suport alt dwarf.

> I am entirely unfamiliar with neither pahole nor libdw nor
> the dwarf file format. Thus it is very confusing when both pahole and
> dwarf library use very similar type names and structs. For example
> libdw has struct Dwarf_CU and pahole has unrelated dwarf_cu struct.
 
> What are the differences between dwarf_nextcu(), dwarf_next_unit(),
> dwarf_get_units() and when should one use each one of them? (or nest
> them?)

> Is a port of https://git.kernel.org/pub/scm/devel/pahole/pahole.git/tree/dwarf_loader.c?id=0135ccd632796ab3aff65b7c99b374c4682c2bcf
> to use dwarf_get_units() a right approach and would be welcomed?

Yes, we need to support DWARF5 fully.
 
> Is anyone else interested in providing any help, or guidance?

I'm interested, and I think if Mark could help it would be great as
well.

- ARnaldo
