Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C411CF2BD
	for <dwarves@vger.kernel.org>; Tue, 19 Nov 2024 19:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732046165; cv=none; b=o5TRfD1T8ASxRZnd5Tk6z/ZBcg8vfcxWbdXI+UEphMm0+KjnMaggpaBenobsh8mj37RxrFbz4ICZST7IdTeaLaKiC0bM4Kv13AJmXOaritA4ELMO+zUTYM6Rt7Yn+q7WJSwWt4OcrNiAnivcINY9xLsP3zGwfYP2OT3iMcbE/Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732046165; c=relaxed/simple;
	bh=KI3JsB5CilVSFn1DFR3P1GYE3dzjDKvPLhkd5BeqO1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OQryGbB52cLt83yGlcktRVrG7iw/pQXmMQHDesBUYZAWLS+IMEHGIomGczu0I49nZIHgzyolDq6F9GaVs2ojhJOTFYtq4KcDbbxhECLrU1BjsVPTie18LfJG+uCDDlz7F45ba5nYcY9uoX5DUrRyxaqUjtuJcH+YrZ8F01bE+XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sg3o7zaj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sg3o7zaj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 910A4C4CECF;
	Tue, 19 Nov 2024 19:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732046164;
	bh=KI3JsB5CilVSFn1DFR3P1GYE3dzjDKvPLhkd5BeqO1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sg3o7zajLWguPq14h9MEuTV5LjnR6N9mmFLlQSlLir2KU4GgLSWZeYpsi/PXJjWMo
	 Q58leIeVDOx0XFFjg9ovetVarjb+VnSjmz/+CV13hvIQF6eimvOZTyPmpbEHnQjJ4s
	 gMmumq51912JmbKP9klb5Q/4T52VGVejyMFtAAdeJpCerhiVWg96KW49hbyJuQ3nlB
	 nNpOO5RRwwCRISQ2h/vzJdyMmLXaxCm3lUpLDflIarfsNpz1fUvHLOG/q+ETNmi/1N
	 5XmM2gyFwbqxXtTI6IGDIGsb84NrCM7uv+f01F5usxL+sxxVXLOMwT7mBQIeaja+jF
	 aHU2/uUt6v7lQ==
Date: Tue, 19 Nov 2024 16:55:59 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Matthias Schwarzott <zzam@gentoo.org>,
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>, dwarves@vger.kernel.org
Subject: Re: [PATCH 2/5] tests default_vmlinux_btf: Introduce test for using
 BTF by default
Message-ID: <ZzztT0PIZ6sYEIbY@x1>
References: <20241118204146.772762-1-acme@kernel.org>
 <20241118204146.772762-3-acme@kernel.org>
 <33b85d2c1adafb5a46a874dfcfd43682395e1564.camel@gmail.com>
 <ZzzrsLQCF9hYtT7P@x1>
 <020ec6550eb5e73bb5a273c57a686565a0a274df.camel@gmail.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <020ec6550eb5e73bb5a273c57a686565a0a274df.camel@gmail.com>

On Tue, Nov 19, 2024 at 11:54:12AM -0800, Eduard Zingerman wrote:
> On Tue, 2024-11-19 at 16:49 -0300, Arnaldo Carvalho de Melo wrote:
 
> [...]
 
> > > Lgtm.
> > > Would it make sense to move this patch to the end of the series?
> > > In case someone does a bisect and runs the tests to find some regression.
> 
> > Humm?
 
> > So you think it should be introduced only when it passes? I.e. when the
> > problem is fixed?
 
> Right.
 
> > My practice so far has been to reproduce the problem manually, write a
> > test, show that it detects the problem, fix, then show that the
> > regression test shows that the problem is not present anymore.
 
> Yes, the downside would be that anyone trying out the fix would
> need to do some rebase to try the test w/o fix.
 
> > I see your point about a bisection when running in the cset that
> > introduces the test case and in all before the fix is added will fail,
> > confusing the bisector or not allowing it to be automated :-\

> > So, yeah, probably, for automated bisection we should move it to after
> > the fix, when finishing the devel cycle, which is now, will do.
 
> Fwiw, that's what folks enforce for bpf selftests ¯\_(ツ)_/¯.

Makes sense, automated bisection trumps old practices :-)

- Arnaldo
