Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E69675816;
	Thu,  4 Apr 2024 09:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712223750; cv=none; b=XTE/YfE2vgNEcwjfKOMvg38Jg9d5o97WIHs5yXGdvl1GixxJVIcDreWtnX4Kd8TeB00YCH2T8SSYQSuEHikHTEDR8+CjMyhT8NbDAu3MIBFAZR9lmd0MtNWPkfwQShUTdlX8MB/Tb2jv14sCV4bYtrVfriYNxxhiZjo79Z0e51U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712223750; c=relaxed/simple;
	bh=1FzNf2cJWe/czz5tnVBjAmFTW5hziKsjDBAr0YxGBG8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o5udJGAgxI93G5Z3Ba2H7iz5eBWCpfWuiuZhLycRjWIjw3Y/6JC94CfHE6AdnIbRassdMxQ2KEO4CXwvs7hWE7C6A4mNC+oEN9a/rBBYzpNeRcYNAa/H67RZRp2r+waY3DJiLOxl+8b6kNor0XY6n/5Jx7Wc+pqoyeguXvBy7pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bmSds30s; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bmSds30s"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-343cd236779so108389f8f.3;
        Thu, 04 Apr 2024 02:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712223747; x=1712828547; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C2mwQ4cIpCk9JgTJJOoZdjhLATYTInjRRedpQUJfEPQ=;
        b=bmSds30spmgvMA5IWBfnNxnI1p62iw2OcxZK2PdPLFFC4lAO2DVUe+2/oLkqD+LfZi
         h6lDH4FDuSFsL/N7V31ldPE2iP7qTyOKD2Oy5va39PFFvEwtGUajOGipb+h5vM9/JSAR
         4CWVkztnX+0HPtOHxKG5Z1OIhavyuzE6x81k5uUwcMPA6i6BoQe1ez8WjdPKr33Gx7kf
         V7oR+DE4lM4CbyFVUAcdNEFytCj2OoF1F8wtwflIljvsSbwY5UCb67pDcDve11S8s8J0
         7EOuH7wuplFKAEUSfIwtmN8KiU0pIF2hOu2A683/WxD5K3lbjESb/CJFSZwcrLJ8/jnF
         v5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712223747; x=1712828547;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2mwQ4cIpCk9JgTJJOoZdjhLATYTInjRRedpQUJfEPQ=;
        b=d4HHwdV+BkZoefM5GyjRa9jDQQPel7vUQ3s/OJmuneQeMDfZHuwmwI2ZL/d6xGK1NO
         4cxWCxwaFMbH34F2tpdcv6Sqh8JylVh/hzPbhatLufwORmpl9ks0Isw8FmjPhWuoz2Rc
         sSFfq5wZS/Cx5TZz4jx3y0l62Dqu7joDSal9/6p2KVolsQN81WIcJ5NFWvmUDHaxD9S6
         Zd8D9mWpcYffiYQ65UPRORU44qGW25Q2zEEtWBS/sMoITitOav+/ccHT6qN/W9Z9aTwr
         5DFNHB87Psdu58y/+UPiROdvrpnTwwCk6B0z8DNyXO7CbUWmJbqjJlmpY6BioeKYShT1
         2CnQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6/ktVqBqNINFZU0uKkI0N+Gs514mOlyCoOLROUx78TvRkWbLoqvHDzY9HG6EBZs98XTRj+qAuu9Sxcktb5q0ECqiV
X-Gm-Message-State: AOJu0YzEP6ZhfD3m4/wwETxqo9ADaH179G6UduRJr83ezMegOsqxb8wC
	SiAcH5PnJYNC8rnZiWe9/jwzCQHPTMUvRvUeMNV/YsM4RYwRxrMW
X-Google-Smtp-Source: AGHT+IHyNbZBSdT3xpb//jGzQ8QHtGoEXODBfmLn3SsJsA6nZ4UqB5tr7F7PpqhINA9aWcbzFJl6+Q==
X-Received: by 2002:a5d:5451:0:b0:343:7653:ad14 with SMTP id w17-20020a5d5451000000b003437653ad14mr1870963wrv.30.1712223747162;
        Thu, 04 Apr 2024 02:42:27 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id r10-20020a05600c35ca00b0041622c88852sm2078530wmq.16.2024.04.04.02.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 02:42:26 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 4 Apr 2024 11:42:24 +0200
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: dwarves@vger.kernel.org, Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>, bpf@vger.kernel.org,
	Alan Maguire <alan.maguire@oracle.com>,
	Kui-Feng Lee <kuifeng@fb.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Subject: Re: [RFC/PATCHES 00/12] pahole: Reproducible parallel DWARF
 loading/serial BTF encoding
Message-ID: <Zg52AE0QByIT_07A@krava>
References: <20240402193945.17327-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402193945.17327-1-acme@kernel.org>

