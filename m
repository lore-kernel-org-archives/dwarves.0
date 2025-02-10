Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB1E13CA8A
	for <dwarves@vger.kernel.org>; Mon, 10 Feb 2025 20:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739217700; cv=none; b=u/vmEKCATeMVg4q0dwiAQrBuDQ61psf4y4gPfL33DntoeuCsx24Z1hYnhG9nryNr8LUUC/saD4hLU1ipvOPfc6HFEFV1A7eDX17C5zzwwtAlW5QqU3k5BG14bZNt04bzF73XsOOLqrYODhTqYtQZ3rCxruo3GZEaucZHQSycVaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739217700; c=relaxed/simple;
	bh=LMb2occHGIVU6QtxpELmiWy8eM4ubsVAbzTz3yaKLD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NFeHZ58P9r5rN49oKnYxdEI3/i5x7lwZ8zA0a+1IfhlGtP+ahijwLDZfys797pxfQUtOm2+4IjOPrh4e5LRcz77bTjJe1QP3GISArybDx123nYI9hi1k0AEM9uQm2WHAu5yIUH9XyZldvhvO+QXJZniOXfqenur5c48jNSmoWfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NMTwZ47u; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMTwZ47u"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5de5a8a96abso4235571a12.3
        for <dwarves@vger.kernel.org>; Mon, 10 Feb 2025 12:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739217697; x=1739822497; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wB7Kh5r6NpooK5uzSn8mlA5C45vBwXQ9aI6QD2Cgw/o=;
        b=NMTwZ47uOEkPDI2Sc16afho5mNP7AcYqL/IQ2aeiKEM6YM/GdzrK27GQtgbZpRhTB9
         nio0TrhnjS+aSTD4mY++jDpD3yFKMxp4bsYwpsPGAf2UPruLl8OmfTmni/5uJBnBAeVM
         7UizlN2bURKiVafzn3Yysc6wNnrz5RCwPxp49veOBB79YpdL6bojyZvp6VImKYVt1xXB
         OJSRCUrMdQa0/5D5y72Cs9NNk9VbAPA7Gp9MD5Xz4Kev5s774t/wQMHBwVNn396+O733
         bFHt918j37nHlq76qLmcyLnjxH+wBH0OlwL6vGiudy01ZtakYi7RbpvUS5HBuwviM5Px
         37yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739217697; x=1739822497;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wB7Kh5r6NpooK5uzSn8mlA5C45vBwXQ9aI6QD2Cgw/o=;
        b=vbBMdb/2ZG0gOJPeEJFTbuDzGrf6Giz57xmPMa9A3s9CKz0KHOgokr6DY6z6A2gCsP
         kDRxrl59zLBuuKTUsdSlPLLh97EsoST2pY7EiB5ml/xIWTME5hceISXvROAdDle/W5Y3
         R+BJX36Ix0TOVxoEXUqAWVMggX1ZyEmNdTY/uQaIC4MIjB2RF7TRseryuBqo5r8OVyZw
         xRNgEY2XlaTU1/UN4114BivYIoHuvo+8dIKRpPAohliT9BoO/31UTdsY5wO2z8QKhJ+V
         aBEgyuIM6usxSxx3RwGyozG72Hb8rJ8puHBOJI2CA/vXaC34U+GNhU2mp/jTmmiM0nHK
         geog==
X-Gm-Message-State: AOJu0YyiMsIPZi5Z04/t3Ybc7HCaAnkB+QKeduTluEXK6AOgGRnUX6zS
	VY+zFr2jGR3wXy4dgxzk7IbuFDo1tKeo1byEguAwzoiVgJAt59fxm2G+EbWGL2D/tA==
X-Gm-Gg: ASbGncvCVM03i1YA/4hdCUpAdzNSsRXJ6hFU/KmL5UQWjwKCQiqIxW5OZe73EUB7VMI
	NwBBrPQeb2mjasjVdfwJFgOzQOOfex5VzRKT+HBuU3iYbz+WdVhuJ/3HEGRxxqlsGtzS439mjmR
	kPBKtJXvqZCS8opXa50YJDf0Ndc0JqozbKf/4NrrnP4zrnOVTwEiYRmyf0Mj6oqhn4IkYMT+E6n
	ENmRYp+v0/96F0JX1ltYmV02Zn1Y09Ikq5j1PFtfN7KfNp6E0D/T9Ar1171M3nlZBXR2DTW/EhD
	gpPZSCMgg3ZQ0WQ=
