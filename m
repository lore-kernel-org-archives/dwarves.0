Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B6B20C488
	for <dwarves@vger.kernel.org>; Fri, 19 Dec 2025 18:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766169414; cv=none; b=ciUEwShzF4Nh9CAVjl+drbqzjo7RFavZw9oiUuc6Zm2NzwJagSVfRlGrQuJsUBJVD9ryUzbiKdJ38bUT2dYraxy7AHQ1B2PWrTVNpQslRIf3czp0wyD4QUS4TRqOhhSxrl18b4pNO96VzgXquXBdBBaEtS5+PvthcxohBn3fF9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766169414; c=relaxed/simple;
	bh=Ckwlrvf67oHBQrVnk7Gu1o4N/ehl3eLCfjTY9bDnu4k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QLu2jnrt2KJNhQYJ1w7XGv4OrWnr26Fowr37fGc8dhalpmKMK9OHmk6o0fI1XahyyaoJJCtbsTSjcKZw758jTEnyPrrIoAAzkRwJS2SV1EkPqDGrJEd8UeS8hFxfAQ2X/2Z7oiPbtijg/qAHwCkcm3EBcYZxll3io4yVAB18vfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LnCoHhDs; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LnCoHhDs"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-34c277ea011so2056546a91.1
        for <dwarves@vger.kernel.org>; Fri, 19 Dec 2025 10:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766169412; x=1766774212; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ckwlrvf67oHBQrVnk7Gu1o4N/ehl3eLCfjTY9bDnu4k=;
        b=LnCoHhDsQRbTgHN7Fb3GgYyKEhFhFU4jL+lHIt7sBcnLOxLHLNvuYW1y9BmdGZ9ai7
         8SUYGnxLtfZrCsvnwIrmFpHar5zgt41SK563HbHo3D7RuAC0Wbe7DmFyE8S+cp6quyDx
         HACOv4BuWigFXd906odqUkVRN43xgaIIrLlWnqcksPypOvgK5I7sawefh9P+nXE6N+lO
         Ndme/ccThiVpw9ZQN4IDb8vXST1YO9q7oo74ICydVSfuz+MsN2pxvHFLCeSSeIk3WSbq
         x31mlf2nbfWxR30UXr6cJwq0q34qwRJ9fMDfiPq5VUBTcFghM5hRvPP53ADGiYta2uRb
         MLDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766169412; x=1766774212;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ckwlrvf67oHBQrVnk7Gu1o4N/ehl3eLCfjTY9bDnu4k=;
        b=GwEoey3pYomfmBdG84mE4nGmYUAK/Kg0d8yO4as2iigZ1ESVyi1z5FV9rCe0ZmfXZF
         87lHzYvEkEhG2SU8iyxjTJGtJ671LFEceJYQ+WeJIXQavcxvtk1WkRhMOXJRZ3Jcz+VR
         1aYw3F0tQo4NoRIBDFrXxelgzkh+N8v0Tzca/7Ugww7k2U8a1fd6T06mkHOFT7X8OybJ
         2vpfipdI4seikjz8GCvRKNq/xFEXOsIJPWsujOKyZ3DFJ9ZbT4PBYJk8lCMBLXJDy7Vl
         zMzy8Jya8fuh3GI1KeI3vpwku9DHcpwk0RWPAlreJZVJmtDxnIHogTRN6zlgWEcop1CO
         Myuw==
X-Forwarded-Encrypted: i=1; AJvYcCU8YCdPvHDeCClbEyOxBSDpL0fEKVNGermV43aA8paY196y2lcqJB9hc4xJyQP6n8luUjl6Cw9k@vger.kernel.org
X-Gm-Message-State: AOJu0YzSKhWyzQiaJYS4SxBqg90JIXvxq/v3w1I8MRR3QOxi4/fdPzyF
	Whi+6GAqeyqZT0XAqGHC1vTJlbyxhcl6XOVZp9OKgblYkJXHwrZOj/x8
