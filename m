Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6727C433F5
	for <linux-dwarves@archiver.kernel.org>; Tue,  4 Oct 2022 21:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbiJDVOK (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 4 Oct 2022 17:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiJDVOH (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Tue, 4 Oct 2022 17:14:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1AD6C76F
        for <dwarves@vger.kernel.org>; Tue,  4 Oct 2022 14:14:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D694EB81BCF
        for <dwarves@vger.kernel.org>; Tue,  4 Oct 2022 21:14:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D169C433D6;
        Tue,  4 Oct 2022 21:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664918039;
        bh=AMgNkt59pnc+e/fuRQXmaX3MoyWltPOhrus+SGvLXkU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kT+AzH27Kx4joe3cjX/JX1Ywi7C+hHBQ2Ht5TP86XS//WpAvSVPm3RcUv+fEiTkCj
         e1nKF79sNCjurqLwZqu7HHJJEafxLVW6qR4C0Z6Y8eh/EmNKLn6M8iBhkvZ5yVixwX
         SCeiexzn0mmdzZD8SaTOIgPvV0oy7pEGLBtR3B2VqLRgveOa8zPsiDvFYnXzpTDbwY
         i/hV6ZfPz8+eZe8GqHcxB2ANhsPb+cs/VsGjcfJIQTM3/id7LO6eaXBu2h+S2ynwHe
         6RiXFBvFY5M27Hvubo9L7Eu/pHpu7Olc1Pj3M/DwA8rUOemqA4fnJFKu75p1/kewnO
         11APcsxisnCBw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EE6E14062C; Tue,  4 Oct 2022 18:13:56 -0300 (-03)
Date:   Tue, 4 Oct 2022 18:13:56 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Nick Clifton <nickc@redhat.com>,
        Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>,
        Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        dwarves@vger.kernel.org
Subject: Re: Encountered error while encoding BTF due to Unsupported
 DW_TAG_unspecified_type(0x3b)
Message-ID: <YzyiFORKy6zk6EsL@kernel.org>
References: <878d0959-7f80-471e-69d5-5228822b4365@suse.cz>
 <YzwkazNc6wNCpQTN@kernel.org>
 <503357c8-39ad-8417-d55c-be6c04fbb27e@redhat.com>
 <81431BB6-D014-4623-BE8D-9BBB457EB687@gmail.com>
 <Yzx2fcq4s3umw8WY@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yzx2fcq4s3umw8WY@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Tue, Oct 04, 2022 at 03:07:57PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Oct 04, 2022 at 10:25:31AM -0300, Arnaldo Carvalho de Melo escreveu:
> > On October 4, 2022 9:33:05 AM GMT-03:00, Nick Clifton <nickc@redhat.com> wrote:
> > >Hi Arnaldo,
> > >
> > >>>   <0><c>: Abbrev Number: 3 (DW_TAG_unspecified_type) <--- the problematic TAG
> > >
> > >>>   <1><29>: Abbrev Number: 2 (DW_TAG_subprogram)
> > >>>      <2a>   DW_AT_name        : (indirect string, offset: 0x2e): entry_ibpb
> > >>>      <2e>   DW_AT_type        : <0xc>
> > >
> > >If it helps the tag is used to tell consumers like GDB that the return
> > >type of specific functions (eg entry_ibpb in the above example) is unknown.
>  
> > Sure helps, thanks!
>  
> > I noticed this is for assembly source code, I'll add it as a special
> > "type" and probably for BTF mask it to void.
> 
> s/mask/map/g

I just committed the patch below, now to support
DW_TAG_unspecified_type...

- Arnaldo

commit 79d9a783ea74797aa4304009e0cf1bdb9235fcf4
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Tue Oct 4 18:09:33 2022 -0300

    pahole: Support '--lang/--lang_exclude=asm'
    
    It is disjoint from the other languages and then the first simple
    implementation of language inclusion/exclusion didn't support it, add
    an special case to test against 0x8001 (DW_LANG_Mips_Assembler) to cover
    that.
    
    This is needed as recently compilers started to add DWARF constructs to
    represent asm CUs that broke pahole as it didn't support
    DW_TAG_unspecified_type as a "type", so add it in case in the future we
    want to exclude such CUs.
    
    The DW_TAG_unspecified_type tag is going to be supported in the next
    csets tho.
    
    We also may want this to exclude new tags that aren't supported in BTF,
    etc.
    
    Cc: Martin Liška <mliska@suse.cz>
    Cc: Nick Clifton <nickc@redhat.com>
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/dwarves.c b/dwarves.c
index 9589747f49f8f3a7..0405592ce0a540a5 100644
--- a/dwarves.c
+++ b/dwarves.c
@@ -2240,6 +2240,9 @@ int lang__str2int(const char *lang)
 	[DW_LANG_UPC]		 = "upc",
 	};
 
+	if (strcasecmp(lang, "asm") == 0)
+		return DW_LANG_Mips_Assembler;
+
 	// c89 is the first, bliss is the last, see /usr/include/dwarf.h
 	for (int id = DW_LANG_C89; id <= DW_LANG_BLISS; ++id)
 		if (languages[id] && strcasecmp(lang, languages[id]) == 0)
diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
index d752ccbeb297d9d7..45a21af500d94772 100644
--- a/man-pages/pahole.1
+++ b/man-pages/pahole.1
@@ -378,7 +378,7 @@ Only process compilation units built from source code written in the specified l
 
 Supported languages:
 
-  ada83, ada95, bliss, c, c89, c99, c11, c++, c++03, c++11, c++14, cobol74,
+  ada83, ada95, asm, bliss, c, c89, c99, c11, c++, c++03, c++11, c++14, cobol74,
   cobol85, d, dylan, fortran77, fortran90, fortran95, fortran03, fortran08,
   go, haskell, java, julia, modula2, modula3, objc, objc++, ocaml, opencl,
   pascal83, pli, python, renderscript, rust, swift, upc
