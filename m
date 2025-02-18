Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0301684E1C
	for <dwarves@vger.kernel.org>; Tue, 18 Feb 2025 15:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739894273; cv=none; b=QLcXk6cZT5zsinUUKlt/c6DTWkAR7OHvNghqss3ytsKDtBQkQwseb4U3I1a+DaB6CCjPVg+thZ5dzBw01qHBtyvWFElq8ahZf+1/CnGTtaBza0V6deb/k8Oa7K0GkDmopoEEWSCvyYfVyLggXB9QZwezF+MudY9PJf3yk+nhKxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739894273; c=relaxed/simple;
	bh=5VXUYeJneYSM+dIxsJ2BJD+cMiyA8VYzVX33upRibXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cBHrGPld67yqhRF8HOcqxBaLxvrrjMMG4G8ahk3g/xF9kUYEwKPnTXxdK62uYmR/fUGaZbGyqUvd728UxOxZsKKElp2IP1A1yf94tip1F4LWWFtj1z4yjVzAJr5RdyKgivDjFPV83sbupU/rgFINP9B+p+CybSRhLUSB33SaHGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=a+YhpqV+; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="a+YhpqV+"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4396f579634so20107975e9.1
        for <dwarves@vger.kernel.org>; Tue, 18 Feb 2025 07:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1739894270; x=1740499070; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uGJk/jauWXLlHhyYcHD6Qu3wfYqtHSSTXficYE+LgxQ=;
        b=a+YhpqV+JJhpZpSRxxs9s0yLm+jeg+t2PB/ode2UFmWUH87Gl7qfMmSg/TTaUZQtVh
         imAt6RURUl2YanY1HlrW1KPsMEyONsjb1wK7BZ+6ZiU4Pz+0rkBwlozHsdkAamoqGH54
         o30cYJKsklgVFdItYM8htZfsFe7qyUmOwPiIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739894270; x=1740499070;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uGJk/jauWXLlHhyYcHD6Qu3wfYqtHSSTXficYE+LgxQ=;
        b=SjTFpW9OuGW99UPNizeoq5mbIjXzK8o6ugFhc1z/MtmM+zFYXg6XAimqQeUvPG73fz
         B5oMkKd5IQdDHOgSJNNNi0NCl6DdlwRwe+EZy96whvp8PWE0Oa8hfUcIgEMdFO7yw4fD
         fAlSCBUZDzk9QzLrCPwnzUWJy5yihn9QzK/W63Nfb1tIHFlQNcTB+lUut76PEd3hXi1f
         5wwc1nOxrX9HpoEe+qbirSjWYvrAlXWlAad4jJmSJgtaiPTnxhq2veaz7rJuTVszVmhA
         E1R5C+E1BxFjUSVpXTIv3PpTjJjTlviR2Y3cXkH9VlDLQoUdM80Yi0BOpmXyvhcNOVwv
         46cA==
X-Forwarded-Encrypted: i=1; AJvYcCUNOX5cygOlBBf09KsMff8m/3mf7aAEAIfLXbLzT/4LLvOKDgv4bghYToWhvQpFpYhaR03S2oV1@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6u/4cyYjO/HhBPA/XWY3tKR24EUJerTBECsB+j2fPw+K1zvjs
	NcCQlT1AgI2MQUl5GYVOhecKsEmzJXXdZhHdjkMBNxpDWhS2W7vvvHoa4/Oeep4G/8uE4x95ASN
	G
X-Gm-Gg: ASbGncsoJ/zglOTyXCv01HN2OPrwzyObYVAmj5APZDDghRX2xRPkrmtxdWBlLwnc3IP
	BZBxzyacCBX7jT1f3J8J6UwUWXVpzOPSqx0GbeQbBqfLXVoie4pDNfSLZYbVSiPQco0dJaitixD
	X92fmjshOF83tRmsHWUOGu6vCSV1dAhENJ4MyoEH4bzTCDSNpqWkCSIJR9uMY24G9IR9Jys5vxG
	SPBvK2RMooEK0cXPYOqtKmMw+u127Mq9150Wf8aw9W++rLyuIprSGfkf3OHnRy+NYl1HFcSyqwn
	2e2uNxRaiVU3IAo3wZcfmCn0KU3gHelsww5Pyf/UhEh1cSXU95OTMbc=
