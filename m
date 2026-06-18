Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854E4377EDD
	for <dwarves@vger.kernel.org>; Thu, 18 Jun 2026 04:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781758015; cv=none; b=pnBphFz9uaIlL2SSjlXh73ITmhEYanB18hu1Ksp/f5+0TX2QwOuf8Z+6huDFDuD/ocxJXclSrnK3NeU4GZ8Kn/5bq25e1EWkBqrMsWXTv4Kw8szeyDTwZyt9FXB9ciMbV7CG2Eb921pJuJ9ydZG2PHwMSQoa9AOcAV0+IMtgy3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781758015; c=relaxed/simple;
	bh=G7NNzpithMzUQF4K63cTAyYOJ7Z0wlyAVq4xsJQDNfk=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=aZM7BNb0BGAWOndjTRDFp9GXlnXlOZtuZAC5rcF9pEC3t4Ud7mwZo3lDA24JpgdExfAiehhTotYGDRTkSqFA2kWG56m3kC099cOHFL+Vdf0SSIMg+G6NqIEAvKYNZURbKigeP6jsbVjojLD2BVKl+AKmcSePjuENMsZdYsVKmHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=NKL9QRpl; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="NKL9QRpl"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-36d5b11201aso307857a91.2
        for <dwarves@vger.kernel.org>; Wed, 17 Jun 2026 21:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1781758012; x=1782362812; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RwYn0b1ljZm5xm9vU8S5Ez8Hx6XEkpn06QsCD9WcSg8=;
        b=NKL9QRple/VLlHvhQyWmRqWTmc3ScY+DppM6hCt+ttKCco2n7TRaEuQe6bvfdeTq1I
         CdgbZUoPo1o00SM+knbWqD+uqNU0+UR0jasVGG4N7Yh060Mo9oXTOtb99nrdiAhIncDU
         4a34dHVv8t8cihSYxH3+fu58ElvwlRHm47SBNi4A1nPvzOYgh3paTH8kmsZi2FLaeZnL
         lFCEFGb2qYuiGbZS6umu7EngXoqf8n7ZZxCdlgHz7a7qfJrlr25uITyt6dxQx7uwGsof
         sJntHc5FsIyY/3Szcl6TxkzGOrGUpcuZEIlT2bTWeCyjneVO7e1E8BVXZYDFbSfl++Gn
         7qHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781758012; x=1782362812;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RwYn0b1ljZm5xm9vU8S5Ez8Hx6XEkpn06QsCD9WcSg8=;
        b=VixFigwUAQQ6/BaPwCPRj3jU4VkCWZ1TdPbsuQrFHniuorBppMag4VKTS6dRMR3zwx
         zUVPzT9cxtWkF3WTDR+tncjhz9MDzNzkoXkVMpKptHB8XXbFn/8zF85XpxkEXjpN4T8h
         Gd+j0d0tNSyzoCQV4k17elXOVDksArt80/JV4S37JogLx/pPLb14fmnxnVNdpG8vU2Xc
         XPNt3TddlufzAbD+i3zETdbx/jDMmuEHMflrF2JoFbYl5gMnnJBUxKlnrnx5cTqevblL
         0WuAWRx/CJ9Oie3vPjemwKUj2DR6GLoKAcP194VBK4ft9/qG/Cd3KFG/5dRm+kw+7q2Z
         4Keg==
X-Forwarded-Encrypted: i=1; AFNElJ+Ja3TnQ5LMaSOOa32cc7EYTmcpH9if4+Zi6tUZcphOM9VDjHJEvyzCgnWPKlo0P5mYpCEIiONJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzUFhG4+OZgYhcmODUveBKYBTK941gTnnzk0AkVTfVpAUdhCT/S
	jfhxzrgXVJGAVK0mkQq4V21LibtaQ9t/NQRwUuHHsT/DHP94AxO3dNvCukkUkXE6W+hgNFCtj0+
	jpq1K062Cgw==
