Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22943C8D2;
	Thu, 28 Dec 2023 14:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bVraqIW3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB96C433C8;
	Thu, 28 Dec 2023 14:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703773269;
	bh=/EQrMG7UvytkqAKY/Q/t1m5yglHvF4uxkUVhc5ytOaQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bVraqIW3IPpG7EFGjd/HwRVxDuy3NgxgLdosygFbb1Shnk6VyAjHFVuEayYRtRe80
	 8jSLylMOKMHv3O8zpPLPn534XYIhYqzuhu9UA0/Oif/U4Nkil2n7MoRnV2gKmRMa41
	 LgObFXi7639W6wMh3XwGCsy+mcGiU66O9J8iDNfENml29wU3xaf2lmzP/KXUFvl3qt
	 E87K1Q7xODXBQyX2d5Au/Gk96A+rsfKPjz/tKEZuNgpFXYPTkWSrRQZtVF45zBagPy
	 Y8LAk/d+CBJdfJLFBGAMEQ9eFO+smRKxcYphf+3TO2Qi60jZAAttQ7r/wNW5bp4aQm
	 1e4TwCVrj4laA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 901F6403EF; Thu, 28 Dec 2023 11:21:06 -0300 (-03)
Date: Thu, 28 Dec 2023 11:21:06 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Yujie Liu <yujie.liu@intel.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, Brian Cain <bcain@quicinc.com>,
	linux-hexagon@vger.kernel.org, dwarves@vger.kernel.org
Subject: Re: [bcachefs:header_cleanup 21/51] /bin/bash: line 1: 19420
 Segmentation fault LLVM_OBJCOPY="llvm-objcopy" pahole -J --btf_gen_floats -j
 --lang_exclude=rust --skip_encoding_btf_inconsistent_proto
 --btf_gen_optimized --btf_base vmlinux drivers/misc/eeprom/at24.ko
Message-ID: <ZY2EUr+EYzyro3NH@kernel.org>
References: <202312192107.wMIKiZWw-lkp@intel.com>
 <20231219205348.wvvxyicaatmljxm2@moria.home.lan>
 <CAKwvOdmrvwdbFrtzsOjoLJJZ1pDZOBWBiEb=Mx5bCHuKU2wPzQ@mail.gmail.com>
 <20231219210454.GA540439@dev-arch.thelio-3990X>
 <ZYKWxl9oQXODIoNe@yujie-X299>
 <20231227224338.GA267659@dev-arch.thelio-3990X>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231227224338.GA267659@dev-arch.thelio-3990X>
X-Url: http://acmel.wordpress.com

