Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CB72D8370
	for <dwarves@vger.kernel.org>; Wed, 11 Mar 2026 17:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773251195; cv=pass; b=rrfbj3T50fcVfUa28pnyotkwS7RIQfOUfAB92YRxsoMdVCd7Uq0OEHPxvNweuo2FIMcB/6wMLqbE+RpFXI+ZTU0MasIU4jHf7MLc7LL6umbZHHJ9cdg2YuT4Qoxh3mh3Or5DrpHwsjYOuAgqq/GQ0b7ofB05eZMFAw4+1QGfXlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773251195; c=relaxed/simple;
	bh=TONfdr6j71FOAqr/zbM5g7QJ2rc/2cpK3YNXNiUbP64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TK4U+hcyFGQIB3408jhZ9yZVsLJO2JaQsv+BRVkHCl5Zw3cKrzooH2EOddI8xNWxgXn1eA0Nw7dEU1EmaTDeoES8yLJadmQTYZ64O9xLjk9YUMFVtk3otJADokuT7nVWRzAODexG55HS1pcSIK8SheczIm1DuXNLGf0IWUFDTSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HGx18DzP; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HGx18DzP"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ae4d919f9bso1574165ad.0
        for <dwarves@vger.kernel.org>; Wed, 11 Mar 2026 10:46:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773251193; cv=none;
        d=google.com; s=arc-20240605;
        b=VJy1/CL8IWQFGrsjJd+/tgXqGrv1SBjGItIWKKCbytpPj2OYr0TTByPYYbSwNlEVxN
         U/kJGRrWbiT+PRZMR6pJCj4hwYznfzAdLN9tNZo8XxyB1n6ZCCchqlMIYi8cKEaymPMb
         p3timdxh1r7PWISOlvIPMsKWxDrNzl5+e4fontQMFX0ctWiBo3c9hd3Xi/Ooi0vrrNxg
         5q21pkq5YTf0Wyx8ZUINJi3urwdgzfWkknj4wJrFens31bLtx3zMQPr6vjIHxN9S6IHB
         m+sBOVHm+U3G3k7x3ZHRtQD8YXmPvSLz1XXg5gj3PWViiCjXy4yb7zhyJe0MlYbUF3Vm
         E1Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yBbbl+rYtduCAT/2aKHMXzgEnUwE1s6H/CjLlVRuVSk=;
        fh=aSbBfl4iDJVCcp/J1icf9XHe3xcS9fW3gRtyw9+qh9s=;
        b=JspIGoQLQsquA3Kzl02BpXCHGlTw5iFn8t7HoA5pxq3piuBOO6aDRLDKR01iHbfj20
         hHVByfuIYeCOV+NY/ywF4GGGZtgPFAtzXUiZZGAJD7fPS0+Q7QJMCkyjcI7c6lsbJf5p
         sJ5tgel/q4oZkTjhCVwUSQQTCUbJG7hfvWyoVUfEOtOfvG2EYK6hvzAP9RIw/NUvvQKK
         tmKLUSBtcxrpejj1Ds2PqaUjMKytO2DosenB8DtKQ8qanPObIPbGVxRZonUeAwwjfYhs
         wV60BxOl5XF6AqWwM3Vs8RnkB7zbNNeM7IO2P1ZTUBrPbPj5aHtOS/wqWgMMbME3QhP8
         Hy2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773251193; x=1773855993; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yBbbl+rYtduCAT/2aKHMXzgEnUwE1s6H/CjLlVRuVSk=;
        b=HGx18DzPj58oWLLX1vyCXKep0IMqSDxyhkyg8xCEv4uWLHqUxMTdRtspv855TKhmj6
         AdkBx1Y1NlMH6iFcr01BAy17cJMDzHZFrzVKGbEIGU9Pv/QdHyuMvAtqZVohG6RpxXIQ
         FpIpNwz6i51w8VehvXtDd08HuMD0DC6cOf5tTVSVxPm7l+lTAIVk0Y5oKV+/1DjXIkEK
         c4dMJ5d6F5JcBlGF2brPfDIlfBAwNFH0kRsti/+ns1ira7M+KqB3y7JoOBf+Tw9Ug2mN
         pFYKpR2cuwntPyBYPTQnPXbhCvnS2wu4ddQMvKOY/4KEFCK4DWmqApN0e44bori2MGnZ
         lpfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773251193; x=1773855993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yBbbl+rYtduCAT/2aKHMXzgEnUwE1s6H/CjLlVRuVSk=;
        b=oWzVbep5w/KolG/k709XrbJj90wALUHmPClipml++cQVS44gmfvtfVBS1enxbz+Qnh
         VdZwmVg5qrkYomK8WE1O/LRuvdSlRKqfim5tq8+cNcJEXSvO5qXE6QqqOF1fTnvgU4fh
         j/IP0mW1OKVmpW8aKEsJgI8ZwTqz9QAr69IYxoOkdDsJQ5HUumM+R2NqHgZ6DqERPPgm
         cOaoKlpw+7YvzYh3lMUt3PSvVndWNdzuYP5uvobTVE/2PLqZ+HNambnms4fBS18qQKE4
         hRViz906GWdaROGze/2z1VEJYKwbtI7CcTUM8RtrCTszi4MBMCBe2/JyPFT5Ygofhal9
         C+sQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8VFlheLmDThrWYziJR05by4FmuX6+6/blgR+RQxFqYBeazZuQVL6j+Vrgo9OUtv1mU0kjtDze@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ8Ygaxjkq/MOB0NPBk43vHR9E1dkeuPQVOiECeNeenmSObbkw
	IbzcP3E064uFi36rptv8RCvWmlw0nelrKZKZWbOldraSkuad72yhX1Hrow5N8C6GiO8dOjueGR8
	OkHa3dkboWK/+UQIh/+5y1H5a5dnGpHk=