X-Gm-Gg: AY/fxX4LlQaCiym7BSTvUUo35Vr9QK8PNEXpTsfA7oqM11j6unIQzTZPhkudt/oKNBb
	BdTByZfO9hZhK3w3qmGHD5csGNNFVLf3OU3lnExEzCoaaLaBEOCR54S2HPRjQRtyZ08UiQaQVIb
	0+sZoiS629CH9vZ3f4m4OFNorl3ous/ITWxBU0ETbxWXo3fKd/JuPCoqnbK7coti/n4pyA2rsa2
	131J3NW1vPY50BFWtQt1cPydtv+alfLt8g9R1FA18Sd8kmZmVQRQ8A5XVHTmUrRp+31WIKQu8So
	9XHOzqkKuIamktCFb1Q7ZLWMQPErrmR3jjJyMXSwC8AqTftES8D3bBVEFd0rdrEKaRslkqcmr2N
	OLTq6MyUsomKM+z4QrMvsGLDLGY2uZvtvPJpfQ0AfoeEk5hEoFVbMpsozrkJzIc4bVwCeJ3TOHW
	ukQV7HHsE=
X-Google-Smtp-Source: AGHT+IHQJqWLiHmQUhK0KQcUhyRWRHsJFOAx1pVl3iinbcLZe5q6pxefagQozOZvUOpTMNvfMCOUqw==
X-Received: by 2002:a17:90b:2246:b0:349:9d63:8511 with SMTP id 98e67ed59e1d1-34e921dff9bmr2913899a91.25.1766169412352;
        Fri, 19 Dec 2025 10:36:52 -0800 (PST)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e70dcc4dcsm5893497a91.14.2025.12.19.10.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 10:36:52 -0800 (PST)
Message-ID: <a99c8b9148a71c7827b00be5c793bfe8379de1de.camel@gmail.com>
Subject: Re: [PATCH v8 bpf-next 02/10] libbpf: Support kind layout section
 handling in BTF
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Alan Maguire
	 <alan.maguire@oracle.com>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, 	song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, 	kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, 	qmo@kernel.org,
 ihor.solodrai@linux.dev, dwarves@vger.kernel.org, 	bpf@vger.kernel.org,
 ttreyer@meta.com, mykyta.yatsenko5@gmail.com
Date: Fri, 19 Dec 2025 10:36:49 -0800
In-Reply-To: <CAEf4BzZ+iH1XvaYOjE==GPJ6wFo14_QtrFYvyvWa=ebc6UKPbA@mail.gmail.com>
References: <20251215091730.1188790-1-alan.maguire@oracle.com>
	 <20251215091730.1188790-3-alan.maguire@oracle.com>
	 <CAEf4Bza+C7nRxFDHS0dNDk5XF79nE6y4GqEu0bmtJPTMoFrNvQ@mail.gmail.com>
	 <db38bb39-7d16-41b6-968d-61e3b7681440@oracle.com>
	 <CAEf4Bzbn_eWC8W8+so-BgkzNOxx8jgEysU3kTzBCW1jwXPEfnQ@mail.gmail.com>
	 <ccafde20-3ea5-458a-b2e7-219aaa9a7ff0@oracle.com>
	 <CAEf4BzZ+iH1XvaYOjE==GPJ6wFo14_QtrFYvyvWa=ebc6UKPbA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-12-19 at 10:21 -0800, Andrii Nakryiko wrote:

[...]

> > The sanitization for user-space consumption is doable alright, I was th=
inking
> > of the case where the kernel itself reads in BTF for vmlinux/modules on=
 boot,
> > and that BTF was generated by newer pahole so has unexpected layout inf=
o.
> > If we just emitted layout info unconditionally that would mean newer pa=
hole might
> > generate BTf for a kernel that it could not read. If however we relaxed=
 the
> > constraints a bit I think we could get the validation to succeed for ol=
der
> > kernels while ignoring the bits of the BTF they don't care about. Fix t=
hat would
> > also potentially future-proof addition of other sections to the BTF hea=
der without
> > requiring options.
>=20
> No, let's forget about allowing the kernel to let through some
> unrecognized parts of BTF. Pahole will keep introducing feature flags
> that we need to enable (like layout stuff, for example), so old
> kernels built with new pahole will be just fine. And any
> kernel-specific modifications will be moved to resolve_btfids and will
> be in-sync with kernel logic. I think we are all good and we don't
> have to invent new things on this front, potentially opening us up to
> some unforeseen attacks through BTF injection.

That would mean that the flag to generate or not layout information
should remain, right?
