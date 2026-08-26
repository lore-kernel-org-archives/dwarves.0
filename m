Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC63B3F86F9
	for <dwarves@vger.kernel.org>; Wed, 26 Aug 2026 13:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787749807; cv=none; b=OHkD8xF2S5ZhKcI8py7nwwwxrMFwufJ2PDakzUzxRRLk1kMD6SVeUB5PvA4ykcrfDlt4EvZu+0t8ZECPpyCdZF5Jr2BwjG03tVce5i1X9X0fvilcnhQtqDNtfGT47IxiJujE14PBGWR8cJKxp0aHOPywi1UlIn2AwXlfgsy8+Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787749807; c=relaxed/simple;
	bh=EvBc8Y1qeY+sIcbX6RmQrbejf3VrfLDUOScNJ7zMOWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nn1XlDySgxOFHVIFcXpN26K1qKVRMYM4mMWVbLJ5ff9ucyUxBCqzh7KQJaxDQOwsNMUbwQsX8dKgH39gXPtcC7vhsDUlWxwVsCAotCn/RYWtHeK02dizU+W4aE6iJSv0ofVdC+ymH2gC5ADvvptJNP8JxjxQGlDo5WuSJnxshmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZZ6fHHT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZZ6fHHT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 140801F000E9;
	Wed, 26 Aug 2026 13:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787749805;
	bh=WfTivHmQX6E2h94TgtjEwQrr8nB3qlqhsQIltOpW6jI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FZZ6fHHTLcMPCRgcnGWwuBHona74MR8AMG5hsII84HP+Z91Yz5isIAdJXz9yxCxvT
	 4rLbLqNvjwwJVNuv/IE3cpkaynX0DPnf4fAUGBA25GTzNfv7ylp1KATXn+tPDOMLT8
	 FPieXUQfm9lU+ShvqrlnCbHuMkbExJ10rpaBb3takrSa969U1VhdWi85UPCK3WC4gj
	 13fR6Emk0w7gowE3G3T5adavokQfVzG7auW+9kBgB4FMCd4BRe17rh4WaqwPq+IZeA
	 4DjyU5PN9OOQ9JCaoPZ3NzYgPRQNyxu0BrfWXtGP7TMFKGAsEGl3MDEBRTR492dQVo
	 kSuazAT8HYgVg==
Date: Wed, 26 Aug 2026 10:10:03 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Clark Williams <williams@redhat.com>,
	dwarves@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v2 0/9] pahole: Support cross-CU type references and dwz
 alternate debug files
Message-ID: <ao7lqxytDiHmVmkk@x2>
References: <20260821213510.22423-1-acme@kernel.org>
 <ao442rldWrCNG3zC@x2>
 <d85a69a5-b08a-4ec8-b09c-4e45b7c1f712@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d85a69a5-b08a-4ec8-b09c-4e45b7c1f712@oracle.com>

On Wed, Aug 26, 2026 at 12:43:09PM +0100, Alan Maguire wrote:
> On 26/08/2026 01:52, Arnaldo Carvalho de Melo wrote:
> > On Fri, Aug 21, 2026 at 06:34:59PM -0300, Arnaldo Carvalho de Melo wrote:
> >> Add support for cross-CU type references and dwz alternate debug
> >> files so pahole can process binaries (e.g. a perf binary with rust
> >> objects, or Firefox) that use DW_FORM_ref_addr inter-CU references or
> >> dwz-compressed .dwz alternate debug files.

> >> Cross-CU type references:

>>   Force-merge CUs that contain inter-CU references (DW_FORM_ref_addr)
> >>   so type lookups resolve correctly.  Handle same-file partial units
> >>   where types are shared across CUs via DW_TAG_imported_unit.  Fix
> >>   cus__merging_cu failing to detect DW_FORM_ref_addr when
> >>   DW_FORM_implicit_const causes dwarf_getabbrevattr() to fail.

> > I did a lot of test runs, and with the patches that are waiting for this
> > series to be landed that stress even more this series, so I'll merge
> > this tomorrow unless anybody have anything against it.
 
> > And then as a followup I'll land a series of test patches that don't
> > affect the functioning of these tools, just do coverage analysis and add
> > lots more tests for its features.
 
> > We need to release a new version as there are people asking for features
> > developed and not yet released, so I'll make sure we get the goodies in
> > and the release out ASAP,
 
> Changes look good CI-wise, one issue that we see (not just for this series)
> is that perf on some systems is a shell script that selects the kernel-version-specific
> binary, so the result is tests relying on perf being a binary get skipped.
> Not a big deal now but maybe we could come up with variants in the future that
> generate inter-cu references reliably locally.

So, one of the patches in one of the test series is:

commit b7938d358c59c279a33a2c4de8943e5469a659bf
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Tue Aug 4 11:07:38 2026 -0300

    tests: Add automatic perf building for cross-distro compatibility

    Make perf-dependent tests work across all distributions by building
    perf from source when the system version lacks debug info. Previously
    tests failed or skipped on Alpine, Debian without -dbgsym packages,
    and other environments lacking perf debug packages.

    Add get_perf_with_debug() helper to test_lib.sh that:
    - Checks if system perf has debug info (file command, "not stripped")
    - Downloads perf-specific tarball (~3MB) and builds with DEBUG=1
    - Caches build in /tmp/pahole-test-perf-cache for reuse
    - Supports wget and curl for download (Alpine compatibility)
    - Skips gracefully if build fails

    Uses kernel.org's perf-specific tarballs (HOWTO.build.perf) rather
    than cloning the full kernel tree (~200MB+) for efficiency.

    Before: 3 tests (inter_cu_refs, prettify_perf.data, prototypes) skip
            on Alpine 3.20 and other distros without perf debug packages

    After:  Tests auto-download perf tarball and build from source
            (one-time ~2min setup), then pass on all distros including
            Alpine/musl systems

    Update 3 tests to use get_perf_with_debug() instead of checking for
    system perf.

    Tested: All tests pass on Fedora with system perf, build-from-source
            path exercises on systems without perf debug info.

    Assisted-by: Claude:claude-sonnet-4-5
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

> I tried a few other approaches where we handle inter-cu references, but all seemed
> like they were a bit too complex or involved multiple traversals of the CU set and
> were too expensive time-wise.
 
> I can land these if you'd prefer, whatever works. Thanks!

Please do it, I think its better so that we try to have multiple people
involved in landing features that touch the code code like in this case.

I'll then land the testing infra that doesn't touch the code code and is
less risky.

Thanks!

- Arnaldo