X-Google-Smtp-Source: AGHT+IFRyv/I4cJ6AEDeQzTRc7YGBEdqZ9Y7Ag4K0KDyjbQmTaNwH2J1h2azZQ57JJBjjbiHIZguQQ==
X-Received: by 2002:a05:6402:5254:b0:5de:3ac1:2027 with SMTP id 4fb4d7f45d1cf-5de45002147mr40369357a12.10.1739217692351;
        Mon, 10 Feb 2025 12:01:32 -0800 (PST)
Received: from m4.lan (tor-exit-11.zbau.f3netze.de. [2a0b:f4c0:16c:11::1])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5de5cd90b29sm5389444a12.63.2025.02.10.12.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 12:01:31 -0800 (PST)
Sender: Domenico Andreoli <domenico.andreoli.it@gmail.com>
Received: from cavok by m4.lan with local (Exim 4.96)
	(envelope-from <cavok@localhost>)
	id 1thZyD-0006Bz-0b;
	Mon, 10 Feb 2025 21:01:29 +0100
Date: Mon, 10 Feb 2025 21:01:29 +0100
From: Domenico Andreoli <domenico.andreoli@linux.com>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: dwarves@vger.kernel.org
Subject: Re: [PATCH] Reformat a too long line.
Message-ID: <Z6pbGaXSGpCOJ6AQ@localhost>
References: <Z54u8vZh5tJBzv2V@localhost>
 <80c1c334-ac68-4cf8-ab42-a93d9c8974a3@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80c1c334-ac68-4cf8-ab42-a93d9c8974a3@oracle.com>

On Mon, Feb 10, 2025 at 04:54:17PM +0000, Alan Maguire wrote:
> On 01/02/2025 14:25, Domenico Andreoli wrote:
> > From: Domenico Andreoli <domenico.andreoli@linux.com>
> > 
> > Reformat a too long line.
> > 
> > Signed-off-by: Domenico Andreoli <domenico.andreoli@linux.com>
> 
> not sure this patch is needed; man will reformat the line for terminal
> display, right?

yes, sure but try editing that line from a terminal.

this is purely a source code quality nit, nobody will be injuried if
you don't merge and neither will if you instead merge it :).

> 
> > 
> > ---
> >  man-pages/pahole.1 |    7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > Index: b/man-pages/pahole.1
> > ===================================================================
> > --- a/man-pages/pahole.1
> > +++ b/man-pages/pahole.1
> > @@ -304,7 +304,12 @@ Allow using all the BTF features support
> >  
> >  .TP
> >  .B \-\-btf_features=FEATURE_LIST
> > -Encode BTF using the specified feature list, or specify 'default' for all standard features supported.  This option can be used as an alternative to using multiple BTF-related options, and 'default' represents the standard set of BTF features that are in use for kernel BTF generation, so is useful as a shortcut for testing the latest set of standard features.  However kernel builds will call out specific features rather than using 'default' to ensure that the desired features are enabled regardless of pahole version and associated 'default' set.  Supported standard features are
> > +Encode BTF using the specified feature list, or specify 'default' for all standard features
> > +supported.  This option can be used as an alternative to using multiple BTF-related options,
> > +and 'default' represents the standard set of BTF features that are in use for kernel BTF generation,
> > +so is useful as a shortcut for testing the latest set of standard features.  However kernel builds
> > +will call out specific features rather than using 'default' to ensure that the desired features
> > +are enabled regardless of pahole version and associated 'default' set.  Supported standard features are
> >  
> >  .nf
> >  	encode_force       Ignore invalid symbols when encoding BTF; for example
> 
> 

-- 
rsa4096: 3B10 0CA1 8674 ACBA B4FE  FCD2 CE5B CF17 9960 DE13
ed25519: FFB4 0CC3 7F2E 091D F7DA  356E CC79 2832 ED38 CB05
