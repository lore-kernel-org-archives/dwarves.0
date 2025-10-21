Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15A12586C8
	for <dwarves@vger.kernel.org>; Tue, 21 Oct 2025 19:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761073592; cv=none; b=bfX4zjsxVFBCtPmi+SexYhm0QdR/F4Nz7HRSVMX/c8JRKORi5jiTnTO0SgEuio6ELUCd0XsvT1o2D5nTpexwr+uZuJ6K6a2txObT9Azqz6ap0O+Qmqk0ziWCWoZ9eLNRdeIjHGtoAAVq+O+H6BDoqxGqYksdcNB49XCswfzI3KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761073592; c=relaxed/simple;
	bh=3Q+kCqPMJRP+G+u/D3GtsgSDglkGCUJspsXhiVjMiJU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V0l8QgaxdbzapPLDGlqTOfIyxlCMoL8HDRHAe2D5Nuoy+9q5209vd9MdmRvjkTYDm3ZAxMEnI3JYPIVXbZBLxYtGb+K8S2SUyvEgg5XpXeYs7cbtVfHTm9tl5MXYUfDh0R1gkg22epuWjtaT9IJrYQAgiyEuVBE8pXUVgkZ995c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=AKAenmsf; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="AKAenmsf"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-63c4c346bd9so7041355a12.0
        for <dwarves@vger.kernel.org>; Tue, 21 Oct 2025 12:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1761073589; x=1761678389; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=hzCkkegdPnkyo2SCoFLVAlHRSdFOhs2fjLAObRHtd/k=;
        b=AKAenmsfvxA/YF74zKPxx/pXLLiavdwdZvZVomlx+Go0FBqwwkws2ZhFwOowrmPItU
         f1txx6RU5lPHCXSB4zrlzaUFSWGj5SUK66MYdQz3VkgD7TRS4+FFFAK7Att+ZlZrBLkb
         cOY9jHIEFJ+Ta/ZKjHAPTsOE61BkIUW9kl1eDpNunP4rN+5h9V+F/EUWKxHjTHkxCHCf
         3tSvuT9Y4rbsPHxbfeycyTrIDHX7bJChNU+PP5qEza44H79Nqh984yrT5QI4wX7RFm9q
         uUVwQuDpc6o1cCO3bX+gjsLMPbaORBhxdMVPWzLheShosS0zFm7m8meFcmXeuHEZ9652
         stjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761073589; x=1761678389;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hzCkkegdPnkyo2SCoFLVAlHRSdFOhs2fjLAObRHtd/k=;
        b=pTcj8GOqm1pMmBZCDZVPn/QLfINtI/9SJIgrYOwm2BLHeCGIS0Ly4cq3FAgwfQgO5Z
         Ji9TR4p6zSY8K0CrASN8suepjx7sWVuc6H474jjGpaGHT8TaFRtyRco2DwEa7OUjnqyd
         LjcByM2AuM7n/GCZMRW+q54ArMHFCk76oz9khLfUY4pEIaVXIYQDE5v62lANCjvfq3A1
         9fwoGAArh632qIF0YbvQvod89ff6OFiW6ubrhBHX3mrVhDa+4GPITVRdy8YqWHOskNvm
         3isxMI8Yhbqv0oc6muhOARBf6vD13RbomsvWGOJr72H8qQoCxRSvuPhfaBolwVF0uhLD
         P87Q==
X-Forwarded-Encrypted: i=1; AJvYcCXOqFm7CIIf5NiavKEhulBQm+VDELYbE0+XfbtG06hxW3HlfwNgmfKNL23jLUXnH4zT8LXmaAdA@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa4zA/uD+ivY5rSJP7C/3tnqMjDtnO11epyjLIUUszCbLYQGN8
	OKvgBvuyBQDuU1bTpOeQcJUuOLkx4pL+pyEuIA0zVhesfqn1Lt+C8HkR3fDardaHwec=
