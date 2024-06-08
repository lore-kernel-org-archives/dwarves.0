Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3700AF505
	for <dwarves@vger.kernel.org>; Sat,  8 Jun 2024 20:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717879085; cv=none; b=WUQ9UDPyMIsBuWFFaOclE4agYGF2ZemHQqaKtz15ETbe9jUgSs0LTyicAFB+8y35EReMGeIJIkA1OzbRKspbWKmbGAgmhh8SoW3hzw7v7kaWJBGL5vCnyxgRqBXF6p6mepDXJwJMIDUG/jI8Bq1Ps7mM55BdM/dC62n9Z+Cjssg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717879085; c=relaxed/simple;
	bh=m+ritCX7iCFyp0v7Fd4Fq6AzTmsjYWIW9UUz5nYxaQQ=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=UOm2j+nwBt7Yj9Wifio4Iox6ZEwYWIF2k1knMAriFFZjdETYXNei68Xs+W7JhtI7gIQuOMGiP6mTnmuQYFXFdkRFiUtUgEJxyJW63ihoTezLbKXoJQgvdFY2RbMfXXrl7Q7iUvYMfNc/uYOrsJN8bCOxuMyfVXOuoDJIfvxmmp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=Wr3JiJNU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YRFrDuP5; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="Wr3JiJNU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YRFrDuP5"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id D8AD11C00063;
	Sat,  8 Jun 2024 16:38:01 -0400 (EDT)
Received: from imap42 ([10.202.2.92])
  by compute4.internal (MEProxy); Sat, 08 Jun 2024 16:38:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1717879081; x=1717965481; bh=7f4kwBNxYY
	whliHEGBCqbALZKS/zh2UlOsQtB+qDyGo=; b=Wr3JiJNUSneGhSdDeohPTRmolf
	CCzuc9iD3sTXVAi19R9ruWvVfVbf/Md80rVUIf1IM/b2tlrZiepSOXyVwxYd2kgl
	2/UpYOj4jDD+BSUHm5igocrWlhKx1Fxn2ed/2VFuGFRiETRdf4YX+HNfjCT/ZdxY
	Ycc0QlX7+jKlj9QDBDVvsDksguQwfzkg5MyUQGSzy9TXtLXXBIlGAhfjnN0ot7Pn
	70GVWOYV/1hMFFH6zwUmDVotYK4hrBZHcFoca4jyZtLJ8be3AxxQ3GWQ7Xk0Be3d
	GEtGTNNcLtJcDBQ6UM+0AC3puJSDflR8Mt87bWwsWmar1apO8UcWBLWEUHXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717879081; x=1717965481; bh=7f4kwBNxYYwhliHEGBCqbALZKS/z
	h2UlOsQtB+qDyGo=; b=YRFrDuP5byU8Uu/plgl4Lg45IaNgtjfvFdxhkM8E6Aob
	X4Hu+oxF8in4HqLAPu5cYh4EjulAz9kN1tgQvfPOk1nolcj+pdZL7qsXMHR0mGQL
	WYhc5Yz7OqwiccnFd9d1zIWms6Ko642l4fl3ICLlHOu8XjayPEw9/WSzDOAYz1g4
	XhN+xNHrAo+mg1RYUjp7a1weMYoJyHnvi0rkH41ddOyRHfnB8x5BTmP/Bn7EpqDH
	HZoAjFf5JZDn3fxXubOufSODg/N4VltLTfF98beL20IW/nODqWAoaWti71hJKfQN
	jsSN5pHqDYZR9ArQivYG0gGnQIP5+3P9yBSJOaCsbg==
X-ME-Sender: <xms:KcFkZoAP8dhaT0fV6tnoNjNx72aKBrUH3v5Yyfm3wIDQjfBJs9OEgg>
    <xme:KcFkZqi1hoReL89aEifQhMXVv-FLPej9KgxBJU4KGFpxhkQQ6djPCc0VVm9x69Iax
    OeLEA6VQ5NsADg2Mw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedtgedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlvdefmdenucfjughrpefofgggkfgjfhffhffvvefutgesthdtredt
    reertdenucfhrhhomhepfdffrghnihgvlhcuighufdcuoegugihusegugihuuhhurdighi
    iiqeenucggtffrrghtthgvrhhnpeettedugedvgeetffelieefvddviedukeduudeiffev
    tdefveehkeeiveevtefgueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhthh
    husgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:KcFkZrmg0JKZMpkMDAm87dxT-5dwpNc5yqpIRaGoPf2OWiUea_Eb3g>
    <xmx:KcFkZuwQqtB9C0ZfgQBwFHuXd_U0jFsVbm1ZnwHVAMBMLJw-BHq-Gw>
    <xmx:KcFkZtQAcSH9n_F3H7H4m51BIW-AbAs5bmt3weWNAMkEkZSniQfuiA>
    <xmx:KcFkZpZuMuATMmSMOd7wmpnj6u8ef0gHD6t0CmoQckj8g_2WNDrRWw>
    <xmx:KcFkZsFUwagyV17sRmOCu5cRRLkb_m1_ItayTt7nI5m_zWw8ul4aPn-r>
Feedback-ID: i6a694271:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id E9533BC007D; Sat,  8 Jun 2024 16:38:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-497-g97f96844c-fm-20240526.001-g97f96844
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9dd86495-6a6f-47f5-ab03-020a43293205@app.fastmail.com>
In-Reply-To: <ZmIXxgbfIJGWmXer@x1>
References: <ZmIXxgbfIJGWmXer@x1>
Date: Sat, 08 Jun 2024 14:37:40 -0600
From: "Daniel Xu" <dxu@dxuuu.xyz>
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>, dwarves@vger.kernel.org
Cc: "Jiri Olsa" <jolsa@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Alan Maguire" <alan.maguire@oracle.com>,
 "Andrii Nakryiko" <andrii.nakryiko@gmail.com>,
 "Matthias Schwarzott" <zzam@gentoo.org>
Subject: Re: RFT: Prepping up pahole 1.27
Content-Type: text/plain

Hi Arnaldo,

On Thu, Jun 6, 2024, at 2:10 PM, Arnaldo Carvalho de Melo wrote:
> Hi,
>
> 	I just pushed what will be in v1.27 to the 'next' branch at:
>
> https://git.kernel.org/pub/scm/devel/pahole/pahole.git next
>
> 	The changes file for what will be in this release, mostly
> reproducible builds and tags for kfuncs:
>
> https://git.kernel.org/pub/scm/devel/pahole/pahole.git/tree/changes-v1.27?h=next
>
> 	I plan to move it to 'master' and release it later today, so if
> anyone could please do some more testing on it, that would be awesome,
>
> Thanks!
>
> - Arnaldo

I've managed to get all the bpf selftests to build and pass on pahole/next [0].
This should be pretty strong signal that it functions correctly.

Note that the linked patchset teaches bpf selftests to generate and use
kfunc prototypes from BTF. Which is why this is a good test.

[0]: https://github.com/kernel-patches/bpf/pull/7163

Thanks,
Daniel
