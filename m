Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0059A3BE17E;
	Sun, 27 Sep 2026 08:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790498243; cv=none; b=sXa7QsjfDXaxz+K6EBYeoEehcZsBVLkA/OYj2qE61mR5vIz9Ec8TRm2J7j5uuZZmEroWFUHCsuDOMZlDUz94eqnSeY7UqfaQ2K8wOon/gNghQbpKHpr30TRcnvY5RKymw4g9nBFZDHCiTxyUBnAL6X7jtDVYqQ4kZNr8uOrlPwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790498243; c=relaxed/simple;
	bh=XnbYM/O1ISsL9RGN8WIKuIqrsFecX9uNOPrvHSVIWXM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=ba9fqY/0LgRstSDFDwYsw49FbD1FMArqWNc4Zz0mBaTk877DdiTHN9vCtMdjnVaPPvrqoDe0ycnFgKi8XMQ2vWp5IzudXZYaR6/5XVieFhEvizHaZDunrgS6NgZ3/ePrZTNnhjI6bpf5gagVjH1MOPMFWMjDkzv2YTnci4KYZ0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=agFki67y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="agFki67y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55D241F000FF;
	Sun, 27 Sep 2026 08:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790498241;
	bh=XnbYM/O1ISsL9RGN8WIKuIqrsFecX9uNOPrvHSVIWXM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=agFki67y2M2TpDRvxqP1sU9R07YZfgo8IPvLkEkmmUHQevq1vgIuGGICoSGlFByiE
	 xPtYInfIzJO9MjkoOjzro+a9aPOhZ9XP4dUP5TVrcN2NbZsaaNCPZxH2FJya0bny0I
	 g3UzZIfIw7akxK1kCrrREyxlpNMor3xOhxQNP4Ck6mw2vUv2EumEM+91Jtu68g/Fpj
	 oy7gT6LIl/d/R/1f5XJhNYPh8UXYQUjggXKZHrkNMBq1OqQBYirucDvcDVw5DVfLFI
	 ZJ7u/WbBT/jLtrljR9PPL2wLbKxzBb8EinGlCCml9NT+lhIcqrMi4cyPtOJBJbiSfQ
	 l+GsaiGWVqlLQ==
Date: Sat, 26 Sep 2026 22:37:20 -1000
Message-ID: <f66c99ad3cb50f868c2c22a88f09fd09@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, dwarves@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH dwarves 1/2] dwarf_loader: Trust the entry value register
 over the first location entry
In-Reply-To: <e3f30691-a5d8-41b8-a075-10cf8cf4bd95@linux.dev>
References: <20260925213619.2187751-1-yonghong.song@linux.dev>
 <DLP2WZASF7LP.18SWCONJDR4LV@gmail.com>
 <e3f30691-a5d8-41b8-a075-10cf8cf4bd95@linux.dev>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>

Hello, Yonghong.

On Sat, Sep 26, 2026 at 10:49:35PM -0700, Yonghong Song wrote:
> One possible workaround is change 'lazy' type from 'bool' to say 'int'.
> As Alexei mentioned in the above, clang didn't handle 'bool' well
> in debug info.

OPTIMIZER_HIDE_VAR(lazy) at the top of the function works too and I can
carry that from the kernel side.

Is this a clang bug that should be fixed? @lazy sits untouched in RSI
until the prologue moves it, and clang describes an int parameter there
but not a bool one.

Thanks.

--
tejun
