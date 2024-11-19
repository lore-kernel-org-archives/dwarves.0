Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E9F45945
	for <dwarves@vger.kernel.org>; Tue, 19 Nov 2024 22:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732055614; cv=none; b=kZsPNFwrI01Si2jqUYRCh6c+doFbeqRZ5fyUEHqCU8aQKgnuG9x5tjIQ/5RZ9u4QkT7q4hfM2smHTp4+5iUQ4ws4czgPk0zyTvSYj+fwvIPQBc7hKSzI2wlVjq8DZQY3ArduonpvW3ltn9ZqiTWMaImjhJqNZnRZWN2U0190USw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732055614; c=relaxed/simple;
	bh=cARYVO9RF7wl+BqnkuwLivM9oD6C3oEr2USZY7gMi4M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aeLYEO/mcrrKIFQPD6kw1wp4YQXE2GyDL5RnD1JoxubDkPJwSfYh3l2LbdfPhoyvgRGObYyFcEQDGYWPMTZaW2yZZslSUy30krXemJYz4nUE34kAGcHLB9h0H6AsSYcDjW15WfPKXJ2mYIVqnsp+NDjWV3HuYi8F1dd5ceEYMw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZPgTR+Lg; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPgTR+Lg"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2ea1bc2a9c5so225890a91.0
        for <dwarves@vger.kernel.org>; Tue, 19 Nov 2024 14:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732055612; x=1732660412; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cARYVO9RF7wl+BqnkuwLivM9oD6C3oEr2USZY7gMi4M=;
        b=ZPgTR+Lg+W8HhFrowFcSDHuK/j7oEM0bg/gsY74EUUx/JH3SLMbL86kG3A6n+uTZGX
         jfvbRIU2lhASiQcMacUATeVYzIWBV+9emydehomFK4ohpzF2ELR8vhKLeLHbi6GWUR8l
         I9fdmoVY1qAol8cuYJBaksvM6y95yxpLAfw5+ND9ff5EXt7HlwAY/SxIRnBoEJA4pSn0
         HVPsMix4zqwZbBXHiR42fUZGCHfnQCBCZVM1qiMbK2lqImOWhI4mcOP3glSfakvyjYTx
         imsgaDVwqCU8CaAyDhpSmfMPlcag5b3woQ2aJ2yIEeAlASpAIT7aab3PNC1bxMlZdufX
         FlsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732055612; x=1732660412;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cARYVO9RF7wl+BqnkuwLivM9oD6C3oEr2USZY7gMi4M=;
        b=CngjEKPZEEEtV8R2fEFAmVeZAmZh9vw57tG0KtbbAbqVKXGo+q5zQnA6UdLyd4pSGD
         V8IsXnbFYd7vgEa9ke99upo+w38LEUUqzuGNtOrSymWVVYMLgNPQ9/HrHqcPKXwDkUvs
         Lcfj4H/fePIByBKJwGQj1FG6DqDnWobBJwd9lphQtkijrW/ixO61nay5KgrrKwcyv/+Y
         v2PLwm4gM/ctDoyyq1sXYGvr8SbgV9bwNzFo5p5g6h7EC91jJhqERcV0Z15vBZLeFAc0
         eLQM2gc05wI1iPcZOzcjCcLg8onz7fk1T/ATXMuH7go4+x0M5qV3EpNhKLJu9gv7Y7za
         zhew==
X-Forwarded-Encrypted: i=1; AJvYcCXjfbQ3aCBkYvIejn/UnnauDP77M6Ubf9lT5vq5tqBDszMCL1ns2PYtAtal5UEv/Q/YP1MbuURD@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2qWRNF3VUNcTvJgv78PxxEBtIRvyUcUd4Jwgle9wDSQjCy3CF
	MW0myXCdtfgQhhRngrtah7BJSbsO5z9o9sSBhnvgLV8MmhpweuGy
X-Google-Smtp-Source: AGHT+IE4MlXkIi95cuByo5OsC7QgXHqa6Kq+YBTLVbVPsH7r+9pp3pXej9823XHwVvcHFYKFSGvYVA==
X-Received: by 2002:a17:90b:1bcb:b0:2ea:3d2c:24bb with SMTP id 98e67ed59e1d1-2eac851e062mr1122796a91.17.1732055612190;
        Tue, 19 Nov 2024 14:33:32 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea89d3678csm3814552a91.43.2024.11.19.14.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 14:33:31 -0800 (PST)
Message-ID: <195a02e478cfb75794fecac06d12fb5c4e2ffef1.camel@gmail.com>
Subject: Re: [PATCH 3/5] pahole: Honour exclusive BTF loading
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, Arnaldo Carvalho de Melo
	 <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Clark Williams <williams@redhat.com>, Kate
 Carcia <kcarcia@redhat.com>, dwarves@vger.kernel.org, Arnaldo Carvalho de
 Melo <acme@redhat.com>,  Matthias Schwarzott <zzam@gentoo.org>, Andrii
 Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>
Date: Tue, 19 Nov 2024 14:33:26 -0800
In-Reply-To: <f2d1b6b9-f04e-4cd2-b73b-1a72057088da@oracle.com>
References: <20241119134032.783215-1-acme@kernel.org>
	 <20241119134032.783215-4-acme@kernel.org>
	 <a1366bfad38306b2e7e41549ba1ac2ed217b94ff.camel@gmail.com>
	 <f2d1b6b9-f04e-4cd2-b73b-1a72057088da@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-11-19 at 22:28 +0000, Alan Maguire wrote:

[...]

> So my read of the current intent is for PAHOLE_VMLINUX_BTF_FILENAME to
> provide an override path for BTF debug info only. In the above cases we
> know where to find BTF but don't go on to assume there is DWARF there
> too. I think this behaviour would be more surprising if the variable was
> called something more generic like PAHOLE_VMLINUX_DEBUGINFO_FILENAME -
> i.e. not specific to debug info type - but that's just my take.

Oh, right...
My bad, sorry for the noise.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

