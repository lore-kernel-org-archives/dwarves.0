Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041B5210E4
	for <dwarves@vger.kernel.org>; Sun,  9 Jun 2024 15:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717947557; cv=none; b=jsGFlS0aNi7C8N0IoiGLcYGm+xmDucKPYZ8bFOKmOb5zcI/3Sm9w075pfX0U0a3WhR7+45XsttTQPdM8XMFtADqi8P0UvXUlHJX0JUjKUlI2aVSgN5wDtQLU5SGd5Sl7cXURTWg5u30cn2BtRlBDaT3wVQhJUH9kFJe99wM/AO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717947557; c=relaxed/simple;
	bh=UucSm74shAzdfgmANthmD017CbYPoloJlGdDFjAe4y8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GlnsqfYYCsZvqEeqjjo8Qm98XzvAwpxAytgMLMUchrYRuuxOXPaFhp+/4Q6x9DNnBTsiNuL0pRmiwVB5e9fsvTfXStxE/M1YLtPz3LyU/KdwEExDxlU/i4GH1qI1xi15SBQRZ+WmIFXk6TgZxyqv8OkydVsn8wwLovMCTe0nVQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N9sEVdpb; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9sEVdpb"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a6f1cf00b3aso40728466b.0
        for <dwarves@vger.kernel.org>; Sun, 09 Jun 2024 08:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717947554; x=1718552354; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sQZ4t63WhUKJh6JL1CbJ7RS6Lmg1h3Mh1hd3bLKXl/4=;
        b=N9sEVdpbeImTaf3MZT85OJvUkrnSYJ74/4A2KFlcgpDqDk5pgfYM43gMmoeKP5xpQ0
         U030Belc9d5jum7v9Il5P4NZPb5JPGIFeGd1NAjmHwQ4Sl0g8adu2hW51p+W8TdvLNR4
         A4RBevUYqzx3MKyP5kxsDf6J+2JV0BlX2xnwRYZbYoaPng6zOgzxv04sop2jpWmAInkp
         Nqrwjm5auZkKdWjukCu0pQi7vXHd957fRYAgln/TD5nslkTqq49V8YGOXgQM9+IuFHum
         5ch1eYJWh5OP8isHK/yiGnQozERsQ7ClezjHC3Gnnd7Hw07fAjTvr/kBfO3ol+7SrvDU
         BiaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717947554; x=1718552354;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQZ4t63WhUKJh6JL1CbJ7RS6Lmg1h3Mh1hd3bLKXl/4=;
        b=sqajzak7qdW4gOqy1xfJZga1UN07wtsfXtNqtqfpaaUytpRDLuE3rzZnnkF2k3XfE1
         8niSmCP+k5ewOhaOpTstTl/ToDk6WMU/aizFH/7lP3lsrI5P6W2nw2lJONsClAJfatAF
         mupRyhEx2Y+tgy9ZuvCOh4iPKyubzWp37B8b194OXWaF1Rdpo8ijYxT/2hJZl+P85s20
         Qq2FFVrk4NRolTtdb2XK679REY+qWmFyAjpEV8p1mN/YuxrgQSWH5BIXlBhh4tN1Ok82
         RMQX7LgRTChP6IVIYk3uPcBdm31Fq49hwW9Z7cO2a/qkTqGUL7GAl6p5sq0vFjuU9IcX
         g8mQ==
X-Gm-Message-State: AOJu0Yz4uApD29QLmo0f2M2zqrOexuKT0dBxWxLU6j+dFIFJuFU1xbKG
	Ud99UzOwxbCI/HiPQ+wYuod65xMl5uuZVSH9tLDZG8gOVNJ18/ht
X-Google-Smtp-Source: AGHT+IGkh3DhonfNuvqUWbe3aTHDexSUf3GsSVKvoVDlpvIItKu3uRcjBFJ1uzm9dTyTqtMKu5rXQQ==
X-Received: by 2002:a17:906:5791:b0:a6e:f540:8b5f with SMTP id a640c23a62f3a-a6ef5408bb4mr388141266b.19.1717947554095;
        Sun, 09 Jun 2024 08:39:14 -0700 (PDT)
Received: from krava ([83.240.62.87])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f1ddc9390sm51598266b.25.2024.06.09.08.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 08:39:13 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 9 Jun 2024 17:39:12 +0200
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: dwarves@vger.kernel.org, Daniel Xu <dxu@dxuuu.xyz>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Matthias Schwarzott <zzam@gentoo.org>
Subject: Re: RFT: Prepping up pahole 1.27
Message-ID: <ZmXMoLkcmSIAk0Un@krava>
References: <ZmIXxgbfIJGWmXer@x1>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmIXxgbfIJGWmXer@x1>

On Thu, Jun 06, 2024 at 05:10:46PM -0300, Arnaldo Carvalho de Melo wrote:
> Hi,
> 
> 	I just pushed what will be in v1.27 to the 'next' branch at:
> 
> https://git.kernel.org/pub/scm/devel/pahole/pahole.git next
> 
> 	The changes file for what will be in this release, mostly
> reproducible builds and tags for kfuncs:
> 
> https://git.kernel.org/pub/scm/devel/pahole/pahole.git/tree/changes-v1.27?h=next
> 
> 	I plan to move it to 'master' and release it later today, so if
> anyone could please do some more testing on it, that would be awesome,

hi,
it works on my testing setup

thanks,
jirka

> 
> Thanks!
> 
> - Arnaldo
