Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FB01CCEF7
	for <dwarves@vger.kernel.org>; Tue, 19 Nov 2024 20:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732047244; cv=none; b=r1lVHBAnj6f2bKbaTohEZft3LlfolXq8BjG7Xoj6i3tBnGb+mbZCJNvOqQkOCUjKbcKFYs0pVe6oyYum9sUYEOCOKg+BPo4L+4zuHEkSaOlHGldSUFy3KRli++KRoRHsOu+TXu4uyEALGlFQeqrDXay0R2sluPCz6irPCXG/DEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732047244; c=relaxed/simple;
	bh=R7tmfgPlCsPzMClXOs7+zcqOvaWTRGQo5tTEJiivnUI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jx1WN3R9SusMHhDOtWPz9uMEuFqnUaYo3VkzuO+QJvB/pEUoqBsqIoKhSdK4sBfchJzJFafjqQSJPItkCY12fpxuoOS2ZrglnTVAOtBPL1gxAEpvO1Tu51Zb8LSa1Qhi/Eg7vwPWQ6ia3bmTHDWtIIMgyiEIqeDlkTxVqlSDpa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZjSEk1em; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZjSEk1em"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7eda47b7343so1029168a12.0
        for <dwarves@vger.kernel.org>; Tue, 19 Nov 2024 12:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732047242; x=1732652042; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=R7tmfgPlCsPzMClXOs7+zcqOvaWTRGQo5tTEJiivnUI=;
        b=ZjSEk1emM7vx7p6sul4MCZ0PXtJ3B3WOH12FhOYROFo9t+1Oj81FZ3ne+NZ8Zc/d7t
         0rsaYPLbzWAxqGGkKVeoWMRGEIRbELvbec9RqAieHpV38fsTULHPtY4VRFrvCnZamgMN
         Zzrm6L8S30CVqRju4p5nCd0BJeMl27jLkRgc7BxtyyU3J/5KvLmMYGrk5AAXKPSmpFnz
         OtXUlSAaB9dOGSxC1dZWMY4IqvPhvHSyhae7xw5sGI+t53rjw87gitS8Z7M+IlnbSjl2
         IfeDkXtLmvoqthlJV3i+yGibzv2LXXe5ZOba9gSRTOqXUnSf7T4vCh1jI73D2d0VLSQv
         FOLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732047242; x=1732652042;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R7tmfgPlCsPzMClXOs7+zcqOvaWTRGQo5tTEJiivnUI=;
        b=THk3uqhCTFyeLns7pS0zoF+2dlIGMXSFQrq9KVE+bpnD6XG6j16JREyMQKxqdnH/qb
         o2Zgtgf0bOX/KARcL+Le0AQ7ckbsZAamZiTPzMj58UdOH50FRHeC4WlJ8GL92OwIc+Re
         QTCjXHBbLYioqNerCyk9TLUIdiMgojo2wviOpw1JL9iTpVMSKtmdnYgNqX70k13GVPoY
         lv67mgsQ4L3d8mHaJlPqjtbGrGNifCQ1+lU7MRexB8w9SkAP5rG7aPymJjxQ/IpJltuK
         tbW/sRyq92nZPJLoXb66GjGBU6p/qA6icx253Ddf232c3sETUu20NzFF7eJE5mAdBNzl
         U0Aw==
X-Forwarded-Encrypted: i=1; AJvYcCUbIMFd764KXaVPF6rsIP28yDHdnUYxyGmcuOCVDrgL5wQoGnNRjUrTALDXKsaGTCNCdpscpNj0@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4oF0GI3Mf4zRpFaBJVRlchO1yC3QncnQEnZp5l0DB7zrbSEtw
	Nv1GqKguuPPYlZAPHfdRy5DN0Opg0f/Q/tfxwoo4KYyP8jXU3ZNQ
X-Google-Smtp-Source: AGHT+IHVVoFj1MrcEOj77CAkMma4H3iTbYh/d/pr6qTVC70B9rip1zqUUfXNXdlqi4NO34tKVot/Cg==
X-Received: by 2002:a05:6a20:c891:b0:1dc:e:e996 with SMTP id adf61e73a8af0-1ddafd57786mr555879637.33.1732047241940;
        Tue, 19 Nov 2024 12:14:01 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724beeb8daasm80141b3a.29.2024.11.19.12.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 12:14:01 -0800 (PST)
Message-ID: <acff9e62b537ddb657cba04d3755db5b86cdfd86.camel@gmail.com>
Subject: Re: [PATCH 2/5] tests default_vmlinux_btf: Introduce test for using
 BTF by default
From: Eduard Zingerman <eddyz87@gmail.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alan Maguire <alan.maguire@oracle.com>, Jiri Olsa <jolsa@kernel.org>, 
 Clark Williams <williams@redhat.com>, Kate Carcia <kcarcia@redhat.com>,
 Arnaldo Carvalho de Melo <acme@redhat.com>,  Matthias Schwarzott
 <zzam@gentoo.org>, Andrii Nakryiko <andrii@kernel.org>, Song Liu
 <song@kernel.org>,  Yonghong Song <yonghong.song@linux.dev>,
 dwarves@vger.kernel.org
Date: Tue, 19 Nov 2024 12:13:56 -0800
In-Reply-To: <ZzzxNrJ51E2dIAGJ@x1>
References: <20241118204146.772762-1-acme@kernel.org>
	 <20241118204146.772762-3-acme@kernel.org>
	 <33b85d2c1adafb5a46a874dfcfd43682395e1564.camel@gmail.com>
	 <ZzzrsLQCF9hYtT7P@x1>
	 <020ec6550eb5e73bb5a273c57a686565a0a274df.camel@gmail.com>
	 <ZzzxNrJ51E2dIAGJ@x1>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-11-19 at 17:12 -0300, Arnaldo Carvalho de Melo wrote:
> On Tue, Nov 19, 2024 at 11:54:12AM -0800, Eduard Zingerman wrote:
> > On Tue, 2024-11-19 at 16:49 -0300, Arnaldo Carvalho de Melo wrote:
> >=20
> > [...]
> >=20
> > > > Lgtm.
>=20
> And I'm taking the lgtm as an Acked-by, maybe a Reviewed-by?

Sorry for confusion, let's go with Acked-by.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

