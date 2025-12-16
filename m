Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358D332ABCD
	for <dwarves@vger.kernel.org>; Tue, 16 Dec 2025 05:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765864702; cv=none; b=OJBY4LMdyC54wIDcNs03RlsPgaqdauRPoXyrD0zUOMzSeBTSbHmyEOn2mVA9UXcMrhPTC+VHf0yWug0bhVw2kQublK73qa2xaWaH1FCwvIQXN+mw9TFC597GOYy4Ih8K1xrVgv7HPxGf251v2XyrLT1EnAaK6n7lMBspdY6wxtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765864702; c=relaxed/simple;
	bh=sM3cNw5SIpD6IQ+LU+smmGWOeqggf2l3Ts/h3XPM7KU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Uo+GH8ZRQqTAem4W2fpyzrFYXjIoh/hJ59vBpuUVh9MDRCO+1UgBYE1pxy6cpY4NWnqInEC/lCzT87XH0X0ShKhetQb2umb291IGIjZIXXn/YH3ihVMbuwR2sFppOWSz5+VI9z+JDxr/VDQUJtnMIt6HuRu6CFt83mzsJwaSkpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dms3mFpV; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dms3mFpV"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-34c7d0c5ddaso1123016a91.0
        for <dwarves@vger.kernel.org>; Mon, 15 Dec 2025 21:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765864695; x=1766469495; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IVTImU2QQNFAuOXTdHLvkqMQomKRULNxJdHbr0KDxdg=;
        b=Dms3mFpVRZBitcSWGgtum/lNFyVfGlVKEMDOn+bNzD5Lh5priv2tpQbTu9lyhZLrco
         jezpXKmVnGFHwPyJQDNuUH9xL+UjW4JPsif2uBMRe74Uid6YMYPmaqLKuxDSajG06PVy
         MnwKkeYqvGL9p2S73Q5GfpwpVdXpbwOGW230wfCxAYm9357x4h6EChJZ7J1vfckvbI2o
         DkWStaNgZAotjQ1W4uoc1Hrbpb4gBRbTRAvAjD/w4bieooWeExoyr9pqYO+9F4jgqsVs
         bQJlqxynA+cIM7T2GRVkJ3K9AggEtG2tNRYFUd9te4RbtBJl2gFsZFwhcv2WzYDmzXZd
         3CVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765864695; x=1766469495;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IVTImU2QQNFAuOXTdHLvkqMQomKRULNxJdHbr0KDxdg=;
        b=kLwmNYdcK0vKCDso5q1PJZYZa/Hwia1Q/Q3nAocj14BhDLhKAxlM0aY7eH+rmg+DCL
         L+1ZZIiS0o9lS7wvErPPZ4inxmbzAe8cDsDzJV9IETKbEYn5AdjSe9C//i8bGLVvi7hn
         VQRS15zQg8wuhQJskO70jsSAngwKPo7Hdh2wUGv7evmNluR88i/Z3QlgLmmG8/dmy7WY
         05B949VY6Z0P/DOkr9WBTlIPi2HaWUE5404j+O9iShx2O72ZZqn/hr7Rd71EqM+t92rb
         dCWOaw93dc06Sr4AiwPJY4ImuajRTY5ZLnu0gstHK8E/SCfEuRRSD65DNmBUrruOQFIn
         ytDA==
X-Forwarded-Encrypted: i=1; AJvYcCUoHqp+LUO5RPzavgZNRoUJZ0tMxgukVmBSJHHlxNV5K6FVe6DFJc/GqSdxFYirja+zjYE0f8Nd@vger.kernel.org
X-Gm-Message-State: AOJu0YzGFjkhk+5alXFl7McQf3BBKMaXjMLc6SyhNupdW1SaW4SBWc65
	JfIpqWNzJJ3hijh9q34+O5hM6zZiFUmEimd2Qsfr2n8x5rHCOSIZXczf
