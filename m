Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F50C433F5
	for <linux-dwarves@archiver.kernel.org>; Tue,  4 Oct 2022 21:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbiJDVpq (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 4 Oct 2022 17:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbiJDVpZ (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Tue, 4 Oct 2022 17:45:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192F36DFAE
        for <dwarves@vger.kernel.org>; Tue,  4 Oct 2022 14:42:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 90D0BB81BFA
        for <dwarves@vger.kernel.org>; Tue,  4 Oct 2022 21:42:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2689CC433D7;
        Tue,  4 Oct 2022 21:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664919734;
        bh=Ysjb36Q7axe+FwNsDo0Z8ZuCg2m+F6VxnztA4iVAsMo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qVR3m3Xk7dgV1u/RuSDPD+cPpbzw8WzCWQw2BdIhCgkZNvoCNclEPCxX/6T9Ns+t6
         giCuJhxp1v1Bp4nHB/maY0P0dKhaeoWzLF2F4jYlMTSJMQqUq4vY/KP/qeSpE2LHup
         0W95vMRJqo03h4gXn5MTqTmw+oD+VbjRhRr2lsaeoHo0jBEj94/aIWR5HptvJDm5xu
         HgNU0KRo4Iq5aO/kUi/cQH4MhFwH+k3jBj3NiZM5K/SupFXCip2ARqPmrl7/1bm6Ca
         IEDSqpEeiznDKua1l5tuA3DV1lIK+su7sapyxLCU3J/K9FNFaCb4mrPirjDxrxSAr1
         XpkI50Ztzb0Ww==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EC0734062C; Tue,  4 Oct 2022 18:42:11 -0300 (-03)
Date:   Tue, 4 Oct 2022 18:42:11 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>,
        Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     dwarves@vger.kernel.org, Nick Clifton <nickc@redhat.com>
Subject: Re: Encountered error while encoding BTF due to Unsupported
 DW_TAG_unspecified_type(0x3b)
Message-ID: <Yzyos3rcOTjOZ0kZ@kernel.org>
References: <878d0959-7f80-471e-69d5-5228822b4365@suse.cz>
 <YzwkazNc6wNCpQTN@kernel.org>
 <Yzwnk/a1ROHrtA2/@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yzwnk/a1ROHrtA2/@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Tue, Oct 04, 2022 at 09:31:15AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Oct 04, 2022 at 09:17:47AM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Mon, Oct 03, 2022 at 10:56:36AM +0200, Martin Liška escreveu:
> > > I noticed one can't build 5.19 with latest binutils master.

> > > One see the following error:
> > > [ 1413s]   BTF     .btf.vmlinux.bin.o
> > > [ 1413s] Unsupported DW_TAG_unspecified_type(0x3b)
> > > [ 1413s] Encountered error while encoding BTF.
> > > 
> > > It's caused by DWARF coming from .S files and the change is introduced since
> > > the following binutils revision:
> > > 
> > > commit 5578fbf672ee497ea19826edeb509f4cc3e825a8
> > > Author: Nick Clifton <nickc@redhat.com>
> > > Date:   Thu Aug 25 11:48:00 2022 +0100
> > > 
> > >     GAS: Add a return type tag to DWARF DIEs generated for function symbols.

> > > for entry.S the output changes to:

> > > $ as-new --gdwarf-5 --64 -o entry.o entry.S && readelf -wi entry.o
> > > Contents of the .debug_info section:

> > >   Compilation Unit @ offset 0x0:
> > >    Version:       5
> > >    Unit Type:     DW_UT_compile (1)
> > >    Abbrev Offset: 0x0
> > >  <0><c>: Abbrev Number: 3 (DW_TAG_unspecified_type) <--- the problematic TAG
> > >  <0><d>: Abbrev Number: 1 (DW_TAG_compile_unit)
> > >     <e>   DW_AT_stmt_list   : 0x0
> > >     <12>   DW_AT_low_pc      : 0x0
> > >     <1a>   DW_AT_high_pc     : 19
> > >     <1b>   DW_AT_name        : (indirect string, offset: 0x0): ../arch/x86/entry/entry.S
> > >     <1f>   DW_AT_comp_dir    : (indirect string, offset: 0x1a): /tmp
> > >     <23>   DW_AT_producer    : (indirect string, offset: 0x1f): GNU AS 2.39.50
> > >     <27>   DW_AT_language    : 32769	(MIPS assembler)
> > >  <1><29>: Abbrev Number: 2 (DW_TAG_subprogram)
> > >     <2a>   DW_AT_name        : (indirect string, offset: 0x2e): entry_ibpb
> > >     <2e>   DW_AT_external    : 1
> > >     <2e>   DW_AT_type        : <0xc>

> > Ok, it happens at the top level of a CU and there are users for it, now
> > to try to figure out how to best support this in the pretty printer,
> > DWARF loader and BTF encoder.

> And it is for an assembly routine, which clarifies things a bit more,
> Andrii, Yonghong, should we try to encode BTF for assembly? Or just
> skip it?

So, I added the one below to the next branch[1], unsure if the kernel
verifier will choke on it.

- Arnaldo

[1] git://git.kernel.org/pub/scm/devel/pahole/pahole.git next

This is a test branch, may or not go to master, CI uses it for testing
once a day.

From 81519586f00836841538d3ca097588db6fc2c7a5 Mon Sep 17 00:00:00 2001
From: Arnaldo Carvalho de Melo <acme@redhat.com>
Date: Tue, 4 Oct 2022 18:22:53 -0300
Subject: [PATCH 1/1] btf_encoder: Encode DW_TAG_unspecified_type as
 BTF_KIND_UNKN

This first appeared for assembler files in the Linux kernel with recent
GNU compilers, we don't have anything in BTF, AFAIK, to properly
represent that, so, for now, lets go with BTF_KIND_UNKN.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 btf_encoder.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/btf_encoder.c b/btf_encoder.c
index 7ad3f29ef153d8d6..adc01396df6098d8 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -962,6 +962,8 @@ static int btf_encoder__encode_tag(struct btf_encoder *encoder, struct tag *tag,
 		return btf_encoder__add_enum_type(encoder, tag, conf_load);
 	case DW_TAG_subroutine_type:
 		return btf_encoder__add_func_proto(encoder, tag__ftype(tag), type_id_off);
+	case DW_TAG_unspecified_type:
+		return btf_encoder__add_ref_type(encoder, BTF_KIND_UNKN, 0, NULL, false);
 	default:
 		fprintf(stderr, "Unsupported DW_TAG_%s(0x%x): type: 0x%x\n",
 			dwarf_tag_name(tag->tag), tag->tag, ref_type_id);
-- 
2.37.3

