Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452D63C38
	for <dwarves@vger.kernel.org>; Fri, 12 Dec 2025 07:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765523410; cv=none; b=C/KCvrPcOusA8BTrymM+6g44mkW6guYx0fV59U+zFz2SrNs/glPGIsN2+UWequ44iFAnRMf+GuIfpoRxyZhm37aAHBmUVEGhHIF9vGvf/W/pRFyET/yTaiAd4UbIeiMuVaGDHSjyU6oNwgS3fM0G99Frnwnl8HhMRXzak3AQloc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765523410; c=relaxed/simple;
	bh=ski7sMyp+O2WAeYvfHItoMLgXRCcG6iQZx02RmEom4o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fxWZxDFC9pH0eD2IaxmoBffjpRctshAPAMeDA1Ca+h+4CpA+k+ahns+6sq3YbaIoSP1E9zCs4ARlCooD9ufpdIyAQvWPy0C/Ghk1iaS1oyJilkIqnk+loRvNoXpa4dStEQFymYd+mPcAmnxUjFQtvsSMtpxmZ7NfM0iN4ZeWoVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V3bJVq+D; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V3bJVq+D"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7e2762ad850so927372b3a.3
        for <dwarves@vger.kernel.org>; Thu, 11 Dec 2025 23:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765523409; x=1766128209; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ski7sMyp+O2WAeYvfHItoMLgXRCcG6iQZx02RmEom4o=;
        b=V3bJVq+DEwo/GVW+NAWm4LQypQVAK0ZbbJSFzxkR+/cOMYahE0pid8b4tyGzx4zVh1
         jSF10nahz1dUd7EVqYwMV5WRqIT0x0vOX9ztutwGdxlrplNkP/jXeGhtOLjJkt6OZUEP
         wljBMY9dE0OFroYxk5/qU7I4urZf7gSgkPltQuasoo9cu6djCkT+GLHBOBa1WZr+q83x
         MKiLXiqoqOQDdmZTmTstydtqccGTqZWKC6xy69Q56NCUhgytAiVbPuzspHAcrXcZfRbr
         XiDxcw+C6Hl+ziX3FNI5r7UzOHyQV1x5iK0o5x0fbztoX3LaTuhqSIHJH8L12GdMdvH9
         P/FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765523409; x=1766128209;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ski7sMyp+O2WAeYvfHItoMLgXRCcG6iQZx02RmEom4o=;
        b=Yu0Lb6cByVDuhI+FchQ5C4Vx0pfPQA3hpl/AAnyYHGpW8RWVgNbLIT4mc9iHRg+BWY
         q/bv+6tW9tASM4LtnWOQfz6MzdY0D5ytqPruG57mlpBJYcC6KDNfcgfGXJhspqmIYMU8
         ikjDRZztMLor0MzvIEXwsGBxz4intHSQ3XaR6jkxBTAlE9xBGshJ53CjRs3iIKt66ZH/
         Pc7/YYp/QdRRZvVE0eVnJGYPrQBMjAe8QiLV3wsHPo+X93kckaqQEGpVGUv5GwebeWHe
         BEItfojc62Zq0j5gHPCjrBtCeGJw6xxhks+HjHj5xQ0YtYozhs+JZKjtD3+Y8ZKLCinH
         Tb9w==
X-Forwarded-Encrypted: i=1; AJvYcCV+W6cY1uu5GW19EXqlHOdbeoVTNF0UWDWnkSP4SNc0zXfjQnx76oaRMx3cx993Qrj6KqzFRjkT@vger.kernel.org
X-Gm-Message-State: AOJu0YyFBmey8QdJeKwhrwrXLAyzBTopovS5ueKHbdr2q/MS3N+BM5j+
	DOGdMMYmn0JsgOp8SbG4Q05Gp6qdQfqqXnLB8VwJJb15yPdAWFxCEn/W
X-Gm-Gg: AY/fxX6+VGg8t/hS+ROMbQbEMwH2O84u+NNSlTW7ZD2XSozB20KHNA9/Nrl0EU1nJfZ
	QDdV0H/I7dG1hjy2SvX6okVgP65FDJeWSlZSUtpYQHIzeg1bUO5FKqXHzaf8H6R2TvSSYCcos56
	jkWYVobxu54uFFFdiO/ROwDywHQXq5W5kcyKvNOnMLl3Ga9NlsuEKo/1BXvew+KV+exfa33HT9O
	PNkBrGhrq7uk/fQ5klRs0LxJoEcrsFO84oySvTuTF135w+7msPiBEzIpvTTCg2vePc+UW5jqU3U
	taopTjK9H+Zljxvr1+BWxh4VvqQ5R8jd2lofLxiiikkEsBkTAzA5P4FRfUiMlEt+Pnv6JtJR8HI
	i0i0NPevNiqcfKaHQRDUDM6KOtlG6kZ7bQjJCsxvenksPQcs41Bfel6tw+yxGbUNVwpyn1MMfdE
	KwiwZQZHZLzh/iIz6oFHophXH3D9IZ7KVdq8YgQR5B3Ss=
X-Google-Smtp-Source: AGHT+IEZgH8C3X2hKHFaGk8m/sj+wXbz4vPJ51iPhQv7rcnwmjwBtTIy55XTg/nxIWcxrRVf5+4t4Q==
X-Received: by 2002:a05:6a00:a381:b0:7e8:4433:8f99 with SMTP id d2e1a72fcca58-7f6694aa45bmr1178150b3a.33.1765523408660;
        Thu, 11 Dec 2025 23:10:08 -0800 (PST)
Received: from [10.200.2.32] (fs98a57d9c.tkyc007.ap.nuro.jp. [152.165.125.156])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7f4c4aa9b56sm4327224b3a.39.2025.12.11.23.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 23:10:08 -0800 (PST)
Message-ID: <f8c5f2a6c05c5a24076aa39fba7a45d30eb5334c.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 1/6] resolve_btfids: Rename object btf field
 to btf_path
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
Date: Fri, 12 Dec 2025 16:10:00 +0900
In-Reply-To: <20251205223046.4155870-2-ihor.solodrai@linux.dev>
References: <20251205223046.4155870-1-ihor.solodrai@linux.dev>
		 <20251205223046.4155870-2-ihor.solodrai@linux.dev>
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
> Rename the member of `struct object` holding the path to BTF data if
> provided via --btf arg. `btf_path` is less ambiguous.
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

