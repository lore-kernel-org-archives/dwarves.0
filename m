Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E52214010;
	Tue,  2 Jan 2024 16:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ihok4/o1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1770C433C7;
	Tue,  2 Jan 2024 16:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704213008;
	bh=A3g6Yi5YQDvGNMpMdnIIjB6HRZJxAWywXtkajsOnf9U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ihok4/o1BaBeV6OnGsZ0XZC5stxHb1fmAj2PuQK3t0XF9CXQJW6fuqgZZwr47P1LK
	 8fipXeLR3zWtlYLa5wX/M3xSQ962YOXsMJXZUmexWtN46WRIO8CNSHndU3STj46Whs
	 1uk1jsCBKTpDKXT9KRDTdaFhTy1InMCtDEgZHkcmCft57hL78mkI49KcZ9r0d7t5ij
	 0MK0Q107NnLINDP8weuFoae7M3UChQgTGQ2AfVIBwKE+OmBpi4RlgA+1IA9Q9OxJg7
	 db1XsKH6H7/jCUzy9WjM9z6n8JVt/9eSIzSlbQEFrVqcY8UjXz8ypV0jQ3iR0WehEo
	 9XhZI+o0ErgPA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id A557C403EF; Tue,  2 Jan 2024 13:30:02 -0300 (-03)
Date: Tue, 2 Jan 2024 13:30:02 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>, Mark Wielaard <mjw@redhat.com>
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
Message-ID: <ZZQ6CpBnqpBgxSgp@kernel.org>
References: <202312192107.wMIKiZWw-lkp@intel.com>
 <20231219205348.wvvxyicaatmljxm2@moria.home.lan>
 <CAKwvOdmrvwdbFrtzsOjoLJJZ1pDZOBWBiEb=Mx5bCHuKU2wPzQ@mail.gmail.com>
 <20231219210454.GA540439@dev-arch.thelio-3990X>
 <ZYKWxl9oQXODIoNe@yujie-X299>
 <20231227224338.GA267659@dev-arch.thelio-3990X>
 <ZY2EUr+EYzyro3NH@kernel.org>
 <20231228173404.GA412881@dev-arch.thelio-3990X>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231228173404.GA412881@dev-arch.thelio-3990X>
X-Url: http://acmel.wordpress.com

Em Thu, Dec 28, 2023 at 10:34:04AM -0700, Nathan Chancellor escreveu:
> On Thu, Dec 28, 2023 at 11:21:06AM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Wed, Dec 27, 2023 at 03:43:38PM -0700, Nathan Chancellor escreveu:
> > > I do not get a segfault personally but there are definitely a lot of
> > > errors from pahole at the end. Arnaldo, is pahole not handling someth=
ing
> > > that it should with regards to clang's debug info?

> > Possibly, would it be possible to provide the vmlinux file where pahole
> > is segfaulting when trying to encode BTF from DWARF?

> > These two files:

> > vmlinux drivers/misc/eeprom/at24.ko

> > So that I can run:
> > LLVM_OBJCOPY=3D"llvm-objcopy" pahole -J --btf_gen_floats -j --lang_excl=
ude=3Drust --skip_encoding_btf_inconsistent_proto --btf_gen_optimized --btf=
_base vmlinux drivers/misc/eeprom/at24.ko
=20
> Sure, here you go:
=20
> https://1drv.ms/u/s!AsQNYeB-IEbqqAilUuGHOU8BMLbf
=20
> If you need more objects, just let me know. That series of commands in
> the previous email should also get them for you locally if you need all
> of them or want to investigate more.

llvm-dwarfdump is the only that is managing to process this file on a
fedora:39 system, more work needed to figure out if this is something
elfutils is planning to support, what amount of work would be necessary,
etc.

Mark, do you know about work on elfutils to support:

=E2=AC=A2[acme@toolbox hexagon-randconfig-r005-20220913-pahole-crash]$ llvm=
-dwarfdump at24.ko | head -22
at24.ko:        file format elf32-hexagon

