Received: from gnu.wildebeest.org (gnu.wildebeest.org [45.83.234.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA60156CB;
	Tue,  2 Jan 2024 18:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=klomp.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=klomp.org
Received: by gnu.wildebeest.org (Postfix, from userid 1000)
	id 5D584302BB42; Tue,  2 Jan 2024 18:53:42 +0100 (CET)
Date: Tue, 2 Jan 2024 18:53:42 +0100
From: Mark Wielaard <mark@klomp.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Yujie Liu <yujie.liu@intel.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, Brian Cain <bcain@quicinc.com>,
	linux-hexagon@vger.kernel.org, dwarves@vger.kernel.org
Subject: Re: [bcachefs:header_cleanup 21/51] /bin/bash: line 1: 19420
 Segmentation fault LLVM_OBJCOPY="llvm-objcopy" pahole -J --btf_gen_floats -j
 --lang_exclude=rust --skip_encoding_btf_inconsistent_proto
 --btf_gen_optimized --btf_base vmlinux drivers/misc/eeprom/at24.ko
Message-ID: <20240102175342.GH26453@gnu.wildebeest.org>
References: <202312192107.wMIKiZWw-lkp@intel.com>
 <20231219205348.wvvxyicaatmljxm2@moria.home.lan>
 <CAKwvOdmrvwdbFrtzsOjoLJJZ1pDZOBWBiEb=Mx5bCHuKU2wPzQ@mail.gmail.com>
 <20231219210454.GA540439@dev-arch.thelio-3990X>
 <ZYKWxl9oQXODIoNe@yujie-X299>
 <20231227224338.GA267659@dev-arch.thelio-3990X>
 <ZY2EUr+EYzyro3NH@kernel.org>
 <20231228173404.GA412881@dev-arch.thelio-3990X>
 <ZZQ6CpBnqpBgxSgp@kernel.org>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZZQ6CpBnqpBgxSgp@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

Hi Arnaldo,

On Tue, Jan 02, 2024 at 01:30:02PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Dec 28, 2023 at 10:34:04AM -0700, Nathan Chancellor escreveu:
> > On Thu, Dec 28, 2023 at 11:21:06AM -0300, Arnaldo Carvalho de Melo wrote:
> > > Em Wed, Dec 27, 2023 at 03:43:38PM -0700, Nathan Chancellor escreveu:
> > > > I do not get a segfault personally but there are definitely a lot of
> > > > errors from pahole at the end. Arnaldo, is pahole not handling something
> > > > that it should with regards to clang's debug info?
> 
> > > Possibly, would it be possible to provide the vmlinux file where pahole
> > > is segfaulting when trying to encode BTF from DWARF?
> 
> > > These two files:
> 
> > > vmlinux drivers/misc/eeprom/at24.ko
> 
> > > So that I can run:
> > > LLVM_OBJCOPY="llvm-objcopy" pahole -J --btf_gen_floats -j --lang_exclude=rust --skip_encoding_btf_inconsistent_proto --btf_gen_optimized --btf_base vmlinux drivers/misc/eeprom/at24.ko
>  
> > Sure, here you go:
>  
> > https://1drv.ms/u/s!AsQNYeB-IEbqqAilUuGHOU8BMLbf
>  
> > If you need more objects, just let me know. That series of commands in
> > the previous email should also get them for you locally if you need all
> > of them or want to investigate more.
> 
> llvm-dwarfdump is the only that is managing to process this file on a
> fedora:39 system, more work needed to figure out if this is something
> elfutils is planning to support, what amount of work would be necessary,
> etc.
> 
> Mark, do you know about work on elfutils to support:
> 
> ⬢[acme@toolbox hexagon-randconfig-r005-20220913-pahole-crash]$ llvm-dwarfdump at24.ko | head -22
> at24.ko:        file format elf32-hexagon

That seems to identify itself as an EM_QDSP6 (QUALCOMM DSP6) 32bit ELF
file. Neither binutils not elfutils seems to know how to resolve
EM_QDSP6 specific relocations. Normally that wouldn't be necessary,
but sadly kernel modules are still ET_REL files, so eu-readelf/readelf
needs relocations resolved to process the DWARF .debug sections.

This seems to need Qualcomm to upstream support for this processor
type to bintuils and elfutils.

Cheers,

Mark
