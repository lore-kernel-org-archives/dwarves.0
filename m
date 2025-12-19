Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC3728CF49
	for <dwarves@vger.kernel.org>; Fri, 19 Dec 2025 18:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766169725; cv=none; b=NDzbB9a1RyTaNGRZoosoZnBbrJb0KKaI6A6IoNSBbvv/TEiTWqf8PSDyS8BnAo0sFsZjhG/LrOgHx26Qv+erJV+Y4j1veRMh4BCIg4rXiKCTmu0fWTvhzA33DpEfeciAN6jSrdswS9jD/PAA5nZLzwTTtvtT9i4hRkeGfk7Vd8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766169725; c=relaxed/simple;
	bh=1t3SvdLKBdnpLyk36pqNQfOQzeNEbS6bTaLlt3bCeC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FNziqEnxNseQ0neUm1qHbVIham0SiJ/2BmmwBo4ZUVTaxuEbuEISP23ebj2l8+GotbDBax6C/07HtSakvfEW6Pa3D81QKl9muYYB5qjYxsIBUg9eJ43XzYPyP37gNdqSZh9aXNn47qm/T/dXnb/elpJ4xJ2FXc25+5XrwlW2auw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MX+dw5JL; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MX+dw5JL"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-34c708702dfso2267146a91.1
        for <dwarves@vger.kernel.org>; Fri, 19 Dec 2025 10:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766169722; x=1766774522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1t3SvdLKBdnpLyk36pqNQfOQzeNEbS6bTaLlt3bCeC4=;
        b=MX+dw5JLsFqOLk1vI0GJ6qy50fvcPNE7tT+eKjAKa6BsumEUjADc7VnaUBcSey/hwa
         tNIwkXaGTe+23Urek0lHtAGSpH8SU1trC+suOtguWVvh1GFQNN+00tRBmp31UfNaCNxV
         X7tW3bTpG02/gr2T4SNbYnWw5yaEQU1H24c++Tw66ABbkMTxhoG5l3C9i612ocTULLwO
         QB1AYy2fDCCE2ois1Oj2PY0pWsEuXk4rqICCbLHvDensFe61/fPoPhFz7bfXp2oNdg64
         gjlxzloh090xvoJOfXLHtQquvzHLgIw6cG/OGj0uqL91Xzvm/fyL6XF3KEYjpbMysCwg
         4aSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766169722; x=1766774522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1t3SvdLKBdnpLyk36pqNQfOQzeNEbS6bTaLlt3bCeC4=;
        b=EVJNwALCLW/LMB1NKmRlgNnk9A/an6JmJ/btJRX0XETHkXX0/YmbISHSX/hLZU3vdc
         gY1aqI5j2pD51o1uLteUqaImQt/YFp/9vecaAcxug3afqWfpgxk+18UQ5RW9OypXRz34
         Vd8M7dcVqHWsE6X6sd/SFR18Ng9QkjJ2N+I/U+4Bd/aouQoQXhHWwSdr0mBkvRj7LyIZ
         9BcYXZzvslYx/CCii54AmrfO6KCD0/OLmiw/N3INJallGpKqMGKU/LQcC/R6gPhhrLMI
         h9mtLrh8V5QUx7gdpEyesJZzLIiBVw68zut/8tk3LRG7PBOKxzk3bRwmvGn+eRch4uFY
         mvtA==
X-Forwarded-Encrypted: i=1; AJvYcCVvErB3Z7gxlVp8JwMzdgRydhP+8DwOTfbcq9Dk1w5XS2SFNvyLBNqGD6YcwRkX/gF6COqoJg2N@vger.kernel.org
X-Gm-Message-State: AOJu0YwlOiIwaabADVs3zlFEY3iPhEkyQtekThpKflKYYSlXd1rcRN8D
	wwJaRdTojigz6OfWHiqXr7VpbD1ZMlOx7G1mj/BPbBZrKa7innGgwtYOZ/qtbPk2CgwkSRdlK45
	Kzq45MSOYAR/d7iJmy94qbi4qyXtxEWI=