X-Gm-Gg: ATEYQzxj/vFlUAdeSsYS9ubQ2968EkWG8lleLLRhXxLf0zfx77mCsP6MD9bB+BaJGbs
	t5K+0H4R55vRNWwZKgMcp1qZhwggHkHF/5PtTzeNCzrQYG2qoJpuSfH2H+1ciVjUIVsNew3hbsL
	EH2+CbljnLctjZUOSRtXXy6te9OT3NqCQgwNXhrLS2CoJV0xBo3IUlCrbcED4QPo+OelbAL8acR
	zHlhjcvtG3TliQ4c25hYmdAdGKBGTDRHHlXf1jXJ+lmxsHz0ZMsd6ifEH2GnSg/KuMg5aUbAwcA
	rWt1p+Y=
X-Received: by 2002:a17:903:2a86:b0:2ae:3e4a:3cba with SMTP id
 d9443c01a7336-2aeae911493mr37426945ad.54.1773251193010; Wed, 11 Mar 2026
 10:46:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306113630.1281527-1-alan.maguire@oracle.com> <20260306113630.1281527-3-alan.maguire@oracle.com>
In-Reply-To: <20260306113630.1281527-3-alan.maguire@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 11 Mar 2026 10:46:20 -0700
X-Gm-Features: AaiRm53ie_L3c5EybTPafMesmnxobM7Ooo_ynZUUASui0-hx75RviqMmmGswFpI
Message-ID: <CAEf4Bza_kJowGmin4Hh2iOpwXZVgNoeGNniidSpZEjRjqWnVyA@mail.gmail.com>
Subject: Re: [PATCH v13 bpf-next 2/8] libbpf: Support layout section handling
 in BTF
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, qmo@kernel.org, 
	ihor.solodrai@linux.dev, mykyta.yatsenko5@gmail.com, dwarves@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 6, 2026 at 3:37=E2=80=AFAM Alan Maguire <alan.maguire@oracle.co=
m> wrote:
>
> Support reading in layout fixing endian issues on reading;
> also support writing layout section to raw BTF object.
> There is not yet an API to populate the layout with meaningful
> information.
>
> As part of this, we need to consider multiple valid BTF header
> sizes; the original or the layout-extended headers.
> So to support this, the "struct btf" representation is modified
> to contain a "struct btf_header" and we copy the valid
> portion from the raw data to it; this means we can always safely
> check fields like btf->hdr.layout_len
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tools/lib/bpf/btf.c | 309 ++++++++++++++++++++++++++++----------------
>  1 file changed, 200 insertions(+), 109 deletions(-)
>

[...]

>
> -       memcpy(p, hdr, hdr->hdr_len);
> +       memcpy(p, hdr, min((__u32)sizeof(struct btf_header), hdr->hdr_len=
));

in all these cases where we have sizeof(struct btf_header), this
smells like a potential issue, tbh. We are silently truncating the
original header here, potentially. Which is ok for read-only case, but
do we error out if someone is trying to modify/write such BTF where we
don't really understand all of it? Should we?

>         if (swap_endian)
> -               btf_bswap_hdr(p);
> +               btf_bswap_hdr(p, hdr->hdr_len);
>         p +=3D hdr->hdr_len;
>
>         memcpy(p, btf->types_data, hdr->type_len);

[..]