=2Edebug_info contents:
0x00000000: Compile Unit: length =3D 0x0000c634, format =3D DWARF32, versio=
n =3D 0x0005, unit_type =3D DW_UT_compile, abbr_offset =3D 0x0000, addr_siz=
e =3D 0x04 (next unit at 0x0000c638)

Cheers,

- Arnaldo

=E2=AC=A2[acme@toolbox hexagon-randconfig-r005-20220913-pahole-crash]$ eu-r=
eadelf --version
eu-readelf (elfutils) 0.190
Copyright (C) 2023 The elfutils developers <http://elfutils.org/>.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
=E2=AC=A2[acme@toolbox hexagon-randconfig-r005-20220913-pahole-crash]

=E2=AC=A2[acme@toolbox hexagon-randconfig-r005-20220913-pahole-crash]$ eu-r=
eadelf -winfo at24.ko  > /dev/null
eu-readelf: DIE [c644] cannot get attribute 'addr_base' (sec_offset) value:=
 invalid offset
eu-readelf: DIE [c644] cannot get attribute 'rnglists_base' (sec_offset) va=
lue: invalid offset
eu-readelf: DIE [c644] cannot get attribute 'loclists_base' (sec_offset) va=
lue: invalid offset
eu-readelf: DIE [c674] cannot get attribute 'name' (strx2) value: invalid o=
ffset
eu-readelf: DIE [c67e] cannot get attribute 'name' (strx2) value: invalid o=
ffset
eu-readelf: DIE [c689] cannot get attribute 'type' (ref4) value: invalid DW=
ARF
eu-readelf: DIE [c697] cannot get attribute 'str_offsets_base' (sec_offset)=
 value: invalid offset
eu-readelf: DIE [c697] cannot get attribute 'stmt_list' (sec_offset) value:=
 invalid offset
eu-readelf: DIE [c697] cannot get attribute 'addr_base' (sec_offset) value:=
 invalid offset
eu-readelf: DIE [c697] cannot get attribute 'rnglists_base' (sec_offset) va=
lue: invalid offset
eu-readelf: DIE [c697] cannot get attribute 'loclists_base' (sec_offset) va=
lue: invalid offset
eu-readelf: DIE [c6bb] cannot get attribute 'type' (ref4) value: invalid DW=
ARF
eu-readelf: DIE [c6c3] cannot get attribute 'type' (ref4) value: invalid DW=
ARF
eu-readelf: DIE [c6db] cannot get attribute 'type' (ref4) value: invalid DW=
ARF
eu-readelf: DIE [c6e5] cannot get attribute 'str_offsets_base' (sec_offset)=
 value: invalid offset
eu-readelf: DIE [c6e5] cannot get attribute 'stmt_list' (sec_offset) value:=
 invalid offset
eu-readelf: DIE [c6e5] cannot get attribute 'addr_base' (sec_offset) value:=
 invalid offset
eu-readelf: DIE [c6e5] cannot get attribute 'rnglists_base' (sec_offset) va=
lue: invalid offset
eu-readelf: DIE [c6e5] cannot get attribute 'loclists_base' (sec_offset) va=
lue: invalid offset
eu-readelf: DIE [c704] cannot get attribute 'name' (strx2) value: invalid o=
ffset
eu-readelf: DIE [c70e] cannot get attribute 'name' (strx2) value: invalid o=
ffset
eu-readelf: DIE [c75c] cannot get attribute 'name' (strx2) value: invalid o=
ffset
eu-readelf: DIE [c762] cannot get attribute 'type' (ref4) value: invalid DW=
ARF
eu-readelf: DIE [c767] cannot get attribute 'type' (ref4) value: invalid DW=
ARF
eu-readelf: DIE [c773] cannot get attribute 'type' (ref4) value: invalid DW=
ARF
eu-readelf: DIE [c778] cannot get attribute 'str_offsets_base' (sec_offset)=
 value: invalid offset
eu-readelf: DIE [c778] cannot get attribute 'stmt_list' (sec_offset) value:=
 invalid offset
eu-readelf: DIE [c778] cannot get attribute 'addr_base' (sec_offset) value:=
 invalid offset
