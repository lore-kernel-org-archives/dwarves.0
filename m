Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEC931DD8A
	for <dwarves@vger.kernel.org>; Wed, 29 Oct 2025 23:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761782093; cv=none; b=IAS/y2jGZaOYs808rffrEQgrwaKbLI9voB/MCqnYFIYRS2FFViPmdwY7x7LGVci3MjRwp3MtW2D8rp9ue3/1MMcLR7+MM8ezVnb4i+pFLWUwccBCzkGlhdZ+H0B88bJW8FICbwSl52Gch2IcXvP4+NpurIoYh/fGKAFp/WOjLwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761782093; c=relaxed/simple;
	bh=IdqEFmHuoRNxR3u0UPrZ5MdcP+JNada6rMZWAMJseOs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=omDXAXCwb3rte3YdsVThq84RvTnQUjmAET46o+3YTFZpf0G5vSdA7CDehhGtGf7stV1go9pTGkG1egeXxzmcmxJmFxKKzWCwfpQHJMD1mUMxZ9Fr2PvRmUvKpIL+HKXYTk+6zGXF5yfFPRf2sukSDzMIRvrp9fEFRhbw1/t4nkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ItPkI+DR; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ItPkI+DR"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b6cea3f34ebso261266a12.0
        for <dwarves@vger.kernel.org>; Wed, 29 Oct 2025 16:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761782092; x=1762386892; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VqHaPvvHNUWfgjNN6SzCPgghHpzAxfuGayVQHsMdmeE=;
        b=ItPkI+DReCHnQEmUMZxEB1XrUNFArr3q5S+JVMeJn4Wrt4zaY+ogH4FRtdWxdfM0Q8
         XLisXfQRjBVvzJOOeRw3Yiszcry0QZr6wWAtvotdf5vggycUFwoDW8mcAZkWFzcH80nM
         9uKG9YWWM3SZdMRnhLwxoFG0jhTiq1SK+qzPM0wkWQgdOGswZrx3jMCGP2CBHGBp7Qkq
         uXuChpJ3nwNLk7ZneDBQD2w1W0fzmcsPB0Zht+f+6ie8Wj1+lPv94zh2Eohg90A4GLCK
         6JUOMhm20cMlyVEkPTgaoNRIDwp2/nqgEtIjZWcn+uN+/aPui5rNJjWffwxihjvXqCvr
         612A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761782092; x=1762386892;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VqHaPvvHNUWfgjNN6SzCPgghHpzAxfuGayVQHsMdmeE=;
        b=cpQYQg+rMpJ5m/dLhxnFXNKD35fQ4IMtY96fY1tW/ImZIuBUXVvK5UC+nzTAWZT+sD
         M6YYHXo7Ew0DwpRBs+hamAttSSf9HYkYQVoTD0GMkX5xCPNuSx8fe9FZ9enSsFiWyxPa
         /9ZxGboS60hK5NxYs4GwyiIZaVHKGe4hx5E/puZYVs4OACtzTWQWHQ5jJX7OMp2lFSqc
         dAoXTwTAGKbAssVHavswfgYMnn9TS8QELQCMEmSNAfPxa3vmoZb6si8LibRpE6YIvENF
         AzM8JBHOhirddPDkiz2PuzSG3k38Mqyg/wab8jMM+sbDCPcN3GtKXKipLBP5Wa0Xcwnn
         hGtA==
X-Gm-Message-State: AOJu0YxRYYtJkrn7ZgP/vW7NKYDt43alzXzLijJdfQIEaMe9oP0mXy/Q
	jI7WNaUnOj4afv1Mbb5X35L66A7AX5crOmxBEwR3UNTjOYWqcKOEpmOs
X-Gm-Gg: ASbGncuKD6iIIxjyjW+dxMQTnLzTYGp8kpJ6xH/10lyBTLHN/471mnJ52Lxg1LVse0y
	uDqsmBCnNL0aUxGD1yzRbfXgPZUg0gQe/Xld4X/TkKR1XnJQw11QSZRpxZnYkidTiUMGKC+gXs/
	gK9VJ1s13V8+P3U48y+H0wg3rn1EkQ3rgBVse0mKPqNbYTCpH+y9F8mKfB8Fie9jyHGs1FscE+5
	8/RxpYHWD0SUHs+dPB8RN7oPsFQysBlwAOiOOvIL4HKOzut4flZFwrfEL1oNPxMDiUbpijQHPiQ
	cpspqM84XGzfrZ8gMOSv9b7NZccuMyZEjqsc3N0hZkoH90+/0ZOaIsNGwksuP8Y/2SBN+Gqh47J
	XKLCnDxo/JLBfxwsyKnVdRrDBFduK8h/sUbbM39rd6WSmWRtA9huLI/NSeEpYUWrpEBBm8w3jra
	K6bWfhZewGxEsRWdb5HsaghuNTtA==
X-Google-Smtp-Source: AGHT+IFHrYkS9VYx/11lvKingSrB4Z7zZwes4RlUiaCld0TDU8btdffXKIIOQlDKot8lbPJDzMD8+Q==
X-Received: by 2002:a17:903:22ca:b0:267:9931:dbfb with SMTP id d9443c01a7336-294ee0aa27fmr12249935ad.54.1761782091823;
        Wed, 29 Oct 2025 16:54:51 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:3086:7e8a:8b32:fa24? ([2620:10d:c090:500::5:6b34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d23218sm162919995ad.51.2025.10.29.16.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 16:54:51 -0700 (PDT)
Message-ID: <c7df8f49fe90256a37b286df7771dfca9b9573a4.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/8] bpf: Add BTF_ID_LIST_END and
 BTF_ID_LIST_SIZE macros
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, bpf@vger.kernel.org, 
	andrii@kernel.org, ast@kernel.org
Cc: dwarves@vger.kernel.org, alan.maguire@oracle.com, acme@kernel.org, 
	tj@kernel.org, kernel-team@meta.com
Date: Wed, 29 Oct 2025 16:54:50 -0700
In-Reply-To: <20251029190113.3323406-2-ihor.solodrai@linux.dev>
References: <20251029190113.3323406-1-ihor.solodrai@linux.dev>
		 <20251029190113.3323406-2-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-10-29 at 12:01 -0700, Ihor Solodrai wrote:
> Implement macros in btf_ids.h to enable a calculation of BTF_ID_LIST
> size. This is done by declaring an additional __end symbol which can
> then be used as an indicator of the end of an array.
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>  include/linux/btf_ids.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
> index 139bdececdcf..27a4724d5aa9 100644
> --- a/include/linux/btf_ids.h
> +++ b/include/linux/btf_ids.h
> @@ -97,6 +97,16 @@ asm(							\
>  __BTF_ID_LIST(name, local)				\
>  extern u32 name[];
> =20
> +/*
> + * The BTF_ID_LIST_END macro may be used to denote an end
> + * of a BTF_ID_LIST. This enables calculation of the list
> + * size with BTF_ID_LIST_SIZE.
> + */
> +#define BTF_ID_LIST_END(name) \
> +BTF_ID_LIST(name##__end)
> +#define BTF_ID_LIST_SIZE(name) \
> +(name##__end - name)
> +

Nit: no need for line break?

  #define BTF_ID_LIST_SIZE(name) (name##__end - name)

>  #define BTF_ID_LIST_GLOBAL(name, n)			\
>  __BTF_ID_LIST(name, globl)
> =20

