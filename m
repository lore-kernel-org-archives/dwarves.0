Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB331F943
	for <dwarves@vger.kernel.org>; Tue, 27 Aug 2024 21:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724793337; cv=none; b=gtZmVok+sg81lJsB5iqJjvEq8u8HxXXOY7C1TFoHYCYwOB8/yeQuPvPzVQmUAG1yPF9z5EYY0juFaFVMBGGSaMjMxiP8wSknDPab1wv5PKPpC7GVyp20GPeOhlf6pYoJHX4pL35YmVfsEgR0TsIKcZW+vnozywgnQ1Mp8ch1HKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724793337; c=relaxed/simple;
	bh=Jq6HNRy4ktdeWPZfErgUhasXNVm4olkUxso4SNkoz+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jQne/BbwZZJn4z3RG/AKKGkbM2odNCSX78Mz+ltK0Ao6DMLhNhNgpaYPIGkBc4ZWAO/Ox2JMGP3gu3aJ34KJsLOxNiJ72IzMdmep43L2JJZzWktxcanlIzfS/zI7xW0JuneHj++MDSrSh+hfqTh0SosdfuxDZoC74e/xOKtSv9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=obs.cr; spf=none smtp.mailfrom=obs.cr; dkim=pass (2048-bit key) header.d=obs-cr.20230601.gappssmtp.com header.i=@obs-cr.20230601.gappssmtp.com header.b=Hf3d1cWh; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=obs.cr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=obs.cr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=obs-cr.20230601.gappssmtp.com header.i=@obs-cr.20230601.gappssmtp.com header.b="Hf3d1cWh"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e179c28f990so5016320276.0
        for <dwarves@vger.kernel.org>; Tue, 27 Aug 2024 14:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=obs-cr.20230601.gappssmtp.com; s=20230601; t=1724793334; x=1725398134; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3w8Z2MjKbjaqXOwC01qcBoUkoD19a26lYkzcpEbnHSg=;
        b=Hf3d1cWhefJ7iQHs4hFkzyTPLDittJeuMRtQxgItxUCsAirt6MW47J5mnIkNXz0P9c
         +jVCE/SjzHffASMkKaV+4BREsocW7bQ1VEI9MUhJ+oBmD7Zwb0PIib80P+Mnj9K+WW0G
         /oo11vegstmrosqicA/2+ipXAe/ZASt/Zx8WA1oD94tc93imRa2/sRszrNHYedaVhU5y
         CafESYtukj5ACRVSeLk0KsvEpQSBnJAMVqMmFxEb2L3gnoP2TkbID77lReK2z3oekgEr
         3Ba0/ZXl+FzfXR627N26g1j0rO3NB4im+UOPd42HD8PYSfTyvETeC0xob9EE1OMc+2ii
         bQ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724793334; x=1725398134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3w8Z2MjKbjaqXOwC01qcBoUkoD19a26lYkzcpEbnHSg=;
        b=CLG5SkZEDF2s2eg6uKyE2q0Ar8ygtaKO1D+zp6xVk7W9HpL2WyKz2Nzoh20R/N89F5
         wKS99H72BaRtMwwg6eS6T4UA0pgAcxwJAFmMpjpZHlMckZYGmsAg1Iy1Kn+XQ46zPfTm
         RFJK9+agQAHQ/kUGfhBK6od2Sg8yNEUIOfmuUD00h28tnajJfxtO0gWSoerfvgTfgSn8
         wl9xSZprgzvKE+0Lk/JOJWTzpUOLFB+KRUZ5BqB5/ygC9z6K+yBIVena7PM+Gutao2ey
         VCgDeRFEoID/7A0rv65lHt30SCfc3PeAoITG4Dd7ocRs59Q+Y7jmGYskkFEXvI2fes8C
         yv4Q==
X-Gm-Message-State: AOJu0Yz6Zz63hINcQ/K3gUsTYEGx1BkAUEF389iXiA9/WdXrE+yRgfHo
	202P8sZyGMXx5TxtCpsQVT+K7s3y5luWE/yE/oDWngeJJ17x+9RGb0ncoo/EePrj9BuThfuiPEk
	fPT8G6SSBOGdwrjhkrGdkY4EUZlvupfOto9xbbWm2A2yzyq9nQp4=