eu-readelf: DIE [c778] cannot get attribute 'rnglists_base' (sec_offset) va=
lue: invalid offset
eu-readelf: DIE [c778] cannot get attribute 'loclists_base' (sec_offset) va=
lue: invalid offset
eu-readelf: DIE [c797] cannot get attribute 'stmt_list' (sec_offset) value:=
 invalid offset
eu-readelf: DIE [c797] cannot get attribute 'addr_base' (sec_offset) value:=
 invalid offset
eu-readelf: DIE [c797] cannot get attribute 'rnglists_base' (sec_offset) va=
lue: invalid offset
eu-readelf: DIE [c7b6] cannot get attribute 'type' (ref4) value: invalid DW=
ARF
eu-readelf: DIE [c7c1] cannot get attribute 'type' (ref4) value: invalid DW=
ARF
eu-readelf: DIE [c7c6] cannot get attribute 'type' (ref4) value: invalid DW=
ARF
eu-readelf: DIE [c7cc] cannot get attribute 'type' (ref4) value: invalid DW=
ARF
eu-readelf: DIE [c7d7] cannot get attribute 'type' (ref4) value: invalid DW=
ARF
eu-readelf: cannot get tag of DIE at offset [c7de] in section '.debug_info'=
: invalid DWARF
=E2=AC=A2[acme@toolbox hexagon-randconfig-r005-20220913-pahole-crash]$


=E2=AC=A2[acme@toolbox hexagon-randconfig-r005-20220913-pahole-crash]$ read=
elf --version
GNU readelf version 2.40-13.fc39
Copyright (C) 2023 Free Software Foundation, Inc.
This program is free software; you may redistribute it under the terms of
the GNU General Public License version 3 or (at your option) any later vers=
ion.
This program has absolutely no warranty.
=E2=AC=A2[acme@toolbox hexagon-randconfig-r005-20220913-pahole-crash]$

=E2=AC=A2[acme@toolbox hexagon-randconfig-r005-20220913-pahole-crash]$ read=
elf -wi at24.ko  > /dev/null
readelf: at24.ko: Error: Missing knowledge of 32-bit reloc types used in DW=
ARF sections of machine number 164
readelf: at24.ko: Warning: unable to apply unsupported reloc type 6 to sect=
ion .debug_info
readelf: at24.ko: Warning: string index of 10 converts to an offset of 0x20=
00028 which is too big for section .debug_strreadelf: at24.ko: Warning: CU =
@ 0xc638 has multiple rnglists_base values (0x40e0000 and 0x7e09)readelf: a=
t24.ko: Warning: CU @ 0xc638 has multiple loclists_base values (0x300a102 a=
nd 0xd020800)readelf: at24.ko: Warning: CU @ 0xc638 has multiple str_offset=
s_base values 0x2000000 and 0xf000000)readelf: at24.ko: Warning: string ind=
ex of 3 converts to an offset of 0xf00000c which is too big for section .de=
bug_strreadelf: at24.ko: Warning: CU @ 0xc638 has multiple rnglists_base va=
lues (0x7e09 and 0x5104)readelf: at24.ko: Warning: CU @ 0xc638 has multiple=
 loclists_base values (0xd020800 and 0xf0000)readelf: at24.ko: Warning: CU =
@ 0xc638 has multiple str_offsets_base values 0xf000000 and 0x3000003)reade=
lf: at24.ko: Warning: string index of 33 converts to an offset of 0x3000087=
 which is too big for section .debug_strreadelf: at24.ko: Warning: CU @ 0xc=
638 has multiple rnglists_base values (0x5104 and 0x2d000312)readelf: at24.=
ko: Warning: CU @ 0xc638 has multiple loclists_base values (0xf0000 and 0xa=
2030000)readelf: at24.ko: Warning: CU @ 0xc638 has multiple str_offsets_bas=
e values 0x3000003 and 0x452)readelf: at24.ko: Warning: CU @ 0xc638 has mul=
tiple rnglists_base values (0x2d000312 and 0x3191084)readelf: at24.ko: Warn=
ing: CU @ 0xc638 has multiple loclists_base values (0xa2030000 and 0x457)re=
adelf: at24.ko: Warning: DIE at offset 0xc7de refers to abbreviation number=
 5568 which does not exist
