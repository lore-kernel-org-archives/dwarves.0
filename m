Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD96E78F20;
	Fri, 21 Feb 2025 01:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740101458; cv=none; b=KNwNpfG/U4SJo4Q0N/6V/F1+ktfGBOVrcpFtxOhO+jAsa9domSrvRInuPNZCgzZwt7fwboLWScSV6ixeLOq2vd2E3sQMrhTAoUul2k+bHBnIWR06jqdfQsHKLI3dk558lmyarHEL0gYu5Lw8EoSIPM1twSl4RN6lrKLn4j1BISg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740101458; c=relaxed/simple;
	bh=E1A8tBCGcXSJ3SBrHl2HK2GRIInsBV0VbP+YIiz4oHY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KPxObv65SsK0g5A3yw09rMoaP+vLmylz2BjexUTC55Tv1ZgranQM+WrWLo5NR1nrASbzp3bMAk/wEzTN8fG/M/PEhusFzyj/I45VGdOyoXM6neWBYmDfxb9AIM3wqGCFPvECEsHnccbmb3GRBY2onXvF+SuVCwSi55YoQfX/YaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=loi838lW; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="loi838lW"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2fcb6c42c47so2579685a91.1;
        Thu, 20 Feb 2025 17:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740101456; x=1740706256; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E1A8tBCGcXSJ3SBrHl2HK2GRIInsBV0VbP+YIiz4oHY=;
        b=loi838lWwfSeYajAasfTrcQB1iPwUa/3SpXiceqdq2rDKzZCQ5QKI7fjXKVmARHtSC
         6k8ydj+xKLxryaFxRmnrZoVaHVBJx6dK/qW04r2IJnNufKD49Ex79CGZB+uYOMhGVeFT
         y9OLqpbjg/Ktc5t12Q/5RgnKlvIQ4GzzbC78vQYE5X4lug948N4CcOu45m0n7uNsQWIk
         cDjJXpmZfoV4IzeBELFE+rqZ+bvtJ+ke3rUw+LMOYpCI/1mgv2jGODH12rBiEtfks4WT
         0SS5mRXbjLROjwxT5BQypNcyH0rEpyk5MLZbDt2sCCf5qvj5l8l7FjcFozgnBIjuZIYQ
         3Lbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740101456; x=1740706256;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E1A8tBCGcXSJ3SBrHl2HK2GRIInsBV0VbP+YIiz4oHY=;
        b=KMmdoedKXp2yHWzFqq5MOBzyuB+6ago3IokScttYopR1vn02CalmuseBxhVF6wCH40
         YVmXInI+lQj3o1qQm7AH21CFKlOO6yx4pPxrb5YMH/685IPYU0yplpy8xFbBOS7cDRNy
         3p7xbSTc5hr8hu+RlFCuZoCmlrXNwPP7VpmNZ3cpPcGzKLgUmK+UaaOpJps9OPi1XZNb
         W7dIJATmZEQjxkvBpBPi7SBjogrnTDQJjEPwVxGmg/9I/wcYmU1+F+pkv35cX7TD8YtV
         sZEMYjC7hQUmmE2c8moE6Pp6ucvEyjpLp/xBykkyvmez8XtnQXvnOZkqjoj7/38nmM1t
         H96w==
X-Forwarded-Encrypted: i=1; AJvYcCUMlJul+6+eesPaXIvo6ma5Uo7JDDsWPYiFFIsObtMAFTAlM88+cn230WgXhd25y+GC/B2Yw0EI@vger.kernel.org, AJvYcCWG5ooJblTt+W4XrWGUyuFVN82J51bOW0Txxg/GQ0QufFFWChgo+kuuac2IpGrBqCGXc/TuMOaFOQd4UdBz6mEp@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc4G/g3CVQT5oQODhnNKKJ58v6S0+T4B6dMSF9JkNyABElZGyI
	JchKH05niUWZBcOcDIyJyjPZDxrXelaCc8Zt9nSZLTxtgvdYi1NtesWj4EyN
X-Gm-Gg: ASbGncsW0nA1aFDH6JnkTv5oWu3uzQ7XRlpCQnG2rPX0adx6xT+dwGIBln2g0tEzVFZ
	kyghoIH3BOZLdVVGG3zjBZrW79hM+3Xv4N41t7KoRLcXJJ1GqtCIZuGaxaicw5ucCK2Yizfli74
	4fcXB8nnlxvNYFDxNIovAeSLqBrgH5xnCHAmvkMDniD8WOt3yW2WL0M8AD9HCzihBJ1xjp5N4yn
	mHqIEOnx9QVpq1vsYQ3kDtO4vckDBTUq3mgZbj2Y7DOSz55YkpgpxpPMA0vkFIvNSAyl9pG62NB
	9whnHy9sb/IdilWgZwEpKQU=
X-Google-Smtp-Source: AGHT+IFcWZMtqoKF5ck0/K7Rh6vnrSxgo+EPHKg6i13CsWHKlgR1o5H7IpF0sEAiokvMJk5IVb6EUw==
X-Received: by 2002:a17:90b:3d8c:b0:2fa:15ab:4df5 with SMTP id 98e67ed59e1d1-2fce7b3e2d6mr1895943a91.34.1740101455942;
        Thu, 20 Feb 2025 17:30:55 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d55850f5sm125604085ad.208.2025.02.20.17.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 17:30:55 -0800 (PST)
Message-ID: <d3c1201ab0ff7831b03cf9cd00afb09696e6e40b.camel@gmail.com>
Subject: Re: [PATCH 0/3] Fix duplicated VAR and secinfo
From: Eduard Zingerman <eddyz87@gmail.com>
To: Stephen Brennan <stephen.s.brennan@oracle.com>, Arnaldo Carvalho de Melo
	 <acme@kernel.org>
Cc: Alan Maguire <alan.maguire@oracle.com>, dwarves@vger.kernel.org, 
	linux-debuggers@vger.kernel.org
Date: Thu, 20 Feb 2025 17:30:51 -0800
In-Reply-To: <875xl4kszj.fsf@oracle.com>
References: <20250212005003.1413091-1-stephen.s.brennan@oracle.com>
	 <1b0f9104586fa37a5480581e6dc59780b25d3b29.camel@gmail.com>
	 <875xl4kszj.fsf@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-02-20 at 17:05 -0800, Stephen Brennan wrote:

[...]

> Thank you for the testing (and the review). I haven't yet been able to
> reproduce this. But I see you're using clang. I'll spend the morning
> building & running selftests with clang to see whether that is the
> issue.

Right, should have pointed that out in the email.
Clang version is 19.1.7.
Just tried with gcc, and `./test_progs -n 1` indeed works.
Then re-tried with clang, same result as yesterday, test fails.

Thanks,
Eduard

