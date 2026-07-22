Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36F83126B2;
	Wed, 22 Jul 2026 18:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784744753; cv=none; b=e6YHwbnC40+TnlNEq1HG7zxczWWWKBkreTx9Q8yxyfM2keZ32CLHpQCGJ+XnBT8Kz48+W4J0Xz15SjrOaL1+qhw9g9+oTi7Lp7m5dmfaLHGvzk8EUBmfgfqA1waAajoznqgz7LeegvaXfjNUUz5Qtb4H2MkEh3+tjjso0mnVDlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784744753; c=relaxed/simple;
	bh=cgE0KhqC+J6z10v2569IYGG0xnPxQb8aUINEveMs5TQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NOomgGg8wkfcBX2oRVSlXNBj3o6mJSiFb0kuxZSsJoj8BDmup/waH7X4RCQCsLuE+diutYxQUsPVWOkI6bU+MFmIxUHYj7KhG8yhCNCBL9077lYGD9rsSRdfV2w4GM3Ni47/Rld0EmSbmjZN3FATHY5zfgse2+HaYUnW4cUzFGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NyI7uW4W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NyI7uW4W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E84FE1F000E9;
	Wed, 22 Jul 2026 18:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784744752;
	bh=gKVbrh3ZtwawBdbbhvYSEsnVXUr70IbDK6DzJ7X76V0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NyI7uW4WyXqLyXE3rYXBfPzSDSbIY2BMsfvl0M5IF/JU/Stu0wqOIa5nkPUJbEnv6
	 Dx6eM2LKP2EJWuf+PYXMGeC1ZMqI4eBsm2ZKLIFd9qKkkDYSdDCQg5R0ExFhxWQklP
	 2LYVXvx8LFtbfZ1uZmb3s8AclYZxz0KO1tUS3cAQ3lIpPSX5vXJZNZ/4N44ehqxqUh
	 QTLOaNZjcQ4PsqrxuA4rIAk1lLa2hWmBCB6jEiBjNtvkoMkiVZqpmX/7EhRS+2fCb8
	 5dpysIR6RQ2BhVYT0W88x2nlXkEIue+/H9+MflpgideoKW998wQkLW3W3aiO5nxqq8
	 nXjmapzanC/5w==
Date: Wed, 22 Jul 2026 15:25:49 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Yonghong Song <yonghong.song@linux.dev>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH dwarves v10 0/5] pahole: Encode true signatures in kernel
 BTF
Message-ID: <amELLY-igHdMXcEe@x1>
References: <20260625020148.1883082-1-yonghong.song@linux.dev>
 <a3027b36-39f5-4e30-be26-8d87bb54d4ee@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3027b36-39f5-4e30-be26-8d87bb54d4ee@oracle.com>

On Wed, Jul 22, 2026 at 04:53:41PM +0100, Alan Maguire wrote:
> On 25/06/2026 03:01, Yonghong Song wrote:
> > Changelog:
> >   v9 -> v10:
> >     - v9: https://lore.kernel.org/bpf/20260624052553.3139112-1-yonghong.song@linux.dev/
> >     - Remove patch 'btf_encoder: Avoid comparing inlined and out-of-line function prototypes'
> >       as it caused btf_functions.sh failure.
 
> Series applied, thanks for sticking with this, and thanks to Jiri and others for testing!

I'll now rebase my nnext long AI assisted series and retest it over the
set of build+test containers, where all the over 80 new tests are
passing.

I'll use the opportunity to add more tests to cover the new code in
next.

Regards,

- Arnaldo
