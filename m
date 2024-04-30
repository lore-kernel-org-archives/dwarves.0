Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3549D1EB46
	for <dwarves@vger.kernel.org>; Tue, 30 Apr 2024 14:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714488469; cv=none; b=VwpULXzIelYU6L61mO1nQlizpolHACL7/zr+z2PVKVA4rzOrZ93djiXuVrIKeqP30cw8b1it5kJdz8NmGMbS+qJIDIytJ7jK4EEEiUpIdPk2yGqK1+RrOyXsysT5YEhTkxnPKRIbGog3HbhXbWbQallwrxHMMxluZtN7agjfyJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714488469; c=relaxed/simple;
	bh=oBUxWt5MfmvzjnxVJfEqg3yCglJgFg214+yYyn3L7Rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q0dcZ6MLcxvwHB6JfomqIE0McYsfIT558zHh2sw9ZWyw11bOyZgMiwzPpNjM+PHBLjYxrgit9F3Nh6N4XMyMEZiVtsMR29Hg575f7pqT7fw5mNxEypRrnR5xmOqegLAmTzDd0QFhMeJ5JqrCa+qbcXXLSFAxbQdlSbxpZT0Ku0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aqEw5pi/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqEw5pi/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D118C2BBFC;
	Tue, 30 Apr 2024 14:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714488468;
	bh=oBUxWt5MfmvzjnxVJfEqg3yCglJgFg214+yYyn3L7Rw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aqEw5pi/Zs4IvjEHC/9hIkb7n7vjC2aN+rDeVBZ+U6quo9ENwr9VNekrCIeWtSW6c
	 4euFERwEcC+dnuT4tpvTJhFoD3Aw1+VELkDUGXEKOJikmpSR6WGdBhTZ/39DeB0/gf
	 RuTctnwVG50W+thKTh3iYvUzYQ1gstgbB2oInvjIH4P7QEUWUwIp1nAw1yBbOZKHD2
	 HSilEVP6uJLTuPdk/WmOMvgAhYkXGJzOgnGW2ZnOBwH3txkjduN3hmeHXRoOGWLLvi
	 UTwrHI8jACXfFgMwemDtUW0AQfq2MczjJFiA/DE1Ifki8g+132OSe2xGWzkEGviA8K
	 t2svve7tJ1rmA==
Date: Tue, 30 Apr 2024 11:47:44 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii.nakryiko@gmail.com, dwarves@vger.kernel.org, jolsa@kernel.org,
	williams@redhat.com, kcarcia@redhat.com, dxu@dxuuu.xyz,
	eddyz87@gmail.com
Subject: Re: [PATCH dwarves] Documentation/pahole: describe expected use of
 'default'
Message-ID: <ZjEEkDmfb9Az5PHh@x1>
References: <20240430095501.1959359-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430095501.1959359-1-alan.maguire@oracle.com>

On Tue, Apr 30, 2024 at 10:55:01AM +0100, Alan Maguire wrote:
> the 'default' --btf_features option is useful for testing the latest
> set of standard features used for BTF encoding, but will not be used
> in the kernel Makefile.btf.  It functions as a useful shortcut for
> testing the latest set of standard features.  Describe this in the manual
> page.

Thanks, applied!

FYI: all this is now on the master branch, it sat for a good time on the
'next' branch, got tested by multiple people and by the libbpf CI at
github.

Plans now are to get the kfunc stuff as the last feature for 1.26.

- Arnaldo
 
> Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  man-pages/pahole.1 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
> index e3c58e0..19bf197 100644
> --- a/man-pages/pahole.1
> +++ b/man-pages/pahole.1
> @@ -290,7 +290,7 @@ Allow using all the BTF features supported by pahole.
>  
>  .TP
>  .B \-\-btf_features=FEATURE_LIST
> -Encode BTF using the specified feature list, or specify 'default' for all standard features supported.  This option can be used as an alternative to unsing multiple BTF-related options. Supported standard features are
> +Encode BTF using the specified feature list, or specify 'default' for all standard features supported.  This option can be used as an alternative to using multiple BTF-related options, and 'default' represents the standard set of BTF features that are in use for kernel BTF generation, so is useful as a shortcut for testing the latest set of standard features.  However kernel builds will call out specific features rather than using 'default' to ensure that the desired features are enabled regardless of pahole version and associated 'default' set.  Supported standard features are
>  
>  .nf
>  	encode_force       Ignore invalid symbols when encoding BTF; for example
> -- 
> 2.39.3
