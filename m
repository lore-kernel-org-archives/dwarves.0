Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549101D0164
	for <dwarves@vger.kernel.org>; Tue, 19 Nov 2024 17:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732038487; cv=none; b=OU/udnvDxf0i7kxo45lTTYUQqHgsHtrhsCe0m7UCLElPomZhrSlg7/0l07Pgw3RSACCGcrc8lTG7DA1fVOZfIWaeQ1mafQmyPYURVhkQYa7LkEPXfKHl9t0lzDyD46j3UFxT7o9j4yIt1HXjguDMDWz4BUwHyY2bNzsTRydFW7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732038487; c=relaxed/simple;
	bh=tjj6MdjIccQBJb/nQ3YXqQiNUQvm7h2MJ7NdTNA7hWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mE5bhdwjPfvYYjC+gZ+k56f4wJTgjiEEQrFfSuZQLTvbZHwf5x9l1NfeaoBF5d8U0t++i+TqdpZlDcrQN/jJq8p/Q5+YBtYhKLcx0MwTM8qqtziugLxQ+uJ8WX9EGg5w2wi6zrwlX12mWzdBhd/58/oSCv5amKKc9Ba5352vIMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vFntEXyx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vFntEXyx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CF2BC4CECF;
	Tue, 19 Nov 2024 17:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732038486;
	bh=tjj6MdjIccQBJb/nQ3YXqQiNUQvm7h2MJ7NdTNA7hWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vFntEXyxAgv3Oik5JZYrkW2eOWdj48bG0Dl+IL3ON5KpIRoUiKqo2CsEfdcfgg+6G
	 g2wm+q3zF7YbyJFXpznfTJ+MuT91/QhaiKA/ZAsHX8tQU6Yr/j7cWQ0tr7dcL5XFPI
	 fbrRDmxmhf/XARRTvijbhAXXcTwNJ50Bx/rq3pmLtTkn4NYrmfufv9pQxKbPEh3Pdm
	 oMhFdEmr+ct4FusRTSlRddKLEtaO7WRgumzlTBfppkjZ7ZYV82htAlDb5hej5rclSZ
	 AVD/V+FDHEhCdIwJvOZuCrx6IpZ9H3fdpFXJ3xLa+oL5wyQAj8bIuuOBhEGd1Hu0Xf
	 OV38edgmsZMTg==
Date: Tue, 19 Nov 2024 14:48:02 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Matthias Schwarzott <zzam@gentoo.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>, dwarves@vger.kernel.org
Subject: Re: [PATCH 1/5] core: Add method to get the vmlinux BTF filename,
 allow overriding it via env var
Message-ID: <ZzzPUhCaew6rHwL_@x1>
References: <20241118204146.772762-1-acme@kernel.org>
 <20241118204146.772762-2-acme@kernel.org>
 <ac93d9fe-2e84-4e00-94ef-50a3074d49fc@oracle.com>
 <ZzyO9aibti18J6sK@x1>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzyO9aibti18J6sK@x1>

On Tue, Nov 19, 2024 at 10:13:32AM -0300, Arnaldo Carvalho de Melo wrote:
> On Tue, Nov 19, 2024 at 12:57:44PM +0000, Alan Maguire wrote:
> > On 18/11/2024 20:41, Arnaldo Carvalho de Melo wrote:
> > > In systems where BTF isn't available there were reports that the
> > > simplest pahole call, without any args, segfaults.
> 
> > > To have a proper test before fixing this problem, allow overriding the
> > > /sys/kernel/btf/vmlinux filename, so that even in systems with BTF we an
> > > point it to a invalid location, making pahole think that there is no BTF
> > > available and thus fallback to something that currently segfaults.
> 
> <SNIP>
> 
> > Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> 
> Thanks!

Ah, thanks, added to the cset,

- Arnaldo
  
> > Small thing - would it be worth dropping the _FILENAME suffix of the
> > envvar to just have PAHOLE_VMLINUX_BTF? One other thing below..
> 
> See below ends up being related to the other point you made.
>  
> > > +++ b/pahole.c
> > > @@ -3754,7 +3754,7 @@ try_sole_arg_as_class_names:
> > >  		if (filename &&
> > >  		    strstarts(filename, "/sys/kernel/btf/") &&
> > >  		    strstr(filename, "/vmlinux") == NULL) {
> > > -			base_btf_file = "/sys/kernel/btf/vmlinux";
> > > +			base_btf_file = vmlinux_path__btf_filename();
> > 
> > so in this case, we are specifying a module in /sys/kernel/btf and
> > implicitly we use /sys/kernel/btf/vmlinux as the base. I wonder if
> > there's much value for the envvar override here; I guess it might allow
> > us to test using a mismatched base vmlinux with split BTF?
> 
> Right, that would be possible with this patch as-is, which may be
> useful, we may want to have PAHOLE_VMLINUX_BTF_DIR as a counterpart to
> PAHOLE_VMLINUX_BTF_FILENAME, that would allow us to use some different
> directory with both vmlinux and modules.
> 
> Having both allows more flexibility, picking some arbitrary vmlinux
> plust some arbitrary directory with modules, etc. So I'd keep the patch
> as is and at some point add the PAHOLE_VMLINUX_BTF_DIR knob.
> 
> - Arnaldo
>  
> > >  			conf_load.base_btf = btf__parse(base_btf_file, NULL);
> > >  			if (libbpf_get_error(conf_load.base_btf)) {
> > >  				fprintf(stderr, "Failed to parse base BTF '%s': %ld\n",
