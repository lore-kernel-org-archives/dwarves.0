Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543242F2616
	for <dwarves@vger.kernel.org>; Tue, 21 Oct 2025 12:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761049931; cv=none; b=E7qUcdcBYr5lfFvzHQRa6PbJAijcajO/dT6qCSlyNdPN1/iXddL1TuG2tODYQarnc2OjkYhwWyF1AdNlhbL+5/WCF7zu8TB95hdm5psku33VAQPjUzBbA9Q8wdh6lQM9n0s3X9RcFLvfAW2L2CC5v2wnYMvI+wy55OABtMX2SyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761049931; c=relaxed/simple;
	bh=OqZpGvkjwOfQHHFVzAVmqW+ATJ5sQiJth0QiaygY6Qo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d2GRmeB7MWGwOYvkMxiP75B7a6yHs/z8VRI3a0PMGZQJTEmscYrbibD0LgbMV3ig/VDT+yKAVlI0/vVSe1G/G6QVJBuRDdimAimrmIm4yUBuqUdccA3ghmGKBxU5oms4nObfLYgE4VLjBR3D9ftvf89nsn4OgVJWeIyr1FylVJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Mb4+R3MP; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Mb4+R3MP"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-634cef434beso10951073a12.1
        for <dwarves@vger.kernel.org>; Tue, 21 Oct 2025 05:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1761049928; x=1761654728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xFwGw6ZE8EhObsv2lodIrTXfK6bSfV60ydBz80z3y+Q=;
        b=Mb4+R3MPF8xwB8vIBpLkcHzBVkaChdW0n6z1jeoWMqU574pg/JYr4togg6CTAC6l05
         wq3Veb8yqwB6SAaTZTsg7qlINys5NQtWBMpN2+erh2UuRv245wlXl4abiVmptHmKhkDh
         Uhvxyoi447ZnM6/HMN52VFlQDza+nUcZ9Iv/TL+7B4PYwyRKatiId6JxsvZANepGkhlY
         IyyLmwD/4KzME0l0Dazd6S8fLvgkTj+WMoFaN/1zZLRS+YW7EbRGwcRPk5dLgKSD0wKK
         Vn1UUvPYhtU0WX+5GkIisunr/69KgU2baTjoZctQ+7nThrf5xhqaNdduruB3GxWpRalL
         46nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761049928; x=1761654728;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xFwGw6ZE8EhObsv2lodIrTXfK6bSfV60ydBz80z3y+Q=;
        b=M3zqVxG8MABB5VtfEW43yIESqbzKdpKR8gLta5di83xQ5hLAHORkV5f3g+ytG3e391
         vYqC4+uWMdUyqjoQps1yCp5NRMk33sy9s9k/ybDRtXTo+7LefJs7i0MKkitkkyetUeu1
         hXBXl2dB+Y9kPHupn555IUOqHf/xYpmp1f/1FESDBwzxJHNsBkOQsPv3XM2Pk0697iLq
         WTo2KaQ5v9ctbaPa2dac4M8qgiO0jIuGD6VNfpHJ+wcMtDfTBYE91Z9+oip8Bfvou7SS
         wjE2j06LMkWT1CbdCZ/xhTtkjvNX/IcpAD3xEN5i4BD/hyZOB/Mzgr4NTGH5BdthkGcf
         rZEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWO3BInnDhBQDQq3jL9SCiHFOh1jMHsGNUKwu9cgU2K+pfn59PGiQRGaRqmFBPJM+Dg6GDe7k45@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg68p2oewFqROKRdk6eA9JUNp9sKBmOJh/J4Z+oED3IFQXltCF
	QZZCj0xmayglKUkSHdxDalTTJKqK2TahRiTS+1UFDT0G6hPq/WRVl6k3YoMkdNoc5Kk=