X-Gm-Gg: AfdE7cn2PGAS7bxYha/98gAUOyBhYHQNmN//95/2zK4gfH49NZ2n1l0AMOrXzCCrtEq
	xR26t7Bu3xfMz/1+xW3AMtHoPHH7DFHVSCKVm+WlTGFPtmlh/7OljfwfUUEVeAWwhYYawSx87d6
	dEPW/Z8sI/VGQtLonzTClJmWho7QwB5uFfLnVXFAookhmRS0TnwQw2LH1jVL6frRAU+x6ijkTJG
	jqYjB+zU5cUcI7l+dwZLAX90briEoStGXRMvzzCnueCRmcRP3xH5guxtTmtQjz8mg4rnAQWtPCx
	zxNbh35UlMbBgNtSiSNnrQk61C+PEvugDMKq7K9z7bjXS/ndZsyU0Go1S5ilpyn3JY/GXtOe1kL
	lpc40y8Mm/fSciZ8GzrtT8GjxDrzc5WfjpEEm4JfvZ6b2mtEqxOmGM01EeIGAXtauTHMAme0tu8
	mkBSy3uOVP2HDsTqhpDGXL4ZNPtPdX/i1bjJv+AWTXb5O28FP0bh2QTFI=
X-Received: by 2002:a17:90b:51cc:b0:36b:bec8:94c5 with SMTP id 98e67ed59e1d1-37ce44b6739mr2335254a91.10.1781758011754;
        Wed, 17 Jun 2026 21:46:51 -0700 (PDT)
Received: from localhost (S0106d8b37028eeb5.vc.shawcable.net. [24.84.91.85])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37c521ae039sm7756627a91.1.2026.06.17.21.46.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 21:46:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 18 Jun 2026 00:46:50 -0400
Message-Id: <DJBWI249TH74.C8BAB4SRRTXB@etsalapatis.com>
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Vineet Gupta" <vineet.gupta@linux.dev>, <dwarves@vger.kernel.org>
Cc: <bpf@vger.kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>,
 <acme@kernel.org>, "Alan Maguire" <alan.maguire@oracle.com>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, <jose.marchesi@oracle.com>, "David
 Faust" <david.faust@oracle.com>, "Yonghong Song" <yonghong.song@linux.dev>
Subject: Re: [PAHOLE v5 1/5] btf_loader: Handle decl tag component_idx for
 parameters
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260618005731.273181-1-vineet.gupta@linux.dev>
 <20260618005731.273181-2-vineet.gupta@linux.dev>
In-Reply-To: <20260618005731.273181-2-vineet.gupta@linux.dev>

On Wed Jun 17, 2026 at 8:57 PM EDT, Vineet Gupta wrote:
> From: Alan Maguire <alan.maguire@oracle.com>
>
> A BTF_KIND_DECL_TAG with a non-negative component_idx applies to a
> specific function parameter (or struct/union member), not to the
> function itself. btf_loader.c however attached every decl tag to the
> type named by btf_type->type, so parameter decl tags were recorded on
> the function rather than on the parameter, and pfunct never printed
> them with the parameter.
>
> Resolve a non-negative component_idx to the corresponding parameter via
> new helpers ftype__parameter()/function__parameter(), and attach the
> tag there. Teach the pretty printer to emit a parameter's attributes by
> factoring the function-level attribute loop into tag__attributes_fprintf(=
)
> and calling it from ftype__fprintf_parms() for each parameter.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>

With one nit:

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

(Also feel free to keep the tags for the other 3 patches since the=20
changes are minimal).

</SNIP>

> +	if (component_idx >=3D 0) {
> +		struct tag *func_tag =3D cu__function(cu, tp->type);
> +
> +		if (func_tag !=3D NULL) {
> +			tag =3D function__parameter(tag__function(func_tag), cu,
> +						  component_idx);
> +			if (tag =3D=3D NULL) {
> +				fprintf(stderr, "WARNING: BTF_KIND_DECL_TAG for unknown parameter %d=
 in BTF id %d\n",
> +					component_idx, tp->type);
> +				return 0;
> +			}
> +		}
> +	}
> +
> +	if (tag =3D=3D NULL && component_idx < 0)
>  		tag =3D cu__function(cu, tp->type);

Nit, I think this can be simplified as follows:

tag =3D cu__function(cu, tp->type);
if (component_idx >=3D 0 && tag !=3D NULL) {
	tag =3D function__parameter(tag__function(tag), cu, component_idx);
	if (tag =3D=3D NULL) {
		fprintf(stderr, "WARNING: BTF_KIND_DECL_TAG for unknown parameter %d in B=
TF id %d\n",
			component_idx, tp->type);
		return 0;
	}
}

<SNIP>
