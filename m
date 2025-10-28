Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091DF33507A
	for <dwarves@vger.kernel.org>; Tue, 28 Oct 2025 14:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761663220; cv=none; b=hadlhtk0Yo2nLNKZ+W9omivqtBe+rzD8JcjpnLCZAPvI2UNKtFmFJ0z5uXZ4x431ns0hPfvbMRpecIFsSGpCDtQUnn67X+uafQlMfXjkMMHrkh4U7CXDKwwvSCQyNJWPlUsHhCNbiMSsMQo7cDo+NspweOe0ySPYD2Q+dP7WjzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761663220; c=relaxed/simple;
	bh=L9NwUDO4yKaBpQKcoMtJHakWOzCQn/ZxB4fx1VZTbNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hO+90xdIuxLHAwXA9WfDZ4jSFk7rTNQO2CwvpvBscrIX2ixKkfymRd/31eIeIxn+ZuvYaFr0rSxhUyNJXOACsnI3LCPOHxKLZ7hgkiFAGhFAYJUhTFtkEp4XJ+kBMB9a4g/XOFFzBgT9y7F0nyIwCXh+Kzt2QfbUd4IuCL2aHuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JVOW76Sy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JVOW76Sy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A340C4CEFD;
	Tue, 28 Oct 2025 14:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761663219;
	bh=L9NwUDO4yKaBpQKcoMtJHakWOzCQn/ZxB4fx1VZTbNg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JVOW76SyiMNEikm3R/utafYHLpO1u10TfyqajM6EIlZJP1nL0r66hRgfhtOgDetit
	 d+8Kzu025Zne1EuImp6w2qN2m/1pRjIx+WN8giXc3Np9NfTWie89MUqUzQLH+kZiVo
	 BOxIPDh0iBohxOLo/epYk/mQrvew4zoOh6mZ4IbTJbV5SMOOZ6N2+xlNQNPpt02Ytz
	 6cZBcw1MOvw4uRaIF9nfK9pPxvrsaoXRWUWJMigjo1oASzrCZMfrWXS61srH8dOfTy
	 5NrHtpCY4JOBPfgwFL1nRkIG4xOpYTrlzAWo6hi66WfNTXGolEdvNxMd5RE3PpmGwW
	 rPrJai31XTnWA==
Date: Tue, 28 Oct 2025 11:53:35 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Matthias Schwarzott <zzam@gentoo.org>
Cc: Alan Maguire <alan.maguire@oracle.com>, dwarves@vger.kernel.org
Subject: Re: pahole: Fix deprecated cmake_minimum_required
Message-ID: <aQDY7_VtHlFP7ssB@x1>
References: <bef26065-2dd0-43df-9dfb-f3c4b7a17685@gentoo.org>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bef26065-2dd0-43df-9dfb-f3c4b7a17685@gentoo.org>

On Tue, Oct 28, 2025 at 07:58:17AM +0100, Matthias Schwarzott wrote:
> I got to know that using a cmake_minimum_required version of less than 3.10
> is deprecated. Support for it will be removed from cmake.

Support for what? For features present before 3.10? So we better make
sure that we have pahole use that 'cmake_minimum_required(3.10)' so that
we don't end up using such deprecated cmake features and end up breaking
the build in distros using, say, cmake 3.11?

Please CC dwarves@vger.kernel.org when sending patches, like I did in
this reply :-)

Thanks!

- Arnaldo
 
> I suggest to raise the minimum required cmake version to at least 3.10
> (released 20 November 2017).
> See attached patch.

> see gentoo pahole issue: https://bugs.gentoo.org/964482
> gentoo overall issue: https://bugs.gentoo.org/964405
 
> cmake merge request:
> https://gitlab.kitware.com/cmake/cmake/-/merge_requests/9875
 
> deprecate-pre-3.10
> ------------------
 
> * Compatibility with versions of CMake older than 3.10 is now deprecated
>   and will be removed from a future version.  Calls to
>   :command:`cmake_minimum_required` or :command:`cmake_policy` that set
>   the policy version to an older value now issue a deprecation diagnostic.

> From b9e521ef5e9c01d8d19f505de778ceaef5ecd4eb Mon Sep 17 00:00:00 2001
> From: Matthias Schwarzott <zzam@gentoo.org>
> Date: Tue, 28 Oct 2025 07:52:00 +0100
> Subject: [PATCH] CMakeLists.txt: Require cmake 3.10 or higher
> 
> To fix this warning from cmake:
> 
> CMake Deprecation Warning at CMakeLists.txt:1 (cmake_minimum_required):
>   Compatibility with CMake < 3.10 will be removed from a future version of
>   CMake.
> 
>   Update the VERSION argument <min> value.  Or, use the <min>...<max> syntax
>   to tell CMake that the project requires at least <min> but has been updated
>   to work with policies introduced by <max> or earlier.
> 
> Signed-off-by: Matthias Schwarzott <zzam@gentoo.org>
> ---
>  CMakeLists.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/CMakeLists.txt b/CMakeLists.txt
> index eb873000d7bf..91522c1382a5 100644
> --- a/CMakeLists.txt
> +++ b/CMakeLists.txt
> @@ -1,4 +1,4 @@
> -cmake_minimum_required(VERSION 3.5)
> +cmake_minimum_required(VERSION 3.10)
>  project(pahole C)
>  cmake_policy(SET CMP0005 NEW)
>  
> -- 
> 2.51.0
> 

