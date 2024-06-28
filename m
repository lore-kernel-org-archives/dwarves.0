Received: from submarine.notk.org (62-210-214-84.rev.poneytelecom.eu [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4288B4CB37
	for <dwarves@vger.kernel.org>; Fri, 28 Jun 2024 19:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719603924; cv=none; b=gz1Jm1RyL4lidrHkAsw95sGddSxdTT4Pnc9x0jvjzW5ML7tIrXrc1sVNLGZ4jBggwSHqNfhW6k/Q2PTbfqxmvRgdNY1P89DWhfrTLgGRxBQcfmGQEkFHAQuimZWSMvIkFka8K4Acw7BhyGzMSo60zGlA0P27f2ok62DJW3ZFVgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719603924; c=relaxed/simple;
	bh=hZGBx+PvmTHqID4dmuk0cfCn9lDsyUr7HrElVUAGxUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KYFHaj5C8/QL3Fi5KPJPnOKZVxPlOde22vrfACReKA0FFJnhGoIOqj5pbj8gzjhcs+TIYg38Ny0469JnMYi5tSnTrvHvB5c31lwB7RwsZUob/oRFpotADY3Mh9SP2rhLQufxi3iw9p4F3kPWrznw/7GAAgUtrSAsefwlPcvMdgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=VkbWCEz3; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="VkbWCEz3"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id A2C3614C1E1;
	Fri, 28 Jun 2024 21:45:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1719603913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HVVtYU4+94CI7+Jicwx4MhygHjwXDqGByecJep+cB0Y=;
	b=VkbWCEz3+rxOI5Ss0HIF/nm9mPfKqOa5ydoatcY70jeewOXcU9a4Apq2QR5/Hvt8h+jNuV
	A8MewEjKSzAIINj0LvVl2cWLYEdNdem5JArRfu1AeVul+SwVbSCGoSq/nC87i541ETI/Oj
	iIW6AVkHkxf7lcO7yahVhjSz/TwxbPW4IATIb6/ROFQpJvYtj30nKpVIW/XCc3ZLiCVPpv
	UqgTe+qTgM832gQTSS9hJE6n5SUlDIp7NZyUYuLHEIrCkQO4PF55LFHAJhuDe7r/XaVzW7
	lk+caujbm7UGhNQj6IGAKVRMdHxxXqWH7IHzonos22JKuMoZlO7FNIQQXdIhDg==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 146c351e;
	Fri, 28 Jun 2024 19:45:03 +0000 (UTC)
Date: Sat, 29 Jun 2024 04:44:48 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: acme@kernel.org, andrii.nakryiko@gmail.com, dwarves@vger.kernel.org,
	jolsa@kernel.org, williams@redhat.com, kcarcia@redhat.com,
	dxu@dxuuu.xyz, eddyz87@gmail.com
Subject: Re: [PATCH dwarves] pahole: enable --reproducible_build when
 SOURCE_DATE_EPOCH is set
Message-ID: <Zn8SsFuSAG2qPgzC@codewreck.org>
References: <20240626032253.3406460-1-asmadeus@codewreck.org>
 <c1414fb5-f7a8-4cb4-9c27-9c0c9b431f28@oracle.com>
 <ZnydwHhgCbUbkm44@codewreck.org>
 <fc0bff28-eb41-401b-95d4-49fd4b72e5c7@oracle.com>
 <1213004a-c75a-4882-bd51-47d458c67e04@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1213004a-c75a-4882-bd51-47d458c67e04@oracle.com>

Alan Maguire wrote on Fri, Jun 28, 2024 at 09:31:17AM +0100:
> FWIW I verified that with the above change, and
> 
> export KBUILD_BUILD_TIMESTAMP=$(date -I)
> 
> ...the feature flag is added to pahole and as a result we get
> reproducible BTF in vmlinux; .btf.vmlinux.bin.o is identical across
> multiple kernel builds.

Sorry for the lack of reply, I didn't have time to test until now, and I
have no idea how to override the kernel config in nixos so the checking
build through nix build took all night.
I've now also confirmed this works including for modules BTF & linux
"package" build on nixos on master.

However from there I built a random kernel module and have also
confirmed they don't set KBUILD_BUILD_TIMESTAMP for external modules --
from a quick look it's not part of the default flags defined as
buildFlags here[1] because each modules' SOURCE_DATE_EPOCH isn't
available at this level (and I have no idea how to call a command at
this level), the configurePhase where it's set only applies to the
kernel itself and not the gazillion of modules.
[1] https://github.com/NixOS/nixpkgs/blob/master/pkgs/os-specific/linux/kernel/manual-config.nix

Add to that that nixos is supporting a dozen of kernels -- all mainlines
stable versions but also a dozen of variants (rt, whatever xanmod and
zen are, and if you look for things like mobile-nixos you'll also get
much older and not update sunxi and other embedded trees) I definitely
won't put the effort to backport equivalent patches to all these kernels


I wanted the patch for alpine as well but I honestly don't have the time
to do the same confirmation work there; if they have any external
modules I don't see the flag being set either, at least they don't have
so many kernels.
(but unlike nixos the kernel build "framework" code isn't shared and I
know of at least one out of tree embedded kernel that doesn't set
KBUILD_BUILD_TIMESTAMP and only has SOURCE_DATE_EPOCH...)


So:
 - in theory, sure; this patch works. I say we can do this independantly
of any other effort. The propere way of setting reproducible build in
the kernel is not SOURCE_DATE_EPOCH but KBUILD_BUILD_TIMESTAMP and
handling it at kernel makefile level is sound.
 - in practice, (nixos hat) some modules won't set it but will only have
SOURCE_DATE_EPOCH available, and there are trees that won't be updated
for years (and that's being optimistic), so our local patch in pahole is
here to stay for a while and the benefits far outweight the rebasing
work.
 - (alpine hat) alpine doesn't seem to care as much about
reproducibility (the nixos patch wasn't in and nobody complained so far),
undecided at this point. Makefile.btf patch is probably good enough, but
since I'm maintaining the patch anyway it's no extra work to add it
there, undecided at this point.


Thanks,
-- 
Dominique Martinet | Asmadeus
