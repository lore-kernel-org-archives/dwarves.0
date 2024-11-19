Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B424D1D1F56
	for <dwarves@vger.kernel.org>; Tue, 19 Nov 2024 17:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732038616; cv=none; b=uF+cK0ZhdAPkz53PQ0x0ONVSXWXStQ4mEi+zNDSOuFaFj6/JojFLo9a/u4kQnzbUFWx9UJvkbSHTIpoeZ8B39SBIoec9NJMKwTFI1rR29ZHvp2m41tQIWmmeYEqkwOizW4aNT4djl1mdPJruHwYaYJos0HxwxGOtaLLuqXy8UE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732038616; c=relaxed/simple;
	bh=mAgoyacbDkMCRcjAb869kSPoZqP5/CqWxcTkTIq3x+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l4ftQTLacUwTNuDUyfujBDOzBv8X4+d7H2ujVPXku7L2K4VK0D2hDFvMq3AlEgIefbeHBZS4uPNcEuW5wQ/2Ilr7kVAy4maDCWjlTEql9IQY6/oCinAE4W9JYUnUPyS/NWWPkw8j2f9DFNxYW1uWhs+Dr0qJnHO9XesYiQpNfeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qRXM2esX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qRXM2esX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8D25C4CECF;
	Tue, 19 Nov 2024 17:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732038616;
	bh=mAgoyacbDkMCRcjAb869kSPoZqP5/CqWxcTkTIq3x+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qRXM2esX/HBt33dznMMuzP9cUaTEHOrMrMRiY1eERg05DPY3zlKyP1gKNtCMgPz8/
	 izBN+FL4nPA9NGoiB4wgiflkBo7SgRvfaWz4y/8DWIyCuVYQR6RXgs9AmlTbwsLKEn
	 /GQRKfHmnYgPxiB+s1nTbqMmy0UlGWuf6IfgS/zHbUqO8FAJUxdVmJ2Nqai4Qjog1m
	 6MRcq65Hddv9OCx2bPN7iqymekhYThQMk7ccn+lyHCybp+i2ChnZK8qaDozt2Xe2va
	 hvk4TVDu0dkWmwG5Uwsf2x/ruGwO5gsOqWoUO591aovMJB2uV29QpctvSAVr9W13O+
	 xnBg051jXkN3Q==
Date: Tue, 19 Nov 2024 14:50:12 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Matthias Schwarzott <zzam@gentoo.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>, dwarves@vger.kernel.org
Subject: Re: [PATCH 2/5] tests default_vmlinux_btf: Introduce test for using
 BTF by default
Message-ID: <ZzzP1BjCY-3_nCjZ@x1>
References: <20241118204146.772762-1-acme@kernel.org>
 <20241118204146.772762-3-acme@kernel.org>
 <90d7282a-60af-4087-8e08-fed3fbe348ee@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90d7282a-60af-4087-8e08-fed3fbe348ee@oracle.com>

On Tue, Nov 19, 2024 at 12:59:58PM +0000, Alan Maguire wrote:
> On 18/11/2024 20:41, Arnaldo Carvalho de Melo wrote:
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > 
> > On a system without any debugging info or when one specifies BTF as the
> > only BTF info desired but no BTF is available (or invalidated using
> > PAHOLE_VMLINUX_BTF_FILENAME to an invalid/non-existent file), we're
> > getting a segfault:
> > 
> >   root@x1:/home/acme/git/pahole# export PAHOLE_VMLINUX_BTF_FILENAME=non-existent
> >   root@x1:/home/acme/git/pahole# pahole --running_kernel_vmlinux
> >   pahole: couldn't find a vmlinux that matches the running kernel
> >   HINT: Maybe you're inside a container or missing a debuginfo package?
> >   root@x1:/home/acme/git/pahole# pahole
> >   Segmentation fault (core dumped)
> >   root@x1:/home/acme/git/pahole#
> > 
> > So add a test that checks for that before we fix it:
> > 
> >   root@x1:/home/acme/git/pahole# tests/default_vmlinux_btf.sh
> >   Default BTF on a system without BTF: FAILED
> >   root@x1:/home/acme/git/pahole#
> > 
> > Reported-by: Matthias Schwarzott <zzam@gentoo.org>
> > Cc: Alan Maguire <alan.maguire@oracle.com>
> > Cc: Andrii Nakryiko <andrii@kernel.org>
> > Cc: Eduard Zingerman <eddyz87@gmail.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Song Liu <song@kernel.org>
> > Cc: Yonghong Song <yonghong.song@linux.dev>
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

Thanks, added to the cset,

- Arnaldo
 
> > ---
> >  tests/default_vmlinux_btf.sh | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >  create mode 100755 tests/default_vmlinux_btf.sh
> > 
> > diff --git a/tests/default_vmlinux_btf.sh b/tests/default_vmlinux_btf.sh
> > new file mode 100755
> > index 0000000000000000..a9effa2d6d37e0ee
> > --- /dev/null
> > +++ b/tests/default_vmlinux_btf.sh
> > @@ -0,0 +1,21 @@
> > +#!/bin/bash
> > +
> > +echo -n "Default BTF on a system without BTF: "
> > +
> > +ulimit -c 0
> > +
> > +# To suppress the "Segmentation fault core dumped" message in bash we
> > +# pipe it to some other command, if it segfaults it will not produce any
> > +# lines and thus we can infer from the number of lines that the segfault
> > +# took place, tricky, but couldn't find any other way to check this
> > +# while suppressing the core dumped message. -acme
> > +
> > +nr_lines=$(PAHOLE_VMLINUX_BTF_FILENAME=foobar pahole -F btf list_head 2>&1 | wc -l)
> > +
> > +if [ $nr_lines -eq 0 ] ; then
> > +	echo "FAILED"
> > +	exit 1
> > +fi
> > +
> > +echo "Ok"
> > +exit 0
