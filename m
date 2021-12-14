Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 233A4C433EF
	for <linux-dwarves@archiver.kernel.org>; Tue, 14 Dec 2021 19:19:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbhLNTTe (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 14 Dec 2021 14:19:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbhLNTTe (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Tue, 14 Dec 2021 14:19:34 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0527C061574
        for <dwarves@vger.kernel.org>; Tue, 14 Dec 2021 11:19:33 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id 193so17743893qkh.10
        for <dwarves@vger.kernel.org>; Tue, 14 Dec 2021 11:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:user-agent:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=ZTjBHh7WjD4/qJp92bP3U+n98FvJv27oL5fkf8fjmU0=;
        b=qilF24vevlkPB6eAa+aKuYGUwfYadKl0tI8mHL1jNdPp4IYJCzq/p7a6aNoe9ZLvVW
         34kfm/OhQCuiLG5dIKuPFjUy323Ow7pfoKSGKw5m4xACdZIcxAriw/PsC5+Mb4Dwq/70
         pcnBPwN1g1FObrx4n0mXB5dqUIPCmrF+QNrEJ4+n5RXJtKBo0Ef1aQ0xFW7jpyQ7bqYF
         Zl7Td6GUAVAasGmBSqWK28bsV9z7GiMMftWVvoz/uaPA/rmo0j7e+IC9j8TwrmQVsL1t
         H/5hs20aEWRckwy7HbMYDE/WrzO129Ft/WVf3kltegVJgP9eBWm1fQx+nnXQRSfruMUG
         Z1xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=ZTjBHh7WjD4/qJp92bP3U+n98FvJv27oL5fkf8fjmU0=;
        b=h7XQ8qfeaIaYdT/awkjxU9f6oBKHvT+GQx0w2fsktQTv/Frc7RqgRSx8IgvGRiAwDB
         1pUJ+QUVYZPdUhbIL5WkV2kXzYMFsQNUiwbUpsUGJgodfxkwsn/Yd5GAW5qnss/tFGnC
         6UjjP5NmJOu4lCGSA3wW7wvqXzsUNHs4VZmcg83KMb77ZDdNMouB9ebM2bwGxQBV/7yQ
         /74xszg9FtuIon+BS8E7A3vuTDySFe29j/9ME/ARAWwFnuP9ef9h7kPT2MXcvuTkKo4R
         KYqY4bhtO92l0mShJI8FBEe+SMAG0VIKd7B9vEu23f+KduquaGAkcfnvvgMZxmODJAst
         mNdw==
X-Gm-Message-State: AOAM5313eq9rD1XVKNFjyyquePAS+0jDcuB0G2xjbJu82zYrUU2Ja0vJ
        cLCd3f9Esh2BtkfIyRhKVXc=
X-Google-Smtp-Source: ABdhPJyMoayY0gZ7sbwKqk+vEkl94RtBv5GmGAkBAg6iUww7UB4bQmgJ0rccLDmVn1RrWm7oKQNyPw==
X-Received: by 2002:a05:620a:4507:: with SMTP id t7mr5918722qkp.655.1639509572946;
        Tue, 14 Dec 2021 11:19:32 -0800 (PST)
Received: from [127.0.0.1] ([187.72.67.185])
        by smtp.gmail.com with ESMTPSA id w63sm461141qkd.88.2021.12.14.11.19.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Dec 2021 11:19:32 -0800 (PST)
Date:   Tue, 14 Dec 2021 16:18:57 -0300
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To:     Douglas Raillard <douglas.raillard@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     acme@redhat.com, dwarves@vger.kernel.org
Subject: Re: [PATCH v2 4/6] pahole.c: Add prefix to expanded type names
User-Agent: K-9 Mail for Android
In-Reply-To: <a5b3b85e-1332-c244-08fb-8e51e9ab0fb4@arm.com>
References: <20211207173151.2283946-1-douglas.raillard@arm.com> <20211207173151.2283946-5-douglas.raillard@arm.com> <YbiwfOPqiuZE7SUX@kernel.org> <a5b3b85e-1332-c244-08fb-8e51e9ab0fb4@arm.com>
Message-ID: <3A9ACBF4-4FFE-4A19-B8D6-EDA8033B05AD@gmail.com>
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

A quick look at the above hints at passing con_fprintf + a buffer + size t=
o either return the type name or use the buffer to concatenate the prefix +=
 the type name, with the type_name() return being the only result to use=2E

- Arnaldo
>
>The worst is not the size of the patch, it's the inability to check that =
it's actually complete=2E
>Any spot where the prefix should be applied and where it is not will resu=
lt in a broken header=2E
>This also stands for any future addition to dwarves_fprintf=2Ec=2E
>
>One way to make the substitution safer is to completely ban direct access=
 to the name and force
>to go through an accessor that would apply the prefix, but this leads to =
either memory management
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
