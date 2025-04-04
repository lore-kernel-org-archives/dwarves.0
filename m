Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BD7145B25
	for <dwarves@vger.kernel.org>; Fri,  4 Apr 2025 19:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743794549; cv=none; b=FrC3ESnptYPLrt/rMsvvQvIqVlsdBaiOv6xCKzm4R7r228tuC551cFK8Exw0yvpNu/BQ/SsO7CavWOEuxmp3QW3U+bGXHfgigdbFbMccuoFFaqJZKGdXOi5UusTyu2pHcnqk7u5c7RvxjHkMsKyEnCUAQ5grFEAbcPgptE5shNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743794549; c=relaxed/simple;
	bh=hmBFvTwpXaadBV0cEKYb+ms4GkpJXZ2qjHhJGpKZ12Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XnZwDVvA5p7muJaqztX6JneL85+pUnswH1woMcTFqkEGWpTAaB/8UtEsILjissWKMnOEjAof27xDARop4L1owPilhtzcf9Ugg1riDEWmGyV6tPVYfJsn8aH/5nAxboTRr48gH5+pkuTpAW0aSQ9lbUJc4RPfUMF9RgkkoXUs5Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rDb84mpT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rDb84mpT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D2BEC4CEDD;
	Fri,  4 Apr 2025 19:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743794549;
	bh=hmBFvTwpXaadBV0cEKYb+ms4GkpJXZ2qjHhJGpKZ12Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rDb84mpTOtktMjAFHIeKpuwBrdzLroJsSvKcWkyja0xBYzXuyeuf1JKnqT+LtKLki
	 0PQvf3KVydEwZWkCvVAV0X2HnwiyYHuuzXzUVQcqY//GGrs05L4aDBfMNNEws/UB+z
	 NegfBVMSoqW4y/1TygWY3z++8FIA86tCX/lU3U4Caed+kt2jXOKyCuJy2vVSkbkK56
	 s+X7q7/MRXT9PgmXWjibcXYyWlVKzdjL/jCfkMLLhYN5/NYaVb9OE6MpiC7za8RrGC
	 lufelrnEmbhP23cIY/CUDuEcPKtCM9FaTyo0Hx0gnlou4l4tz1sUifOvtte6nDrrTz
	 X6WwOVrIlzM6w==
Date: Fri, 4 Apr 2025 16:22:25 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: dwarves@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH 1/1] pahole: When trying to encode BTF avoid DWARF less
 files
Message-ID: <Z_AxcUKWM1xtdgyb@x1>
References: <Z-2fij_hUUFYF-YQ@x1>
 <a86ffc25-fdbc-4f6a-9579-aff59400d677@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a86ffc25-fdbc-4f6a-9579-aff59400d677@oracle.com>

On Thu, Apr 03, 2025 at 07:40:19PM +0100, Alan Maguire wrote:
> On 02/04/2025 21:35, Arnaldo Carvalho de Melo wrote:
> > +	// Right now encoding BTF has to be from DWARF, so enforce that, otherwise
> > +	// the loading process can fall back to other formats, BTF being the case
> > +	// and as this is at this point unintended, avoid that.
> > +	// Next we need to just skip object files that don't have the format we
> > +	// expect as the source for BTF encoding, i.e. no DWARF, no BTF, no problema.
> > +	if (btf_encode && conf_load.format_path == NULL)
> > +		conf_load.format_path = "dwarf";