X-Gm-Gg: ASbGnct8ICeNDGfPrUf1FSssGdezY06a+rZH6ortiNOvD+j50XVis/LvZV6FHNEAlvG
	QjmZNZY1w19CP99Jd5AGtylgGa2i4uByTUGbqH6/BU72yvBCbxEEwqOcEiCAQeb6gTqzKAPF676
	oUFHsnxTk5iHWUldNUCsWnC/N0W5ePL6LXiypTW8hYtR8g6VSg3s9O1RQW1lGC2Pu9yOqkIJjPh
	NwNp79cJr4DkSow/H6so8zdyXMjiqxy8gdZgA6HIu2AXYitZ7hEVchq7s7AvJ5U6Q0H/pIld/SE
	rfH6yAo/LKZXPczCBRoFm6aAXSqFDVpGMrMr9Uo4+ywsF7seE6OEtZxhJZXlKQi6xG69JkM+n7C
	Vg9v5UPySFFUpkkyNV9BKjUpkjSKgxuHnnyOTY8CkxlVjjO8k7Adl6+T+nnkVbsnkDMRwk9yt47
	kpVvg=
X-Google-Smtp-Source: AGHT+IGbAVeISZZ/fSBa+vEzYe7C9T5LZGwR5Tcar9U9zo1o5FkmkdnYQ8jCpnHjPTsWqxezTGQXWA==
X-Received: by 2002:a05:6402:4444:b0:63e:b49:c9c3 with SMTP id 4fb4d7f45d1cf-63e0b49cd06mr2279176a12.31.1761073588897;
        Tue, 21 Oct 2025 12:06:28 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:d0])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c4943015bsm10158178a12.21.2025.10.21.12.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 12:06:28 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Yonghong Song <yonghong.song@linux.dev>,  Arnaldo Carvalho de Melo
 <arnaldo.melo@gmail.com>,  dwarves@vger.kernel.org,  Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>,
  bpf@vger.kernel.org,  Daniel Borkmann <daniel@iogearbox.net>,
  kernel-team@fb.com,  Matt Fleming <mfleming@cloudflare.com>,
  kernel-team@cloudflare.com
Subject: Re: [PATCH dwarves] pahole: Avoid generating artificial inlined
 functions for BTF
In-Reply-To: <caf3969f-658d-41f9-9de9-9ef3a3773ee8@oracle.com> (Alan Maguire's
	message of "Tue, 21 Oct 2025 15:32:08 +0100")
References: <20251003173620.2892942-1-yonghong.song@linux.dev>
	<874irswi4a.fsf@cloudflare.com>
	<caf3969f-658d-41f9-9de9-9ef3a3773ee8@oracle.com>
Date: Tue, 21 Oct 2025 21:06:26 +0200
Message-ID: <87zf9kulal.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Oct 21, 2025 at 03:32 PM +01, Alan Maguire wrote:
> On 21/10/2025 13:32, Jakub Sitnicki wrote:
>> On Fri, Oct 03, 2025 at 10:36 AM -07, Yonghong Song wrote:
>>> But actually, one of function 'foo' is marked as DW_INL_inlined which means
>>> we should not treat it as an elf funciton. The patch fixed this issue
>>> by filtering subprograms if the corresponding function__inlined() is true.
>> 
>> I have a semi-related question: are there any plans for BTF to indicate
>> when a function has been inlined? Not necessarily where it has been
>> inlined, just that it has, somewhere, at least once.
>> 
>> When tracing with bpftrace or perf without a vmlinux available, it's
>> easy to assume you're tracing all calls to a function, when in fact some
>> calls may be inlined within the same compilation unit.
>> 
>> A good example is tracing the rtnl_lock - there are multiple inlined
>> copies, but neither bpftrace nor perf can warn you about it when debug
>> info is absent.
>> 
>
> hi Jakub, see the RFC series at [1]. The goal is to represent inline
> sites in BTF such that we can see when a function has been partially or
> fully inlined, or indeed when optimizations have been applied to its ,
> parameters which result in it being unsafe for fprobe()ing - in these
> cases we skip representing such functions in BTF today.
>
> In the case of inlined/optimized functions the proposal is to represent
> them via BTF location data; not all of these locations will have all
> parameters available due to optimization etc. However even absent that
> it is still valuable to know such inlining has occurred as you say.
>
> [1]
> https://lore.kernel.org/bpf/20251008173512.731801-1-alan.maguire@oracle.com/

Fresh stuff! Thanks for the link, Alan.

(I could have used the search box harder. Shame on me.)

[...]
