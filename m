Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D1A13DBA5
	for <dwarves@vger.kernel.org>; Tue, 27 Feb 2024 13:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709041345; cv=none; b=mA7uTYcIeK57hA8zHKA5beZ0LGAbNieaS1PO+739S6WVnQ2Zume23JaaLs4kbVhI9BFxANuCmxENeqznjsWeHRj26F006QtCHivVERNmryp6taUcbeK5dttZxv8CpmSBiv0z6ycv1LWQgCwOdOjObK4APCaXg7hjq/I3yAmyViY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709041345; c=relaxed/simple;
	bh=nS+mNJ0+QQ6e/5dfcYA2i1xCmmGPulNm+/5QRS/q1mY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CViPzFtW+QfWBbIOoz6Tc0wxHpMBTdhFI+Psjfj7+5ACPzKL6OD/VAwMB4m99FkpDw1H477PtQF9yOfIpMCVaGBeRY4sZsw2R5GZrZgfWxidbhkOafzF8BtIMWMeeHL2LWjpzzS6LeO5y+5a6iUV8+JNxAVlUiNGUHFHd8PGhJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h8oEnF+O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h8oEnF+O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F6A1C433F1;
	Tue, 27 Feb 2024 13:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709041344;
	bh=nS+mNJ0+QQ6e/5dfcYA2i1xCmmGPulNm+/5QRS/q1mY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h8oEnF+Oos1J+BoVFhqdvoBYiHtT7FZe93t9LZq094YGyHLOnmXes7m8jZofhKRaq
	 dtA4K5t6yZJLyWnZhm/274IgyGp3IFAqAq4eyqb0AIF5rg65MlCVXef27TsSmQ606b
	 mFq7aB865kxGLwUWy+rEziS8YtlaQHNUL58UnBHa2Z61bcMCCvTz3YtZY/KL98iI9C
	 a0L5xryD+gATW8OpMmafeFiOIb6DqZs/nzb4pJQJodaAJuqWjrcEhW2cVwK1M1Wabu
	 MoTQa2l5PLq3Cyis/Dt2W+9EMNDt3T6i33SAFS8i2VVRhUW0eTwjTvJwokWGiHgAM1
	 eB2cSmGGQ02Gw==
Date: Tue, 27 Feb 2024 10:42:21 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: J B <jb.1234abcd@gmail.com>
Cc: dwarves@vger.kernel.org
Subject: Re: pahole Version 1.25-4 dumps
Message-ID: <Zd3mvX4N0VXlRoXg@x1>
References: <CAJXMFhFbv5MccigKvmQt9MhYwKv2iyigEG3Bhs64BZ=PMWc0WQ@mail.gmail.com>
 <Zd3gSG7v3web_rM2@x1>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zd3gSG7v3web_rM2@x1>

On Tue, Feb 27, 2024 at 10:14:48AM -0300, Arnaldo Carvalho de Melo wrote:
> On Mon, Feb 26, 2024 at 09:09:34AM +0100, J B wrote:
> > H,i
> > some random tests:
> 
> At some point conf_load became non-optional for:
> 
> Program received signal SIGSEGV, Segmentation fault.
> 0x00007ffff7f4b1ed in dwarf__load_file (cus=0x4052a0, conf=0x0, filename=0x7fffffffe4c3 "bla") at /home/acme/git/pahole/dwarf_loader.c:3626
> 3626		if (conf->max_hashtable_bits != 0) {
> Missing separate debuginfos, use: dnf debuginfo-install bzip2-libs-1.0.8-16.fc39.x86_64 elfutils-libelf-0.190-4.fc39.x86_64 elfutils-libs-0.190-4.fc39.x86_64 glibc-2.38-16.fc39.x86_64 libgcc-13.2.1-6.fc39.x86_64 libzstd-1.5.5-4.fc39.x86_64 xz-libs-5.4.4-1.fc39.x86_64 zlib-1.2.13-4.fc39.x86_64
> (gdb) bt
> #0  0x00007ffff7f4b1ed in dwarf__load_file (cus=0x4052a0, conf=0x0, filename=0x7fffffffe4c3 "bla") at /home/acme/git/pahole/dwarf_loader.c:3626
> #1  0x00007ffff7f310f5 in cus__load_file (cus=0x4052a0, conf=0x0, filename=0x7fffffffe4c3 "bla") at /home/acme/git/pahole/dwarves.c:2074
> #2  0x00007ffff7f31ca1 in cus__load_files (cus=0x4052a0, conf=0x0, filenames=0x7fffffffe1c0) at /home/acme/git/pahole/dwarves.c:2577
> #3  0x000000000040177a in main (argc=2, argv=0x7fffffffe1b8) at /home/acme/git/pahole/syscse.c:159
> (gdb)
> 
> Thanks for the report, I'll add it.

Here are the csets, pushed out now:

⬢[acme@toolbox pahole]$ git log --oneline -3
90201c2bde4b0ca8 (HEAD -> master) prefcnt: cus__load_files() requires a non NULL conf_load
f86ed770b5396cd5 dtagnames: cus__load_files() requires a non NULL conf_load
b2e0f084eca03613 syscse: cus__load_files() requires a non NULL conf_load
⬢[acme@toolbox pahole]$ 

Thanks,

- Arnaldo

> > $ touch test.txt
> > $ syscse test.txt
> > Segmentation fault (core dumped)
> > $ <as above>
> > $ syscse /boot/vmlinuz-linux
> > Segmentation fault (core dumped)
> > $ <as above>
> > 
> > jb
> > 
> 
