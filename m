Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89EDFC433F5
	for <linux-dwarves@archiver.kernel.org>; Tue, 11 Oct 2022 13:45:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiJKNp2 (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 11 Oct 2022 09:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiJKNp1 (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Tue, 11 Oct 2022 09:45:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C513C6BD6F
        for <dwarves@vger.kernel.org>; Tue, 11 Oct 2022 06:45:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5B51EB815A9
        for <dwarves@vger.kernel.org>; Tue, 11 Oct 2022 13:45:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0AB0C433C1;
        Tue, 11 Oct 2022 13:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665495922;
        bh=IS543VmoDDgiboI2wWeGBp6gB7mdZSEbuhZFsJ7+310=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SHpMvzcjH62jCF7CGzU56P6gYQ8ZJ1FLP4Tfjiw415XW4zpC2z3Pi+IcIbS7h4GDf
         1SmASsT1piM6jbjLOPZD0uDcQaLbmPZNB33vdTkL0+s+yngiWHTQPG9aUFBZoH0/Ba
         a0H1WTgmbrBUUT1I/U9qxJvRONksT27rMcGT4AG1K3ts4o3WVSiH4x87ajOdTXumi3
         DVgB65mJLdvZB07yueEoVk4QNxNIrFjiS4EZMizRB9gsaZD54kuOyMn/ZWzxnFbAqG
         3LU3He6n6NdyW3oi1sezqvubWmKSQ0Sl94vEirQXRa1xjg170QbTYPrskqUp2iV47g
         Hl4/Z1wj6Xgrg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DE6624062C; Tue, 11 Oct 2022 10:45:18 -0300 (-03)
Date:   Tue, 11 Oct 2022 10:45:18 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Yonghong Song <yhs@meta.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>,
        Yonghong Song <yhs@fb.com>, dwarves@vger.kernel.org,
        Nick Clifton <nickc@redhat.com>
Subject: Re: Encountered error while encoding BTF due to Unsupported
 DW_TAG_unspecified_type(0x3b)
Message-ID: <Y0VzbkffTg2TJ5i3@kernel.org>
References: <Yz7bevBJAm0JiLfp@kernel.org>
 <Yz7fdFPTpwALxvak@kernel.org>
 <CAEf4BzaonLxP77zj9ReaEWdZ-Whh4JUts3S5YO8v9vVuCfMdiQ@mail.gmail.com>
 <Yz8PBLflC2VDm9qw@kernel.org>
 <Y0CKQHhcTSWYqNpj@kernel.org>
 <166780df-a8ca-6dfb-88e9-9e489efc6bf7@meta.com>
 <Y0QK1nmVjqr95od1@kernel.org>
 <Y0R7uu3s/imnvPzM@kernel.org>
 <Y0R+U8i8mDPkOAw7@kernel.org>
 <002daef3-ce5e-e6f1-ec12-fe5f64ae2632@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <002daef3-ce5e-e6f1-ec12-fe5f64ae2632@meta.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Mon, Oct 10, 2022 at 10:57:24PM -0700, Yonghong Song escreveu:
> On 10/10/22 1:19 PM, Arnaldo Carvalho de Melo wrote:
> > > +++ b/btf_encoder.c
> > > @@ -593,6 +593,19 @@ static int32_t btf_encoder__add_func_param(struct btf_encoder *encoder, const ch
> > >   	}
> > >   }
> > > +static int32_t btf_encoder__tag_type(struct btf_encoder *encoder, uint32_t type_id_off, uint32_t tag_type)
> > > +{
> > > +	if (tag_type == 0)
> > > +		return 0;
> > > +
> > > +	if (encoder->cu->unspecified_type.tag && tag_type == encoder->cu->unspecified_type.type) {
> 
> Why we need tag_type == encoder->cu->unspecified_type.type?
> Should we unconditionally convert an unspecified_type to btf type id 0?

right, that is what is being done on that line, see,
DW_TAG_unspecified_type isn't some constant, what we have as the type in
functions in DWARF is the ID for that DW_TAG_unspecified_type for that
specific CU, see:

         <0><c>: Abbrev Number: 1 (DW_TAG_compile_unit)
            <d>   DW_AT_stmt_list   : 0
            <11>   DW_AT_low_pc      : 0
            <19>   DW_AT_high_pc     : 19
            <1a>   DW_AT_name        : (indirect string, offset: 0): arch/x86/entry/entry.S
            <1e>   DW_AT_comp_dir    : (indirect string, offset: 0x17): /root/git/linux
            <22>   DW_AT_producer    : (indirect string, offset: 0x27): GNU AS 2.39.50
            <26>   DW_AT_language    : 32769  (MIPS assembler)
         <1><28>: Abbrev Number: 2 (DW_TAG_subprogram)
            <29>   DW_AT_name        : (indirect string, offset: 0x36): entry_ibpb
            <2d>   DW_AT_external    : 1
            <2d>   DW_AT_type        : <0x37>
            <2e>   DW_AT_low_pc      : 0
            <36>   DW_AT_high_pc     : 19
         <1><37>: Abbrev Number: 3 (DW_TAG_unspecified_type)
         <1><38>: Abbrev Number: 0

Look at the info for entry_ibpb, there is no DW_TAG_unspecified_type
there, what it has is 0x37 as its type. We have to go see what that type
is, it could be DW_TAG_pointer_type with a DW_AT_type pointing to the
real type (or a series of references via DW_TAG_const_type,
DW_TAG_volatile_type, etc).

So in the DWARF loader we record if we have a DW_TAG_unspecified_type in
the current CU and what is its "small id", which won't be 0x37, as we
use an array for types, to compress the ID space.

Then, at the btf_encoding phase we look at functions type, and if it
matches the DW_TAG_unspecified_type type for that specific CU, then we
convert it to void.

- Arnaldo
 
> > > +		// No provision for encoding this, turn it into void.
> > > +		return 0;
> > > +	}
> > > +
> > > +	return type_id_off + tag_type;
> > > +}
> > > +
> > >   static int32_t btf_encoder__add_func_proto(struct btf_encoder *encoder, struct ftype *ftype, uint32_t type_id_off)
> > >   {
> > >   	struct btf *btf = encoder->btf;
> > > @@ -603,7 +616,7 @@ static int32_t btf_encoder__add_func_proto(struct btf_encoder *encoder, struct f
> > >   	/* add btf_type for func_proto */
> > >   	nr_params = ftype->nr_parms + (ftype->unspec_parms ? 1 : 0);
> > > -	type_id = ftype->tag.type == 0 ? 0 : type_id_off + ftype->tag.type;
> > > +	type_id = btf_encoder__tag_type(encoder, type_id_off, ftype->tag.type);
> > >   	id = btf__add_func_proto(btf, type_id);
> > >   	if (id > 0) {
> > > @@ -966,6 +979,15 @@ static int btf_encoder__encode_tag(struct btf_encoder *encoder, struct tag *tag,
> > >   		return btf_encoder__add_enum_type(encoder, tag, conf_load);
> > >   	case DW_TAG_subroutine_type:
> > >   		return btf_encoder__add_func_proto(encoder, tag__ftype(tag), type_id_off);
> > > +        case DW_TAG_unspecified_type:
> > > +		/* Just don't encode this for now, converting anything with this type to void (0) instead.
> > > +		 *
> > > +		 * If we end up needing to encode this, one possible hack is to do as follows, as "const void".
> > > +		 *
> > > +		 * Returning zero means we skipped encoding a DWARF type.
> > > +		 */
> > > +               // btf_encoder__add_ref_type(encoder, BTF_KIND_CONST, 0, NULL, false);
> > > +               return 0;
> > >   	default:
> > >   		fprintf(stderr, "Unsupported DW_TAG_%s(0x%x): type: 0x%x\n",
> > >   			dwarf_tag_name(tag->tag), tag->tag, ref_type_id);
> > > @@ -1487,7 +1509,7 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
> > >   {
> > >   	uint32_t type_id_off = btf__type_cnt(encoder->btf) - 1;
> > >   	struct llvm_annotation *annot;
> > > -	int btf_type_id, tag_type_id;
> > > +	int btf_type_id, tag_type_id, skipped_types = 0;
> > >   	uint32_t core_id;
> > >   	struct function *fn;
> > >   	struct tag *pos;
> > > @@ -1510,8 +1532,13 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
> > >   	cu__for_each_type(cu, core_id, pos) {
> > >   		btf_type_id = btf_encoder__encode_tag(encoder, pos, type_id_off, conf_load);
> > > +		if (btf_type_id == 0) {
> > > +			++skipped_types;
> > > +			continue;
> > > +		}
> > > +
> > >   		if (btf_type_id < 0 ||
> > > -		    tag__check_id_drift(pos, core_id, btf_type_id, type_id_off)) {
> > > +		    tag__check_id_drift(pos, core_id, btf_type_id + skipped_types, type_id_off)) {
> > >   			err = -1;
> > >   			goto out;
> > >   		}
> > 

-- 

- Arnaldo