> >  	if (show_running_kernel_vmlinux) {
> >  		const char *vmlinux = vmlinux_path__find_running_kernel();
 
> LGTM
 
> Acked-by: Alan Maguire <alan.maguire@oracle.com>

> In the same spirit, should we error out if the format path is explicitly
> set to anything other than DWARF for now when btf_encode is set?

Probably, but I focused just on this part as I'm trying to follow up on
an idea I described to folks about doing the BTF encoding right after
the .o file is generated, to try and exploit all being in memory and the
natural parallelism of the kernel build process.

If DWARF isn't asked for, which some developers do to avoid having tons
of things hitting the disk, then this gets discarded right away, the
kernel build patch I have right now is super simple and doesn't trow
away DWARF yet:

acme@x1:~/git/linux$ git diff
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 4d543054f72356a4..02a595b82b299151 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -313,7 +313,7 @@ cmd_ld_single = $(if $(objtool-enabled)$(is-single-obj-m), ; $(LD) $(ld_flags) -
 endif
 
 quiet_cmd_cc_o_c = CC $(quiet_modtag)  $@
-      cmd_cc_o_c = $(CC) $(c_flags) -c -o $@ $< \
+      cmd_cc_o_c = $(CC) $(c_flags) -c -o $@ $< && ${PAHOLE} --btf_encode ${PAHOLE_FLAGS} $@ \
                $(cmd_ld_single) \
                $(cmd_objtool)
 
acme@x1:~/git/linux$

With a the above patch and the following:

acme@x1:~/git/pahole$ git show
commit ee3e75da682eb6bcc191127ea4324677ca2ab7c4 (HEAD -> master)
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Thu Apr 3 15:28:35 2025 -0300

    pahole: Don't fail if no DWARF is available when encoding BTF, just skip
    
    While building the kernel there are a few files that have no DWARF and
    thus needs to get skipped while doing early BTF generation, i.e. per .o
    file instead of vmlinux. Things like arch/x86/purgatory/purgatory.c.
    
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/pahole.c b/pahole.c
index f34e1ecd5542c245..59b7418e3eff89e5 100644
--- a/pahole.c
+++ b/pahole.c
@@ -3609,6 +3609,11 @@ try_sole_arg_as_class_names:
 
        err = cus__load_files(cus, &conf_load, argv + remaining);
        if (err != 0) {
+               if (btf_encode && strcmp(conf_load.format_path, "dwarf") == 0) {
+                       // Assume no DWARF is available and thus just skip this object file
+                       goto out_ok;
+               }
+
                if (class_name == NULL && !btf_encode && !ctf_encode) {
                        class_name = argv[remaining];
 
acme@x1:~/git/pahole$ 

I end up with a vmlinux.o that has .BTF file that combines all the .BTF
for the .o files that comprise vmlinux and then the next step is to use
some --btf_feature=dedup_archive that will basically notice that no
DWARF to BTF is needed, just make btf_parse_elf() to see that the .BTF
section is bigger than what its in the btf_header and then go on in a
loop using btf__add_btf() to go on merging all BTFs to then do the
dedup.

This process is kinda what will happen when gcc -gbtf takes place, i.e.
its generated by the compiler, then after the linker merges all of the
.BTF files (as it does with my patches) it will do the dedup, be it in
the linker, compiler or using libbpf or libctf or whatever other method.

So doing it now is paving the way for this future and may end up
speeding up building kernels while we wait for the whole cc+ld doing it
gets in place and is dependable.

There are issues with the above that needs to be addressed after we have
some basic stuff in place, which I'm getting to, but lets see if I (or
somebody else with less distractions tham myself) do it.

Some numbers:

acme@x1:~/git/pahole$ readelf -SW ../build/v6.14.0+/vmlinux.o  | grep .BTF
  [125] .BTF_ids          PROGBITS        0000000000000000 2a701f8 001178 00   A  0   0  1
  [253] .BTF              PROGBITS        0000000000000000 3ac86c8 15b07fe1 00      0   0  1
acme@x1:~/git/pahole$

363.888.609

acme@number:~$ ls -lah /sys/kernel/btf/vmlinux 
-r--r--r--. 1 root root 6.466.451 Apr  4 14:49 /sys/kernel/btf/vmlinux
acme@number:~$

Way more, as its not deduped, if we ask pahole to pretty print it, it
will see just the first BTF header:

acme@x1:~/git/pahole$ pahole -F btf ../build/v6.14.0+/vmlinux.o | wc -l
12080
acme@x1:~/git/pahole$ pahole -F dwarf ../build/v6.14.0+/vmlinux.o | wc -l
167204
acme@x1:~/git/pahole$

I.e. not dedup'ed

For builds without CONFIG_DEBUG_INFO=y, just with
CONFIG_DEBUG_INFO_BTF=y, which isn't possible now, but should be for
people not wanting DWARF, when using a compiler that doesn't produce BTF
for vmlinux (or produces bad BTF and you want to avoid it, a transition,
point in time situation), this:

-      cmd_cc_o_c = $(CC) $(c_flags) -c -o $@ $< \
+      cmd_cc_o_c = $(CC) $(c_flags) -c -o $@ $< && ${PAHOLE} --btf_encode ${PAHOLE_FLAGS} $@ \

should additionally strip DWARF after --btf_encode.

- Arnaldo
