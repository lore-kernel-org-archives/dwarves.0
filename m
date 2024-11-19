Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F361B1CF2BD
	for <dwarves@vger.kernel.org>; Tue, 19 Nov 2024 19:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732046060; cv=none; b=E11PDWMIzfTFatYRFnm87sIzYoVQJz9VKQQUglrXyEhOYRNdWR2WjuYUvcIx+3rWQuLfCFM5Mj33OE6FfznsNH2qU8a8iX05S73ZF71gS/AAspwLbFiegkMXJp9e2omOHtIU3nSWzEi/tP/sorFvSf5lrQgIx5b1QO0PGHqEEjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732046060; c=relaxed/simple;
	bh=aEmAjUWmOsUMWnWZWoAjHvm2HwCzUf0nnYahGyzJm1A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IyWKBEsDgSleVo/yN19eWqf04y3o5EAWnBod/MTH/LPw51AixcPF17ncy0un9dNRHuN8vYvdrBkJVhhXH/X0A7cr0pP5/fkhqH/DakQ6dmcjA3RgeXRZGWy3iyf+/6/FV6+AodkEbhYdqAgQYnXyMov1w2zRbvwCovklZc5GzHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fY/K03ir; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fY/K03ir"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-724455f40a0so1054757b3a.0
        for <dwarves@vger.kernel.org>; Tue, 19 Nov 2024 11:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732046058; x=1732650858; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aEmAjUWmOsUMWnWZWoAjHvm2HwCzUf0nnYahGyzJm1A=;
        b=fY/K03irTxa0aWX3JXdAzSrwRM88PQZwWWtG9CCqcZ5HCxZu+zrGv69ISpMUqTS0Kq
         Bf1qBfO55qDmosfEYXthl235jS6ALdIKkZoTlfsdqqkWiHXoUnmeVluWBfxNKjOlQUNv
         A/yRobVPTz5YGN+dgkuUdYx19vu6xJh7jD44jnD/1a0hGc2n3yiHO22qi6VyMq4M+1YV
         Pclk4jffM3cdvEslYKbE9wrvoSWnOHOnhzPqEs2XwSCv7AvYSvySk0Ziw6G8JXldh2AT
         8uLSovrnOZfRxtgF1e3i80D8YyBQgzgOLSUzxOvglgbVXXCIE/WEhqOlM9F9E05pPACm
         4SpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732046058; x=1732650858;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aEmAjUWmOsUMWnWZWoAjHvm2HwCzUf0nnYahGyzJm1A=;
        b=vlRioirCJWp7XKQ6KDXUEpkax8u0A/cneYG3FuYNms67qDMTPB8Zljho3BxtxP6ZWc
         NJbXE9OMj4u/pcS0rF8sXTHixCDcagrsFIv1K0tb22qEdKXSw5v6QnbOWlhyvMC5Tbz9
         3SC2NfDmx4E7OyfwOd941hEqD1mN518mEu412qwgnKM3wOj5vQ9x9TcAiqdWSBgkl3Sa
         YduRwaKU2tvuciroUtRWSohETNC5R4K7lJIyRtikOGYJ31WiiZeQxY9xApwpldV5I8RT
         PMrbLDpL1uAiStmcEGTEBxsb+R7W2q9luyBwnHH4FXJWXxJrDXQFkWlr/InUygoMhbGH
         wZBg==
X-Forwarded-Encrypted: i=1; AJvYcCW/10q/Om/vLewLGeUwrieF+Jq1QHFmwQxV3PS0WqrJkUdnqJdbOEIUeLDLmXoSYGUHinWejOhM@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe4G4Fpl0GMuSWWVpH1Mfp3W+67+ir2TZCzTNM464Yp5f127RU
	OPnzlBbk42FxzdJno3SwFYtyQQr9g6Nplq6Q+SaUm69lCVoXR2nn
X-Google-Smtp-Source: AGHT+IFMv1Co6MOqpi3TD0s23v8OD7LrDFoyyfNimET1KxIy7Mc4BNLqGHqaFbQUsMSOHder6vaNHQ==
X-Received: by 2002:a05:6a00:888:b0:71e:cc7:c511 with SMTP id d2e1a72fcca58-724bee2b334mr310358b3a.23.1732046058184;
        Tue, 19 Nov 2024 11:54:18 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f8c1c31df6sm8222157a12.31.2024.11.19.11.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 11:54:17 -0800 (PST)
Message-ID: <020ec6550eb5e73bb5a273c57a686565a0a274df.camel@gmail.com>
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
Date: Tue, 19 Nov 2024 11:54:12 -0800
In-Reply-To: <ZzzrsLQCF9hYtT7P@x1>
References: <20241118204146.772762-1-acme@kernel.org>
	 <20241118204146.772762-3-acme@kernel.org>
	 <33b85d2c1adafb5a46a874dfcfd43682395e1564.camel@gmail.com>
	 <ZzzrsLQCF9hYtT7P@x1>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-11-19 at 16:49 -0300, Arnaldo Carvalho de Melo wrote:

[...]

> > Lgtm.
> > Would it make sense to move this patch to the end of the series?
> > In case someone does a bisect and runs the tests to find some regressio=
n.
>=20
> Humm?
>=20
> So you think it should be introduced only when it passes? I.e. when the
> problem is fixed?

Right.

> My practice so far has been to reproduce the problem manually, write a
> test, show that it detects the problem, fix, then show that the
> regression test shows that the problem is not present anymore.

Yes, the downside would be that anyone trying out the fix would
need to do some rebase to try the test w/o fix.

> I see your point about a bisection when running in the cset that
> introduces the test case and in all before the fix is added will fail,
> confusing the bisector or not allowing it to be automated :-\
>=20
> So, yeah, probably, for automated bisection we should move it to after
> the fix, when finishing the devel cycle, which is now, will do.

Fwiw, that's what folks enforce for bpf selftests =C2=AF\_(=E3=83=84)_/=C2=
=AF.

