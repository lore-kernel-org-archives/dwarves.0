Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0149C1DA26
	for <dwarves@vger.kernel.org>; Wed,  3 Jan 2024 22:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qXEOFqn/"
Date: Wed, 3 Jan 2024 17:03:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704319401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NBzUZuT0BfcxoAprbvM1KtRefqBl5uevb744fGCS3+E=;
	b=qXEOFqn/2nRxNpIUFJ4QCjwmv1xawSPcOdnsBwwrt4yv7Azgubi79Kd+n6LNVP1/wGz5xu
	vdbBT/5WSh0cshC0M9O8eprXPWgsr7A2XPCbvQ/NrLlTjHPzAKk6t2bB0+i0PfgcWYXFpg
	hi8XWrN21CqhpJcnBxvJdZCOGYhdLWc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Brian Cain <bcain@quicinc.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Yujie Liu <yujie.liu@intel.com>, 
	kernel test robot <lkp@intel.com>, llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, 
	linux-hexagon@vger.kernel.org, dwarves@vger.kernel.org, Mark Wielaard <mark@klomp.org>
Subject: Re: [bcachefs:header_cleanup 21/51] /bin/bash: line 1: 19420
 Segmentation fault LLVM_OBJCOPY="llvm-objcopy" pahole -J --btf_gen_floats -j
 --lang_exclude=rust --skip_encoding_btf_inconsistent_proto
 --btf_gen_optimized --btf_base vmlinux drivers/misc/eeprom/at24.ko
Message-ID: <f6moe6xstxuj2wrnqftc2w7kx4yrnjyoqnigxprvnv4ymtgre6@6ioujgedt72e>
References: <20231219205348.wvvxyicaatmljxm2@moria.home.lan>
 <CAKwvOdmrvwdbFrtzsOjoLJJZ1pDZOBWBiEb=Mx5bCHuKU2wPzQ@mail.gmail.com>
 <20231219210454.GA540439@dev-arch.thelio-3990X>
 <ZYKWxl9oQXODIoNe@yujie-X299>
 <20231227224338.GA267659@dev-arch.thelio-3990X>
 <ZY2EUr+EYzyro3NH@kernel.org>
 <20231228173404.GA412881@dev-arch.thelio-3990X>
 <ZZQ6CpBnqpBgxSgp@kernel.org>
 <20240102175342.GH26453@gnu.wildebeest.org>
 <CAKwvOd=AAuqKk4GXV0jWORwJKJ0gao2zVd_RYWXoA90A77c47A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOd=AAuqKk4GXV0jWORwJKJ0gao2zVd_RYWXoA90A77c47A@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Jan 03, 2024 at 08:20:10AM -0800, Nick Desaulniers wrote:
> On Tue, Jan 2, 2024 at 9:53 AM Mark Wielaard <mark@klomp.org> wrote:
> >
> > This seems to need Qualcomm to upstream support for this processor
> > type to bintuils and elfutils.
> 
> Probably should disable BTF for hexagon until then.

Do we want to include a patch for that in the header cleanup tree?