readelf: at24.ko: Warning: loc_offset 0 too big
readelf: at24.ko: Warning: loc_offset 1 too big
readelf: at24.ko: Warning: loc_offset 2 too big
readelf: at24.ko: Warning: loc_offset 3 too big
readelf: at24.ko: Warning: loc_offset 4 too big
readelf: at24.ko: Warning: loc_offset 5 too big
readelf: at24.ko: Warning: loc_offset 6 too big
readelf: at24.ko: Warning: loc_offset 7 too big
readelf: at24.ko: Warning: loc_offset 8 too big
readelf: at24.ko: Warning: loc_offset 9 too big
readelf: at24.ko: Warning: loc_offset 10 too big
readelf: at24.ko: Warning: loc_offset 11 too big
readelf: at24.ko: Warning: loc_offset 12 too big
readelf: at24.ko: Warning: loc_offset 13 too big
readelf: at24.ko: Warning: loc_offset 14 too big
readelf: at24.ko: Warning: loc_offset 15 too big
readelf: at24.ko: Warning: loc_offset 16 too big
readelf: at24.ko: Warning: loc_offset 17 too big
readelf: at24.ko: Warning: loc_offset 18 too big
readelf: at24.ko: Warning: loc_offset 19 too big
readelf: at24.ko: Warning: loc_offset 20 too big
readelf: at24.ko: Warning: loc_offset 21 too big
readelf: at24.ko: Warning: loc_offset 22 too big
readelf: at24.ko: Warning: loc_offset 23 too big
readelf: at24.ko: Warning: loc_offset 24 too big
readelf: at24.ko: Warning: loc_offset 27 too big
readelf: at24.ko: Warning: loc_offset 28 too big
readelf: at24.ko: Warning: loc_offset 29 too big
readelf: at24.ko: Warning: loc_offset 30 too big
readelf: at24.ko: Warning: loc_offset 31 too big
readelf: at24.ko: Warning: loc_offset 32 too big
readelf: at24.ko: Warning: loc_offset 33 too big
readelf: at24.ko: Warning: loc_offset 34 too big
readelf: at24.ko: Warning: loc_offset 35 too big
readelf: at24.ko: Warning: loc_offset 41 too big
readelf: at24.ko: Warning: loc_offset 40 too big
readelf: at24.ko: Warning: loc_offset 36 too big
readelf: at24.ko: Warning: loc_offset 37 too big
readelf: at24.ko: Warning: loc_offset 38 too big
readelf: at24.ko: Warning: loc_offset 39 too big
readelf: at24.ko: Warning: loc_offset 46 too big
readelf: at24.ko: Warning: loc_offset 45 too big
readelf: at24.ko: Warning: loc_offset 44 too big
readelf: at24.ko: Warning: loc_offset 47 too big
readelf: at24.ko: Warning: loc_offset 48 too big
readelf: at24.ko: Warning: loc_offset 49 too big
readelf: at24.ko: Warning: loc_offset 50 too big
readelf: at24.ko: Warning: loc_offset 51 too big
readelf: at24.ko: Warning: loc_offset 52 too big
readelf: at24.ko: Warning: loc_offset 53 too big
readelf: at24.ko: Warning: loc_offset 54 too big
readelf: at24.ko: Warning: loc_offset 55 too big
readelf: at24.ko: Warning: loc_offset 56 too big
readelf: at24.ko: Warning: loc_offset 57 too big
readelf: at24.ko: Warning: loc_offset 58 too big
readelf: at24.ko: Warning: loc_offset 59 too big
readelf: at24.ko: Warning: loc_offset 60 too big
readelf: at24.ko: Warning: loc_offset 61 too big
readelf: at24.ko: Warning: loc_offset 66 too big
readelf: at24.ko: Warning: loc_offset 65 too big
readelf: at24.ko: Warning: Unable to resolve ref form: uvalue ce020c0b + cu=
_offset c638 > CU size 1003e
readelf: at24.ko: Warning: string index of 35340 converts to an offset of 0=
x22830 which is too big for section .debug_strreadelf: at24.ko: Warning: Un=
able to resolve ref form: uvalue 50000 + cu_offset c638 > CU size 1003e
readelf: at24.ko: Warning: string index of 40463 converts to an offset of 0=
x2783c which is too big for section .debug_strreadelf: at24.ko: Warning: Un=
able to resolve ref form: uvalue 50000 + cu_offset c638 > CU size 1003e
readelf: at24.ko: Warning: string index of 10 converts to an offset of 0x20=
00028 which is too big for section .debug_strreadelf: at24.ko: Warning: Off=
set into section .debug_rnglists too big: 0x40e0008
readelf: at24.ko: Warning: CU @ 0xc638 has multiple rnglists_base values (0=
x40e0000 and 0x7e09)readelf: at24.ko: Warning: CU @ 0xc638 has multiple loc=
lists_base values (0x300a102 and 0xd020800)readelf: at24.ko: Warning: strin=
g index of 0 converts to an offset of 0x2000000 which is too big for sectio=
n .debug_strreadelf: at24.ko: Warning: Unable to resolve ref form: uvalue 9=
a0c + cu_offset c638 > CU size 1003e
readelf: at24.ko: Warning: string index of 154 converts to an offset of 0x2=
000268 which is too big for section .debug_strreadelf: at24.ko: Warning: st=
ring index of 2 converts to an offset of 0x2000008 which is too big for sec=
tion .debug_strreadelf: at24.ko: Warning: string index of 0 converts to an =
offset of 0x2000000 which is too big for section .debug_strreadelf: at24.ko=
: Warning: CU @ 0xc638 has multiple str_offsets_base values 0x2000000 and 0=
xf000000)readelf: at24.ko: Warning: string index of 3 converts to an offset=
 of 0xf00000c which is too big for section .debug_strreadelf: at24.ko: Warn=
