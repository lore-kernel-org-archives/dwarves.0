Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1363376A2
	for <dwarves@vger.kernel.org>; Mon, 22 Dec 2025 19:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766430208; cv=none; b=VyLEl2U/nCWjyNrN+46zWtBs3tDbaeR1v9oVi4m1C5PruiuwwgQwZ2eKe81UT5ucJtonG431q1PjPjt6sdJhUl9o+uasNaso6cMmBvJP/CEWdkt8+k/bejLOphx8DmudEwMkwB0Bp8vO3T9Tmcfu0W+2wVyAQVlSnonDlE0Seek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766430208; c=relaxed/simple;
	bh=5iAYN54MFAPkrX8EkYZmeAcc5q9qX8LUMd9BPp1et24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rz4/ZkbDdsVfECVi8N3MNNajlYL9+9kTh3LmI7kHzNPqdlRuc2dWiyPbYyGY/FhuZkrTtzDftRjORF/uevD6qC4PFvDPQ1+Mtl12Kqek0NHPiQgQ7GV07zVYKopOSIfQ0ZjNJ6dN7irm7Y9jS4gsQQ1se+PrKZ42sDZjQLcAneY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BTy9cDCd; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTy9cDCd"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4779aa4f928so41536815e9.1
        for <dwarves@vger.kernel.org>; Mon, 22 Dec 2025 11:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766430203; x=1767035003; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5iAYN54MFAPkrX8EkYZmeAcc5q9qX8LUMd9BPp1et24=;
        b=BTy9cDCdvf51kpeSqoGJwYEC8CWFYvzSPBJudifiBvVKyQSSmluEAufJ8KhtgjiAdj
         BFymS8vUybLogUG+9uH+p217nog7uY/cNMMdJEEEM8TwXtuSWBK6mUxKg58+3EUJnSUX
         XGWTsDru0K0AFZMtphVk4kmiHACAGYqSrOTeR6Rpoa/MCKZD7ch921RuocB+R/mnXhS+
         NTQJfiXcucAFvofJPFb2Gx997hONLJpDeRkJ4rVaolgXWA/ir2jjv7Sne0LvIlIBIDJl
         JzQDmffQJWvfm329wt3TZ74sY8nD6KLqVYhELrfjW7YawmWMPnJygNOvTYZp5hVLNkOu
         jQSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766430203; x=1767035003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5iAYN54MFAPkrX8EkYZmeAcc5q9qX8LUMd9BPp1et24=;
        b=YMm0z/yZo+0/lJiXeq+lulQw3kmZSqugRkc5rd3uwB92286uCIkY479LiU5kcc3pwZ
         FYh1DhmdkiLPjGdwiIM/loVSswu46wSmL3jrjzTZeFEMD6++XUDezG4iTXAbaYKgkxRL
         7gb2W4MqVPE/D+VUshIJ2SPnMxSW45eeHL/g4p9S5PvMJ+HfwTU6a+qX07MqU4rVN+z6
         ndXwVtveB59DWk3UW93WZVo1TSy6pNRpjXwCoeLdcXrqgYBboik1+cH3I4kWIDx+UZ97
         qJi5U8ihWJEKDHIP6zpjSZlNqIFqQG6ikybZLGIuWW/EX03AjrVoJcryy4jhWdMzLojJ
         HPSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiPnPmfcnGNZq7VBvkTWDNNWGsWD4zI4rptznJPdzcuJZI9hR3X1c73Lmjp/vBXPD3pYG2laSv@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0JSqD3TIA4NnkdEYe5khK1nFRmv2ZJIt+52uzBLyQ1Pwaaq5w
	e5SAqEB52xbIbO/0GG/xC6wTNkEktEi2oL+DkU5FOaXylJEPjQMCOiB79+8Vfr6J76poSIATmkj
	7Q15YGWSIu7odfQD/kCl7ImsVQfp+ocA=
