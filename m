Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2EE39AF4
	for <dwarves@vger.kernel.org>; Fri,  1 Mar 2024 19:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709320553; cv=none; b=dkBVC0Kk7GcdHGcjNsmNiFwnYVuWOLuR38XfSFew1cPA3V+W7Uc0rCj9Hh17R8g/iB79ZhJjJ3GwRh3Lqt1XfcF+/ZyCLYguinuYtfyCtu6XueN5aet1yeQ+O82j8JqSssHNa2/6bG0GYAbK0nK+nb8CtGJUz8UFosjeOurYnM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709320553; c=relaxed/simple;
	bh=4SGVdNCzUzfJSyLUiv7OJm+Q7HZsz7W458Em84AKSBQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D/T9TLIvUzPLwMvPEBt3eXa84XAj7uIP7ZFwjT+n4tSxqD4CUAlwC0ZhfDRy5qRDUYofNso/cWiyecuJ8x/YIbszsBJf/Rho6DByVnEs8efaV1nbwpgOg1d9rCWg8IJR+Mf5myg5j99FsHsQZRTM3ds17wlLZHrQELAx8XTsN4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IoN1nBGz; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IoN1nBGz"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dcbef31a9dbso1888458276.1
        for <dwarves@vger.kernel.org>; Fri, 01 Mar 2024 11:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709320550; x=1709925350; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4SGVdNCzUzfJSyLUiv7OJm+Q7HZsz7W458Em84AKSBQ=;
        b=IoN1nBGzM8kKRJYCn67Uky3jQ8CmRFaRigUyxYupbK3bd0W4Y4Q4oFL2AaP+IftBTB
         P3AwqIgJVkRvYhQ68XpQbRfgi2jY5r2pKC8bWr7tPV/wVHzJ9UHzPjelEn0UPiephrAt
         FHB8LMqEifgH9TBgLc7rauryOUwzVVa44WFVLPC2M5Bl+NPRetY/F6Z8iYQrA0o3TYqU
         BGKMCkNQC5CXy0F2pr45JsQRRVlyBy3vA/410gAlEWoKt3nkPZbyISENxMW0ZEijk5OR
         OpBxnQMMfIbqnj14uaraEGm7f0XyrEFR14oqKpEzzOY/dd2b6zjwvNi7Iki292HMJNyN
         7Fgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709320550; x=1709925350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4SGVdNCzUzfJSyLUiv7OJm+Q7HZsz7W458Em84AKSBQ=;
        b=R2FvHsSIK9F9OFldRU78Q1OXSJrx+Orp94v7iTM5DszAx6SQxQYfA59xqyDqLBIT/7
         oQpEP3C7Vh5oNgaUH5ODk7zvhFCiXy6fWi/sNSt6/yhaodYle0ZgdsLB1VTqFnaJ9Hoi
         JM51tilnlvAJJzKQNJ6vowh8DEaKG5VZw61B8dZDtztSASCAr8qWwPmnjyklqjar+i4A
         7OquHqMS8tHK/zPZA5QtiUApf2spiwwXMwRNB/afyeeQUD45FqzahqnJoiNCOYu/CEUa
         PVO8uEHpiFQKfm/LU93w9omeKV4JGfQSmBsyseTF57DVTKKeqtwVSQwirNE6ddiPMq68
         aaWg==
X-Forwarded-Encrypted: i=1; AJvYcCXPbAKr+hPHosEjPHsdI2LXqSomXlcEAKVs8bEYQG1kH1wyiiDKsf8CzvTcjiki0OTA3wSCN4vEEnzsbYOKeEl4Ey78m6yoWw==
X-Gm-Message-State: AOJu0YwmTEDZwvZBk2yeVPyRNLft+Dht0Wk4azIIJLyAXNXqzfRoFDn7
	hBhtRTivYMg1VhsN/4twyu7nn7YCi3OAV7UCKBBtmQ1+s7bUSkL+vEb17Fn6fhkN8MjSUBLxq/i
	BmKxP/3JBuEAJAWThgykfevawIKHxtRO7j2wA