X-Google-Smtp-Source: AGHT+IH8ETLLpITLYdnkaQdJ30wKtVTbOq0aaAvzpa2utH0vvdHIfUlcjh1Z7HdYywVOGL8V57+wVA==
X-Received: by 2002:a05:6000:18a9:b0:38f:2193:f8c2 with SMTP id ffacd0b85a97d-38f33f34e32mr14528731f8f.31.1739894270204;
        Tue, 18 Feb 2025 07:57:50 -0800 (PST)
Received: from [192.168.1.10] (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258ccdccsm15393716f8f.24.2025.02.18.07.57.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 07:57:49 -0800 (PST)
Message-ID: <e3e90afc-4b65-4675-ab02-98d800e2180f@citrix.com>
Date: Tue, 18 Feb 2025 15:57:48 +0000
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Alignment information
To: Alan Maguire <alan.maguire@oracle.com>, dwarves@vger.kernel.org
References: <07381c66-f102-44ea-8966-9a49222847b8@citrix.com>
 <f000e43c-d81b-4ee2-938e-e1b4acbdcb1b@oracle.com>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <f000e43c-d81b-4ee2-938e-e1b4acbdcb1b@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 18/02/2025 10:52 am, Alan Maguire wrote:
> On 14/02/2025 16:34, Andrew Cooper wrote:
>> Hello,
>>
>> I think this is a new feature request.
>>
>> I'm tracking down a UBSAN failure (only shows up on one arch, and it's
>> in a list_for_each() so there's loads of container_of() going on too).
>>
>> Newer versions of pahole have the overall structure alignment given the
>> end, but I can't seem to persuade it to give the the alignment of each
>> field.
>>
>> More concretely, I'm looking at a structure which is nearly 4k in size,
>> differs per arch and has an overall alignment of 128, but I can't find
>> which sub-struct within it is causing such an alignment requirement.
>>
>> Would it be possible to also print the alignment information in the
>> comments that exist already?  i.e., instead of:
>>
>> /* $offset    $size */
>>
>> could we have
>>
>> /* $offset    $size $align */
>>
>> ?
>>
> hi Andrew, I might be missing something but I think "pahole -E
> <struct_name>" should give what you're looking for.  This should show
> any nested structs which have alignment attributes associated.  For
> example with "pahole -E task_struct" I see the a few substructures
> tagged with alignment attributes:
>
> $ pahole -E task_struct|grep align
> 		} avg __attribute__((__aligned__(64))); /*   320    64 */
> 	} __attribute__((__aligned__(64))) stats
> __attribute__((__aligned__(64))); /*   960   256 */
> 	/* Force alignment to the next boundary: */
> 				} regs __attribute__((__aligned__(64))); /*  6016  4096 */
> 		} fpu __attribute__((__aligned__(64))); /*  5888  4224 */
> 	} thread __attribute__((__aligned__(64))); /*  5696  4416 */
> 	/* forced alignments: 2, forced holes: 2, sum forced holes: 88 */
>
> It's possible there are bugs that mean this doesn't always work
> correctly of course; it would be worth trying if that helps and if you
> run into any issues let us know. Thanks!

Hmm, that's a little different.  Still nothing internally, but:

> } __attribute__((__aligned__(128))) arch
> __attribute__((__aligned__(128))); /* 0x180 0x380 */

suggests I've been an idiot all along.  This struct has an explicit
align attribute, rather than an internal member causing this, hidden
behind __cacheline_aligned which appears to be wrongly 128 instead of 64.

Ok, so that explains my problem, but I still think it would be nice to
get the alignment of every member.

~Andrew
