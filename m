Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0F92D6E67
	for <dwarves@vger.kernel.org>; Wed, 11 Mar 2026 17:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773251199; cv=pass; b=q9Ze4bM4u6NdRBa4QjD16rDYLJKq4spcAx6v+su32jP4YPtMa0wdHTo0BVfSWmBZra4SRCxGoI9R/yN5f8XtLMv7+iBSAP0rDX03pknKHKNMjyQe8wj7wwB4Mh+EpXTvEDHbvuXAo8JF0mxhX5RM3z4DeUjEK5oWEsvD+ERu4c4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773251199; c=relaxed/simple;
	bh=U55dxhPwWjTbDNblaC6CYNPA3GkL6VWrivlJzvge+D0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KXD0tdgmYTJJcjs/BLJNLSEGJ9zGwRaG37MaLrZyFCGrrfO3K4f5+3r+5oD85Y+0YAWXsG6TvElRwgL0Ix6ztdt/irMifJBjm18N5fKGLAtfR4RSyJRJwDOFzhilEuxmw9bzKjra4AZRnBDtVI6gDhp2sKZB63R0nt6lrEAI2Ho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YavksS/Z; arc=pass smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YavksS/Z"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c739561f0d3so44924a12.3
        for <dwarves@vger.kernel.org>; Wed, 11 Mar 2026 10:46:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773251198; cv=none;
        d=google.com; s=arc-20240605;
        b=SrgdYvtxDcXiRzbWM2dCaox4SKPbbnqvIRmO3iaFVI2xqoG/+bx2lyml7sQbpbE+Cj
         uNR/Q6CFN4EroY8fvB3kIQnPhXFizNga1U1JxYUUEoNWupxVN3QVRpaCyB4wwPQ1N7tD
         +PwPipQPeXuS5iVuidkIllygDs0bYyfTLvxbhAatZTt4J+PEg+fxtC/SSUFlAIJPGHXI
         LumC4Khxjwo/KJw3bnPqVjJI53dhVv/pGwYkZzOYorWE/7yh96/S28bMtYVFkr8LiTPZ
         Iwv3TEZtBFP1LzAbpSz0Io1zk8WNf6VxUnE8vigiWphMsyS+y6fk6S7KXwNQeSUimcRZ
         BQuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v/OQNd9y+UayBiD2BW4UV3/sUJiK1ToC4qs87k338Zk=;
        fh=E/Ljb7+VlvoDz/OX17Fbyj0bN56rtgrbrxyjy/ixal0=;
        b=gfkWJU2EEbwGwWeKjvLLAk9ATNry6oTShdwsuRmo3qB25H7NIg4JH3/7C0a7kepHUf
         goutFoHDgVaqEWLd3K8nu2n8MgagGpizH5X3QKDxHO+y0a1hhjV1tOWRq35us2ZlXlkT
         qeRIrWMsA6CGwBnUZkb/UECaM8cP0dfi7WGH+SX7Y6dVELO9KyD1q4EMelYQJ8Pbx7OT
         kewE3gZ+KT0911lzMP/K5pSFZuR9rMIBq+qVy3Zw+TNoSVSIU9BTJXy8T4WtLPF+NEr9
         9t8JJ22kcsfyDORINh6e64UrhO1wWIk84WnAKJz6fv5/70RMcDIxNn4sMxtyo25mbS3m
         GVIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773251198; x=1773855998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v/OQNd9y+UayBiD2BW4UV3/sUJiK1ToC4qs87k338Zk=;
        b=YavksS/ZEFftR4ZyzPeGYlwRS875StLnGqgkKbkdJQzPDwTa3cvKWbHK3RjOh+3ZTq
         O034hrvOi+3GaAB3GNy56l1nAfy+VXBr+E5dzCNHVHpSba34nd+UIsPFVH9rkcAU6ujh
         1aHcAidpCBEEsVHGWACqCb1pj4X8Tih40LZhgjXsuMoGErkVVeP6X3MMUH0GZZfznUGk
         TjStfWocWkqpWyEzp8zVFmCqlDa77X84hkZwRmtq+zwF85zbFpUayLfPNw6w58GE75er
         VPObx+yF8maGFZIwTIHqhLWMRyTQL3R7RX3t9EfEdn1hBfCVYxKRq9ME9bkOO3Qy5i0C
         qWAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773251198; x=1773855998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v/OQNd9y+UayBiD2BW4UV3/sUJiK1ToC4qs87k338Zk=;
        b=P3KsFbS2sK5JZshL7dP0QP2Vq5kmhRERhQjsJwAafAi5SDR7Lubsx8vcRljD2XFplZ
         2Tn7aRh6oZtEe2tPNXZ6cqs8SXrvD2JwTEOoDyai3mS4WkD2oYZijJh2kTaDbgh8Ux+L
         m3025rxoXXT5gnqZ+3O5epDBCtUzzehIbpTL6QEIrgXtD+s/hQ0bbQ5ehMvbv0dYnmjj
         7mXSLYW/lIFlRiiT9GlgXPD1XLZ6ONmBY3pSPNVbb7WMdhtz/+bao+x8420+UyvK2wav
         1OCiZD+5ySpWx0Ks+RkoFGkYbuGwIpKqw8VxCxAGXJmrjhRefu29Fez1KtbM2pEGInGn
         +rog==
