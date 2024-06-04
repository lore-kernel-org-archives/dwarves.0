Received: from lf-1-19.ptr.blmpb.com (lf-1-19.ptr.blmpb.com [103.149.242.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059A014265A
	for <dwarves@vger.kernel.org>; Tue,  4 Jun 2024 08:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.149.242.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717490541; cv=none; b=BUcnVB37XwYqrU0d83zbKHcmL/hyHugpaRq9YD+i6NZJvZB6rSiFJq3Noq218tLcHNBwCDcZVnHvBPh+X+wYhoCGT4Tp2r87ZqcrJDlXnt2Yoc+Ne/KRGlDrRrUkiCDsNCQjo4a1W76Oc3GHHOe++SvKna9cZCD/toe+XYAx/DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717490541; c=relaxed/simple;
	bh=DlquuiqYkSNTfzfq5OVV0cpTdtY0M3vPwSLjp3C0Gx8=;
	h=From:Date:Cc:Message-Id:References:In-Reply-To:To:Subject:
	 Mime-Version:Content-Type; b=IoaizHPvEGTVaT4iKpWh4wC4PXDGNO+GcUqvZGSXxqL+wfxKqhktTcFlVr62xLrXhUBBBQSDrbpFnsId5ILIc5lbP8Ti0QjCcJ0dna9pZfHp3Q4frv7mUO1i4HXgvWdLBy+ebZ803MVsUe4tK7+aW69GGu701el4IoNtkii8tJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=oss.cipunited.com; spf=pass smtp.mailfrom=oss.cipunited.com; dkim=pass (2048-bit key) header.d=oss.cipunited.com header.i=@oss.cipunited.com header.b=A4RALWN9; arc=none smtp.client-ip=103.149.242.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=oss.cipunited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cipunited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cipunited.com header.i=@oss.cipunited.com header.b="A4RALWN9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2303200042; d=oss.cipunited.com; t=1717489645;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=jeyrMUQ5TvLc9+Ekzj3kZZHqcxEPhw/nCPOeHQv80rw=;
 b=A4RALWN94xzrDrPQFKINiX9zIgIIlgCdGztE3M89ki7jMPmMhLGdbeI3BUaplhg5pNkAOs
 qt4nhOqS7cJd4k4XR/9ds2IvPwchRTOd9tEwV09alGX3v8oe4Cpj26T9oOg/P74gb466KS
 xWEr6R8q49uRC6a0Qicvto38EBxOOoX0K/MG/g5rqdY4Z0zmP4hIUaxz9IMDMkryIKU1Gf
 an94Cgdzn0wWomzG4da4UGCZrqAbJsFajZJ6K2NmApzj+pQ92ALUve76zEOHxqCj/Go8Pb
 iXAfyHrt61KFpb/3k6n9Kcjlo7RkNg7RVeHrpvH7koqER/UFF4ZwYMtv9mqOCw==
From: "Ying Huang" <ying.huang@oss.cipunited.com>
Date: Tue, 4 Jun 2024 16:27:22 +0800
X-Lms-Return-Path: <lba+2665ecfed+ebb5a0+vger.kernel.org+ying.huang@oss.cipunited.com>
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Cc: "Arnaldo Carvalho de Melo" <acme@kernel.org>, 
	"Mark Wielaard" <mjw@redhat.com>, "Hengqi Chen" <hengqi.chen@gmail.com>, 
	<bpf@vger.kernel.org>, <dwarves@vger.kernel.org>, 
	"Alexei Starovoitov" <ast@kernel.org>, 
	"Daniel Borkmann" <daniel@iogearbox.net>, 
	"Andrii Nakryiko" <andrii@kernel.org>
Message-Id: <f04c6a54-cad0-4490-89bd-4193b4ad405a@oss.cipunited.com>
References: <ZlkoM6/PSxVcGM6X@kodidev-ubuntu> <CAEyhmHT_1N3xwLO2BwVK97ebrABJv52d5dWxzvuNNcF-OF5gKw@mail.gmail.com> <ZlmrQqQSJyNH7fVF@kodidev-ubuntu> <Zln1kZnu2Xxeyngj@x1> <Zl2m4RP7BwhZ0J6l@kodidev-ubuntu> <Zl3Zp5r9m6X_i_J4@x1> <Zl4AHfG6Gg5Htdgc@x1> <20240603191833.GD4421@gnu.wildebeest.org> <Zl6OTJXw0LH6uWIN@kodidev-ubuntu>
X-Original-From: Ying Huang <ying.huang@oss.cipunited.com>
Received: from [192.168.8.113] ([123.52.16.81]) by smtp.feishu.cn with ESMTPS; Tue, 04 Jun 2024 16:27:24 +0800
In-Reply-To: <Zl6OTJXw0LH6uWIN@kodidev-ubuntu>
To: "Tony Ambardar" <tony.ambardar@gmail.com>, 
	"Mark Wielaard" <mark@klomp.org>
Subject: Re: elfutils DWARF problem was: Re: Problem with BTF generation on mips64el
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
User-Agent: Mozilla Thunderbird

Hi Tony,

Yes, I also found that merge will have some conflicts now.

And you can modify the key code as follows to fix the issue about "eu-reade=
lf -w" could not show info.

But this can not fix other display error in the result of the "eu-readelf -=
w" which need modify the way to get symbol index and type.

> diff --git a/libelf/libelfP.h b/libelf/libelfP.h
> index bdd2cc6a..6565ee02 100644
> --- a/libelf/libelfP.h
> +++ b/libelf/libelfP.h
> @@ -620,4 +620,5 @@ extern void __libelf_reset_rawdata (Elf_Scn *scn, voi=
d *buf, size_t size,
>  #define ELF64_MIPS_R_TYPE1(i)          ((i) & 0xff)
>  #define ELF64_MIPS_R_TYPE2(i)           (((i) >> 8) & 0xff)
>  #define ELF64_MIPS_R_TYPE3(i)           (((i) >> 16) & 0xff)
> +#define is_debug_section_type(type) (type =3D=3D SHT_PROGBITS || type =
=3D=3D SHT_MIPS_DWARF)
>  #endif  /* libelfP.h */ > diff --git a/src/readelf.c b/src/readelf.c
> index 0e931184..e88cf67c 100644
> --- a/src/readelf.c
> +++ b/src/readelf.c > @@ -12043,7 +12139,7 @@ print_debug (Dwfl_Module *d=
wflmod, Ebl *ebl, GElf_Ehdr *ehdr)
>  	  GElf_Shdr shdr_mem;
>  	  GElf_Shdr *shdr =3D gelf_getshdr (scn, &shdr_mem);
> =20
> -	  if (shdr !=3D NULL && shdr->sh_type =3D=3D SHT_PROGBITS)
> +	  if (shdr !=3D NULL && is_debug_section_type(shdr->sh_type))
>  	    {
>  	      const char *name =3D elf_strptr (ebl->elf, shstrndx,
>  					     shdr->sh_name);
> @@ -12073,7 +12169,7 @@ print_debug (Dwfl_Module *dwflmod, Ebl *ebl, GElf=
_Ehdr *ehdr)
>        GElf_Shdr shdr_mem;
>        GElf_Shdr *shdr =3D gelf_getshdr (scn, &shdr_mem);
> =20
> -      if (shdr !=3D NULL && shdr->sh_type =3D=3D SHT_PROGBITS)
> +      if (shdr !=3D NULL && is_debug_section_type(shdr->sh_type))
>  	{
>  	  static const struct
>  	  {

Thanks,

Ying


=E5=9C=A8 2024/6/4 11:47, Tony Ambardar =E5=86=99=E9=81=93:
> Hi Mark,
>
> On Mon, Jun 03, 2024 at 09:18:33PM +0200, Mark Wielaard wrote:
>> On Mon, Jun 03, 2024 at 02:40:45PM -0300, Arnaldo Carvalho de Melo wrote=
:
>>> Couldn't find a way to ask eu-readelf for more verbose output, where we
>>> could perhaps get some clue as to why it produces nothing while binutil=
s
>>> readelf manages to grok it, Mark, do you know some other way to ask
>>> eu-readelf to produce more debug output?
>>>
>>> I'm unsure if the netdevsim.ko file was left in a semi encoded BTF stat=
e
>>> that then made eu-readelf to not be able to process it while pahole,
>>> that uses eltuils' libraries, was able to process the first two CUs for
>>> a kernel module and all the CUs for the vmlinux file :-\
>>>
>>> Mark, the whole thread is available at:
>>>
>>> https://lore.kernel.org/all/Zl3Zp5r9m6X_i_J4@x1/T/#u
>> I haven't looked at the vmlinux file. But for the .ko file the issue
>> is that the elfutils MIPS backend isn't complete. Specifically MIPS
>> relocations aren't recognized (and so cannot be applied). There are
>> some pending patches which try to fix that:
>>
>> https://patchwork.sourceware.org/project/elfutils/list/?series=3D31601
> Earlier in the thread, Hengqi Chen pointed out the latest elfutils backen=
d
> work for MIPS, and I locally rebuilt elfutils and then pahole from their
> respective next/main branches. For elfutils, main (935ee131cf7c) includes
>
>   e259f126 Support Mips architecture
>   f2acb069 stack: Fix stack unwind failure on mips
>   db33cb0c backends: Add register_info, return_value_location, core_note =
mips
>
> which partially applies the patchwork series but leaves out the support f=
or
> readelf, strip, and elflint.
>
> I believe this means the vmlinux and .ko files I shared are OK, or is the=
re
> more backend work needed for MIPS?
>
> The bits missing in eu-readelf would explain the blank output both Arnald=
o
> and I see from "$ eu-readelf -winfo vmlinux". I tried rebuilding with the
> patchwork readelf patch locally but ran into merge conflicts.
>
> CCing Ying Huang for any more insight.
>
> Thanks,
> Tony
