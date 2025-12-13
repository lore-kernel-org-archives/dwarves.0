Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DB21917F0
	for <dwarves@vger.kernel.org>; Sat, 13 Dec 2025 03:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765597907; cv=none; b=kpcxl1P6vBkqqtU0ZCdTIvX/KQLNjn2vLpXVQvY+s3Y2m/mmQL4DYoi534LUsogYyqZbhVCFLIdeRigs8OqV+aFR8PAX2DM3YSwF6ahnF70OKgnwI3kAmHXZqb3x0jcSm1Nty7303Y8RFNG5kLXsYzsJn8+juQRremEE+De3Zzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765597907; c=relaxed/simple;
	bh=uscT8Cs8wBFI8wiJhSy+7LAetnzLJV2CLIL4Ql/3nfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VGZMz1TOQzcHWVufjpYInAFfd9Mwm1PfY+Row5g+EtyPJKSRixNhO0LFEzyV5Ktz7hITO4tzkOe9pycAeOuN9UjxxDuqbqH1ma94nQsAu8+dI4x9GL7Z9o268vjXM02Q4HAqinlOIuB31s1vBFo04UUp544j21tS/w8j6TIqoMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k58+4PkB; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k58+4PkB"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-297d4ac44fbso9231705ad.0
        for <dwarves@vger.kernel.org>; Fri, 12 Dec 2025 19:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765597905; x=1766202705; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qtt5olcEbFdNtHyhpME8qsZGCPrss/5X0HqR4SKaFN4=;
        b=k58+4PkBEqgf+8vP9mFo8PzV5kcwTqf+CsT34dHgPkxHysq/kCAH2ZV+MtS0MUmxMK
         20/9cfuQtqTcyEUb2FzFs8Rn/UZnMTX/Az2VhyxUFWt3X/rwE16QOpWM5HtQWcQT0MdX
         SzoXKo3uGaoUYjutK8w8vINfYRZqkcDzt/ik3TMcQF5vzRpTvs0gyzRCjMBaom/jhWox
         IrWe6BWSp+c8m5OopugtboZHqDpvD7QknAFOtPXoLFQN7KCeL2322OsYx4KBMS9CwZp3
         7Lz87uk2J0w9fSQz2NI3qMtdjAo2HClciJlVSmRryCx6uH5bhpWEooSQEiP2Nvj/e0Ty
         DdOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765597905; x=1766202705;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qtt5olcEbFdNtHyhpME8qsZGCPrss/5X0HqR4SKaFN4=;
        b=us6H3vg5AW+TEuKoL1qm7OGbKk0e7xwlJgto24vUCMWk5CXSAjtUMVJvH0IBghCDyF
         qKMTR287TvYUOjPlv1rqTN/A7WYs/0XUHHtIlpjZSh9DZsgMxBz79LQDfbmLfVHyxnsT
         1maCWB6ouWIPZY7SeawUzYfYbF9Nb8GcCDAUI1nIm4VkK+mDAg2s4UxNw5U+VNqNeQPq
         xCSznIZN7poBdwKBdzqH0NNOD1kQ0Up50oRmaNuNbIWUWv9vHxvR462y9coyjGt4uCoe
         tuI2SqKgUI8qViDtrfm0eZjO9qC1QTSwS7XJcAdUjxoeLP7PZz+tQgBouH+z/PcUmUfl
         TEMw==
X-Forwarded-Encrypted: i=1; AJvYcCVExNfglbbHeFNzt9I+MESe62/Y1yZUzolSIqW2KqmBH5vg54MDKQvD2Iij3v+A35TEbak9m+MN@vger.kernel.org
X-Gm-Message-State: AOJu0YygfFL48M2JPQAW4WbGgy2fKQL4LQJKMKQJNcVjHPi0PqEu2BzK
	KFrT1fazUkV3HqOkP2vPM5IF78ef8GTGDn9Xq9srQRIaGRuX/e3dLabg
X-Gm-Gg: AY/fxX5wKG/L505YDvVTA8dkwPinUY60P8jbRUyIScE3+ra4SLSX+pkvyzkzjzSpGG8
	DrT5sWO2UwLEUUZAvFIuWmTbuDQJdp2AfGu3nLl9/M1yx8silojXF1ewFocT1JVdVJzoOrwJk/H
	c+VqY/sFfRSzgK/MtVtrnhIpN87byDsxmqywPBI4WP2Ij0n3dENaO1U81CHbguEWD7PBfGYtnLQ
	nhEp9KJXhccubsmUiyVHbM9uqlFdQ7bjYuHKImf0X4Y9FRGtASsHeqq+NknuYujtLMmgXex9Ed3
	GPTN9F7AUS10oQh4zdSf3jJE0slraEKJhWgSwOtwrfiTuWUqXRWdzIXUiWZvkBd6Koo8Yg+y/IO
	rW+aNSQzjAqqvXqQHrxe2d+0peY0RBRPxN95hp65GmKfp3E6bS/w0AShzuoEB4JfXgf90ExsP1s
	9/xF0lxMCUlkbNnkf6eJK4OZgH7xfjSgPepwiiNkZENEm25UcIRHMD7VNaG94=