On Tue, Apr 02, 2024 at 04:39:33PM -0300, Arnaldo Carvalho de Melo wrote:
> Hi,
> 
> 	This allows us to have reproducible builds while keeping the
> DWARF loading phase in parallel, achieving a noticeable speedup as
> showed in the commit log messages:
> 
> On a:
> 
>   model name    : Intel(R) Core(TM) i7-14700K
> 
>   8 performance cores (16 threads), 12 efficiency cores.
> 
> Serial encoding:
> 
>   $ perf stat -e cycles -r5 pahole --btf_encode_detached=vmlinux.btf.serial vmlinux
>              5.18276 +- 0.00952 seconds time elapsed  ( +-  0.18% )
> 
> Parallel, but non-reproducible:
> 
>   $ perf stat -e cycles -r5 pahole -j --btf_encode_detached=vmlinux.btf.parallel vmlinux
>               1.8529 +- 0.0159 seconds time elapsed  ( +-  0.86% )
> 
> reproducible build done using parallel DWARF loading + CUs-ordered-as-in-vmlinux serial BTF encoding:
> 
>   $ perf stat -e cycles -r5 pahole -j --reproducible_build --btf_encode_detached=vmlinux.btf.parallel.reproducible_build vmlinux
>               2.3632 +- 0.0164 seconds time elapsed  ( +-  0.69% )

hm, got it even faster than paralel build ;-) but it's within the
1 second deviation, I guess it shows better on bigger kernels

reproducible_build:

	[root@krava linux-qemu]# perf stat -e cycles -r 3 -- /home/jolsa/kernel/bpf/pahole/build/pahole -j --reproducible_build --btf_encode_detached=btf.2 ./vmlinux

	 Performance counter stats for '/home/jolsa/kernel/bpf/pahole/build/pahole -j --reproducible_build --btf_encode_detached=btf.2 ./vmlinux' (3 runs):

	   295,519,117,258      cycles                                                                  ( +- 19.48% )

		      9.43 +- 1.02 seconds time elapsed  ( +- 10.84% )

paralel build:

	[root@krava linux-qemu]# perf stat -e cycles -r 3 -- /home/jolsa/kernel/bpf/pahole/build/pahole -j  --btf_encode_detached=btf.2 ./vmlinux

	 Performance counter stats for '/home/jolsa/kernel/bpf/pahole/build/pahole -j --btf_encode_detached=btf.2 ./vmlinux' (3 runs):

	   391,320,973,331      cycles                                                                  ( +- 19.19% )

		     9.851 +- 0.695 seconds time elapsed  ( +-  7.06% )

1 cpu:

	[root@krava linux-qemu]# perf stat -e cycles -r 3 -- /home/jolsa/kernel/bpf/pahole/build/pahole --btf_encode_detached=btf.2 ./vmlinux

	 Performance counter stats for '/home/jolsa/kernel/bpf/pahole/build/pahole --btf_encode_detached=btf.2 ./vmlinux' (3 runs):

	   208,492,342,135      cycles                                                                  ( +- 19.43% )

		    16.761 +- 0.644 seconds time elapsed  ( +-  3.84% )

jirka

> 
> Please take a look, its in the 'next' branch at:
> 
>   https://git.kernel.org/pub/scm/devel/pahole/pahole.git
>   https://git.kernel.org/pub/scm/devel/pahole/pahole.git/log/?h=next
> 
> There is a new tool to do regression testing on this feature:
> 
>   https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?h=next&id=c751214c19bf8591bf8e4abdc677cbadee08f630
>   
> And here a more detailed set of tests using it:
> 
>   https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?h=next&id=4451467ca16a6e31834f6f98661c63587ce556f7
> 
> Working on libbpf to allow for parallel reproducible BTF encoding is the
> next step.
> 
> Thanks a lot,
> 
> - Arnaldo
> 
> Arnaldo Carvalho de Melo (12):
>   core: Allow asking for a reproducible build
>   pahole: Disable BTF multithreaded encoded when doing reproducible builds
>   dwarf_loader: Separate creating the cu/dcu pair from processing it
>   dwarf_loader: Introduce dwarf_cus__process_cu()
>   dwarf_loader: Create the cu/dcu pair in dwarf_cus__nextcu()
>   dwarf_loader: Remove unused 'thr_data' arg from dwarf_cus__create_and_process_cu()
>   core: Add unlocked cus__add() variant
>   core: Add cus__remove(), counterpart of cus__add()
>   dwarf_loader: Add the cu to the cus list early, remove on LSK_DELETE
>   core/dwarf_loader: Add functions to set state of CU processing
>   pahole: Encode BTF serially in a reproducible build
>   tests: Add a BTF reproducible generation test
> 
>  dwarf_loader.c              | 73 +++++++++++++++++++++++---------
>  dwarves.c                   | 58 ++++++++++++++++++++++++-
>  dwarves.h                   | 17 ++++++++
>  pahole.c                    | 84 +++++++++++++++++++++++++++++++++++--
>  tests/reproducible_build.sh | 56 +++++++++++++++++++++++++
>  5 files changed, 264 insertions(+), 24 deletions(-)
>  create mode 100755 tests/reproducible_build.sh
> 
> -- 
> 2.44.0
> 
