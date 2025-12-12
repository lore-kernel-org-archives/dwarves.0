Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4C0311967
	for <dwarves@vger.kernel.org>; Fri, 12 Dec 2025 09:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765530306; cv=none; b=keFoEz/SPynXQjYT2WdQ8Y4hNpqLzYf6qmWZ7Jh2FrK5lyg+hoottbUU2Qgc+ANcD8l733mCzSkb+fUNtfEJZgGl+FH5x77Rryyp7iGpmnwKAoGBF40lEfxozjuRUOvvzwSwOU5lIXJAcUEK6W08ZEmUn+5fkrKpRAq40mkr0Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765530306; c=relaxed/simple;
	bh=JKozA+ihNq4x4Z9RrSdTKWeKEiQ1xyKxK4t4W67sS6Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W0/qWLVj9Rg2R5VhC0EHtAqFmMroO3vo+cbIjcv1r3ozDQZ9s1qjriYIxYzQ+DIuBupPiIMc5IceZA+0QChLAc9GuuK+dP3k/QBeC3AgGMT1WZq8y+1t3VmaK/29D49UJGQlASnLavCwQJKMwCQH5RWTS3MyUnI9hMtmg6bQ9C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LoojL3g4; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LoojL3g4"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-450be85b7d9so638595b6e.0
        for <dwarves@vger.kernel.org>; Fri, 12 Dec 2025 01:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765530304; x=1766135104; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JKozA+ihNq4x4Z9RrSdTKWeKEiQ1xyKxK4t4W67sS6Y=;
        b=LoojL3g4EPK6J4p1wr2PdyaT9nytwCp1Pcv7vsGEg/5PEboo7BezT78CTTNEnR2fcE
         JvmD/7KEq0GP843AwxPmHSWlwO4rVOMnE28eYS4kk+F8HH5S2am8uVkNAxrbEJcz2MxA
         TVW+a/ZHyMS1XXg72GhfTKvu4n4/uSE6rLcFMwdtUTGZVUND7TX/BRgLH2yPbYrWTYD2
         2TkiocXG/DiH5DuYySLA5McpYkd4n2hY13wkWW43atwqitKLkLqWJ9IA4xJS6IfuCkpT
         jVy50m7BGXpqa79q5qksHrcr44XDZuhr6FAAZduGEK+pBOHU3j9Ic0CKDHHxkFbIC/PV
         Hahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765530304; x=1766135104;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JKozA+ihNq4x4Z9RrSdTKWeKEiQ1xyKxK4t4W67sS6Y=;
        b=BVriDBVmGrQDaMGz4diOOafrozCeeOmQfajTrtWERrgGZS5jDFCXdHKUU1nKCiPILL
         TksHwDgg4wk1sTuOLjhgmkbxE+4gVO9bVF1JfXGn7SpfsbOlxYlFdVK0rKdIRkow6lm2
         9y4rWXpqk6w1E/WAlA0lsFxNtyaxj+x1mRtoLLXfaO98UfIjY5NpRUW9cDL/IvCOAW4J
         zuwJXLD+3Kcjt67rXObuWJOFjO8YlzQAyXSbCI1QxmrEKws8YjCpIegKbaAb07qsHpKD
         Xc5TodHuL5YZAUMjGVOaUG/lghLejChn9XO3WFdEb/nHWAcFFZ+PIA7/BHUKMEXpkCeO
         HxWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcO/Y75NZn23yGZ8eECuZRDrIdHofL0tul1F68CJCKZoTFE39odlR/0tIFVRaQmbLMUAutt+oy@vger.kernel.org
X-Gm-Message-State: AOJu0YyIfAIUvCYXel4K3g6pBmkzD3C6mpdYEb6GC2x3d5+QI1W00ff+
	ofOjT/tq0nhzYADczJC4KYofJD/WBMk5/N3gT5wR8L2bGiXVn4ZNiUUKJIE10naz
X-Gm-Gg: AY/fxX6pKTpdXDtKWOWEIdyJ1D9avpXCMoCNiNB2gSVnGfrZS2cERCxGyW+ciLBI65C
	VRxpH9uBwBoM6a+t/xZBrfeKMJFd9khQqsrMKCo46293aM0FPgMbuhGy07Xk5Qq/JifNc90cu7f
	PcTY84avnyPpypd04iXIHiTjIHyz5b3WfaKcK/ZoC49JhGLB5DQ1R9Mx735JIKJD0BENgtg5Wk9
	ABYtkSYFnHVyx80+RZX+OnwJ1eoMh2HCMwwswORd1P8Wdxjj5/P2ql+SgqP5BUp9NrvwU3xUfcD
	u5SEh8vDfNGE4Y260xFJyS/uv01yfB8k6u+veEOjSPKL9Z9kr7EJGu8Lt358dghe0PsReNMM6NI
	1/xoaTSkx7xkFbwGSUWf4RhQXzg/+xN3/wQ9nHMYlZnpPJI/37ao9gU8lcdqr7Ly8aEUGtPu4G+
	egQzypC+S5zA+yF9vag2ryioj2mA5yqPF/zNoFuxxYhVc=
X-Google-Smtp-Source: AGHT+IH321PbFRiMaWCDNl4lSGVuS0AwL6lMd2u2Ei57eaf0ISIe5GTqG0pgY602LItAKZZCrdasEQ==
X-Received: by 2002:a17:902:f686:b0:295:9a46:a1d0 with SMTP id d9443c01a7336-29f23cd7cebmr12297065ad.45.1765523389898;
        Thu, 11 Dec 2025 23:09:49 -0800 (PST)
Received: from [10.200.2.32] (fs98a57d9c.tkyc007.ap.nuro.jp. [152.165.125.156])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29f2e40765csm5138155ad.0.2025.12.11.23.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 23:09:49 -0800 (PST)
Message-ID: <e509afe94b4492d64e27756f4db773b7a179e994.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 4/6] lib/Kconfig.debug: Set the minimum
 required pahole version to v1.22
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,  Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend	
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev	 <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>,  Andrew Morton <akpm@linux-foundation.org>, Nathan
 Chancellor <nathan@kernel.org>, Nicolas Schier	 <nsc@kernel.org>, Tejun Heo
 <tj@kernel.org>, David Vernet <void@manifault.com>,  Andrea Righi
 <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, Shuah Khan
 <shuah@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt	 <justinstitt@google.com>,
 Alan Maguire <alan.maguire@oracle.com>, Donglin Peng	
 <dolinux.peng@gmail.com>
Cc: bpf@vger.kernel.org, dwarves@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	linux-kbuild@vger.kernel.org
Date: Fri, 12 Dec 2025 16:09:41 +0900
In-Reply-To: <20251205223046.4155870-5-ihor.solodrai@linux.dev>
References: <20251205223046.4155870-1-ihor.solodrai@linux.dev>
		 <20251205223046.4155870-5-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-12-05 at 14:30 -0800, Ihor Solodrai wrote:
> Subsequent patches in the series change vmlinux linking scripts to
> unconditionally pass --btf_encode_detached to pahole, which was
> introduced in v1.22 [1][2].
>=20
> This change allows to remove PAHOLE_HAS_SPLIT_BTF Kconfig option and
> other checks of older pahole versions.
>=20
> [1] https://github.com/acmel/dwarves/releases/tag/v1.22
> [2] https://lore.kernel.org/bpf/cbafbf4e-9073-4383-8ee6-1353f9e5869c@orac=
le.com/
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