X-Google-Smtp-Source: AGHT+IGSBRnT12udRwJeWV8FDUJn5X2BM7apTDfwdXf9FduS4gutii6U21QkPX2DK5RIAwtpfoxXiQ==
X-Received: by 2002:a17:903:320a:b0:295:55fc:67a0 with SMTP id d9443c01a7336-29eee9f2be6mr80191975ad.2.1765597905105;
        Fri, 12 Dec 2025 19:51:45 -0800 (PST)
Received: from [10.200.5.118] (p99249-ipoefx.ipoe.ocn.ne.jp. [153.246.134.248])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29ee9b374a9sm69193025ad.11.2025.12.12.19.51.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Dec 2025 19:51:44 -0800 (PST)
Message-ID: <e2775a4d-e79e-4c3a-84bf-6c95b8f543e9@gmail.com>
Date: Sat, 13 Dec 2025 03:51:38 +0000
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 bpf-next 03/10] libbpf: use kind layout to compute an
 unknown kind size
To: Alan Maguire <alan.maguire@oracle.com>, bot+bpf-ci@kernel.org,
 andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 qmo@kernel.org, ihor.solodrai@linux.dev, dwarves@vger.kernel.org,
 bpf@vger.kernel.org, ttreyer@meta.com, martin.lau@kernel.org, clm@meta.com
References: <20251210203243.814529-4-alan.maguire@oracle.com>
 <6dcc4caa01eabb37a074ca584c6e9deac0e8ab217269dac8e2317a23c252f5c2@mail.kernel.org>
 <e15e740b-ff93-451b-99b0-9baa025730f2@oracle.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <e15e740b-ff93-451b-99b0-9baa025730f2@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/11/25 08:33, Alan Maguire wrote:
> On 10/12/2025 20:55, bot+bpf-ci@kernel.org wrote:
>>> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
>>> index 737adc560818..4eb0704a0309 100644
>>> --- a/tools/lib/bpf/btf.c
>>> +++ b/tools/lib/bpf/btf.c
>> [ ... ]
>>
>>> +/* for unknown kinds, consult kind layout. */
>>> +static int btf_type_size_unknown(const struct btf *btf, const struct btf_type *t)
>>> +{
>>> +	int size = sizeof(struct btf_type);
>>> +	struct btf_kind_layout *k = NULL;
>>> +	__u16 vlen = btf_vlen(t);
>>> +	__u8 kind = btf_kind(t);
>>> +
>>> +	if (btf->kind_layout)
>>> +		k = &((struct btf_kind_layout *)btf->kind_layout)[kind];
>>> +
>>> +	if (!k || (void *)k > ((void *)btf->kind_layout + btf->hdr->kind_layout_len)) {
>>                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>
>> Can the bounds check be moved before the array access?  Currently the code
>> indexes into kind_layout[kind] before validating whether 'kind' is within
>> bounds.  While computing an out-of-bounds pointer may not cause immediate
>> issues, the bounds check itself appears incorrect.
>>
>> The check uses '>' which allows access when k points exactly to the end of
>> the array. For example, if kind_layout_len is 40 bytes (20 kinds * 2 bytes
>> each) and kind is 20, then k would point to offset 40, and the check
>> '(ptr at 40) > (ptr at 40)' evaluates to false, allowing the subsequent
>> read of k->info_sz at an out-of-bounds location.
>>
>> Should this be: 'if (!btf->kind_layout || kind >= (btf->hdr->kind_layout_len
>> / sizeof(*k)))'?  This would validate the index before the array access and
>> ensure the full structure can be read safely.
>>
> Yep, good suggestion. Will fix.
maybe something like this:

__u32 off = kind * sizeof(struct btf_kind_layout);

if (!btf->kind_layout || off >= btf->hdr->kind_layout_len) {
     pr_debug("Unsupported BTF_KIND: %u\n", kind);
     return -EINVAL;
}

k = btf->kind_layout + off;
>>> +		pr_debug("Unsupported BTF_KIND: %u\n", btf_kind(t));
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	size += k->info_sz;
>>> +	size += vlen * k->elem_sz;
>>> +
>>> +	return size;
>>> +}
>> [ ... ]
>>
>>
>> ---
>> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
>> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>>
>> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20112692486
>

