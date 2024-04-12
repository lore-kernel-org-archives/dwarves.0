Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7862AEAC7;
	Fri, 12 Apr 2024 20:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712954252; cv=none; b=UBMwBs/ZD9McR6266AvPQk84RGfpv4R6wfL9lmRM7lvNzPberSPbQV8RJ8hkP/dyd7xu5dGdp7H+H1UoWeCLUV1RSom6Q8xq9C6Y+9zHJS8mOik4tFm9mpUb6b3krJJ8iklrr0jTNwAGlru6idgNl/sZmCabyXzt3NPYXrejroI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712954252; c=relaxed/simple;
	bh=gCpL0UGOV+Ju/rzdeKxdRLOXOVWh4DiDxiqM+i4cfgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W/2SeQCRrNstaCa9jciVsV6hBeTdzY/KLQC/FM6DYw15NddpYy1hXpWc85JmjyMpY/vGK0q2+ULGvcYu8FhHefAPVRqwo5c9GwfaCVTpX/Nw3CwehnSYfT92zE30NTG9Feq5Qy8+xU6/zn38tD1orj9fw7L5+cNiMSBGkUOQGyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LPH+FrCP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LPH+FrCP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68267C113CC;
	Fri, 12 Apr 2024 20:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712954251;
	bh=gCpL0UGOV+Ju/rzdeKxdRLOXOVWh4DiDxiqM+i4cfgc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LPH+FrCPR4+eRecoDY0lhxtMF8KwO2U2pioNI/q/PCvv3By4l8cZf+pDyUWq61P9U
	 Af68NN6bBwnkzX+9xSewi5bxqXlS0nNYHJBr6yfjAr0XIi2zxaPJIMevc6koNyAr6C
	 l2jW62wblThHucmtLEEQW5TiuZlC4LluTgOuhGqTP7/RJmwTbPq421Oka6KzkH87G4
	 3VpfHWy9RTvlvH5mHnVgbEL87dw4L/GhZ47sXymVqb/FN3GdC0JY45RcPmPbcQLwtW
	 kQrwrU8uAlCL61gGobkr4R5nXGEP5xK2A3Et2w/hOGFptdOD1Eb59cr+iIQIohNL+T
	 zsr1WgrtBjp1Q==
Date: Fri, 12 Apr 2024 17:37:28 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, dwarves@vger.kernel.org,
	Jiri Olsa <jolsa@kernel.org>, Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>, bpf@vger.kernel.org,
	Kui-Feng Lee <kuifeng@fb.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Subject: Re: [RFC/PATCHES 00/12] pahole: Reproducible parallel DWARF
 loading/serial BTF encoding
Message-ID: <ZhmbiFdtYN3tlG6u@x1>
References: <20240402193945.17327-1-acme@kernel.org>
 <747816d2edd61a075d200ffa5da680d2cc2d6854.camel@gmail.com>
 <64bfcf02-030d-471a-871a-e7490d74ca28@oracle.com>
 <db6480e9378f59c367b03f7455372caf7b593348.camel@gmail.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db6480e9378f59c367b03f7455372caf7b593348.camel@gmail.com>

On Tue, Apr 09, 2024 at 05:34:46PM +0300, Eduard Zingerman wrote:
> Still, there are a few discrepancies in generated BTFs: some function
> prototypes are included twice at random (about 30 IDs added/deleted).
> This might be connected to Alan's suggestion and requires
> further investigation.
> 
> All in all, Arnaldo's approach with CU ordering looks simpler.

I'm going, for now, with the simple approach, can I take your comments
as a Reviewed-by: you?

- Arnaldo