X-Gm-Gg: AY/fxX7mHsLmPbxs4Y/TbmHgw0JrnYInLKsGPqN8BSBZGSz1Fbl1faA4EEe9L4jUvlD
	OAsCHPT7oGNk1ZCG9KaSd251XqpeDyXURpOYBPGEIYcwphNMNO23id4Kyl3SgquwI1v0ib9Wf9f
	8bSe0z8Z4FOmhj4OsFt6SQXc26X7dzcDQfSZqaVj1f4wYpjo769YakUUqa6UqX796e44aL6NXxu
	+OE64eVMhyW1PyCLTXZGWLDmGXn+yc811MVnYJshCa+cHGiXNfTXe8dSSJw/iC2vtCQ9gM=
X-Google-Smtp-Source: AGHT+IH2D1pwfLkRfYRld646pBfuD0MjZS76cEgvU9gjFR6Io6clmZDmSSZ8uuJD6DHemsg+Ucthed83iuRFVEni7o8=
X-Received: by 2002:a17:90b:2585:b0:341:8ac6:2244 with SMTP id
 98e67ed59e1d1-34e9212a9fbmr2934322a91.9.1766169722525; Fri, 19 Dec 2025
 10:42:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215091730.1188790-1-alan.maguire@oracle.com>
 <20251215091730.1188790-3-alan.maguire@oracle.com> <CAEf4Bza+C7nRxFDHS0dNDk5XF79nE6y4GqEu0bmtJPTMoFrNvQ@mail.gmail.com>
 <db38bb39-7d16-41b6-968d-61e3b7681440@oracle.com> <CAEf4Bzbn_eWC8W8+so-BgkzNOxx8jgEysU3kTzBCW1jwXPEfnQ@mail.gmail.com>
 <ccafde20-3ea5-458a-b2e7-219aaa9a7ff0@oracle.com> <CAEf4BzZ+iH1XvaYOjE==GPJ6wFo14_QtrFYvyvWa=ebc6UKPbA@mail.gmail.com>
 <a99c8b9148a71c7827b00be5c793bfe8379de1de.camel@gmail.com>
In-Reply-To: <a99c8b9148a71c7827b00be5c793bfe8379de1de.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 19 Dec 2025 10:41:50 -0800
X-Gm-Features: AQt7F2rWDSJVuCd0kTKtGcjM5u5ZCHuXe2XNLuAk6Z5kkf0iBnl8lf9s5cNg-zY
Message-ID: <CAEf4BzaS9xoFaTF7LEyjYg9iPZZGn3=UhDVXAv9AuuMz1wFoZg@mail.gmail.com>
Subject: Re: [PATCH v8 bpf-next 02/10] libbpf: Support kind layout section
 handling in BTF
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, qmo@kernel.org, 
	ihor.solodrai@linux.dev, dwarves@vger.kernel.org, bpf@vger.kernel.org, 
	ttreyer@meta.com, mykyta.yatsenko5@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 10:36=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Fri, 2025-12-19 at 10:21 -0800, Andrii Nakryiko wrote:
>
> [...]
>
> > > The sanitization for user-space consumption is doable alright, I was =
thinking
> > > of the case where the kernel itself reads in BTF for vmlinux/modules =
on boot,
> > > and that BTF was generated by newer pahole so has unexpected layout i=
nfo.
> > > If we just emitted layout info unconditionally that would mean newer =
pahole might
> > > generate BTf for a kernel that it could not read. If however we relax=
ed the
> > > constraints a bit I think we could get the validation to succeed for =
older
> > > kernels while ignoring the bits of the BTF they don't care about. Fix=
 that would
> > > also potentially future-proof addition of other sections to the BTF h=
eader without
> > > requiring options.
> >
> > No, let's forget about allowing the kernel to let through some
> > unrecognized parts of BTF. Pahole will keep introducing feature flags
> > that we need to enable (like layout stuff, for example), so old
> > kernels built with new pahole will be just fine. And any
> > kernel-specific modifications will be moved to resolve_btfids and will
> > be in-sync with kernel logic. I think we are all good and we don't
> > have to invent new things on this front, potentially opening us up to
> > some unforeseen attacks through BTF injection.
>
> That would mean that the flag to generate or not layout information
> should remain, right?

Yeah, unfortunately, as there will be no libbpf to sanitize that. But
that brings the layout question for Clang/GCC, are we adding that?
That should be emitted unconditionally, IMO.