X-Gm-Gg: AY/fxX77mTaWziDO6tsAqiw8+AWVBqnNq6PqqX9E9fgdH6mGE3vJfJU61lIn/Kp4+0m
	wu+rdVq/pGsXS66psCgQJfBSePUi/N1kO+lWfdR7CiCfaekyKZHq5PuPWrOwOTziThx6FERu5tQ
	UdSTJq8LO6c9QlFJua7dwAQ5Fy5eHdzNoNXdw5mhl/8/kd46cucDOlGijWHqQmusEBC6ylC+JTy
	CJoakVRYpJBA2J4R8Xl2g3TUdZxtGyZvYpMliUXQbL57ixbaPdB9ZBKX7PttmWqr20mTRZD
X-Google-Smtp-Source: AGHT+IGWlY6loBjKIYUvY3sJxh9hmOkZNaQ/5Aegdl04SOShtYfzVNtf9kjzV+lII5u7h4TAq4J4/Sz11mXDupmoLmY=
X-Received: by 2002:a05:6000:2302:b0:42f:bbc6:eda2 with SMTP id
 ffacd0b85a97d-4324e5060b7mr12235818f8f.40.1766430202652; Mon, 22 Dec 2025
 11:03:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215091730.1188790-1-alan.maguire@oracle.com>
 <20251215091730.1188790-2-alan.maguire@oracle.com> <CAEf4Bzaw6KRU2yDbawOe+eusCjCwvg0FwhkpvGA3HE=gC=ZLbQ@mail.gmail.com>
 <42914a9b-0f34-4cee-bc36-4847373fa0b5@oracle.com> <CAEf4BzZuikZK5cZQyV=ge6UBKHxc+dwTLjcHZB_1Smw1AwntNA@mail.gmail.com>
 <e2df60e1-db17-4b75-8e0e-56fcfdb53686@oracle.com> <CAEf4BzarPLAcwKApft_nBVM_d3WW58zytZfLQVz387TF2c2FVg@mail.gmail.com>
 <CAADnVQ+achE6ebfCxyfHyxMMFJ-Oq=hUK=JkWUAGwz+7HeV4Qw@mail.gmail.com> <22c54404-512c-4229-8c93-8ec1321619e0@oracle.com>
In-Reply-To: <22c54404-512c-4229-8c93-8ec1321619e0@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 22 Dec 2025 09:03:11 -1000
X-Gm-Features: AQt7F2owleetMFpC7ourxjF6EltaOtWsOJeESKt-MP00dpYF_8Rf9fLNrsVdOBo
Message-ID: <CAADnVQ+VU_nRgPS0H6j6=macgT49+eW7KCf7zPEn9V5K0HN5-A@mail.gmail.com>
Subject: Re: [PATCH v8 bpf-next 01/10] btf: add kind layout encoding to UAPI
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Quentin Monnet <qmo@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, dwarves <dwarves@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, Thierry Treyer <ttreyer@meta.com>, 
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 21, 2025 at 10:58=E2=80=AFPM Alan Maguire <alan.maguire@oracle.=
com> wrote:
>
> >
> > Hold on. I'm missing how libbpf will sanitize things for older kernels?
>
> The sanitization we can get from layout info is for handling a kernel bui=
lt with
> newer kernel/module BTF. The userspace tooling (libbpf and others) does n=
ot fully
> understand it due to the presence of new kinds. In such a case layout dat=
a gives us
> info to parse it by providing info on kind layout, and libbpf can sanitiz=
e it
> to be usable for some cases (where the type graph is not fatally compromi=
sed
> by the lack of a kind). This will always be somewhat limited, but it
> does provide more usability than we have today.

I'm even more confused now. libbpf will sanitize BTF for the sake of
user space? That's not something it ever did. libbpf sanitizes BTF
only to
be loaded in the older kernel where the original BTF was
generated for a newer one. There is no reason to mangle BTF right until
the point of loading. Presence of a kind layout helps user space tooling
to print it, but that's not sanitization. The tools will just skip over.
