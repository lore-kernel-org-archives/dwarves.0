Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF042C433FE
	for <linux-dwarves@archiver.kernel.org>; Tue,  4 Oct 2022 13:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbiJDN1c (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 4 Oct 2022 09:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbiJDN1O (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Tue, 4 Oct 2022 09:27:14 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0440E631C7
        for <dwarves@vger.kernel.org>; Tue,  4 Oct 2022 06:25:37 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id x124so6509889vsb.13
        for <dwarves@vger.kernel.org>; Tue, 04 Oct 2022 06:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date;
        bh=OVqi+EVAK6EkcIAe4qK2Q/bPPD2UmJMPKONHVRkZPTY=;
        b=Fkt23fDeIuRpKg18VMRbTg7OB/PtVjGVIuqoYEnCb58ycuGFiTCiHQbNPqbs6+RkCW
         K99QDNzpk4c7l2mnWBZfm0D8QmEB5qvf1M674+e7w6D7AwOBZ99N2YhVQq1G43ZhwyHj
         ImYJU5KPfJE2oX5h0g7oy6+AE+k6612oBZhBgPk8UuuGfk3N8bv5xt0W0CPaloXlQijr
         Tfb2I8xtl71d9JnmZbcWSuurh4C9goXn7AEbxKXhfZvbwaTiuqCAnZtzscsiKSEgBG0U
         suBIPGGDys4mSM6Ig5NZyh+lVXXdBZXXmVEAgOJI9nd8ZdFnlllg2Oe1DhXCShwSJGRo
         bwaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=OVqi+EVAK6EkcIAe4qK2Q/bPPD2UmJMPKONHVRkZPTY=;
        b=uPvKAO4bofC0c3o7eogt6qF33cZb/AqTlcLUXGDmwOe5Ak4exmwxwRSlBwVW7IyDeV
         P4Sqo/nOHXDLuGYxpAJILGYaZ/V/h6a18eKmwnL0A8GcriIgDtTGpQAkHkgOVBUzOYUI
         5nylHtMsCp99Xo4g0hNFUtdrBH1ooVn1GOe+RajRNQCIZKX+nM/OFx05vsktEzjpdpHC
         K+rnx8zF2OK+7wyJVw4gZZfLg8gGw+1nwTMnyflNq9S6T9o+wDNF/Mie21iKsCoNYWBI
         flYjiBwHXLjieiqQx3BFdmoa15cdIgJaIQ3FNOJOEHwgmD4J/cQuqAtYHFIuwTeNUfbV
         ElDw==
X-Gm-Message-State: ACrzQf3mYsQsOlgb0Vc+6JDthyzAfnyQ9mFSakemGFS7IcO2wHMhr9DG
        D/2L2P94mX2gm9ZRG2C0GFo=
X-Google-Smtp-Source: AMsMyM7+j8HmpHPqI4ygioPfGm1Jt2w2OM1ojfEOaA3aS/Ao4zEe4ZdpIsbEMNyu7eEftMzScxY2Pw==
X-Received: by 2002:a05:6102:721:b0:3a6:cdf8:5fde with SMTP id u1-20020a056102072100b003a6cdf85fdemr105689vsg.61.1664889936657;
        Tue, 04 Oct 2022 06:25:36 -0700 (PDT)
Received: from ?IPv6:::1? ([2804:14d:128a:85a9:f130:d296:d4d0:e617])
        by smtp.gmail.com with ESMTPSA id p22-20020a056102275600b003a6842b4c44sm3319059vsu.11.2022.10.04.06.25.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 06:25:36 -0700 (PDT)
Date:   Tue, 04 Oct 2022 10:25:31 -0300
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To:     Nick Clifton <nickc@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        =?UTF-8?Q?Martin_Li=C5=A1ka?= <mliska@suse.cz>,
        Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     dwarves@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_Encountered_error_while_encoding_BTF_due?= =?US-ASCII?Q?_to_Unsupported_DW=5FTAG=5Funspecified=5Ftype=280x3b=29?=
User-Agent: K-9 Mail for Android
In-Reply-To: <503357c8-39ad-8417-d55c-be6c04fbb27e@redhat.com>
References: <878d0959-7f80-471e-69d5-5228822b4365@suse.cz> <YzwkazNc6wNCpQTN@kernel.org> <503357c8-39ad-8417-d55c-be6c04fbb27e@redhat.com>
Message-ID: <81431BB6-D014-4623-BE8D-9BBB457EB687@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org



On October 4, 2022 9:33:05 AM GMT-03:00, Nick Clifton <nickc@redhat=2Ecom>=
 wrote:
>Hi Arnaldo,
>
>>>   <0><c>: Abbrev Number: 3 (DW_TAG_unspecified_type) <--- the problema=
tic TAG
>
>>>   <1><29>: Abbrev Number: 2 (DW_TAG_subprogram)
>>>      <2a>   DW_AT_name        : (indirect string, offset: 0x2e): entry=
_ibpb
>>>      <2e>   DW_AT_type        : <0xc>
>
>If it helps the tag is used to tell consumers like GDB that the return
>type of specific functions (eg entry_ibpb in the above example) is unknow=
n=2E


Sure helps, thanks!

I noticed this is for assembly source code, I'll add it as a special "type=
" and probably for BTF mask it to void=2E

- Arnaldo=20

>
>Cheers
>  Nick
>
