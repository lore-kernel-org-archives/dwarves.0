Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAE82D059
	for <dwarves@vger.kernel.org>; Wed, 28 Feb 2024 08:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709109037; cv=none; b=prRs1CA50dg0PGPf1fF7QjJoGWrUF+t2GiMVtl9KL7ez6cKVbsp098QLSLbAhfjFnKQGian4V6ZwugKiLs71E4YIMPMTKkKz22EeFCq8xI3Bdrv8D+MYZcsc0HRlAHXTJDFEkzByBz5NoNPjLjwWbs1DA88uamZHGQbLPvSosV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709109037; c=relaxed/simple;
	bh=R5cGOZnxszKyJjhjjeZIaDfhQwURzKy6lkmUw2oxAk0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=atgue1elJppMl2I7rUHuyH1c8G360RAFWjyat4yJerpBJoi8ZpQaLiOQp5NOHub4wv1X9BhxAwhTlWMxiLENkm6SSb/5kfSYS9agTuiSfcXrR2XJ5t/BPbOj778AWW67qfTVRH+yGt01vwfq6ZVtoEYHTJ51C9DohIOttLOaMGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G3YMT92+; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3YMT92+"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a3e552eff09so571892266b.3
        for <dwarves@vger.kernel.org>; Wed, 28 Feb 2024 00:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709109034; x=1709713834; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B2YlgjklJrBhnMAENh7ZKDw9YoM05O49K6IqtbGR67I=;
        b=G3YMT92+Pa+UqU91/nyT2uJW0Cc4/QsUAds0aecThtbT9O+zmWgjXUA6jFKCHPh9Dh
         AouyACAcYECTlH2VYGhcQ1WbcMLItKHBvW8RV4JIpWQ/jAIq1x7A2ux0S2FprRBx19oL
         ElgIc7YRucibC5ik7k9/fMF7DfH0JqHIQN5WpAtSilZwqSl484Jr1tb1MtDbH2ThZ4ZQ
         7TQNTzAJgLXmR/UEJyif7z9LfIYUsuSDajrEywcNzHjMCMm50mAaEB+sy7u0M6/FEld6
         ygOVhhcT1zYwSG/u0R1v4FTbr3dAxqXJbdgSgn+ISfj4D1yRmmE6CBUgSCIYP5CCQFQP
         Cthg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709109034; x=1709713834;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B2YlgjklJrBhnMAENh7ZKDw9YoM05O49K6IqtbGR67I=;
        b=lIl0nqleK+d3u+T3Hv9TJAIDr/ITRuGpTWcVUdk3CwPk2H+VDKfUS+CaeqoYCMCbqj
         5Ngl1aT1lJQi4t0NlREQVGElSGs54mNx+0a3bSKnr1yGPeiShk3wSuwvxG+z/dvlqn9M
         bOyISLaKIg5yPU/juX7k/lhY0fAseb3/xV0WWffW8tO4a0e9aTYa7hYqSvV+2Jp0Dup0
         vPjLyr0aurflOlewZVctg+sICZrHTg/0xXNv4BK88Cjo/sPPe/BbFFNU2YqngIxC1ZXT
         HBzRg1fLxfkAQJeTwGp4rm/5xKPk2KtTGrk7X6wBKyYK7/ALnnoGGP0oxICyWFJbNFKP
         E/3g==
X-Forwarded-Encrypted: i=1; AJvYcCX3aabQs41/HOOrkloTlw66IcjiGzpRCrgsO+lno95eeuQFt1nz96YDuPfPmG7c+9zDZbhVxHzsIEdgeMbXxwVFHciZj1tTdg==
X-Gm-Message-State: AOJu0Yw2aW2fjbo9d8/4h4RCoyG6NEA3AC7PFyVNAmQFGTFb9eGFsN/4
	LCVX4dEXYvq5+BnAJtfPw70tX5rxlKzAyd3yYwvLFmbMD0VY9dDfR4NMJvEO
X-Google-Smtp-Source: AGHT+IGfeAQYWoVjlAXx6qqK6PWT02Haj0EUZqZAt+F/UOiwZfwjjkCYe2k504Na44PPoR57EBp+QA==
X-Received: by 2002:a17:906:f9d4:b0:a43:4c31:c4f1 with SMTP id lj20-20020a170906f9d400b00a434c31c4f1mr5486390ejb.11.1709109034013;
        Wed, 28 Feb 2024 00:30:34 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id di15-20020a170906730f00b00a432899c28dsm1584188ejc.123.2024.02.28.00.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 00:30:33 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 28 Feb 2024 09:30:31 +0100
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alan Maguire <alan.maguire@oracle.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Viktor Malik <vmalik@redhat.com>, dwarves@vger.kernel.org
Subject: Re: HEADS UP: pahole 1.26 to be released soon
Message-ID: <Zd7vJyjGjzmXW4R0@krava>
References: <Zd3cooJ1HgnuC1aV@x1>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zd3cooJ1HgnuC1aV@x1>

On Tue, Feb 27, 2024 at 09:59:14AM -0300, Arnaldo Carvalho de Melo wrote:
> Hi,
> 
> 	I'm prepping up pahole 1.26, the noticeable thing for BTF
> encoding are Alan's patches (--btf_features, --btf_features_strict and
> --supported_btf_features).
> 
> 	There was a fix for BTF loading, namely the signedness of
> enumerations, but that isn't used when building the kernel, just when
> pretty printing from BTF.
> 
> 	I also have a few fixes and new features in the pretty printing
> code, but again, that isn't involved when building the kernel.
> 
> 	If you have time, please do some tests and report results.
> 
> 	You can find it in the usual places:
> 
> git://git.kernel.org/pub/scm/devel/pahole/pahole.git
> https://github.com/acmel/dwarves.git
> 
> 	In the master branch.

hi,
tested on top of my setup and it looks good

I hoped the kfuncs decl tag would get in, but AFAICS there was
no new version of the patches.. I'll ping Daniel about that

thanks,
jirka

> 
> Thanks a lot!
> 
> - Arnaldo