X-Gm-Gg: ASbGncvhvAJSh8VBEkXa16W0Z3jV01kJRZdeXlZmWQJ8c4VZt9GVbFbeprF1FMKw+I/
	MllC6e+JytwJv/d7kvo6Uv0dtSXHsebS2Hh3QVt6Uxb5E1YUxkzgG/XFPyXP4ZlgzPIHbLACQNI
	FJQHeuKbzfvOGbfCf9qQABe4wDGxaDTBzOpVralPza69ZJqQm/JRbz6Ws+BUTQF1v65Fhkg9WhE
	F2xy+kCjTngLtmH7+brED18UIiHzMx080peQTjcCoBN3l353i1cREe2L0Tq+OYY53lqljzehdek
	t2gdP2hCqPbRWeagyUyCUzS3BN8SQIN8UWpjGRhgfrGW6Y+SASkkBNaiKwUAo3RdwUKh+x8Hex6
	5hg+XdLnpiSELLnK5ms5P0vAMPLgDw8kCQjgytXxp8azbFGy0nGX1kNhGqmwUTv1dRe5cy3bz9B
	DHyLg=
X-Google-Smtp-Source: AGHT+IHWIb+Co+vuJf1iem9c6iig+KbqAhYRE4O2xwNvbAOF2/NUXOJ6de1WKz1tjfueBppgc6L9eA==
X-Received: by 2002:a17:907:9718:b0:b3c:eb78:e085 with SMTP id a640c23a62f3a-b645f0f9992mr2097988866b.27.1761049927573;
        Tue, 21 Oct 2025 05:32:07 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:d0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e8391547sm1069622466b.22.2025.10.21.05.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 05:32:06 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Alan Maguire <alan.maguire@oracle.com>,  Arnaldo Carvalho de Melo
 <arnaldo.melo@gmail.com>,  dwarves@vger.kernel.org,  Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>,
  bpf@vger.kernel.org,  Daniel Borkmann <daniel@iogearbox.net>,
  kernel-team@fb.com, Matt Fleming <mfleming@cloudflare.com>,
 kernel-team@cloudflare.com
Subject: Re: [PATCH dwarves] pahole: Avoid generating artificial inlined
 functions for BTF
In-Reply-To: <20251003173620.2892942-1-yonghong.song@linux.dev> (Yonghong
	Song's message of "Fri, 3 Oct 2025 10:36:20 -0700")
References: <20251003173620.2892942-1-yonghong.song@linux.dev>
Date: Tue, 21 Oct 2025 14:32:05 +0200
Message-ID: <874irswi4a.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 03, 2025 at 10:36 AM -07, Yonghong Song wrote:
> But actually, one of function 'foo' is marked as DW_INL_inlined which mea=
ns
> we should not treat it as an elf funciton. The patch fixed this issue
> by filtering subprograms if the corresponding function__inlined() is true.

I have a semi-related question: are there any plans for BTF to indicate
when a function has been inlined? Not necessarily where it has been
inlined, just that it has, somewhere, at least once.

When tracing with bpftrace or perf without a vmlinux available, it's
easy to assume you're tracing all calls to a function, when in fact some
calls may be inlined within the same compilation unit.

A good example is tracing the rtnl_lock - there are multiple inlined
copies, but neither bpftrace nor perf can warn you about it when debug
info is absent.

$ sudo perf probe -a rtnl_lock
Added new event:
  probe:rtnl_lock      (on rtnl_lock)
=20
You can now use it in all perf tools, such as:
=20
        perf record -e probe:rtnl_lock -aR sleep 1
=20
$ sudo apt install linux-image-`uname -r`-dbg
Installing:
  linux-image-6.12.53-cloudflare-2025.10.4-dbg
[=E2=80=A6]
$ sudo perf probe -d rtnl_lock
Removed event: probe:rtnl_lock
$ sudo perf probe -a rtnl_lock
Added new events:
  probe:rtnl_lock      (on rtnl_lock)
  probe:rtnl_lock      (on rtnl_lock)
  probe:rtnl_lock      (on rtnl_lock)
  probe:rtnl_lock      (on rtnl_lock)
  probe:rtnl_lock      (on rtnl_lock)
  probe:rtnl_lock      (on rtnl_lock)
  probe:rtnl_lock      (on rtnl_lock)
  probe:rtnl_lock      (on rtnl_lock)
  probe:rtnl_lock      (on rtnl_lock)
  probe:rtnl_lock      (on rtnl_lock)
  probe:rtnl_lock      (on rtnl_lock)
=20
You can now use it in all perf tools, such as:
=20
        perf record -e probe:rtnl_lock -aR sleep 1
=20
$

Thanks,
-jkbs
