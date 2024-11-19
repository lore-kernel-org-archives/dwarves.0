Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E8E1D1E65
	for <dwarves@vger.kernel.org>; Tue, 19 Nov 2024 20:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732047513; cv=none; b=gG0ikkzvZ1NdGgl+U1HUiHHGMv9AT9MNQoG1YRWBegp59PQbZGnH/vlvsWjwLh1kcAqjQuqtCD8bE8eeeWUhytem2pl5AexaRy2rXekcgsPhSmhP7Jy9QQdGNHwA6KNAemvL8cLZD2HIDWnhfAFPssRK+EQbvQE68uMLEa4sKPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732047513; c=relaxed/simple;
	bh=eXr0ndymq3kPDfCwif2LLhGyCa/VcBXqpzUSZfTOGUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bOgjrgaz1wU3X3fGSZL6wpZw7KTDDil96151NND1oJA+XmGTVfX03sbnsuoQIazuJ41SJ/p+C7FeNX+a4lntXgGEFfZCCeEE2Nit3vycEbtc3E/aSRYVwyMVXZZd0geXNj+BJYIWH675I+PRxj0WdT/vIJzu9hjpy2x1tWaHBS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N6L2fm6G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N6L2fm6G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40372C4CECF;
	Tue, 19 Nov 2024 20:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732047513;
	bh=eXr0ndymq3kPDfCwif2LLhGyCa/VcBXqpzUSZfTOGUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N6L2fm6G7TzIC/vIHoQ3thDUDK41AUzGnhE43ljIFIAZ9/FGXFyVVTHXKYL4Q8Od0
	 bdN0CBjbrV7qzbQqU55k/poZTU+AHd5Ney59s1aq2KTmZ554HJ5IjmkubLb1m+J+2m
	 y9hZKwHJKhFHIXf3zhcGIWgs4DYxmLzVchZ8HPMxombkOzcZPOgBmupCDRR/BSytRr
	 EvfuXpJWwVwnhd0FuP5m6LYJIk0CX/F9vG3YpNGqgz240fXDOMLhphIUPSDCCu8rh7
	 Z2s5TYNYKDTa8JsbrsowagneJLSM9W+fKF8OGQ03DfA2Klp7aFYLmL/oBes21BK/Ar
	 KJ5wLcU0i7KFA==
Date: Tue, 19 Nov 2024 17:18:29 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>, dwarves@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Matthias Schwarzott <zzam@gentoo.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH 3/5] pahole: Honour exclusive BTF loading
Message-ID: <ZzzylUuU-a9Y3XB8@x1>
References: <20241119134032.783215-1-acme@kernel.org>
 <20241119134032.783215-4-acme@kernel.org>
 <0ddffba9-eb26-456b-bfa6-68bf94e8b481@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ddffba9-eb26-456b-bfa6-68bf94e8b481@oracle.com>

On Tue, Nov 19, 2024 at 05:47:21PM +0000, Alan Maguire wrote:
> On 19/11/2024 13:40, Arnaldo Carvalho de Melo wrote:
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > 
> > When we specify 'btf' and BTF info is available in the system, in the
> > /sys/kernel/btf/vmlinux file, pahole will find it and use it to get the
> > type information asked for:
> > 
> >   root@x1:~# perf trace -o /tmp/output -e openat pahole -F btf list_head ; tail -1 /tmp/output
> >   struct list_head {
> >   	struct list_head *         next;                 /*     0     8 */
> >   	struct list_head *         prev;                 /*     8     8 */
> > 
> >   	/* size: 16, cachelines: 1, members: 2 */
> >   	/* last cacheline: 16 bytes */
> >   };
> > 
> >        1.579 ( 0.010 ms): pahole/764777 openat(dfd: CWD, filename: "/sys/kernel/btf/vmlinux", flags: RDONLY|CLOEXEC) = 3
> >   root@x1:~#
> > 
> > But, if the system doesn't have BTF info, which we now can simulate by using an
> > environment variable it is tryng DWARF after failing for BTF, which isn't what
> > the user asked for having specified just btf in the -F pahole command line:
> > 
> >   root@x1:~# export PAHOLE_VMLINUX_BTF_FILENAME=non-existent
> >   root@x1:~# perf trace -o /tmp/output -e openat,access pahole -F btf list_head ; tail -12 /tmp/output
> >   struct list_head {
> >   	struct list_head *         next;                 /*     0     8 */
> >   	struct list_head *         prev;                 /*     8     8 */
> > 
> >   	/* size: 16, cachelines: 1, members: 2 */
> >   	/* last cacheline: 16 bytes */
> >   };
> > 
> >   1.643 ( 0.003 ms): pahole/765220 access(filename: "list_head", mode: R)      = -1 ENOENT (No such file or directory)
> >   1.658 ( 0.002 ms): pahole/765220 access(filename: "non-existent", mode: R)   = -1 ENOENT (No such file or directory)
> >   1.697 ( 0.018 ms): pahole/765220 openat(dfd: CWD, filename: "/sys/kernel/notes") = 3
> >   1.801 ( 0.004 ms): pahole/765220 openat(dfd: CWD, filename: "vmlinux")       = -1 ENOENT (No such file or directory)
> >   1.807 ( 0.005 ms): pahole/765220 openat(dfd: CWD, filename: "/boot/vmlinux") = -1 ENOENT (No such file or directory)
> >   1.927 ( 0.005 ms): pahole/765220 openat(dfd: CWD, filename: "/usr/lib/debug/lib/modules/6.11.6-200.fc40.x86_64/vmlinux", flags: RDONLY|CLOEXEC) = 3
> >   root@x1:~#
> > 
> > So honour the request and fails when just BTF is asked and no BTF file is
> > found:
> > 
> >   # export PAHOLE_VMLINUX_BTF_FILENAME=non-existent
> >   # pahole -F btf list_head
> >   pahole: couldn't find any btf debug information on this system.
> >   #
> > 
> > Reported-by: Matthias Schwarzott <zzam@gentoo.org>
> > Cc: Alan Maguire <alan.maguire@oracle.com>
> > Cc: Andrii Nakryiko <andrii@kernel.org>
> > Cc: Eduard Zingerman <eddyz87@gmail.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Song Liu <song@kernel.org>
> > Cc: Yonghong Song <yonghong.song@linux.dev>
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> For the series (since some of my replies didn't reach the list, apologies)
> 
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> Tested-by: Alan Maguire <alan.maguire@oracle.com>