X-Google-Smtp-Source: AGHT+IHpoZqSKyU8K72QYJxIxHP1qT5UNeWaLy/IbqZ0RAKIL2jso0DEQzufbvQHjoDbpJ46K4tcQNzrXK7CAMMiHxM=
X-Received: by 2002:a25:850a:0:b0:dcd:3172:7269 with SMTP id
 w10-20020a25850a000000b00dcd31727269mr2397758ybk.2.1709320550364; Fri, 01 Mar
 2024 11:15:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228032142.396719-1-jhubbard@nvidia.com> <Zd76zrhA4LAwA_WF@krava>
 <856564cf-fba4-4473-bfa9-e9b03115abd1@oracle.com> <983b98db-79c0-4178-b88f-61f39d147cf7@nvidia.com>
 <34157878-c480-44bb-91d6-9024da329998@oracle.com> <f248cf92-038c-480f-b077-f7d56ebc55bc@nvidia.com>
 <ZeHi4qz8HqDSCC4H@krava> <a0ea8c23-96e8-4ad2-8523-6749dc59b462@nvidia.com>
In-Reply-To: <a0ea8c23-96e8-4ad2-8523-6749dc59b462@nvidia.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 1 Mar 2024 19:15:36 +0000
Message-ID: <CAJuCfpGMoOTPBJoT=R8GayLg6rfFRppKameeW1w3_V1=YgL6kA@mail.gmail.com>
Subject: Re: [PATCH] fix linux kernel BTF builds: increase max percpu
 variables by 10x
To: John Hubbard <jhubbard@nvidia.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, dwarves@vger.kernel.org, 
	Kent Overstreet <kent.overstreet@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 6:33=E2=80=AFPM John Hubbard <jhubbard@nvidia.com> w=
rote:
>
> On 3/1/24 06:14, Jiri Olsa wrote:
> > On Thu, Feb 29, 2024 at 10:15:23AM -0800, John Hubbard wrote:
> >>> ...
> >>> Running
> >>>
> >>> bpftool btf dump file vmlinux |grep "] VAR"
> >>>
> >>
> >> $ bpftool btf dump file vmlinux |grep "] VAR" | wc -l
> >> 4852
> >>
> >> $ bpftool btf dump file vmlinux |grep "] VAR" | tail -5
> >> [136994] VAR '_alloc_tag_cntr.9' type_id=3D703, linkage=3Dstatic
> >> [137003] VAR '_alloc_tag_cntr.5' type_id=3D703, linkage=3Dstatic
> >> [137004] VAR '_alloc_tag_cntr.7' type_id=3D703, linkage=3Dstatic
> >> [137005] VAR '_alloc_tag_cntr.17' type_id=3D703, linkage=3Dstatic
> >> [137018] VAR '_alloc_tag_cntr.14' type_id=3D703, linkage=3Dstatic
> >>
> >>> ...should give us a sense of what's going on. I only see 375 per-cpu
> >>> variables when I do this so maybe there's something
> >>> kernel-config-specific that might explain why you have so many more?
> >>
> >> Yes, as mentioned earlier, this is specifically due to the .config.
> >> The .config is a huge distro configuration that has a lot of modules
> >> enabled.
> >
> > could you share your .config? I tried with fedora .config and got 396
> > per cpu variables, I wonder where this is coming from
> >
>
> Attaching it. And based on your results, I think that Suren's Memory
> allocation profiling patchset v4 [1] may also be required, as that is wha=
t
> I was building.

Yes, that will definitely increase the number of required per-cpu
variables since it adds a per-cpu variable for each kernel allocation
to track it. I vaguely remember now that Johannes also mentioned
hitting this limit when he was using our patchset. Allocating
encoder->percpu.vars dynamically seems to be a great way to fix this
limitation.

>
> Cc: Suren and Kent. btw, I the whole reason I went down this path was tha=
t
> I recommended your patchset in order to zero in on a memory leak that a
> colleague is debugging. This patchset provides a new view of allocations
> and leaks and we have high hopes for it. :)

Thanks for trying it out John and CC'ing us on this thread!
Suren.

>
>
> [1] https://lore.kernel.org/20240221194052.927623-1-surenb@google.com
>
>
> thanks,
> --
> John Hubbard
> NVIDIA
