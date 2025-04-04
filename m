Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DAB13BAE3
	for <dwarves@vger.kernel.org>; Fri,  4 Apr 2025 19:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743795429; cv=none; b=NQ21q97amslAAwHp19pAmtT1BH8FK0pSkilMJWLTGm218cgNsly1iTFqLnKxntiyD9kZFgfuSOlwZd+QIEnlDfwHH8SsI9ZmpXOXhAl0xaNfDsaR/KPbKrJbKvXBIcYXTkoCgfSygkUOJf9CyxcIwjCncD0NI1YePvDKQDfw7LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743795429; c=relaxed/simple;
	bh=jjo9wiRzFE5UNpIiQnWs3mlHRbr8WkbcG9i1dkSScGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FHjzWr5l+LATE0wYyKgZ5RTvp4Vl92QO6dUhAw5ZJ7l4cUD/rz48Jny2ySelZ/+4QVy8Vl9bXFWLya7op7e6XObAekkD4kXSKSFXO6xd8ajvNjn2LFLm1XlH0ZH4P7DQ20LoJbYpIpFKowNKuImiriUIC0ghLtVHoXtSvA0zBcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=obIW/8SL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="obIW/8SL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16027C4CEDD;
	Fri,  4 Apr 2025 19:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743795428;
	bh=jjo9wiRzFE5UNpIiQnWs3mlHRbr8WkbcG9i1dkSScGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=obIW/8SL3CkxS/b6utZRBQ+Jiz7hTCwjWK2eWjXlZrZ3W0MGZleAQLs3G8AMsIQIz
	 FVTZXIcKBdgQYM68WBr5GqKeABTOBfbRsdfPY15GBtjvglnDh+JqW/zBMg240LZ5yt
	 LIGFE1V6XPmK8LeIZKftsOZntst8OM7wV4OLkxTuwlOgDl9XH2eG2ljstxqpT/aZBy
	 jcXzhT7YMRTTAbKdEWd8CK+VSmzS/rn2GYlpDHccJgkzPtMtQ9pVSnNJvMbJ8rxlyX
	 UKaGi692o3tPs69WJAb+2hplX6Xg9jZLjxnJxMVpvPfCMKpiVq6jMy0EvzZnsX+/q1
	 beFM0wMoJZNyw==
Date: Fri, 4 Apr 2025 16:37:05 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: dwarves@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH 1/1] pahole: When trying to encode BTF avoid DWARF less
 files
Message-ID: <Z_A04TWu6zKFQsWU@x1>
References: <Z-2fij_hUUFYF-YQ@x1>
 <a86ffc25-fdbc-4f6a-9579-aff59400d677@oracle.com>
 <Z_AxcUKWM1xtdgyb@x1>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_AxcUKWM1xtdgyb@x1>

On Fri, Apr 04, 2025 at 04:22:25PM -0300, Arnaldo Carvalho de Melo wrote:
> On Thu, Apr 03, 2025 at 07:40:19PM +0100, Alan Maguire wrote:
> > In the same spirit, should we error out if the format path is explicitly
> > set to anything other than DWARF for now when btf_encode is set?
 
> Probably, but I focused just on this part as I'm trying to follow up on
> an idea I described to folks about doing the BTF encoding right after

While at LSFMM/BPF in Montreal, that is.

- Arnaldo
