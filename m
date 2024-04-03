Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9F0153511;
	Wed,  3 Apr 2024 18:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712168389; cv=none; b=rYxLESTyawr9KtdWcw3ApTghQM7W6gJ2c9SB59te+blq6j+HV+rV+dHM7NCQ1wzYocYXrxcnJYbcU0ZrYYXgu1t+Rx2APR/+LBeM9oLHi6ZeQs6sPVaNYQ0Qk0xJXGRwHyZ/wfcqHnYUyx9iI43OLszn5dXNoUJXhIghcqC4kJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712168389; c=relaxed/simple;
	bh=mJ5BSIxZ0+2uFrYSCW87YYS2UquT7i2UiMYxOObMnkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bHNhta6Jf0kv7MzyXaT/wNigAE4t8M2DJsOj/kVjycZv7m0t7iDLORB57GkApcWGTcNJSJJJHrXws/qN4XW6IBGMl2qCsb+4jt0M4FkisgqMxxcZ2B8VYlINEx+NKYkVDf0u5I3A+9JpogKi3nvgHSZFBfpn+miJSBxz/tOxs8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XtfEMG34; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XtfEMG34"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5cddfe0cb64so150504a12.0;
        Wed, 03 Apr 2024 11:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712168387; x=1712773187; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zSMhmZfdMqQ3LaPuP+97PmbA0PsZfnf6Q7+3E2Mb+6A=;
        b=XtfEMG349+YDmnTp3p24XZ7zxZclsloyr1hYccuonaxrnh/vNlOI58Kzlwvf9mYIHF
         UOS9clW5OJLi5QUCFvzebUotixqszmroQNakgLqSM5Gs4mqA6x+65sg173VP/P1HBnVl
         tW+q86FTwGpF4Strqu3U/LZO0qw2LQXWLZDGWEq8RiI6C+l6GgGDt64DvlO6PZkHXPxw
         vqonl0vMD+18ya2yYvYxGXEuDtsdMdp9fYB5Z9oqQoVAS3UO1F99lA50AAMto2omB9he
         nysfcYdTFxhvsHNhPNEdo1fbchGy11sTZsC23oA+ilrqYILfGt+EtKt+veZCbOB9ATcl
         o81g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712168387; x=1712773187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zSMhmZfdMqQ3LaPuP+97PmbA0PsZfnf6Q7+3E2Mb+6A=;
        b=BTxsOxRNNN+rr79omxYkXOTqm9375T0XeWwv3cNzMqjTqPyQjCTiKOyYqktolIkLz2
         xjTbJ7tkYqABCZH008xQ2lNGzUhysDh7ZLOGF5p2z5Wwn2z/yqdt4jpyk9Gwx7Nfr8Gz
         JfZbkz50+Fs1dkQ82sg5NUrNB5ja+HlI6cERkygbbMZRWf94ELxosMg3Nk294oLjBA+d
         LS20Ekdcd94EalCa3ylyvRzg8WARHPkxdid8turduViA+yXcE88YO72G8tdEOAoC5RCH
         DjCtsAZsZ/0DhxjKhBopj39A50jmcOHc18e24Z9wAr16o7Br8JIX3qo4/mPZs1iX242N
         vHmQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7OnEgdKxUYAV+sXjiV5rL5joQEGyc5KooxZZrEZ6IUrqTun1/6Tg/36bjiR9OUkpdhCc7Oe4o2z3HnSBvIOJFnCKA
X-Gm-Message-State: AOJu0YzZZ/aOkzT67c6+fQ3S8e4rk4X/Vu8vrKUIbkPFjDHcyEw+GCC8
	xaicm5cCkFTFqoFHr8OrAn2lB79diZMrFR7ETf9XcDDgKjyAG7jMxsVhX3TO8UojyOmjdITA+vI
	C9IB8m6mGP3tsXkCx7qRe1flaYm4=
X-Google-Smtp-Source: AGHT+IF53qOazJIi76k3j2G0aZ+UxcYFNoGT9ecF6ATC46GPVCkVy5rnDzYabwXV6GSRVcBEzihXSA7qC0ocPuH5m3A=
X-Received: by 2002:a05:6a20:a125:b0:1a7:2e6f:e5d3 with SMTP id
 q37-20020a056a20a12500b001a72e6fe5d3mr571123pzk.3.1712168387154; Wed, 03 Apr
 2024 11:19:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402193945.17327-1-acme@kernel.org> <20240402193945.17327-3-acme@kernel.org>
In-Reply-To: <20240402193945.17327-3-acme@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 3 Apr 2024 11:19:33 -0700
Message-ID: <CAEf4Bza1BG+f__D4fvDvZueGxL0yrMuVu6LZQmNyme584L7r4w@mail.gmail.com>
Subject: Re: [PATCH 02/12] pahole: Disable BTF multithreaded encoded when
 doing reproducible builds
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: dwarves@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, 
	Clark Williams <williams@redhat.com>, Kate Carcia <kcarcia@redhat.com>, bpf@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, Alan Maguire <alan.maguire@oracle.com>, Kui-Feng Lee <kuifeng@fb.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 12:40=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> Reproducible builds need to produce BTF that have the same ids, which is