Em Wed, Dec 27, 2023 at 03:43:38PM -0700, Nathan Chancellor escreveu:
> + Arnaldo and dwarves list
> 
> On Wed, Dec 20, 2023 at 03:24:54PM +0800, Yujie Liu wrote:
> > On Tue, Dec 19, 2023 at 02:04:54PM -0700, Nathan Chancellor wrote:
> > > On Tue, Dec 19, 2023 at 12:58:28PM -0800, Nick Desaulniers wrote:
> > > > On Tue, Dec 19, 2023 at 12:54 PM Kent Overstreet
> > > > <kent.overstreet@linux.dev> wrote:
> > > > >
> > > > > On Tue, Dec 19, 2023 at 09:40:09PM +0800, kernel test robot wrote:
> > > > > > tree:   https://evilpiepirate.org/git/bcachefs.git header_cleanup
> > > > > > head:   89188fceb7a49e3c4b0578d86f6f6e647f202821
> > > > > > commit: 1db61740aeb7d6b1c7bfb2a98708a65a6679d068 [21/51] locking/seqlock: Split out seqlock_types.h
> > > > > > config: hexagon-randconfig-r005-20220913 (https://download.01.org/0day-ci/archive/20231219/202312192107.wMIKiZWw-lkp@intel.com/config)
> > > > > > compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
> > > > > > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231219/202312192107.wMIKiZWw-lkp@intel.com/reproduce)
> > > > > >
> > > > > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > > > > the same patch/commit), kindly add following tags
> > > > > > | Reported-by: kernel test robot <lkp@intel.com>
> > > > > > | Closes: https://lore.kernel.org/oe-kbuild-all/202312192107.wMIKiZWw-lkp@intel.com/
> > > > > >
> > > > > > All errors (new ones prefixed by >>):
> > > > > >
> > > > > >    die__process_unit: DW_TAG_member (0xd) @ <0xc689> not handled!
> > > > > >    die__process_unit: tag not supported 0xd (member)!
> > > > > >    die__process_function: DW_TAG_compile_unit (0x11) @ <0xc697> not handled!
> > > > > >    die__process_function: tag not supported 0x11 (compile_unit)!
> > > > > >    die__process_function: DW_TAG_member (0xd) @ <0xc6db> not handled!
> > > > > >    die__process_function: DW_TAG_compile_unit (0x11) @ <0xc6e5> not handled!
> > > > > >    die__process_class: DW_TAG_compile_unit (0x11) @ <0xc778> not handled!
> > > > > >    namespace__recode_dwarf_types: couldn't find 0xc689 type for 0xc66b (member)!
> > > > > >    namespace__recode_dwarf_types: couldn't find 0xc638 type for 0xc674 (member)!
> > > > > >    namespace__recode_dwarf_types: couldn't find 0xc638 type for 0xc67e (member)!
> > > > > > >> /bin/bash: line 1: 19420 Segmentation fault      LLVM_OBJCOPY="llvm-objcopy" pahole -J --btf_gen_floats -j --lang_exclude=rust --skip_encoding_btf_inconsistent_proto --btf_gen_optimized --btf_base vmlinux drivers/misc/eeprom/at24.ko
> > > > >
> > > > > Not sure how likely a header cleanup is to cause a segfault in
> > > > > llvm-objcopy and I don't have the toolchain to repro this - could
> > > > > hexagon people take a look?
> > > 
> > > For what it's worth in case you were not aware, I provide copies of LLVM
> > > on kernel.org that can be installed in some prefix and invoked with
> > > LLVM=<prefix>/bin/, which can make reproducing reports such as these
> > > relatively easy.
> > > 
> > > https://mirrors.edge.kernel.org/pub/tools/llvm/
> > > 
> > > > Is it a segfault in llvm-objcopy, or pahole?
> > > 
> > > Should be pahole. I have not been able to reproduce these crashes in
> > > pahole v1.25 in the past when they come up every so often. 0day folks,
> > > what version of pahole are you testing with?
> > 
> > We clone pahole source code from [1] and build it on the master branch.
> > The current head is commit c129fa757948 which is newer than v1.25.
> > 
> > c129fa757948 ("pahole: Add --btf_features_strict to reject unknown BTF features")
> > 
> > [1] https://git.kernel.org/pub/scm/devel/pahole/pahole.git
> 
> Thanks for that additional information but I can reproduce this at v1.25
> as well, I just tried:
> 
>   $ git fetch https://evilpiepirate.org/git/bcachefs.git 1db61740aeb7d6b1c7bfb2a98708a65a6679d068
>   $ git reset --hard FETCH_HEAD
>   $ curl -LSso .config https://download.01.org/0day-ci/archive/20231219/202312192107.wMIKiZWw-lkp@intel.com/config
>   $ curl -LSs https://mirrors.edge.kernel.org/pub/tools/llvm/files/llvm-16.0.6-x86_64.tar.xz | tar -xJf -
>   $ make -skj"$(nproc)" ARCH=hexagon LLVM=$PWD/llvm-16.0.6-x86_64/bin/ olddefconfig all
>   ...
>   die__process: got compile_unit unexpected tag after DW_TAG_compile_unit!
>   die__create_new_enumeration: DW_TAG_array_type (0x1) @ <0x120b1> not handled!
>   die__create_new_enumeration: DW_TAG_pointer_type (0xf) @ <0x120b7> not handled!
>   die__process_unit: DW_TAG_member (0xd) @ <0x3669> not handled!
>   die__process_unit: tag not supported 0xd (member)!
>   die__process: got compile_unit unexpected tag after DW_TAG_compile_unit!
>   die__process_unit: DW_TAG_member (0xd) @ <0x3650> not handled!
>   die__process_unit: tag not supported 0xd (member)!
>   die__process: got compile_unit unexpected tag after DW_TAG_compile_unit!
>   die__create_new_enumeration: DW_TAG_array_type (0x1) @ <0x9cb5> not handled!
>   die__create_new_enumeration: DW_TAG_pointer_type (0xf) @ <0x9cbb> not handled!
>   die__process_unit: DW_TAG_enumerator (0x28) @ <0x705a> not handled!
>   die__process_unit: tag not supported 0x28 (enumerator)!
>   ...
> 
> I do not get a segfault personally but there are definitely a lot of
> errors from pahole at the end. Arnaldo, is pahole not handling something
> that it should with regards to clang's debug info?

Possibly, would it be possible to provide the vmlinux file where pahole
is segfaulting when trying to encode BTF from DWARF?

These two files:

vmlinux drivers/misc/eeprom/at24.ko

So that I can run:

LLVM_OBJCOPY="llvm-objcopy" pahole -J --btf_gen_floats -j --lang_exclude=rust --skip_encoding_btf_inconsistent_proto --btf_gen_optimized --btf_base vmlinux drivers/misc/eeprom/at24.ko

Here.

- Arnaldo
