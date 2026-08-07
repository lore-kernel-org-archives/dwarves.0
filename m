Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E5A2DECA8;
	Fri,  7 Aug 2026 18:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786128839; cv=none; b=M1hpSwwHrzi1Kqo1TyDtPXLfBok8SSNV+DmA7MLyNZLqu6fNp7U/R58JpbbHvVnBrROPkxLUU9/gamg+ZeF/pEg5dlQzD6fd2abbLbTultvRX9V/j4d8dVSkQlbYpGUK74VbIaVsXpZWP3d+8lO5CRnom9pN/V8qkoTDw1AyaL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786128839; c=relaxed/simple;
	bh=O8d7jt4yP9kBXBvI/7UYBC5IiRI2rghk2eb6zsu2W28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AqVqp9J0VomgAFRT9MUvKf5GHoMhnI3maLsCoMrrx1VYepi8e7eraeys1M+qu6FmS9JTmA4X8rna9J5NWU1PtsMMSXIU3RuJxhq0wa8wCW8RqX80k8cRab80yZx23C6DPFdUP/bMw656n17NSgybjnTT2iiKR81MFQxq4cvHLls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4HCH4wp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4HCH4wp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 358381F000E9;
	Fri,  7 Aug 2026 18:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786128838;
	bh=W7EbF3+ZkY+19N/2IhITCR4hIT9Xgx1TaKze5MM03QU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=U4HCH4wp6FcnFdF2DESfPF4UaqEY9ryRjM6w/e/UzKTggNHKDiI5T9qRVaNQCiSWL
	 yYKalbXLLVT4XaroOMwef/YsBU5Mjp49VkRhp8RLvJHwBOIzY9Nl6TVM/nFMAlfvcP
	 qhwOD7dbN5FdjN2tId72gjf6rhUokhMcOX1VlHTnXsrVz+hbPFaWS2SCTaGl3L6pq7
	 js0u/of/wu4+3RkWwcmS27u3pq3Q8osUhI7Xw9Bl08dOSo40badyN8cHP5ujI20QXn
	 ujDQtO09P8zd2BjfKubsIHQ+MqUcLKovGBt6I2dZl7h5/BTDB4bnBqsrdnE9CAPwSK
	 1Su4qM+4FTduw==
Date: Fri, 7 Aug 2026 15:53:53 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>, dwarves@vger.kernel.org,
	bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Mark Wieelard <mjw@redhat.com>,
	rust-for-linux <rust-for-linux@vger.kernel.org>,
	Gary Guo <gary@garyguo.net>
Subject: Re: [PATCHES 00/12] pahole: Support more rust tags and references to
 dwz alternate debug files
Message-ID: <anYpwcDBtkzE3WIt@x1>
References: <20260731193102.110693-1-acme@kernel.org>
 <18b557a8-e1ca-46cf-b03f-5e68490c9229@oracle.com>
 <anXTAComw6XAvnXU@x1>
 <CANiq72nHWY638h4mxJCfh_HFtzhwFEPyo6a-7k_3CxZsRV+Jiw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72nHWY638h4mxJCfh_HFtzhwFEPyo6a-7k_3CxZsRV+Jiw@mail.gmail.com>

On Fri, Aug 07, 2026 at 07:34:10PM +0200, Miguel Ojeda wrote:
> On Fri, Aug 7, 2026 at 2:43 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >
> > Adding Miguel to the CC list, Miguel we're trying to improve BTF support
> > for Rust, this series handles multiple enabling fixes/improvements that
> > gets us to the next level, i.e. we can load everything from DWARF, now
> 
> Thanks for the Cc! Cc'ing rust-for-linux and Gary.
> 
> > its time to try to map it to existing BTF kinds and propose BTF
> > extensions when we can't use existing encodings.
> 
> Sounds cool :)
> 
> > Inferring from "does any member have a niche layout" means
> > reverse-engineering rustc's layout algorithm, which is explicitly
> > unstable and unspecified. It'd break silently on a compiler bump, with
> > no way to tell from the DWARF that you got it wrong.
> 
> Yeah, the LLM is correct here: the Rust compiler gives very few
> guarantees for the default `repr`, i.e. in common cases it has the
> freedom to use whatever layout it wants (i.e. even for essentially
> equivalent types in the same compilation unit) -- the official docs
> are at:
> 
>   https://doc.rust-lang.org/reference/type-layout.html
> 
> >     u8                  __discriminant;      /*  0  1 */
> 
> For the niche cases like `Option<NonZero<u32>>`, what would be printed?

Can you think about one such niche case that is present in the kernel
rust .o files right now? I tried finding the `Option<NonZero<u32>>` to
look at its DWARF but couldn't find one.

- Arnaldo
