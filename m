Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD3C1F939;
	Wed,  3 Jan 2024 23:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VadaSLZ3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78D4AC433C7;
	Wed,  3 Jan 2024 23:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704326146;
	bh=hwTcID2H2X8/mEb7kXNbwxxeSCC0oergI4q2KvRnCw8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VadaSLZ3K7jde2kzFOAgBzYxJOMmT83Z2eIG6SqPK6UMOue2zD+XxAO4fhKNW1sSZ
	 Cx1PSYOgQ2KIzvucc+S780XvfipE935WoUsfNEk5ol9xW9Az3KG1Js1vzHM3R+krlf
	 uc6Ef/uOr7ycnugactjhk5OOLFxxo7kiQ0CT3+4KccmPPA0SXjte8kqsSrIEvudn9R
	 w7KjiiU9mgYzvF31OAk5HeN6Mc8RC4N7eVq3TkLoQ+w2wQoB93TwBp1RZIfj+NYGio
	 dTVpievtWJ3XoxunCIvd7hlZZter7fCOetTglA28YE5hWZJFc7XR+5UNnftuNmM3aW
	 BBP5P+s/jveDg==
Date: Wed, 3 Jan 2024 16:55:43 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Nick Desaulniers <ndesaulniers@google.com>,
	Brian Cain <bcain@quicinc.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Yujie Liu <yujie.liu@intel.com>, kernel test robot <lkp@intel.com>,
	llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-hexagon@vger.kernel.org, dwarves@vger.kernel.org,
	Mark Wielaard <mark@klomp.org>
Subject: Re: [bcachefs:header_cleanup 21/51] /bin/bash: line 1: 19420
 Segmentation fault LLVM_OBJCOPY="llvm-objcopy" pahole -J --btf_gen_floats -j
 --lang_exclude=rust --skip_encoding_btf_inconsistent_proto
 --btf_gen_optimized --btf_base vmlinux drivers/misc/eeprom/at24.ko
Message-ID: <20240103235543.GA696229@dev-arch.thelio-3990X>
References: <CAKwvOdmrvwdbFrtzsOjoLJJZ1pDZOBWBiEb=Mx5bCHuKU2wPzQ@mail.gmail.com>
 <20231219210454.GA540439@dev-arch.thelio-3990X>
 <ZYKWxl9oQXODIoNe@yujie-X299>
 <20231227224338.GA267659@dev-arch.thelio-3990X>
 <ZY2EUr+EYzyro3NH@kernel.org>
 <20231228173404.GA412881@dev-arch.thelio-3990X>
 <ZZQ6CpBnqpBgxSgp@kernel.org>
 <20240102175342.GH26453@gnu.wildebeest.org>
 <CAKwvOd=AAuqKk4GXV0jWORwJKJ0gao2zVd_RYWXoA90A77c47A@mail.gmail.com>
 <f6moe6xstxuj2wrnqftc2w7kx4yrnjyoqnigxprvnv4ymtgre6@6ioujgedt72e>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f6moe6xstxuj2wrnqftc2w7kx4yrnjyoqnigxprvnv4ymtgre6@6ioujgedt72e>

On Wed, Jan 03, 2024 at 05:03:17PM -0500, Kent Overstreet wrote:
> On Wed, Jan 03, 2024 at 08:20:10AM -0800, Nick Desaulniers wrote:
> > On Tue, Jan 2, 2024 at 9:53 AM Mark Wielaard <mark@klomp.org> wrote:
> > >
> > > This seems to need Qualcomm to upstream support for this processor
> > > type to bintuils and elfutils.
> > 
> > Probably should disable BTF for hexagon until then.
> 
> Do we want to include a patch for that in the header cleanup tree?

This issue is reproducible on mainline so I don't think there needs to
be a patch for this in the header cleanup tree.

As for the patch, I assume it would look something like this?

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 4405f81248fb..1b939f5583eb 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -378,6 +378,8 @@ config DEBUG_INFO_BTF
 	depends on !GCC_PLUGIN_RANDSTRUCT || COMPILE_TEST
 	depends on BPF_SYSCALL
 	depends on !DEBUG_INFO_DWARF5 || PAHOLE_VERSION >= 121
+	# pahole uses elfutils, which does not have support for Hexagon relocations
+	depends on !HEXAGON
 	help
 	  Generate deduplicated BTF type information from DWARF debug info.
 	  Turning this on expects presence of pahole tool, which will convert
