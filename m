Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7CC19EEA2
	for <dwarves@vger.kernel.org>; Tue, 27 Aug 2024 14:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724769430; cv=none; b=IX/gCSJCQ9ROoM7kFEFq1rgdIUq65uE5ybFjGS+sb4Fb03PdMyNR14szHvIb+xl9fEYy6HAlE3c/y1CLnv+0Ue/33OQSQ1FFQ8vN/BS4LPBesxwz26hywZn6G3U8JXXjsg6WYnYfkfRLQH2WFXDhNX18FI6As0+CP97vIwi2HMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724769430; c=relaxed/simple;
	bh=DWERGSNG6oA5czVllZVA0t/Jx+3yUnPr0e1kElluByI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FOEYhNJIRH7iK1GJLEQAq3fCRfYTv+QpAP/19Ia2C3OdQBrCWnLlhRHYHM7vlSaNM3tkvR1gRra08ZKTt5eYeqXVcLLFmeKfF6OFfMAG9ixW1X23/2ky5RjorIy8sFMAe2reaAAVR+wIqxXCGz8lSa4y06Smsf1RnxNJza1dBy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EQfHNuhy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQfHNuhy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31376C4DE08;
	Tue, 27 Aug 2024 14:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724769429;
	bh=DWERGSNG6oA5czVllZVA0t/Jx+3yUnPr0e1kElluByI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EQfHNuhyPi98Azyj4pXhZt349Y0xCZnAaYzlHmuiPsMcbAsWP62qdwtrSXYyrHX2G
	 cVm8/oFBahRQ+mKLX/iFrvomGu22OgyWaJahx48VcBrzHpLX7YPUGHi/krqB/NgzVv
	 5VOP2efhN2knEPy5irIhjqCcBuV5r8S5vn0kWc2Eo9uD9VfsyXhL8T6QdXpBzURsOY
	 SfJFZCp4xxusbIic439u8Xi0J7TzNGW8Cnx5RFlqfzxv54DJsuOLx4N9R/7VLt8C9F
	 gTiV4wxFMT0Tzeelk9vuOeMdT8gijJm3H1Zzu4nPsLCyS1ts8AM8FqQraJXJSz+nbA
	 morDf3jl312mg==
Date: Tue, 27 Aug 2024 11:37:06 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Will Hawkins <hawkinsw@obs.cr>
Cc: dwarves@vger.kernel.org
Subject: Re: [PATCH v2 0/1] btf_loader support for subprogram linkage
Message-ID: <Zs3kkqSybsbBCwiw@x1>
References: <20240823212835.1078351-1-hawkinsw@obs.cr>
 <20240827040909.1358861-1-hawkinsw@obs.cr>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240827040909.1358861-1-hawkinsw@obs.cr>

