Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0054B313547
	for <dwarves@vger.kernel.org>; Mon, 26 Jan 2026 10:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769421759; cv=none; b=tbf+w4RfPKHdmFvEJTHgjzywO5TSxZteltPIHO5mqxMMuJIYKuQtZiMNpKi6QdgSETU51BCz6vMmjyL6U5zF1pPROuc8OxbZDs02+Tl0qLLuZ/uqhziXPu707zjddwv4PWvwgfceviHParUmbjsabDggnaylmgWY1niEt0oJe3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769421759; c=relaxed/simple;
	bh=heD1/zxbWRIQM9lkgarT0VzF5h/BHiXrLX0s8WFS5PI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EboyMOFYl2XiLMlNWi/3J1Hh9E/4hYdEP8pqPhHi6CJFeZ8C0HYjlUWlEELwctGSLqoF9WWddKyNVcf+8s1K/5KEZFuHfXCYcuHaHmf+IEPEVm11FP1SogmWx3uUIrGpKH10KSe8L/gptxhrFS121AZsSpUZjJUEPtgz7GiWwH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F8EbefgK; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F8EbefgK"
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-65815ec51d3so7792855a12.2
        for <dwarves@vger.kernel.org>; Mon, 26 Jan 2026 02:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769421756; x=1770026556; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9hT60tmihYcKbv1/AvWYSJ5d72JRvZQpyi5UDbrwfXQ=;
        b=F8EbefgKOoVr8jcTTSa5ANHdchKn4LFJzle/laLCnJNWBgE8J9PQ5HW/6Zw3+0/4gd
         V6LB0BFy2fDUCFWsQkPftqlUWmktnrnWyJOzqOhzOp0ekxGuMy6zpv3/rBtPgkDXKZ+P
         NufrKKHX4ujc0PvKans/dIxJuzw75hWQ1ONYsv6G6TGdu0JrghAkVq1BfZGI0o9KpK0S
         mpEotkn6vSzZY33aXuWUOylw8/H7MGUtAntc5g/gDlCzi4U1+0MxNksp/uxFANUzc+2U
         0L8/jBiuoifu5qRCj4wjf07wEaEAbW5M2Eun+3lOEk5CVsVxafDo4DdJJdtDev17SuBV
         OUEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769421756; x=1770026556;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9hT60tmihYcKbv1/AvWYSJ5d72JRvZQpyi5UDbrwfXQ=;
        b=iVsbBcEKYnZiJPn7CjR6RrY9ZkyiWeq9X4BSUXZHpm2bjpfuq0lz9SCGIWJEKJXJU5
         RarftUCBhtyzcHw2sJpBL9ewRH6thN2dyH3hJwe0Sk9TAMkGyX5LbasQ6FzEPAOmEVah
         Kl15Em7jGLHh9WNoXoYoNY18QpKk2AoSmQ/uQMjlrmQS6GGJSxmMpt/Nq6vAJ9WTwtKs
         /827un8PQvEdvgi6kPOpx9v/cygo+vs1ABS/MWZdk2rEW98xL+zP8mutRe8nX1H+ikAX
         CS0iJHwjhWxsHpq0yOA3i0Uet04VhJ5myMjYCm9ytNTpGw8acP36o7Hjl98kEqNkJixb
         nwDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQ80M0Obhk6NfJCX/Js6mbJGXXk0U7VpiPHaIgbin5WxmROBqueJtZt+Cz4XEimJgixshBzKsB@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp3cvR/EtLiZpkZwNdwtAQOAhF8JqPcfEKpUpRbWWmhd+jwp0/
	yHhwLpKiZOszO2Ev3kyGZPpwlsLU5NJ6fWibR9GSiigPwob74qXpFRJelNxU7Ka+tw==
X-Gm-Gg: AZuq6aJS+DY6jPq8ifD4QQobN7+gMEtuQQOZc4akgxb6/Ps00h1wWzaxvJbARun4/xp
	U5zu9supELYJ3GQBSXXETUC5TEu35W89EHtfefjNFW2H3NUvwrqAs8Cf1ywG8R4ex21E3GIM9ji
	6vnmPsXrj9obf+k2QgPxsVZIxCvIKb9dfbfIwhnNfJvPElJfr0Ii6EK7ja4B0WoRe4nbQxC8tol
	AOp9dNIY0tpEmkH9qBx3/n+7AvDk4JFnQegsBDOZHLVWwO01IoRdFbhW05HTUg264GlA2Qy/zeC
	ndTnFite3lfXx7t3bo6eZEIOKzeBm5kNPq1Q82VM6WDLVEK0Q0jxRXW2PmAY3meLlZ2f4iRZgmc
	RVJe24A80Z7NHdPIBn9Vm/mscmJpJVi4+4ti66+naJNKLJFukLdVxRaQ1JWGSjxQ/5x5RGOKylK
	slhiucMyZ2dIVUaN6ZzDtu0QoaQxdXfo1g+4ilGDPnSt57JamePDI=
X-Received: by 2002:a17:907:c10:b0:b88:4ddf:d6f0 with SMTP id a640c23a62f3a-b8d4f723bf6mr282103166b.61.1769421755871;
        Mon, 26 Jan 2026 02:02:35 -0800 (PST)
Received: from google.com (93.50.90.34.bc.googleusercontent.com. [34.90.50.93])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b885b7d7ceasm632281966b.65.2026.01.26.02.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 02:02:35 -0800 (PST)
Date: Mon, 26 Jan 2026 10:02:32 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: yonghong.song@linux.dev, ihor.solodrai@linux.dev, eddyz87@gmail.com,
	jolsa@kernel.org, andrii@kernel.org, ast@kernel.org,
	david.faust@oracle.com, dwarves@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH v2 dwarves 4/5] man-pages: document true_signature
 btf_feature
Message-ID: <aXc7uFtOhE7bSZnw@google.com>
References: <20260123172650.4062362-1-alan.maguire@oracle.com>
 <20260123172650.4062362-5-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123172650.4062362-5-alan.maguire@oracle.com>

On Fri, Jan 23, 2026 at 05:26:49PM +0000, Alan Maguire wrote:
> Ensure non-default "true_signature" feature is documented in
> the manual page.
> 
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

Acked-by: Matt Bobrowski <mattbobrowski@google.com>

> ---
>  man-pages/pahole.1 | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
> index 3125de3..90a8f45 100644
> --- a/man-pages/pahole.1
> +++ b/man-pages/pahole.1
> @@ -337,6 +337,11 @@ Supported non-standard features (not enabled for 'default')
>  	                   of split BTF with a possibly changed base, storing
>  	                   it in a .BTF.base ELF section.
>  	global_var         Encode all global variables using BTF_KIND_VAR in BTF.
> +	true_signature     Encode functions ensuring that binary-level
> +	                   (rather than source-level) signatures are used;
									 ^
									 within the generated BTF.
									 
> +                           for gcc these are ".isra.0" and ".costprop.0"
> +                           optimized functions

For BTF generation, would there ever be a situation whereby we
wouldn't want true signature support? I'm just trying to understand
why this isn't defaulted to true.
