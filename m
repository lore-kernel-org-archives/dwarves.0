Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD3CC433FE
	for <linux-dwarves@archiver.kernel.org>; Tue, 11 Oct 2022 17:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiJKRQc (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 11 Oct 2022 13:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJKRQb (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Tue, 11 Oct 2022 13:16:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F6D36DE2
        for <dwarves@vger.kernel.org>; Tue, 11 Oct 2022 10:16:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE4276122C
        for <dwarves@vger.kernel.org>; Tue, 11 Oct 2022 17:16:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28065C433C1;
        Tue, 11 Oct 2022 17:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665508585;
        bh=M024kNMYCavMvVWlisaVy+/MwCVJdtsnQYWqQtNde1k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QRdXaltxEMm0J3a56ZUTOYxYelmOD2mk0c0t8JutyH23fU5HUH6l4TPdWZsDW2Ata
         DkUlos2XrN6HGxnh9/PCd9NCH+NIu3dkEhzkR3XssxpC95aD5Z0+vRZ9abKAUhh0JY
         nTvCKxcd89K9X2ZuN1e6Qa31kT1OJ1pHKGvs8qmx0DnGXvPhYAyBmXXRtJPi7ouZol
         5C/QcD8pPxQS9Ib4nqi7dBkTvtqE4daQvMV19vevdri9Xlze64xuMkvHQTgMroHwlz
         fzVNHm+5nwhaiTXiRQV2AullVKe/Y4jpXjuur+4O7vP6ETrIIOUSYGa/ViBVgrfIeh
         MsiY13MmRPyug==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AEFEA4062C; Tue, 11 Oct 2022 14:16:22 -0300 (-03)
Date:   Tue, 11 Oct 2022 14:16:22 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Yonghong Song <yhs@meta.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>,
        Yonghong Song <yhs@fb.com>, dwarves@vger.kernel.org,
        Nick Clifton <nickc@redhat.com>
Subject: Re: Encountered error while encoding BTF due to Unsupported
 DW_TAG_unspecified_type(0x3b)
Message-ID: <Y0Wk5i0Zz2saSKK3@kernel.org>
References: <CAEf4BzaonLxP77zj9ReaEWdZ-Whh4JUts3S5YO8v9vVuCfMdiQ@mail.gmail.com>
 <Yz8PBLflC2VDm9qw@kernel.org>
 <Y0CKQHhcTSWYqNpj@kernel.org>
 <166780df-a8ca-6dfb-88e9-9e489efc6bf7@meta.com>
 <Y0QK1nmVjqr95od1@kernel.org>
 <Y0R7uu3s/imnvPzM@kernel.org>
 <Y0R+U8i8mDPkOAw7@kernel.org>
 <002daef3-ce5e-e6f1-ec12-fe5f64ae2632@meta.com>
 <Y0VzbkffTg2TJ5i3@kernel.org>
 <ee52054a-bd76-2817-33c4-ffae00e72fb9@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee52054a-bd76-2817-33c4-ffae00e72fb9@meta.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Tue, Oct 11, 2022 at 08:33:34AM -0700, Yonghong Song escreveu:
> 
> 
> On 10/11/22 6:45 AM, Arnaldo Carvalho de Melo wrote:
> > Em Mon, Oct 10, 2022 at 10:57:24PM -0700, Yonghong Song escreveu:
> > > On 10/10/22 1:19 PM, Arnaldo Carvalho de Melo wrote:
> > > > > +++ b/btf_encoder.c
> > > > > @@ -593,6 +593,19 @@ static int32_t btf_encoder__add_func_param(struct btf_encoder *encoder, const ch
> > > > >    	}
> > > > >    }
> > > > > +static int32_t btf_encoder__tag_type(struct btf_encoder *encoder, uint32_t type_id_off, uint32_t tag_type)
> > > > > +{
> > > > > +	if (tag_type == 0)
> > > > > +		return 0;
> > > > > +
> > > > > +	if (encoder->cu->unspecified_type.tag && tag_type == encoder->cu->unspecified_type.type) {
> > > 
> > > Why we need tag_type == encoder->cu->unspecified_type.type?
> > > Should we unconditionally convert an unspecified_type to btf type id 0?
> > 
> > right, that is what is being done on that line, see,
> > DW_TAG_unspecified_type isn't some constant, what we have as the type in
> > functions in DWARF is the ID for that DW_TAG_unspecified_type for that
> > specific CU, see:

> >           <0><c>: Abbrev Number: 1 (DW_TAG_compile_unit)
> >              <d>   DW_AT_stmt_list   : 0
> >              <11>   DW_AT_low_pc      : 0
> >              <19>   DW_AT_high_pc     : 19
> >              <1a>   DW_AT_name        : (indirect string, offset: 0): arch/x86/entry/entry.S
> >              <1e>   DW_AT_comp_dir    : (indirect string, offset: 0x17): /root/git/linux
> >              <22>   DW_AT_producer    : (indirect string, offset: 0x27): GNU AS 2.39.50
> >              <26>   DW_AT_language    : 32769  (MIPS assembler)
> >           <1><28>: Abbrev Number: 2 (DW_TAG_subprogram)
> >              <29>   DW_AT_name        : (indirect string, offset: 0x36): entry_ibpb
> >              <2d>   DW_AT_external    : 1
> >              <2d>   DW_AT_type        : <0x37>
> >              <2e>   DW_AT_low_pc      : 0
> >              <36>   DW_AT_high_pc     : 19
> >           <1><37>: Abbrev Number: 3 (DW_TAG_unspecified_type)
> >           <1><38>: Abbrev Number: 0

> > Look at the info for entry_ibpb, there is no DW_TAG_unspecified_type
> > there, what it has is 0x37 as its type. We have to go see what that type
> > is, it could be DW_TAG_pointer_type with a DW_AT_type pointing to the
> > real type (or a series of references via DW_TAG_const_type,
> > DW_TAG_volatile_type, etc).

> > So in the DWARF loader we record if we have a DW_TAG_unspecified_type in
> > the current CU and what is its "small id", which won't be 0x37, as we
> > use an array for types, to compress the ID space.

> > Then, at the btf_encoding phase we look at functions type, and if it
> > matches the DW_TAG_unspecified_type type for that specific CU, then we
> > convert it to void.
 
> Thanks for explanation. Now I understand.
 
> encoder->cu->unspecified_type.tag indicates that at cu level, we have an
> unspecified type.
 
> encoder->cu->unspecified_type.type records the unspecified_type small_id. I
> assume this should be okay since compiler did dedup
> within the cu so we should have only one unspecified type per cu.

Yes, that is my assumption as well, that a CU will have just one
DW_TAG_unspecified_type, lemme confirm this by finding some other ASM
CU with more than one "function".
 
> tag_type == encoder->cu->unspecified_type.type ensures the
> current btf type should expect the unspecified type before it
> can be considered as an unspecified type.

> Acked-by: Yonghong Song <yhs@fb.com>

Thanks!

- Arnaldo