ing: Offset into section .debug_rnglists too big: 0x7e19
readelf: at24.ko: Warning: CU @ 0xc638 has multiple rnglists_base values (0=
x7e09 and 0x5104)readelf: at24.ko: Warning: CU @ 0xc638 has multiple loclis=
ts_base values (0xd020800 and 0xf0000)readelf: at24.ko: Warning: string ind=
ex of 35340 converts to an offset of 0xf022830 which is too big for section=
 .debug_strreadelf: at24.ko: Warning: Unable to resolve ref form: uvalue 50=
000 + cu_offset c638 > CU size 1003e
readelf: at24.ko: Warning: string index of 57615 converts to an offset of 0=
xf03843c which is too big for section .debug_strreadelf: at24.ko: Warning: =
Unable to resolve ref form: uvalue 50000 + cu_offset c638 > CU size 1003e
readelf: at24.ko: Warning: string index of 18 converts to an offset of 0xf0=
00048 which is too big for section .debug_strreadelf: at24.ko: Warning: str=
ing index of 19 converts to an offset of 0xf00004c which is too big for sec=
tion .debug_strreadelf: at24.ko: Warning: string index of 253 converts to a=
n offset of 0xf0003f4 which is too big for section .debug_strreadelf: at24.=
ko: Warning: string index of 768 converts to an offset of 0xf000c00 which i=
s too big for section .debug_strreadelf: at24.ko: Warning: string index of =
20 converts to an offset of 0xf000050 which is too big for section .debug_s=
trreadelf: at24.ko: Warning: string index of 253 converts to an offset of 0=
xf0003f4 which is too big for section .debug_strreadelf: at24.ko: Warning: =
string index of 0 converts to an offset of 0xf000000 which is too big for s=
ection .debug_strreadelf: at24.ko: Warning: string index of 1 converts to a=
n offset of 0xf000004 which is too big for section .debug_strreadelf: at24.=
ko: Warning: string index of 45583 converts to an offset of 0xf02c83c which=
 is too big for section .debug_strreadelf: at24.ko: Warning: string index o=
