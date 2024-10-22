Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C55E17C98
	for <dwarves@vger.kernel.org>; Tue, 22 Oct 2024 18:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729622377; cv=none; b=Ysabdlp1zCSdyJOLEpKSG73sDBkTAff668pLCQOHFiIoiiVGm7h3DPkYoLO7ei9vAaQqQkywdny6KvtPIWuPcp/FQe9KzO3l3pb9LtPDATQWW+nPWHEK9kDm/D5VgnhXv9x3UHpYTnKwNrElzdfr9vXuppjBTM0sXhqqm/XtCFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729622377; c=relaxed/simple;
	bh=HbTHhHcdS9O9pupgDELzIMvG0adsZ/Fo6A6fKYTBOlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I/ZU/c+tx3Y6sxyfWPOysBOdDFBpPBdvDp09vLX9z8ZZ50SYqB4YbUarDIBPweR2y7gjjcGKRtJOYiOWh/4s+GYsEqhbjx6sGpe3u6mJeffqew9EC4P8OuoiooSh4ceSyFC9FeASy1aQLjYRDj5+Xh2g6rPH/jkgSKhSRVE2Vcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T8XQE+a1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T8XQE+a1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1061C4CEC3;
	Tue, 22 Oct 2024 18:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729622376;
	bh=HbTHhHcdS9O9pupgDELzIMvG0adsZ/Fo6A6fKYTBOlw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T8XQE+a1oLIBnMKm+184JcPT1R+FGC/R9qQuAqXtGh+HmqREBNEnIeaxXIK44kVwS
	 8uATvbKMKStoGAIrEVzm8NLEU0yMkovYleEsZTu2bcUgz1bpkxrAmLAx11V3AmBB8j
	 Tbl9dyptGkd8jis6dk3FTMYpda4np3qRTdfnLPqnEw1cnzmSzkYDMAB8Bp7KIJfc+C
	 uHzry5LGupCRuQqGOU1fI8ub8kTACTnnF8yeoMOQ6rfD1r/96oLRWO7Z1v/UuU2vUI
	 MVFhX7sRcUMtEZFYCUgQBhuTRfeXxCdWEjul84rfdlY9Uwxr+zDY5Owwo2k/MY54MN
	 g+ddc6/aV6srw==
Date: Tue, 22 Oct 2024 15:39:31 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, ojeda@kernel.org,
	andrii.nakryiko@gmail.com, jolsa@kernel.org,
	dwarves@vger.kernel.org, stephen.s.brennan@oracle.com
Subject: Re: [PATCH dwarves] btf_encoder: filter var names before btf name
 check
Message-ID: <ZxfxY44iOJCcuNhU@x1>
References: <20241018094301.1550149-1-alan.maguire@oracle.com>
 <CANiq72kMif-BzsNwmh8WpDgc_KohxkHZA2=+F6RjEKV+j8TnmQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72kMif-BzsNwmh8WpDgc_KohxkHZA2=+F6RjEKV+j8TnmQ@mail.gmail.com>

On Tue, Oct 22, 2024 at 08:21:09PM +0200, Miguel Ojeda wrote:
> On Fri, Oct 18, 2024 at 11:43 AM Alan Maguire <alan.maguire@oracle.com> wrote:
> >
> > ...as this means we avoid seeing multiple messages of the form
> >
> > PAHOLE: Warning: Found invalid variable name when encoding btf, ignored (sym: '__UNIQUE_ID___addressable__RNvXsa_NtCs2vSfyxKMEZc_4core4charNtB5_11EscapeDebugNtNtNtNtB7_4iter6traits10exact_size17ExactSizeIterator3len57').
> >
> > Such symbols are filtered anyway due to the __UNIQUE_ID prefix, so
> > warning about them is not necessary; simply reordering the checks
> > should ensure we will not see these warnings.
> >
> > Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> > Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> 
> FWIW, I applied the patch and the `__UNIQUE_ID` warnings indeed go
> away (but I don't know if those warnings would be useful to see/fix
> for other reasons):

Maybe we should have a debug mode where anything that is skipped gets
reported.
 
> Tested-by: Miguel Ojeda <ojeda@kernel.org>

Thanks, since this hasn't hit 'master' yet, I added it to the cset,

- Arnaldo