X-Gm-Gg: AY/fxX5bN4UuCSsDcN/bHDw37+9tCZvGxKtDDQhFW8bOLSllXQBXgFcTtMmNvsTPlD+
	XrKainQRLN/2+YY927ozqqKEt+jW3GPDcNeiRW/sDjD5lQuw4+NZAXO6IYu/d+3bQZAl3aoGRKF
	PTn0jNtsNh93yYRf6lFA80g6Gaj62or9PXDQUnNeQirQf9/Govj8lFpU+5KpQ39+HA0EiL9cG5+
	DWSW6dDGWDwTDJ85RL6zgRSMC/uAOLyj13aH9+U0GemjVYClSR6ie6uXJUS5RoMwstMTSR/DTMc
	/vhsk0VF+Vyh+VEBr3MjBpMwSz2taLfxid5xQKWYRy0ebpGPuUdcq19wZ3xbwOa7hJHKICnH/dY
	N+SRX9I14pIuarqkoIxG0nR/UWeMu4hQoXRb57OnrfV4lQMyMzs1VmdH1oEkHdRXO09lOWmXnGt
	RSmR8zjb4y
X-Google-Smtp-Source: AGHT+IHLNsvQdwzrBfeSHByDYIeQscxyPTYW9jk/uY54VBfW+Ug79KVvtcihVB6EuC6Db4DpraKqnA==
X-Received: by 2002:a17:90b:3c05:b0:34c:2778:1681 with SMTP id 98e67ed59e1d1-34c27781911mr10785620a91.6.1765864695242;
        Mon, 15 Dec 2025 21:58:15 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34cd215a212sm192143a91.0.2025.12.15.21.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 21:58:14 -0800 (PST)
Message-ID: <1456370aa292410bdda4bff85bead8e091675f4c.camel@gmail.com>
Subject: Re: [PATCH v8 bpf-next 04/10] libbpf: Add kind layout encoding
 support
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, qmo@kernel.org, 
	ihor.solodrai@linux.dev, dwarves@vger.kernel.org, bpf@vger.kernel.org, 
	ttreyer@meta.com, mykyta.yatsenko5@gmail.com
Date: Mon, 15 Dec 2025 21:58:11 -0800
In-Reply-To: <20251215091730.1188790-5-alan.maguire@oracle.com>
References: <20251215091730.1188790-1-alan.maguire@oracle.com>
	 <20251215091730.1188790-5-alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-12-15 at 09:17 +0000, Alan Maguire wrote:

[...]

> @@ -1106,6 +1137,8 @@ static struct btf *btf_new_empty(struct btf *base_b=
tf)
> =20
>  	/* +1 for empty string at offset 0 */
>  	btf->raw_size =3D sizeof(struct btf_header) + (base_btf ? 0 : 1);
> +	if (add_kind_layout)
> +		btf->raw_size =3D roundup(btf->raw_size, 4) + sizeof(kind_layouts);
>  	btf->raw_data =3D calloc(1, btf->raw_size);
>  	if (!btf->raw_data) {
>  		free(btf);
> @@ -1126,6 +1159,13 @@ static struct btf *btf_new_empty(struct btf *base_=
btf)
>  		free(btf);
>  		return ERR_PTR(-ENOMEM);
>  	}
> +
> +	if (add_kind_layout) {
> +		hdr->kind_layout_len =3D sizeof(kind_layouts);
> +		hdr->kind_layout_off =3D roundup(hdr->str_len, 4);

btf_add_str() adjusts btf->hdr->str_len w/o moving hdr->kind_layout_off.
This should make hdr->kind_layout_off obsolete after each string addition.
btf_get_raw_data() does not seem to have any logic to adjust kind_layout_of=
f.
Is this a problem, or do I miss something?

> +		btf->kind_layout =3D btf->raw_data + hdr->hdr_len + hdr->kind_layout_o=
ff;
> +		memcpy(btf->kind_layout, kind_layouts, sizeof(kind_layouts));
> +	}
>  	memcpy(btf->hdr, hdr, sizeof(*hdr));
> =20
>  	return btf;
> @@ -1133,12 +1173,26 @@ static struct btf *btf_new_empty(struct btf *base=
_btf)
> =20
>  struct btf *btf__new_empty(void)
>  {
> -	return libbpf_ptr(btf_new_empty(NULL));
> +	LIBBPF_OPTS(btf_new_opts, opts);
> +
> +	return libbpf_ptr(btf_new_empty(&opts));

Nit: btf_new_empty(NULL) should work fine because of OPTS_GET.

>  }
> =20

[...]