X-Forwarded-Encrypted: i=1; AJvYcCXBKpToPyTG2txB4Et0q+DAZumsFxQWDt+gprs9TeNJNPz4EcTuP19GniWJ/JWJcu1zFTGd8vHD@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq7G47nADOE7Ct7PCS0+p50HiRErZqe4fTCOxqdlKvRxyWBq2Z
	cF0e/efgnMWQby5ObKwrZLyPuVdhlMj9TOwMHIpLRZAtpKxR2OYK1AyKNcqI079/jgFqVnBvOw3
	c1AoE7Ij0EBkodztdMCwIGpFYv8z1s6o=
X-Gm-Gg: ATEYQzwylgh7u6qaPyeKkcERLBj3/ItROg2/EUsMS6WxHNUg2sRdxzDLiobot/KH54A
	Inye6jhlVrMsqkKhgl27VZWdt2l2V50Y9sigIDgvVwxHX7+wWsgxCJNBtZbON3p121iPyAb1/qG
	//KrX4rnUZkbHJPKPFK7wd7erajdNdqnp4DQbWBfQZVewRwmEWGf0qxtjh6VROEA96DaG1kguY7
	SY12yvQSc/j7T3lr4b2Sszx8II6OuVh9qFcXMeZJr5rQhaDWZ7HNuXD8om8CUUs5dAOf+pONokm
	xJKnk4M=
X-Received: by 2002:a05:6a21:70cb:b0:398:9e99:e190 with SMTP id
 adf61e73a8af0-398c60e4115mr3096099637.33.1773251197610; Wed, 11 Mar 2026
 10:46:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306113630.1281527-1-alan.maguire@oracle.com> <20260306113630.1281527-4-alan.maguire@oracle.com>
In-Reply-To: <20260306113630.1281527-4-alan.maguire@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 11 Mar 2026 10:46:24 -0700
X-Gm-Features: AaiRm50l3hjalPVXWnb3ojFmIUdLirJnF_KaJFQRejzIbEFIc3nbVQT0oD-dDKQ
Message-ID: <CAEf4BzYQGh1=EJkewD9wSyTawvwxTFJ9ODy-PFVHeuP59ATBQA@mail.gmail.com>
Subject: Re: [PATCH v13 bpf-next 3/8] libbpf: use layout to compute an unknown
 kind size
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
> This allows BTF parsing to proceed even if we do not know the
> kind.  Fall back to base BTF layout if layout information is
> not in split BTF.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tools/lib/bpf/btf.c | 42 +++++++++++++++++++++++++++++++++---------
>  1 file changed, 33 insertions(+), 9 deletions(-)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index ae13f9f4df08..9f4d1bd73b4d 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -356,7 +356,32 @@ static int btf_parse_layout_sec(struct btf *btf)
>         return 0;
>  }
>
> -static int btf_type_size(const struct btf_type *t)
> +/* for unknown kinds, consult kind layout. */
> +static int btf_type_size_unknown(const struct btf *btf, const struct btf=
_type *t)
> +{
> +       __u32 layout_kinds =3D btf->hdr.layout_len / sizeof(struct btf_la=
yout);

(give you are going to resubmit anyways)

nit: l_cnt or something? layout_kinds sounds like it actually contains a co=
ntent

> +       struct btf_layout *l =3D btf->layout;
> +       __u16 vlen =3D btf_vlen(t);
> +       __u32 kind =3D btf_kind(t);
> +

[...]
