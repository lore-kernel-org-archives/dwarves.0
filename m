Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2899BC433EF
	for <linux-dwarves@archiver.kernel.org>; Tue, 14 Dec 2021 19:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbhLNTOH (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 14 Dec 2021 14:14:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbhLNTOH (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Tue, 14 Dec 2021 14:14:07 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033A0C061574
        for <dwarves@vger.kernel.org>; Tue, 14 Dec 2021 11:14:07 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id p19so19374207qtw.12
        for <dwarves@vger.kernel.org>; Tue, 14 Dec 2021 11:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:user-agent:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=0Ac/hz3C9T5rtwuvgzh3/KBuz46fntSFbDp10hSLg4k=;
        b=lr5Lt+MqqSVwQmwUAFVmhmrDOydW5apxfhtU9lMh6L1VQ1Dsk+HA1vrmmXfgmp1MY2
         WKv1mDk9BHQ+TT7OzR7tr2Jo2eW3FLsF9LY6+mwRL7XwuYYgDI1l0CV3vxpqxKpQbiPB
         uIKjL0avVh8cAsUNuEPhwdmMwqUQw+/GKZPAI9H68TdY3VoofuePddtCbQuD51Pgub9v
         Q4KHAAQz4D1okEpi6bAhoMfYpMEQtYenehNFOBel88tNQUaRYdcNgHaWHS22aIYdDZT5
         BM3Q2B3QnFFJRfS6P/MiPFcyyGbIIdEaySv+iAO4D1d1cHPfhGuES3XJFztklrIFCN2v
         kHNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=0Ac/hz3C9T5rtwuvgzh3/KBuz46fntSFbDp10hSLg4k=;
        b=ofVJ/vwC8EPc99LCzCdTPE7uMzwqRqnCeW3pNOsn7HZAExRnbCJ7qlPeovXr4pvtOH
         H6PzOYQBnj2cQaoP14LMXpL9Sw4R+S4aGCaoCNnn8UH++NZKeN8YkCGktbTOfDVGzIgJ
         ZBiojS8HzWWUMueNMqOmdy6kOv5U9bFmR9sRFt2Cejk6jauG4bSnzREcl2z5wXCk4DZx
         e2a6ZCEo5CfnvolympJTYWyCAKykyVT/0QYdIHrItSBCIuFeruk8+QFVb64HWbuJXkVx
         JwywZaakJ1DGrJkg6+uym+e6lbJvbrcTTyrmBHuyPAmhbqxarzt4S9pjQo0hnBiAPLOB
         cENg==
X-Gm-Message-State: AOAM531FkHhwgeC8O7hHvkSXsVGiGWg6bturVxnhGKTrJ+vngE3Q4H8d
        STGR6WBGUssKVZeU3u38qdo=
X-Google-Smtp-Source: ABdhPJy5x8vKmRsU/fg8ixX3dbFb+zIwj5xZfElTHbBRTGH74EANV/8XPnXlA1z8nnGbS9Pp/ZZn/Q==
X-Received: by 2002:ac8:5c54:: with SMTP id j20mr8150051qtj.438.1639509245947;
        Tue, 14 Dec 2021 11:14:05 -0800 (PST)
Received: from [127.0.0.1] ([187.72.67.185])
        by smtp.gmail.com with ESMTPSA id s20sm624522qtc.75.2021.12.14.11.14.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Dec 2021 11:14:05 -0800 (PST)
Date:   Tue, 14 Dec 2021 16:13:25 -0300
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To:     Douglas Raillard <douglas.raillard@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     acme@redhat.com, dwarves@vger.kernel.org
Subject: Re: [PATCH v2 4/6] pahole.c: Add prefix to expanded type names
User-Agent: K-9 Mail for Android
In-Reply-To: <a5b3b85e-1332-c244-08fb-8e51e9ab0fb4@arm.com>
References: <20211207173151.2283946-1-douglas.raillard@arm.com> <20211207173151.2283946-5-douglas.raillard@arm.com> <YbiwfOPqiuZE7SUX@kernel.org> <a5b3b85e-1332-c244-08fb-8e51e9ab0fb4@arm.com>
Message-ID: <8F9601B0-7CB9-41C6-9907-764A9CF1BF19@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org



On December 14, 2021 2:50:15 PM GMT-03:00, Douglas Raillard <douglas=2Erai=
llard@arm=2Ecom> wrote:
>On 12/14/21 2:55 PM, Arnaldo Carvalho de Melo wrote:
>> Em Tue, Dec 07, 2021 at 05:31:49PM +0000, Douglas RAILLARD escreveu:
>>> From: Douglas Raillard <douglas=2Eraillard@arm=2Ecom>
>>>
>>> Add the prefix specified by --expanded_prefix to type names that have
>>> not been specificaly requested using -C=2E This allows manual namespac=
ing
>>> so that these inner types will not conflict with existing headers=2E
>>>
>>> Signed-off-by: Douglas Raillard <douglas=2Eraillard@arm=2Ecom>
>>> ---
>>>   dwarves=2Eh |  1 +
>>>   pahole=2Ec  | 29 +++++++++++++++++++++++++++--
>>>   2 files changed, 28 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/dwarves=2Eh b/dwarves=2Eh
>>> index fc5b3fa=2E=2E0967e5c 100644
>>> --- a/dwarves=2Eh
>>> +++ b/dwarves=2Eh
>>> @@ -90,6 +90,7 @@ struct conf_load {
>>>    */
>>>   struct conf_fprintf {
>>>   	const char *prefix;
>>> +	const char *name_prefix;
>>>   	const char *suffix;
>>>   	int32_t	   type_spacing;
>>>   	int32_t	   name_spacing;
>>> diff --git a/pahole=2Ec b/pahole=2Ec
>>> index 42ba110=2E=2Ee0a1438 100644
>>> --- a/pahole=2Ec
>>> +++ b/pahole=2Ec
>>> @@ -2882,6 +2882,33 @@ out_btf:
>>>  =20
>>>   	bool include_decls =3D find_pointers_in_structs !=3D 0 || stats_for=
matter =3D=3D nr_methods_formatter;
>>>   	struct prototype *prototype, *n;
>>> +	static type_id_t class_id;
>>> +
>>> +	uint32_t id;
>>> +	struct tag *pos;
>>> +	bool skip;
>>> +	const char *prefix =3D conf_load->conf_fprintf->name_prefix;
>>> +	const size_t prefix_len =3D prefix ? strlen(prefix) : 0;
>>> +	cu__for_each_type(cu, id, pos) {
>>> +		if (tag__is_type(pos)) {
>>> +			const char *name =3D type__name(tag__type(pos));
>>> +			if (name && prefix) {
>>> +				skip =3D false;
>>> +				list_for_each_entry_safe(prototype, n, &class_names, node) {
>>> +					if (!strcmp(prototype->name, name)) {
>>> +						skip =3D true;
>>> +						break;
>>> +					}
>>> +				}
>>> +				if (!skip) {
>>> +					const size_t len =3D 1024 + prefix_len;
>>> +					char *bf =3D malloc(len);
>>> +					snprintf(bf, len, "%s%s", prefix, name);
>>> +					tag__namespace(pos)->name =3D bf;
>>> +				}
>>> +			}
>>> +		}
>>> +	}
>>=20
>> I don't like this change in place mode, but I understand it is easier t=
o
>> do it here instead of in all types fprintf routines, but perhaps its
>> better that way, I'll check how big it would be=2E
>
>I don't really like it either but the alternative is something like that:
>https://github=2Ecom/douglas-raillard-arm/pahole/commit/a3d4e224b2a0cb819=
6db0f8536bd77f976e364ca
>
>The worst is not the size of the patch, it's the inability to check that =
it's actually complete=2E
>Any spot where the prefix should be applied and where it is not will resu=
lt in a broken header=2E
>This also stands for any future addition to dwarves_fprintf=2Ec=2E
>
>One way to make the substitution safer is to completely ban direct access=
 to the name and force
>to go through an accessor that would apply the prefix,=20


I like this, and we have tag__name(), I'm AFK now, will check if it fits=
=2E

Looking at your patch in te link you just provided

- Arnaldo

> but this leads to either memory management
>issue or inefficiency (as we would need to return copies so the caller ca=
n free it)=2E
>
>>=20
>>>  =20
>>>   	list_for_each_entry_safe(prototype, n, &class_names, node) {
>>>  =20
>>> @@ -2891,8 +2918,6 @@ out_btf:
>>>   				prototype->type_enum_resolved =3D type__find_type_enum(tag__type=
(prototype->class), cu, prototype->type_enum) =3D=3D 0;
>>>   			continue;
>>>   		}
>>> -
>>> -		static type_id_t class_id;
>>>   		struct tag *class =3D cu__find_type_by_name(cu, prototype->name, i=
nclude_decls, &class_id);
>>>  =20
>>>   		// couldn't find that class name in this CU, continue to the next =
one=2E
>>> --=20
>>> 2=2E25=2E1
>>=20
>