f 854 converts to an offset of 0xf000d58 which is too big for section .debu=
g_strreadelf: at24.ko: Warning: string index of 4 converts to an offset of =
0xf000010 which is too big for section .debug_strreadelf: at24.ko: Warning:=
 string index of 138 converts to an offset of 0xf000228 which is too big fo=
r section .debug_strreadelf: at24.ko: Warning: CU @ 0xc638 has multiple str=
_offsets_base values 0xf000000 and 0x3000003)readelf: at24.ko: Warning: str=
ing index of 33 converts to an offset of 0x3000087 which is too big for sec=
tion .debug_strreadelf: at24.ko: Warning: Offset into section .debug_rnglis=
ts too big: 0x5110
readelf: at24.ko: Warning: CU @ 0xc638 has multiple rnglists_base values (0=
x5104 and 0x2d000312)readelf: at24.ko: Warning: CU @ 0xc638 has multiple lo=
clists_base values (0xf0000 and 0xa2030000)readelf: at24.ko: Warning: strin=
g index of 124 converts to an offset of 0x30001f3 which is too big for sect=
ion .debug_strreadelf: at24.ko: Warning: string index of 3 converts to an o=
ffset of 0x300000f which is too big for section .debug_strreadelf: at24.ko:=
 Warning: CU @ 0xc638 has multiple str_offsets_base values 0x3000003 and 0x=
452)readelf: at24.ko: Warning: Offset into section .debug_rnglists too big:=
 0x2d000312
readelf: at24.ko: Warning: CU @ 0xc638 has multiple rnglists_base values (0=
x2d000312 and 0x3191084)readelf: at24.ko: Warning: CU @ 0xc638 has multiple=
 loclists_base values (0xa2030000 and 0x457)readelf: at24.ko: Warning: DIE =
at offset 0xc7de refers to abbreviation number 5568 which does not exist
=E2=AC=A2[acme@toolbox hexagon-randconfig-r005-20220913-pahole-crash]$


But:

=E2=AC=A2[acme@toolbox hexagon-randconfig-r005-20220913-pahole-crash]$ llvm=
-dwarfdump --version
LLVM (http://llvm.org/):
  LLVM version 17.0.6
  Optimized build.
=E2=AC=A2[acme@toolbox hexagon-randconfig-r005-20220913-pahole-crash]$ llvm=
-dwarfdump at24.ko > /dev/null
=E2=AC=A2[acme@toolbox hexagon-randconfig-r005-20220913-pahole-crash]$

=E2=AC=A2[acme@toolbox hexagon-randconfig-r005-20220913-pahole-crash]$ llvm=
-dwarfdump at24.ko | head -22
at24.ko:	file format elf32-hexagon

=2Edebug_info contents:
0x00000000: Compile Unit: length =3D 0x0000c634, format =3D DWARF32, versio=
n =3D 0x0005, unit_type =3D DW_UT_compile, abbr_offset =3D 0x0000, addr_siz=
e =3D 0x04 (next unit at 0x0000c638)

0x0000000c: DW_TAG_compile_unit
              DW_AT_producer	("ClangBuiltLinux clang version 16.0.6 (https:=
//github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)")
              DW_AT_language	(DW_LANG_C11)
              DW_AT_name	("/home/nathan/cbl/src/linux/drivers/misc/eeprom/a=
t24.c")
              DW_AT_str_offsets_base	(0x00000008)
              DW_AT_stmt_list	(0x00000000)
              DW_AT_comp_dir	("/mnt/nvme/tmp/build/linux")
              DW_AT_low_pc	(0x00000000)
              DW_AT_ranges	(indexed (0x8) rangelist =3D 0x00000090
                 [0x00000000, 0x00000058)
                 [0x00000000, 0x00000014)
                 [0x00000000, 0x000008a8))
              DW_AT_addr_base	(0x00000008)
              DW_AT_rnglists_base	(0x0000000c)
              DW_AT_loclists_base	(0x0000000c)

0x0000002b:   DW_TAG_variable
=E2=AC=A2[acme@toolbox hexagon-randconfig-r005-20220913-pahole-crash]$