X-Google-Smtp-Source: AGHT+IGwIZBRCUsCXbNVobmBFZZKGxeL3RF+WHbaKYvC4BtQ8nGC24j+96VjZMiwPUPmIRq7QOnj2Dt7WdCPxMMFDGk=
X-Received: by 2002:a25:ea04:0:b0:e16:3cfc:f716 with SMTP id
 3f1490d57ef6-e17a868079fmr10765448276.57.1724793334286; Tue, 27 Aug 2024
 14:15:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823212835.1078351-1-hawkinsw@obs.cr> <20240827040909.1358861-1-hawkinsw@obs.cr>
 <Zs3kkqSybsbBCwiw@x1>
In-Reply-To: <Zs3kkqSybsbBCwiw@x1>
From: Will Hawkins <hawkinsw@obs.cr>
Date: Tue, 27 Aug 2024 17:15:23 -0400
Message-ID: <CADx9qWj7T3NJkppG0wzR_t=5HsU0x4nkm1-0+rcHG4OR-hVB4g@mail.gmail.com>
Subject: Re: [PATCH v2 0/1] btf_loader support for subprogram linkage
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: dwarves@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 10:37=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Tue, Aug 27, 2024 at 12:09:07AM -0400, Will Hawkins wrote:
> > Thank you for the feedback on my first attempt. I believe that this
> > attempt is better. Given the feedback, I
> >
> > 0. Removed the incorrect use of linkage_name field;
> > 1. Tried to maintain the semantics of DWARF as much as possible;
> > 2. Reworked how BTF information is loaded into a new function based on
> > my understanding of the semantics of BTF_FUNC_STATIC, BTF_FUNC_GLOBAL,
> > and BTF_FUNC_EXTERN; and
> > 3. Modified (slightly) the way functions are printed in pfunc to show
> > linkage where appropriate (based, in particular, on
> > https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D45153#c6.
> >
> > I saw that Arnaldo and Namhyung have made similar changes to the
> > printing code so I hope that I am not stepping on their work (sorry if =
I
> > am!).
> >
> > Again, I appreciate the feedback and hope that I was able to address it
> > with this v2.
>
> So, I broke it down into two patches, the first for the BTF loader and
> then a second patch for pfunct to use that info, but:
>
> =E2=AC=A2[acme@toolbox pahole]$ readelf -wi cases/btf_linkages/linkage.o
> Contents of the .debug_info section:
>
>   Compilation Unit @ offset 0:
>    Length:        0x4e (32-bit)
>    Version:       5
>    Unit Type:     DW_UT_compile (1)
>    Abbrev Offset: 0
>    Pointer Size:  8
>  <0><c>: Abbrev Number: 1 (DW_TAG_compile_unit)
>     <d>   DW_AT_producer    : (indirect string, offset: 0x5): GNU C17 14.=
1.1 20240701 (Red Hat 14.1.1-7) -mtune=3Dgeneric -march=3Dx86-64 -gbtf -g -=
O0
>     <11>   DW_AT_language    : 29       (C11)
>     <12>   DW_AT_name        : (indirect line string, offset: 0): linkage=
.c
>     <16>   DW_AT_comp_dir    : (indirect line string, offset: 0xa): /home=
/acme/git/pahole/cases/btf_linkages
>     <1a>   DW_AT_low_pc      : 0
>     <22>   DW_AT_high_pc     : 0xb
>     <2a>   DW_AT_stmt_list   : 0
>  <1><2e>: Abbrev Number: 2 (DW_TAG_subprogram)
>     <2f>   DW_AT_name        : x
>     <31>   DW_AT_decl_file   : 1
>     <32>   DW_AT_decl_line   : 6
>     <33>   DW_AT_decl_column : 12
>     <34>   DW_AT_type        : <0x4a>
>     <38>   DW_AT_low_pc      : 0
>     <40>   DW_AT_high_pc     : 0xb
>     <48>   DW_AT_frame_base  : 1 byte block: 9c         (DW_OP_call_frame=
_cfa)
>     <4a>   DW_AT_call_all_calls: 1
>  <1><4a>: Abbrev Number: 3 (DW_TAG_base_type)
>     <4b>   DW_AT_byte_size   : 4
>     <4c>   DW_AT_encoding    : 5        (signed)
>     <4d>   DW_AT_name        : int
>  <1><51>: Abbrev Number: 0
>
> =E2=AC=A2[acme@toolbox pahole]$
>
> In DWARF we don't have that DW_AT_external, so the simplified second
> patch:
>
> =E2=AC=A2[acme@toolbox pahole]$ git diff
> diff --git a/pfunct.c b/pfunct.c
> index bc3026b384284cb4..9cf61713354d178e 100644
> --- a/pfunct.c
> +++ b/pfunct.c
> @@ -377,6 +377,9 @@ static void function__show(struct function *func, str=
uct cu *cu)
>         if (fstats && fstats->printed)
>                 return;
>
> +       if (!func->external)
> +               fprintf(stdout, "static ");
> +
>         if (expand_types)
>                 function__emit_type_definitions(func, cu, stdout);
>         tag__fprintf(tag, cu, &conf, stdout);
> =E2=AC=A2[acme@toolbox pahole]$
>
> Would print as static, but it isn't...
>
> =E2=AC=A2[acme@toolbox pahole]$ cat cases/btf_linkages/linkage.c
> // https://lore.kernel.org/all/20240823212835.1078351-1-hawkinsw@obs.cr/T=
/#u
> // Will Hawkins
> // $ gcc -gbtf -g -O0 -c linkage.c
> // $ ~/code/pahole/build/pfunct -Fbtf --compile linkage.o
>
> static int x() {
>         return 5;
> }
> =E2=AC=A2[acme@toolbox pahole]$
>
> =E2=AC=A2[acme@toolbox pahole]$ pfunct --prototype -F btf cases/btf_linka=
ges/linkage.o
> int x(void);
> =E2=AC=A2[acme@toolbox pahole]$
>

Sorry for the trouble! I *thought* that I tested cases like these and
got results that seemed reasonable. Clearly what you got does not seem
to work. So, I will go through and test using a few different cases,
make sure that I get the right answer, then confirm with you in a
follow-up patch.

(See below)

>
> So, if instead I do it at:
>
> =E2=AC=A2[acme@toolbox pahole]$ git diff
> diff --git a/dwarves_fprintf.c b/dwarves_fprintf.c
> index ffbe6fbd3f5c405a..9a8bb5f15c88125a 100644
> --- a/dwarves_fprintf.c
> +++ b/dwarves_fprintf.c
> @@ -1406,6 +1406,9 @@ static size_t function__fprintf(const struct tag *t=
ag, const struct cu *cu,
>         size_t printed =3D 0;
>         bool inlined =3D !conf->strip_inline && function__declared_inline=
(func);
>
> +       if (!func->external)
> +               printed +=3D fprintf(fp, "%s ", "static");
> +
>         if (tag->attribute)
>                 printed +=3D fprintf(fp, "%s ", tag->attribute);
>
> =E2=AC=A2[acme@toolbox pahole]$
>
> Then we seem to get what we want:
>
> =E2=AC=A2[acme@toolbox pahole]$ pfunct --prototype -F btf cases/btf_linka=
ges/linkage.o
> static int x(void);
> =E2=AC=A2[acme@toolbox pahole]$ pfunct --compile -F btf cases/btf_linkage=
s/linkage.o
> static int x(void)
> {
>         return 0;
> }
>
> =E2=AC=A2[acme@toolbox pahole]$ pfunct --prototype -F dwarf cases/btf_lin=
kages/linkage.o
> static int x(void);
> =E2=AC=A2[acme@toolbox pahole]$ pfunct --prototype -F btf cases/btf_linka=
ges/linkage.o
> static int x(void);
> =E2=AC=A2[acme@toolbox pahole]$
>
> And if we add a non-static function, it also works for both DWARF and
> BTF when generated by gcc:
>
> =E2=AC=A2[acme@toolbox btf_linkages]$ gcc -gbtf -g -O0 -c linkage.c
> =E2=AC=A2[acme@toolbox btf_linkages]$ cd -
> /home/acme/git/pahole
> =E2=AC=A2[acme@toolbox pahole]$ cat cases/btf_linkages/linkage.c
> // https://lore.kernel.org/all/20240823212835.1078351-1-hawkinsw@obs.cr/T=
/#u
> // Will Hawkins
> // $ gcc -gbtf -g -O0 -c linkage.c
> // $ ~/code/pahole/build/pfunct -Fbtf --compile linkage.o
>
> static int x() {
>         return 5;
> }
>
> int y() {
>         return 4;
> }
> =E2=AC=A2[acme@toolbox pahole]$ pfunct --prototype -F btf cases/btf_linka=
ges/linkage.o
> static int x(void);
> int y(void);
> =E2=AC=A2[acme@toolbox pahole]$ pfunct --prototype -F dwarf cases/btf_lin=
kages/linkage.o
> static int x(void);
> int y(void);
> =E2=AC=A2[acme@toolbox pahole]$ pfunct --compile -F btf cases/btf_linkage=
s/linkage.o
> int y(void)
> {
>         return 0;
> }
>
> static int x(void)
> {
>         return 0;
> }
>
> =E2=AC=A2[acme@toolbox pahole]$ pfunct --compile -F dwarf cases/btf_linka=
ges/linkage.o
> int y(void)
> {
> }
>
> static int x(void)
> {
> }
>
> =E2=AC=A2[acme@toolbox pahole]$
>
> But, for a vmlinux I have laying around it seems we're not encoding that
> with pahole:
>
> =E2=AC=A2[acme@toolbox pahole]$ pfunct --prototype -F btf vmlinux  | grep=
 ^static | head
> static void clean_cache_range(void * addr, size_t size);
> static void arch_wb_cache_pmem(void * addr, size_t size);
> static long int __copy_user_flushcache(void * dst, const void  * src, uns=
igned int size);
> static void __memcpy_flushcache(void * _dst, const void  * _src, size_t s=
ize);
> static long unsigned int copy_from_user_nmi(void * to, const void  * from=
, long unsigned int n);
> static void call_depth_return_thunk(void);
> static void entry_untrain_ret(void);
> static void retbleed_untrain_ret(void);
> static void srso_untrain_ret(void);
> static void srso_alias_safe_ret(void);
> =E2=AC=A2[acme@toolbox pahole]$ pfunct --prototype -F btf vmlinux  | grep=
 ^static | wc -l
> 59015
> =E2=AC=A2[acme@toolbox pahole]$ pfunct --prototype -F btf vmlinux  | wc -=
l
> 59015
> =E2=AC=A2[acme@toolbox pahole]$
>
> =E2=AC=A2[acme@toolbox pahole]$ pahole --btf_encode -j vmlinux
> =E2=AC=A2[acme@toolbox pahole]$ pfunct --prototype -F btf vmlinux  | wc -=
l
> 59650
> =E2=AC=A2[acme@toolbox pahole]$ pfunct --prototype -F btf vmlinux  | grep=
 ^static | wc -l
> 59650
> =E2=AC=A2[acme@toolbox pahole]$ pfunct --prototype -F btf vmlinux  | grep=
 -v ^static
> =E2=AC=A2[acme@toolbox pahole]$
>
> So before we change function__fprintf() we need to investigate this
> other part: pahole seemingly not encoding:
>
> +       func->declaration =3D BTF_INFO_VLEN(tp->info) =3D=3D BTF_FUNC_EXT=
ERN;
> +       func->external =3D BTF_INFO_VLEN(tp->info) =3D=3D BTF_FUNC_GLOBAL=
;
>
> The thing is we want to release 1.28, so lets leave this for after that,
> ok.

Sorry -- it took me a few reads through your thorough email to
understand. I appreciate your willingness to engage with me on this
patch! If I understand correctly, you are saying that pahole may not
be encoding the BTF_FUNC* properly. So, we will need to debug that at
the same time as we add this feature.

If that is the case, then I will start to work on that!

If possible, would you be willing to send around that "bad" vmlinux?
(You can send directly to me -- I know that they are far from small).
That would help me debug and recreate what you are seeing.

Thank you again for engaging with me on this effort! I really, really
appreciate your openness! As I said, I am a huge fan of your work (I
really enjoyed your talk at DevConf in 2021)!

Will

>
> - Arnaldo
