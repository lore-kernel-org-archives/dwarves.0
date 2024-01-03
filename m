Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB021D522;
	Wed,  3 Jan 2024 20:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AAo5QiYb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86EC0C433C7;
	Wed,  3 Jan 2024 20:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704314703;
	bh=FMv5vBS+OUl9IhdRIkoDxynEByJXpgOPngDtTzyaGNE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AAo5QiYbvDoWm0D/5TxV/LeNO6csxAU8d+ETptz56L7+9FexS07VOsCW6H0i+AjEe
	 nVPQTiA4LdMZSaF/ac8p74zbb7vTZpvX1xlZcSm0P03plS0cIjk5D5hmyKHLr8Xw0g
	 C+pU5GILpvjtcFZsqJsHj3z6DQJwoXsZ+GguLAvC0iQeTJjtwhBHwxAcOM2tkqu3mp
	 OOyVBiVh7/O6Phua4ecA8WlsuKgVDj7zk3dX8Pq9CPzWGeOHrBaD7sZiVtg9P7kQvn
	 KsrE17EbYbXFcCHn3fPVZC3LCuRgoMftvZ0ouvCfXx0LIkBPbe368uXEHnU8039bb5
	 k1Gwd4hheUp0g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 23CD6403EF; Wed,  3 Jan 2024 17:45:01 -0300 (-03)
Date: Wed, 3 Jan 2024 17:45:01 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Brian Cain <bcain@quicinc.com>
Cc: Mark Wielaard <mark@klomp.org>, Nathan Chancellor <nathan@kernel.org>,
	Yujie Liu <yujie.liu@intel.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	kernel test robot <lkp@intel.com>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>,
	"oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
	"linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
	"dwarves@vger.kernel.org" <dwarves@vger.kernel.org>,
	Sid Manning <sidneym@quicinc.com>
Subject: Re: [bcachefs:header_cleanup 21/51] /bin/bash: line 1: 19420
 Segmentation fault LLVM_OBJCOPY="llvm-objcopy" pahole -J --btf_gen_floats -j
 --lang_exclude=rust --skip_encoding_btf_inconsistent_proto
 --btf_gen_optimized --btf_base vmlinux drivers/misc/eep...
Message-ID: <ZZXHTawRETL4XNmc@kernel.org>
References: <20231219205348.wvvxyicaatmljxm2@moria.home.lan>
 <CAKwvOdmrvwdbFrtzsOjoLJJZ1pDZOBWBiEb=Mx5bCHuKU2wPzQ@mail.gmail.com>
 <20231219210454.GA540439@dev-arch.thelio-3990X>
 <ZYKWxl9oQXODIoNe@yujie-X299>
 <20231227224338.GA267659@dev-arch.thelio-3990X>
 <ZY2EUr+EYzyro3NH@kernel.org>
 <20231228173404.GA412881@dev-arch.thelio-3990X>
 <ZZQ6CpBnqpBgxSgp@kernel.org>
 <20240102175342.GH26453@gnu.wildebeest.org>
 <SN6PR02MB42057525427B47481F1934D5B860A@SN6PR02MB4205.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SN6PR02MB42057525427B47481F1934D5B860A@SN6PR02MB4205.namprd02.prod.outlook.com>
X-Url: http://acmel.wordpress.com

Em Wed, Jan 03, 2024 at 05:25:11PM +0000, Brian Cain escreveu:
> > From: Mark Wielaard <mark@klomp.org>
> > To: Arnaldo Carvalho de Melo <acme@kernel.org>
> > > llvm-dwarfdump is the only that is managing to process this file on a
> > > fedora:39 system, more work needed to figure out if this is something
> > > elfutils is planning to support, what amount of work would be necessary,
> > > etc.

> > > Mark, do you know about work on elfutils to support:

> > > ⬢[acme@toolbox hexagon-randconfig-r005-20220913-pahole-crash]$ llvm-
> > dwarfdump at24.ko | head -22
> > > at24.ko:        file format elf32-hexagon

> > That seems to identify itself as an EM_QDSP6 (QUALCOMM DSP6) 32bit ELF
> > file. Neither binutils not elfutils seems to know how to resolve
> > EM_QDSP6 specific relocations. Normally that wouldn't be necessary,
> > but sadly kernel modules are still ET_REL files, so eu-readelf/readelf
> > needs relocations resolved to process the DWARF .debug sections.

> > This seems to need Qualcomm to upstream support for this processor
> > type to bintuils and elfutils.
 
> We can take a look at this.  But - please forgive my inexperience here
> -- do the corresponding tools such as llvm-readelf not suffice here?
> Would it be welcome for us to change pahole to support those if it
> doesn't already?

pahole uses the DWARF library that comes with elfutils, so the changes
that were made to the DWARF library used by llvm-readelf would have to
be done to elfutils' DWARF library for pahole to be able to process
these files.

IANAL to say if you can copy code across these these codebases.

- Arnaldo
