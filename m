Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="hRsPGuiL"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A291A4
	for <dwarves@vger.kernel.org>; Tue,  5 Dec 2023 08:11:44 -0800 (PST)
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 520143FDF0
	for <dwarves@vger.kernel.org>; Tue,  5 Dec 2023 16:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1701792703;
	bh=YErL9PrxlMFQTZuu9uUYgnrKFq5bDwB2Gw0gdqbiQPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=hRsPGuiLwdM64Rwyx74Tyn1yfAiPP2Gm9TXIZtHCgfWCjCxa/juxvoNiP4MVxpMpN
	 O+XzUIrpWlArsklabiSttyFcJ5IbvBfnkZZol/fHaq5hJu2QIu94GFtP6ai1MEll9A
	 lgcigwB8FRxA5EDpWSZwUWgl+jCZ3UDP9NzUY+GCNHW8+5kYdKRkX3gGxtMtH1wXAH
	 1noREytVwhpTTEvz+jCwhuDTBEBhrA8gqp+O3GeH6nKZVvpliDYpdVLAuDU4AqMBl6
	 J1OHV98WQ1A9SMDCsvPfwcGaAnW6/FtuMSaT1ujceODenNrJnI+GcNYHifAwlXDT3c
	 o2UAY8Zu3MDFQ==
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33340d20b90so2537573f8f.2
        for <dwarves@vger.kernel.org>; Tue, 05 Dec 2023 08:11:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701792703; x=1702397503;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YErL9PrxlMFQTZuu9uUYgnrKFq5bDwB2Gw0gdqbiQPg=;
        b=Ezax48M/SA9gtvKbRQs3TXxn+jn4Wva4y9FQ4rQehrDm2Sgldw22Q7OyydsqbUQ5++
         mV4VUr6awQtaH4J4ffR8ShfuRH0xN4annjSlJ8ClondllZAEaq8am9kWGNvxOWgGamGp
         xT1uIM5ubNgKFSUYdK/bLuC3XS2AYo4prnkbwL73ZInq7d6lwTmRg1KvYBO1paLGH05+
         wK277wGzlYmINDN6S65PWZQ9v0Jl8IaulWeNg18OQT86mJtnRaQ9H4L6CnmCVJRsKGFX
         +ybEftSPyQ8CQIgWcbeig+oNmKl5dtbSbjd7i6sQ5/cHTIImycyaMuPeRnoclDCAYYit
         G2AA==
X-Gm-Message-State: AOJu0Yx3CWQiFnZq0dyVC1YLAzvvz02/XoBpApNxDYiNEr31TiI6pqGk
	mGWHUCV6qhsLDX/wNCguatM5NZfo6mFAcRvw++YugTfL+RFU+chAgwzVeHXgwjeYlaNMhh3jBKA
	40jf0JCM1alpf00U/2rrPSVXQY5EqwscZvvecGxWkj0dsbvtQGCvVoIx8irE=
X-Received: by 2002:a05:6000:145:b0:333:3f8c:d38b with SMTP id r5-20020a056000014500b003333f8cd38bmr2959170wrx.84.1701792702848;
        Tue, 05 Dec 2023 08:11:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFYF2OXHD0rFx4gwGWJxAc8w5csY+VaBjnGx0IyWYuOXBtlm1r9+9NJCNdIduT1B3cl+PegB7X0oyg9A/0wbRE=
X-Received: by 2002:a05:6000:145:b0:333:3f8c:d38b with SMTP id
 r5-20020a056000014500b003333f8cd38bmr2959157wrx.84.1701792702554; Tue, 05 Dec
 2023 08:11:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADWks+b06hpoBJpVdtd4HXdC0w24hObq0WOGCdfMGkpC7k=2vQ@mail.gmail.com>
 <ZW9GKNPpEU1M3vYp@kernel.org>
In-Reply-To: <ZW9GKNPpEU1M3vYp@kernel.org>
From: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Date: Tue, 5 Dec 2023 16:11:06 +0000
Message-ID: <CADWks+bxFgT0e8vA0MaX2aXsLDzawU2kyhiOXBm_bP3UOxw_dA@mail.gmail.com>
Subject: Re: Porting pahole from dwarf_next_unit() to dwarf_get_units()
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: dwarves@vger.kernel.org, elfutils-devel@sourceware.org, mark@klomp.org
Content-Type: text/plain; charset="UTF-8"

I

On Tue, 5 Dec 2023, 15:47 Arnaldo Carvalho de Melo, <acme@kernel.org> wrote:
>
> Em Tue, Dec 05, 2023 at 01:03:01PM +0000, Dimitri John Ledkov escreveu:
> > Currently pahole warns and does nothing upon hitting
> > DW_TAG_skeleton_unit as implemented at
> > https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?id=0135ccd632796ab3aff65b7c99b374c4682c2bcf
> >
> > In elfutils, a while back a new API got added that aids with discovery
> > and processing of such tags -
> > https://sourceware.org/git/?p=elfutils.git;a=commitdiff;h=79f0e623dcde4b042bb72f636a2211d67d5c0ade
> >
> > It seems to me if pahole is ported from using dwarf_next_unit() to
> > instead use dwarf_get_units() native support can be added for
> > split-dwarf (dwo) files.
>
> That would be awesome!
>
> > I am trying to write such a port, but it is proving to be very
> > difficult.
>
> I did some work on supporting split-dwarf months ago, but got
> sidetracked with other work, BTF related and then the code bitrotted, I
> have to go back looking at it to swap back the details into my brain:
>
> https://git.kernel.org/pub/scm/devel/pahole/pahole.git/log/?h=alt_dwarf
>
> The patches after:
>
> 45c044860c2abce7 dwarf_loader: Sync with LINUX_ELFNOTE_LTO_INFO macro from kernel
>
> Are the ones to suport alt dwarf.

I will read into those thanks.

>
> > I am entirely unfamiliar with neither pahole nor libdw nor
> > the dwarf file format. Thus it is very confusing when both pahole and
> > dwarf library use very similar type names and structs. For example
> > libdw has struct Dwarf_CU and pahole has unrelated dwarf_cu struct.
>
> > What are the differences between dwarf_nextcu(), dwarf_next_unit(),
> > dwarf_get_units() and when should one use each one of them? (or nest
> > them?)
>
> > Is a port of https://git.kernel.org/pub/scm/devel/pahole/pahole.git/tree/dwarf_loader.c?id=0135ccd632796ab3aff65b7c99b374c4682c2bcf
> > to use dwarf_get_units() a right approach and would be welcomed?
>
> Yes, we need to support DWARF5 fully.

ack

>
> > Is anyone else interested in providing any help, or guidance?
>
> I'm interested, and I think if Mark could help it would be great as
> well.

I have something that sort of works, but then like aboarts with
invalid free's on exit - which the purist in me cares, but not sure if
it is of practical value or not.
And eu-readelf code also mentions that it deliberary leaks memory,
because life is hard.
I will try to address or warn about memory leaks to see if stuff
works, and post and RFC.

Regards,

Dimitri.