On Tue, Aug 27, 2024 at 12:09:07AM -0400, Will Hawkins wrote:
> Thank you for the feedback on my first attempt. I believe that this
> attempt is better. Given the feedback, I
> 
> 0. Removed the incorrect use of linkage_name field;
> 1. Tried to maintain the semantics of DWARF as much as possible;
> 2. Reworked how BTF information is loaded into a new function based on
> my understanding of the semantics of BTF_FUNC_STATIC, BTF_FUNC_GLOBAL,
> and BTF_FUNC_EXTERN; and
> 3. Modified (slightly) the way functions are printed in pfunc to show
> linkage where appropriate (based, in particular, on 
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=45153#c6.
> 
> I saw that Arnaldo and Namhyung have made similar changes to the
> printing code so I hope that I am not stepping on their work (sorry if I
> am!).
> 
> Again, I appreciate the feedback and hope that I was able to address it
> with this v2.

So, I broke it down into two patches, the first for the BTF loader and
then a second patch for pfunct to use that info, but:

⬢[acme@toolbox pahole]$ readelf -wi cases/btf_linkages/linkage.o
Contents of the .debug_info section:

  Compilation Unit @ offset 0:
   Length:        0x4e (32-bit)
   Version:       5
   Unit Type:     DW_UT_compile (1)
   Abbrev Offset: 0
   Pointer Size:  8
 <0><c>: Abbrev Number: 1 (DW_TAG_compile_unit)
    <d>   DW_AT_producer    : (indirect string, offset: 0x5): GNU C17 14.1.1 20240701 (Red Hat 14.1.1-7) -mtune=generic -march=x86-64 -gbtf -g -O0
    <11>   DW_AT_language    : 29	(C11)
    <12>   DW_AT_name        : (indirect line string, offset: 0): linkage.c
    <16>   DW_AT_comp_dir    : (indirect line string, offset: 0xa): /home/acme/git/pahole/cases/btf_linkages
    <1a>   DW_AT_low_pc      : 0
    <22>   DW_AT_high_pc     : 0xb
    <2a>   DW_AT_stmt_list   : 0
 <1><2e>: Abbrev Number: 2 (DW_TAG_subprogram)
    <2f>   DW_AT_name        : x
    <31>   DW_AT_decl_file   : 1
    <32>   DW_AT_decl_line   : 6
    <33>   DW_AT_decl_column : 12
    <34>   DW_AT_type        : <0x4a>
    <38>   DW_AT_low_pc      : 0
    <40>   DW_AT_high_pc     : 0xb
    <48>   DW_AT_frame_base  : 1 byte block: 9c 	(DW_OP_call_frame_cfa)
    <4a>   DW_AT_call_all_calls: 1
 <1><4a>: Abbrev Number: 3 (DW_TAG_base_type)
    <4b>   DW_AT_byte_size   : 4
    <4c>   DW_AT_encoding    : 5	(signed)
    <4d>   DW_AT_name        : int
 <1><51>: Abbrev Number: 0

⬢[acme@toolbox pahole]$

In DWARF we don't have that DW_AT_external, so the simplified second
patch:

⬢[acme@toolbox pahole]$ git diff
diff --git a/pfunct.c b/pfunct.c
index bc3026b384284cb4..9cf61713354d178e 100644
--- a/pfunct.c
+++ b/pfunct.c
@@ -377,6 +377,9 @@ static void function__show(struct function *func, struct cu *cu)
        if (fstats && fstats->printed)
                return;
 
+       if (!func->external)
+               fprintf(stdout, "static ");
+
        if (expand_types)
                function__emit_type_definitions(func, cu, stdout);
        tag__fprintf(tag, cu, &conf, stdout);
⬢[acme@toolbox pahole]$

Would print as static, but it isn't...

⬢[acme@toolbox pahole]$ cat cases/btf_linkages/linkage.c
// https://lore.kernel.org/all/20240823212835.1078351-1-hawkinsw@obs.cr/T/#u
// Will Hawkins
// $ gcc -gbtf -g -O0 -c linkage.c
// $ ~/code/pahole/build/pfunct -Fbtf --compile linkage.o

static int x() {
	return 5;
}
⬢[acme@toolbox pahole]$

⬢[acme@toolbox pahole]$ pfunct --prototype -F btf cases/btf_linkages/linkage.o
int x(void);
⬢[acme@toolbox pahole]$


So, if instead I do it at:

⬢[acme@toolbox pahole]$ git diff
diff --git a/dwarves_fprintf.c b/dwarves_fprintf.c
index ffbe6fbd3f5c405a..9a8bb5f15c88125a 100644
--- a/dwarves_fprintf.c
+++ b/dwarves_fprintf.c
@@ -1406,6 +1406,9 @@ static size_t function__fprintf(const struct tag *tag, const struct cu *cu,
        size_t printed = 0;
        bool inlined = !conf->strip_inline && function__declared_inline(func);
 
+       if (!func->external)
+               printed += fprintf(fp, "%s ", "static");
+
        if (tag->attribute)
                printed += fprintf(fp, "%s ", tag->attribute);
 
⬢[acme@toolbox pahole]$

Then we seem to get what we want:

⬢[acme@toolbox pahole]$ pfunct --prototype -F btf cases/btf_linkages/linkage.o
static int x(void);
⬢[acme@toolbox pahole]$ pfunct --compile -F btf cases/btf_linkages/linkage.o
static int x(void)
{
	return 0;
}

⬢[acme@toolbox pahole]$ pfunct --prototype -F dwarf cases/btf_linkages/linkage.o
static int x(void);
⬢[acme@toolbox pahole]$ pfunct --prototype -F btf cases/btf_linkages/linkage.o
static int x(void);
⬢[acme@toolbox pahole]$ 

And if we add a non-static function, it also works for both DWARF and
BTF when generated by gcc:

⬢[acme@toolbox btf_linkages]$ gcc -gbtf -g -O0 -c linkage.c
⬢[acme@toolbox btf_linkages]$ cd -
/home/acme/git/pahole
⬢[acme@toolbox pahole]$ cat cases/btf_linkages/linkage.c
// https://lore.kernel.org/all/20240823212835.1078351-1-hawkinsw@obs.cr/T/#u
// Will Hawkins
// $ gcc -gbtf -g -O0 -c linkage.c
// $ ~/code/pahole/build/pfunct -Fbtf --compile linkage.o

static int x() {
	return 5;
}

int y() {
	return 4;
}
⬢[acme@toolbox pahole]$ pfunct --prototype -F btf cases/btf_linkages/linkage.o
static int x(void);
int y(void);
⬢[acme@toolbox pahole]$ pfunct --prototype -F dwarf cases/btf_linkages/linkage.o
static int x(void);
int y(void);
⬢[acme@toolbox pahole]$ pfunct --compile -F btf cases/btf_linkages/linkage.o
int y(void)
{
	return 0;
}

static int x(void)
{
	return 0;
}

⬢[acme@toolbox pahole]$ pfunct --compile -F dwarf cases/btf_linkages/linkage.o
int y(void)
{
}

static int x(void)
{
}

⬢[acme@toolbox pahole]$

But, for a vmlinux I have laying around it seems we're not encoding that
with pahole:

⬢[acme@toolbox pahole]$ pfunct --prototype -F btf vmlinux  | grep ^static | head
static void clean_cache_range(void * addr, size_t size);
static void arch_wb_cache_pmem(void * addr, size_t size);
static long int __copy_user_flushcache(void * dst, const void  * src, unsigned int size);
static void __memcpy_flushcache(void * _dst, const void  * _src, size_t size);
static long unsigned int copy_from_user_nmi(void * to, const void  * from, long unsigned int n);
static void call_depth_return_thunk(void);
static void entry_untrain_ret(void);
static void retbleed_untrain_ret(void);
static void srso_untrain_ret(void);
static void srso_alias_safe_ret(void);
⬢[acme@toolbox pahole]$ pfunct --prototype -F btf vmlinux  | grep ^static | wc -l
59015
⬢[acme@toolbox pahole]$ pfunct --prototype -F btf vmlinux  | wc -l
59015
⬢[acme@toolbox pahole]$

⬢[acme@toolbox pahole]$ pahole --btf_encode -j vmlinux 
⬢[acme@toolbox pahole]$ pfunct --prototype -F btf vmlinux  | wc -l
59650
⬢[acme@toolbox pahole]$ pfunct --prototype -F btf vmlinux  | grep ^static | wc -l
59650
⬢[acme@toolbox pahole]$ pfunct --prototype -F btf vmlinux  | grep -v ^static
⬢[acme@toolbox pahole]$

So before we change function__fprintf() we need to investigate this
other part: pahole seemingly not encoding:

+       func->declaration = BTF_INFO_VLEN(tp->info) == BTF_FUNC_EXTERN;
+       func->external = BTF_INFO_VLEN(tp->info) == BTF_FUNC_GLOBAL;

The thing is we want to release 1.28, so lets leave this for after that,
ok.

- Arnaldo
