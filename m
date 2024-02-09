Received: from gnu.wildebeest.org (gnu.wildebeest.org [45.83.234.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0A6383B6;
	Fri,  9 Feb 2024 13:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.83.234.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707485693; cv=none; b=H8ve+7UhYDOxBwDIEJJ/3uFEujCpxjF5XsnwbSj+dL1NeBuhJvOoTAkxFKWkBPiR/WC20BASSCbL+a4vHTAsOFc8k15leWSgA3qiuD//EGUbTWwUX0QfODksknmTIhKlrd+XGslUs4moNlpQXonLJq5lHh81Z0jHxQLZcf4DvCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707485693; c=relaxed/simple;
	bh=YwE9cHhKhhBpSsDZCL92ttY6c2YwtUIaImHuL6O8huA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SQkrgQMWKwkrISQmPg+TCojPtN4sKxtbYcdS1wc/dIcNGhijnhdhLVRLSyCCbtzFFV26Ow80RbeEKkIr4MVsWLQsU7HWEmYTilpZj/8LCZe1BDBL7YXz4JTmol03b9kPojb64fp/6GQGFzRCyRqYhiYsTXEs1HOl+ioOay7i/IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=klomp.org; spf=pass smtp.mailfrom=klomp.org; arc=none smtp.client-ip=45.83.234.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=klomp.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=klomp.org
Received: from r6.localdomain (82-217-174-174.cable.dynamic.v4.ziggo.nl [82.217.174.174])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by gnu.wildebeest.org (Postfix) with ESMTPSA id 7FBE73000673;
	Fri,  9 Feb 2024 14:34:41 +0100 (CET)
Received: by r6.localdomain (Postfix, from userid 1000)
	id 1D4363404FF; Fri,  9 Feb 2024 14:34:40 +0100 (CET)
Message-ID: <6498586d7d0ed112e6c44be98d439abc549653c7.camel@klomp.org>
Subject: Re: [bcachefs:header_cleanup 21/51] /bin/bash: line 1: 19420
 Segmentation fault LLVM_OBJCOPY="llvm-objcopy" pahole -J --btf_gen_floats
 -j --lang_exclude=rust --skip_encoding_btf_inconsistent_proto
 --btf_gen_optimized --btf_base vmlinux drivers/misc/eep...
From: Mark Wielaard <mark@klomp.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Brian Cain
 <bcain@quicinc.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Yujie Liu <yujie.liu@intel.com>, 
 Nick Desaulniers <ndesaulniers@google.com>, Kent Overstreet
 <kent.overstreet@linux.dev>, kernel test robot <lkp@intel.com>,
 "llvm@lists.linux.dev" <llvm@lists.linux.dev>, 
 "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
 "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
 "dwarves@vger.kernel.org" <dwarves@vger.kernel.org>, Sid Manning
 <sidneym@quicinc.com>
Date: Fri, 09 Feb 2024 14:34:39 +0100
In-Reply-To: <ZZXHTawRETL4XNmc@kernel.org>
References: <20231219205348.wvvxyicaatmljxm2@moria.home.lan>
	 <CAKwvOdmrvwdbFrtzsOjoLJJZ1pDZOBWBiEb=Mx5bCHuKU2wPzQ@mail.gmail.com>
	 <20231219210454.GA540439@dev-arch.thelio-3990X>
	 <ZYKWxl9oQXODIoNe@yujie-X299>
	 <20231227224338.GA267659@dev-arch.thelio-3990X>
	 <ZY2EUr+EYzyro3NH@kernel.org>
	 <20231228173404.GA412881@dev-arch.thelio-3990X>
	 <ZZQ6CpBnqpBgxSgp@kernel.org> <20240102175342.GH26453@gnu.wildebeest.org>
	 <SN6PR02MB42057525427B47481F1934D5B860A@SN6PR02MB4205.namprd02.prod.outlook.com>
	 <ZZXHTawRETL4XNmc@kernel.org>
Autocrypt: addr=mark@klomp.org; prefer-encrypt=mutual;
 keydata=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
	QifSU1tvZxQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Flag: NO

Hi,

On Wed, 2024-01-03 at 17:45 -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, Jan 03, 2024 at 05:25:11PM +0000, Brian Cain escreveu:
> > > From: Mark Wielaard <mark@klomp.org>
> > > To: Arnaldo Carvalho de Melo <acme@kernel.org>
> > >=20
> > > > Mark, do you know about work on elfutils to support:
>=20
> > > > =E2=AC=A2[acme@toolbox hexagon-randconfig-r005-20220913-pahole-cras=
h]$ llvm-
> > > dwarfdump at24.ko | head -22
> > > > at24.ko:        file format elf32-hexagon
>=20
> > > That seems to identify itself as an EM_QDSP6 (QUALCOMM DSP6) 32bit EL=
F
> > > file. Neither binutils not elfutils seems to know how to resolve
> > > EM_QDSP6 specific relocations. Normally that wouldn't be necessary,
> > > but sadly kernel modules are still ET_REL files, so eu-readelf/readel=
f
> > > needs relocations resolved to process the DWARF .debug sections.
>=20
> > > This seems to need Qualcomm to upstream support for this processor
> > > type to bintuils and elfutils.
> =20
> > We can take a look at this.  But - please forgive my inexperience here
> > -- do the corresponding tools such as llvm-readelf not suffice here?
> > Would it be welcome for us to change pahole to support those if it
> > doesn't already?
>=20
> pahole uses the DWARF library that comes with elfutils, so the changes
> that were made to the DWARF library used by llvm-readelf would have to
> be done to elfutils' DWARF library for pahole to be able to process
> these files.
>=20
> IANAL to say if you can copy code across these these codebases.

Literally copying code over between those codebases is probably not
going to work anyway. But it shouldn't be too hard to get just the
support for handling ET_REL kernel modules in elfutils.

Basically you'll have to add a new backend and at least implement the
reloc_simple_type callback (this is the one that tells elfutils which
relocations are "simple" and how they can be resolved between .debug
sections). An example to follow might be the initial LoongArch backend
support:
https://sourceware.org/cgit/elfutils/commit?id=3D13a4d1279c5b7847049ca3045d=
04f2705c45ce31
This one is just ~200 lines long, and the reloc_simple_types callback
is bigger than most, often arches have just really simple relocations
without any need for add/sub support. e.g the aarch backend simply has
support for 16, 32 and 64 offsets without any additional addsub addend:

/* Check for the simple reloc types.  */
Elf_Type
aarch64_reloc_simple_type (Ebl *ebl __attribute__ ((unused)), int type,
                           int *addsub __attribute__ ((unused)))=20
{
  switch (type)
    {
    case R_AARCH64_ABS64:
      return ELF_T_XWORD;
    case R_AARCH64_ABS32:
      return ELF_T_WORD;
    case R_AARCH64_ABS16:
      return ELF_T_HALF;
   =20
    default:
      return ELF_T_NUM;
    }
}

The only relocations that are really relevant here are those that are
used for the .debug sections.

Then follow the CONTRIBUTING guide to submit the new (partial) port:
https://sourceware.org/cgit/elfutils/tree/CONTRIBUTING

Cheers,

Mark
