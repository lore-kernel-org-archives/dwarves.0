Received: from mail-ej2-f41.google.com (mail-ej2-f41.google.com [74.125.228.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4033CF1E0
	for <dwarves@vger.kernel.org>; Thu, 24 Sep 2026 16:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790266816; cv=none; b=jr2V3/y7UWED/fZEZjZ73IcXE43OoggfFoJuPxKhduyGWRIMBsFOa4piZ4VMil4QXdzKQS6I83oGuMewnwDhCe//6IVJPs52Wkjyh+hHfjmuSlLad/M3ZLGjS0bzgtCTl/2q/gYE0NXhdTMe3K9/DLRQjdRXapKekMi1jbutxiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790266816; c=relaxed/simple;
	bh=3RqIO6sePBeRSZKF7G/2KBgpPD2lZ4MbL7NsJ27Vwb4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=OqzL9clFnk4UGoiTfOfj9O7eDNu0gC6U4UYL+ZLo8ozzIBX5QZWmJiHNPx8GaAjcpvcozrH+iHbKmZ71iNebWzDrDbwMN1CVoeyCHCeCQ114uEdKw5KpYROvuV+45ogLWOt0Lo5cIsaDVddo9cXWVGDg69ywiAQ9NsgPGndt9Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j5bqZmiF; arc=none smtp.client-ip=74.125.228.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j5bqZmiF"
Received: by mail-ej2-f41.google.com with SMTP id a640c23a62f3a-c254fa663bfso392299666b.1
        for <dwarves@vger.kernel.org>; Thu, 24 Sep 2026 09:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790266813; x=1790871613; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qWiIWAbEhMe5Qe0PgIHxYK173K5Od+mN1jv9eb0aS9g=;
        b=j5bqZmiFLxl0IR2tzdLDnMn/kCWj/59BKoEpMyuMTDuGbQYr/XBsMj9JQhwI3L56yo
         EbsRsrDUuWfR89Q0N82oW3tadJ73JY2zaQPx45lkLrvrK6jLeZRw91hZNGgpnzMtyn9m
         wJIVwxoSEMKhZ4MhVs1LYWIZCbKqHvQ0U29dU5Fmg74YUkGXb/SGQNR3x4bektPqUi48
         Pb5pjTBJ5SJa20ac8uzXewiywYIIkUUcEWxseLbYm6CyGn/ezCWe1o/Kz1OIOMyTaZUf
         tD+hzkz857ISE6/E0xsUv13hP5e0Esz62XiGo5hiDYmWqJ5qkybGyHKOxNMEQDEJzIek
         XgSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790266813; x=1790871613;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qWiIWAbEhMe5Qe0PgIHxYK173K5Od+mN1jv9eb0aS9g=;
        b=uE7MPJswhwjfiBA465Fuu58mfi0RN48I9uO4qHSvM0dYkVqVtWQbefxwoecE3/WX9X
         KNEhpsmlLAjuURmxDot3dMa5OYvkmgi41zZiVmdbv/7dR5jO/YiD60Qz5cPjjCCXj92+
         0r9ISFhsXoriDwsk2LMARF5zApYw5VPnrwwxdFZ9/+nWqfNbpMmKPdxffVH6sgMg+Dzp
         oZeyTu0VP/f4lSr5KsZJokRfNwuRXQC5CjAf05wRKkKkL2eLRSagsOiBS1T4bjM+1Lid
         A03TFXqEmt70AaocWEvNeUAO6ALls4Gvisr/8tYRnv/B7P//zGFlZ7mHEw/gyTqo2+KW
         ZGBw==
X-Forwarded-Encrypted: i=1; AKwUvBx95bS9aRJ5CJe00ftcE1gqR20vV/wuKfZKF2BkQwv+cpylPoaI2kgmYKHRZMLl+9WsFpWq7H4D@vger.kernel.org
X-Gm-Message-State: AFuF++lU6m0npwt2S0+pA1iCpiUySa3E4lwbVP9M6VrCE/2uAcCN0tZT
	hLS/T112d3D3lEKryq3Rxb7k/gNZZKO1qc8wovmTyKv12HLEugmwuImf
X-Gm-Gg: AYBFou1nTuX3OFafkDSnSnGLuin3Z36maLWIXXg4/w22pKJJGh1GVjC2L/Wv1scDWk8
	lz1eRXLBQKchMpcw7hZd/4sIMsMcr9VChM0oaNUxzyMIrlZjGUuBnYrUmZxoByGs1z9NhnixjxA
	SxAqX9dmeRq1cKTg6t3e1J6n7Bf4FzAcczuNVuN+fyIxA9Tsq0uOP0MLzphLoQ4sy3lYaRCWEQB
	tCOZsouqM/pALe2z32x/8C2VtvTSLHFZaiqj3ISQ68uA+j68J2msSpgTp4iSe95n6oMn02J10k5
	srIVvMu9928O7p+8VOTjld1BTLEM53jVs9IABBrjrfDIn8tS9d0fl/5NTOtKiDqsoGmpzfCulML
	KA1ZmdAg69TUGkkvzVke8aDLNL3pOMhRGHFsItmCrztl7vlwFbfJC79sYg9gDmvvMzIa7C+GXvE
	2vD+vx/+QhLU4t8QRbAvLS0LBksnxsuvkfibtaIeVprtn40BUj5/zOag0E2V3b6MmKpns/J+nbk
	uP+rICpx2hpdnj8qsqa7dsX+udIWXAS6qgu5LXuI7Vrid/RZbQJEso5rfjMRHAuHG6nL5SOkFer
	V6a+
X-Received: by 2002:a17:906:6312:b0:c25:2d27:5652 with SMTP id a640c23a62f3a-c2ac2308fd7mr272369366b.11.1790266812819;
        Thu, 24 Sep 2026 09:20:12 -0700 (PDT)
Received: from localhost ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae5c6f35sm331872766b.12.2026.09.24.09.20.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 09:20:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2026 16:20:08 +0000
Message-Id: <DLNOMA3RI740.18YZJ9G0HDKDQ@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, <bpf@vger.kernel.org>, <kernel-team@fb.com>
Subject: Re: [PATCH dwarves v2 0/3] pahole: Fix arm64 argument register
 allocation
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Alan Maguire" <alan.maguire@oracle.com>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Arnaldo Carvalho de Melo"
 <arnaldo.melo@gmail.com>, <dwarves@vger.kernel.org>
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <20260917164038.1576763-1-yonghong.song@linux.dev>
 <09dbfeea-a4d1-4b7a-b92e-bcf8c4cdabb4@oracle.com>
In-Reply-To: <09dbfeea-a4d1-4b7a-b92e-bcf8c4cdabb4@oracle.com>

On Thu Sep 24, 2026 at 4:15 PM UTC, Alan Maguire wrote:
> On 17/09/2026 17:40, Yonghong Song wrote:
>>=20
>> The arm64 ABI starts an argument twice the register size on an even-numb=
ered
>> argument register, leaving a hole when the next free register is an odd =
one:
>>=20
>>   u64 f(u64 a, __int128 v, u64 b);
>>=20
>> passes a in x0, v in x2:x3 -- skipping x1 -- and b in x4.  pahole did no=
t
>> model the hole, so b looked like it was in an unexpected register and th=
e
>> whole function was dropped from BTF.  Patch 1 skips the register the ABI
>> leaves behind, patch 3 adds a test for it.  Only arm64 has this rule; th=
e
>> other architectures are unaffected.
>>=20
>> Patch 2 is a small follow-up.  Floating point and vector arguments are
>> allocated from a register bank of their own -- v0-v7 on arm64, xmm0-xmm7=
 on
>> x86-64 -- so a wide one never occupies a general purpose register pair a=
nd
>> must not trigger the even-register rule either.  It does not change the =
BTF
>> emitted today, because such an argument still advances the general purpo=
se
>> register index by its own size, so it comes with no test of its own; it
>> keeps the alignment rule scoped to the bank it applies to.
>>
>
> one small issue here; we record alignment for structs from DW_AT_align
> in associated tags; we should ensure that we utilize that alignment
> where available. However it's a bit broken in that we don't appear
> to record alignment for typedefs, just structs.
>
> I think we can tackle that with a followup though; unless anyone objects =
I'll
> land these patches later today.

Pls go ahead.
Also pls land LOC* things too, so you can post the rest of LOC* kernel bits=
.
So that everything lands and ready for the merge window in a couple weeks.

People will be traveling soon, so the sooner the better.