> not possible at the moment to do in parallel with libbpf, so serialize
> the encoding.
>
> The next patches will also make sure that DWARF while being read in
> parallel into internal representation for later BTF encoding has its CU
> (Compile Units) fed to the BTF encoder in the same order as it is in the
> DWARF file, this way we'll produce the same BTF output no matter how
> many threads are used to read BTF.
>
> Then we'll make sure we have tests in place that compare the output of
> parallel BTF encoding (well, just the DWARF loading part, maybe the BTF
> in the future), i.e. when using 'pahole -j' with the one obtained when
> doing single threaded encoding.
>
> Testing it on a:
>
>   # grep -m1 "model name" /proc/cpuinfo
>   model name    : 13th Gen Intel(R) Core(TM) i7-1365U
>   ~#
>
> I.e. 2 performance cores (4 threads) + 8 efficiency cores.
>
> From:
>
>   $ perf stat -r5 pahole -j --btf_encode_detached=3Dvmlinux.btf.parallel =
vmlinux
>
>    Performance counter stats for 'pahole -j --btf_encode_detached=3Dvmlin=
ux.btf.parallel vmlinux' (5 runs):
>
>          17,187.27 msec task-clock:u       #    6.153 CPUs utilized   ( +=
-  0.34% )
>   <SNIP>
>             2.7931 +- 0.0336 seconds time elapsed  ( +-  1.20% )
>
>   $
>
> To:
>
>   $ perf stat -r5 pahole -j --reproducible_build --btf_encode_detached=3D=
vmlinux.btf.parallel.reproducible_build vmlinux
>
>    Performance counter stats for 'pahole -j --reproducible_build --btf_en=
code_detached=3Dvmlinux.btf.parallel.reproducible_build vmlinux' (5 runs):
>
>          14,654.06 msec task-clock:u       #    3.507 CPUs utilized   ( +=
-  0.45% )
>   <SNIP>
>             4.1787 +- 0.0344 seconds time elapsed  ( +-  0.82% )
>
>   $
>
> Which is still a nice improvement over doing it completely serially:
>
>   $ perf stat -r5 pahole --btf_encode_detached=3Dvmlinux.btf.serial vmlin=
ux
>
>    Performance counter stats for 'pahole --btf_encode_detached=3Dvmlinux.=
btf.serial vmlinux' (5 runs):
>
>           7,506.93 msec task-clock:u       #    1.000 CPUs utilized   ( +=
-  0.13% )
>   <SNIP>
>             7.5106 +- 0.0115 seconds time elapsed  ( +-  0.15% )
>
>   $
>
>   $ pahole vmlinux.btf.parallel > /tmp/parallel
>   $ pahole vmlinux.btf.parallel.reproducible_build > /tmp/parallel.reprod=
ucible_build
>   $ diff -u /tmp/parallel /tmp/parallel.reproducible_build | wc -l
>   269920
>   $ pahole --sort vmlinux.btf.parallel > /tmp/parallel.sorted
>   $ pahole --sort vmlinux.btf.parallel.reproducible_build > /tmp/parallel=
.reproducible_build.sorted
>   $ diff -u /tmp/parallel.sorted /tmp/parallel.reproducible_build.sorted =
| wc -l
>   0
>   $
>
> The BTF ids continue to be undeterministic, as we need to process the
> CUs (compile unites) in the same order that they are on vmlinux:
>
>   $ bpftool btf dump file vmlinux.btf.serial > btfdump.serial
>   $ bpftool btf dump file vmlinux.btf.parallel.reproducible_build > btfdu=
mp.parallel.reproducible_build
>   $ bpftool btf dump file vmlinux.btf.parallel > btfdump.parallel
>   $ diff -u btfdump.serial btfdump.parallel | wc -l
>   624144
>   $ diff -u btfdump.serial btfdump.parallel.reproducible_build | wc -l
>   594622
>   $ diff -u btfdump.parallel.reproducible_build btfdump.parallel | wc -l
>   623355
>   $
>
> The BTF ids don't match, we'll get them to match at the end of this
> patch series:
>
>   $ tail -5 btfdump.serial
>         type_id=3D127124 offset=3D219200 size=3D40 (VAR 'rt6_uncached_lis=
t')
>         type_id=3D11760 offset=3D221184 size=3D64 (VAR 'vmw_steal_time')
>         type_id=3D13533 offset=3D221248 size=3D8 (VAR 'kvm_apic_eoi')
>         type_id=3D13532 offset=3D221312 size=3D64 (VAR 'steal_time')
>         type_id=3D13531 offset=3D221376 size=3D68 (VAR 'apf_reason')
>   $ tail -5 btfdump.parallel.reproducible_build
>         type_id=3D113812 offset=3D219200 size=3D40 (VAR 'rt6_uncached_lis=
t')
>         type_id=3D87979 offset=3D221184 size=3D64 (VAR 'vmw_steal_time')
>         type_id=3D127391 offset=3D221248 size=3D8 (VAR 'kvm_apic_eoi')
>         type_id=3D127390 offset=3D221312 size=3D64 (VAR 'steal_time')
>         type_id=3D127389 offset=3D221376 size=3D68 (VAR 'apf_reason')
>   $
>
> Now to make it process the CUs in order, that should get everything
> straight without hopefully not degrading it further too much.
>
> Cc: Alan Maguire <alan.maguire@oracle.com>
> Cc: Kui-Feng Lee <kuifeng@fb.com>
> Cc: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  pahole.c | 25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
>

We can still produce per-thread smaller BTFs in parallel, that won't
hurt reproducibility. You only need to concatenate them in
reproducible order at the very end.

Or maybe it's already working like this, not sure, I'm a bit rusty in
pahole internals nowadays, sorry :)

> diff --git a/pahole.c b/pahole.c
> index 96e153432fa212a5..fcb4360f11debeb9 100644
> --- a/pahole.c
> +++ b/pahole.c
> @@ -3173,6 +3173,14 @@ struct thread_data {
>         struct btf_encoder *encoder;
>  };

[...]
