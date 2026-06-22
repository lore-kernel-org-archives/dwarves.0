Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C333344D8C;
	Mon, 22 Jun 2026 20:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782159411; cv=none; b=uR3Lm2cgOAOTsktkBliL8Kr3OxxxIK39ujc85eIEqBsEK0aKc6Fzi0mjDp3beyf4oGCd2z+Y6KD9uv2fKcegnZjUV1608fxxWoGR9BRxDIG/tBP0HdVUM2j0Gv1189qZYO95G0SBLTBVSTZJeprdlgdsbWhx1RQgImwmegEkPVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782159411; c=relaxed/simple;
	bh=cN6JyDFhhoyr/lqgNsS0BxnTKr8R3l1FkMwTMo2dn1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k5lH+koXjM5QkkQgpxZIuuehe6MwlsXG05FyJUxn6RK9MEztbV8SyZfe6S+480lqWgcKHrOgh9+z5x4kk9SP/WUksAwM0hbB03rdDYge4mIyxXNDuKXymgiOhPZPHbxss3ZnN4/6uPg7YZsoh0QsFrbCiHFW7aDwzk6tdqzCPX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J8XxD8ji; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J8XxD8ji"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 790D91F000E9;
	Mon, 22 Jun 2026 20:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782159410;
	bh=uTO8sfivc1pilKc+r6OItCPUGJXwZUuhGbmjBbYKado=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=J8XxD8jigOcw+u3GU8lXelyCcTu2OxzOkoykOo0+GCBUE5lPK0bxNLbkAuJcSGr7Z
	 O68yoaNkuWUjP5z5t0dVqc5yanQzKFlBmINN/Dh5l/4OJ7o8rwgbAmVXtUW0vhhYak
	 3FhQmPsl59cxkkNJJD3itI3bkEhQmMi4LJ3SZoJkIfpCVaozbV6FPAW/M2AfnuTK9b
	 TY5+REH4zwLjFX44Ilrvu8IcTAMqnOgjzqgvFwLoN7WTur4s5RpjyEmGX/Dx/m4V16
	 6CsatFyAcPj2rR4QO7YzIUO7G777uV1Yrzr+hBowb1FWwl8u6kkIVL/Hb7MG8LoA61
	 B4ybjiYvz/8RA==
Date: Mon, 22 Jun 2026 17:16:46 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Alan Maguire <alan.maguire@oracle.com>, sashiko@lists.linux.dev,
	dwarves@vger.kernel.org
Subject: Re: Sashiko reviews for pahole: missing custom_remotes
Message-ID: <ajmYLrz2qbUoRx8k@x1>
References: <ajWY48GyZXw0aMDx@x1>
 <02DBCD93-1189-4EFE-875D-25B22EF1657A@linux.dev>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <02DBCD93-1189-4EFE-875D-25B22EF1657A@linux.dev>

On Mon, Jun 22, 2026 at 12:18:10PM -0700, Roman Gushchin wrote:
> Hi Arnaldo,
> 
> Sashiko is not really officially supporting a non-kernel code yet. It might work occasionally,
> but I can’t guarantee anything and results might be pathetic.

I'm using it locally with great results, using:

acme@number:~/git/sashiko$ cat Settings.toml | grep -B1 -A3 'dwarves\|pahole'
[mailing_lists]
track = ["linux-kernel", "dwarves"]

[nntp]
server = "nntp.lore.kernel.org"
--
[[git.custom_remotes]]
name = "pahole"
url = "git://git.kernel.org/pub/scm/devel/pahole/pahole.git"
check_all_branches = false
only_branches = ["next", "master"]

acme@number:~/git/sashiko$

Submitting series to sashiko with:

$ sashiko-cli submit FIRST_SHA^..LAST_SHA --repo /home/acme/git/pahole

With great results, for instance:

acme@number:~$ sashiko-cli show 132 | head -100
Patchset Details:
  ID:        132
  Subject:   dwarf_loader: Initial support for DW_TAG_variant_part
  Author:    Arnaldo Carvalho de Melo <acme@redhat.com>
  Status:    Failed
  Date:      2026-06-20 11:23:54

Patches (16):
  [1] dwarf_loader: Initial support for DW_TAG_variant_part (Reviewed) [Issues Found] {cache: 1322/2592 hits, 16.5M tokens saved}
  [2] dwarf_loader: Allow forcing the merge of CUs for solving inter CU tag references (Reviewed) [Reviewed] {cache: 1321/2567 hits, 16.5M tokens saved}
  [3] dwarf_loader: Initial support for DW_TAG_subprogram in DW_TAG_enumeration (Reviewed) [Issues Found] {cache: 1324/2542 hits, 16.5M tokens saved}
  [4] encoders: Fix diagnostic messages for unexpected tags in enumerations (Reviewed) [Reviewed] {cache: 818/1833 hits, 10.0M tokens saved}
  [5] dwarves_fprintf: Accumulate function__fprintf return value in enumeration printing (Failed) [Failed] {cache: 309/401 hits, 3.8M tokens saved}
  [6] dwarves: Use tag__delete for enumeration children (Reviewed) [Reviewed] {cache: 1325/2534 hits, 16.5M tokens saved}
  [7] btf_encoder: Fix types__match parameter comparison in BTF_KIND_FUNC_PROTO (Reviewed) [Reviewed] {cache: 508/1429 hits, 6.1M tokens saved}
  [8] encoders: Handle DW_TAG_subprogram in enumerations during BTF/CTF encoding (Reviewed) [Reviewed] {cache: 64/624 hits, 719.8k tokens saved}
  [9] dwarf_loader: Populate DW_TAG_variant children in DW_TAG_variant_part (Reviewed) [Issues Found] {cache: 1325/2570 hits, 16.5M tokens saved}
  [10] btf_encoder: Encode variant parts as union members in BTF (Reviewed) [Reviewed] {cache: 965/2027 hits, 11.9M tokens saved}
  [11] dwarf_loader: Handle DW_FORM_block in attr_numeric for Rust discriminant values (Reviewed) [Issues Found] {cache: 1325/2614 hits, 16.5M tokens saved}
  [12] dwarf_loader: Support DW_TAG_imported_unit for same-file partial units (Reviewed) [Issues Found] {cache: 1320/2550 hits, 16.5M tokens saved}
  [13] dwarf_loader: Fix cus__merging_cu failing to detect DW_FORM_ref_addr (Reviewed) [Reviewed] {cache: 274/1071 hits, 3.2M tokens saved}
  [14] tests: Add inter-CU type reference comparison test (Reviewed) [Reviewed] {cache: 280/1097 hits, 3.2M tokens saved}
  [15] tests: Guard cleanup() against empty outdir to prevent rm /* (Reviewed) [Reviewed] {cache: 1233/2356 hits, 15.5M tokens saved}
  [16] tests: Source test_lib.sh via dirname so tests run from any directory (Failed) [Failed] {cache: 322/405 hits, 4.2M tokens saved}

Cache: 14035/29212 hits (48.0%), 174.2M tokens saved, 530.8M tokens stored

Review Summary:
  Model:   gemini-3.1-pro-preview

Patch 1: dwarf_loader: Initial support for DW_TAG_variant_part
Critical: 0 · High: 0 · Medium: 0 · Low: 1

  [Low] 

commit 3d23ae0089bbe7cda5b12c12f58ad92e02812f2b
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: dwarf_loader: Initial support for DW_TAG_variant_part

This commit adds initial scaffolding for parsing DW_TAG_variant_part entries
from Rust DWARF. The goal is to allow perf to process Rust workloads and test
pahole's pretty printing features.

> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index 8ce34cbb8ed60aca..438ebd52893fdb8f 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -508,6 +508,8 @@ static void tag__init(struct tag *tag, struct cu *cu, Dwarf_Die *die)
>  
>  	if (tag->tag == DW_TAG_imported_module || tag->tag == DW_TAG_imported_declaration)
>  		dwarf_tag__set_attr_type(dtag, type, die, DW_AT_import);
> +	else if (tag->tag == DW_TAG_variant_part)
> +		dwarf_tag__set_attr_type(dtag, type, die, DW_AT_discr);
>  	else
>  		dwarf_tag__set_attr_type(dtag, type, die, DW_AT_type);
>  

[ ... ]

> @@ -2085,9 +2099,19 @@ static int die__process_class(Dwarf_Die *die, struct type *class,
>  		case DW_TAG_GNU_template_template_param:
>  #endif
>  		case DW_TAG_subrange_type: // XXX: ADA stuff, its a type tho, will have other entries referencing it...
> -		case DW_TAG_variant_part: // XXX: Rust stuff
>  			tag__print_not_supported(die);
>  			continue;
> +		case DW_TAG_variant_part: {
> +			struct variant_part *vpart = variant_part__new(die, cu, conf);
> +
> +			if (vpart == NULL)
> +				return -ENOMEM;
> +
> +			// For rust it seems we have just one, but DWARF, according to Gemini, support having
> +			// more than one DW_TAG_variant_part for a given DW_TAG_structure_type, so future proof it
> +			type__add_variant_part(class, vpart);

[Severity: Low]
Are we missing a call to cu__table_add_tag() here before adding the
variant part?

Since variant_part tags are not added to the CU's tags table, they will be
skipped entirely during type recoding in cu__recode_dwarf_types(). This
leaves the DW_AT_discr attribute extracted earlier in tag__init() as a
raw DIE offset rather than a valid small_id, which makes the extracted
discriminant unusable.

> +			continue;
> +		}
>  		case DW_TAG_template_type_parameter: {

Patch 2: dwarf_loader: Allow forcing the merge of CUs for solving inter CU tag references
Critical: 0 (2) · High: 0 · Medium: 0 · Low: 0

  [Critical] 
  [Critical] 

commit 72c660e79f1db109e3466377d4d7f2ea187787f4
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

dwarf_loader: Allow forcing the merge of CUs for solving inter CU tag references

thread 'main' (127686) panicked at library/std/src/io/stdio.rs:1165:9:
failed printing to stdout: Broken pipe (os error 32)
note: run with `RUST_BACKTRACE=1` environment variable to display a backtrace
acme@number:~

Etc.

> We might explore adding support for more project going forward, but we’re not there yet.

Your call, but just as a data point, its being useful for me for pahole
development and I bet other pahole developers would like having it
enabled, since it seems to be useful with the current sashiko codebase.

- Arnaldo
 
> Thanks
> 
> > On Jun 19, 2026, at 12:30 PM, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > 
> > ﻿Hi Roman,
> > 
> >    The dwarves@vger.kernel.org mailing list is being tracked:
> > 
> > https://sashiko.dev/#/?list=org.kernel.vger.dwarves
> > 
> >    But all the patches for pahole are failing to apply, I think we
> > need to have the second hunk applied, the first should be there as it is
> > being tracked, can you please take a look and fix this?
> > 
> > Thanks,
> > 
> > - Arnaldo
> > 
> > diff --git a/Settings.toml b/Settings.toml
> > index 61978b51f89a0d86..666b4e8f1b7a76f3 100644
> > --- a/Settings.toml
> > +++ b/Settings.toml
> > @@ -5,7 +5,7 @@ url = "sashiko.db"
> > token = ""
> > 
> > [mailing_lists]
> > -track = ["linux-kernel"]
> > +track = ["linux-kernel", "dwarves"]
> > 
> > [nntp]
> > server = "nntp.lore.kernel.org"
> > @@ -104,6 +104,12 @@ port = 8080
> > repository_path = "third_party/linux"
> > 
> > # Track custom remotes and attempt to apply patches on their branches
> > +[[git.custom_remotes]]
> > +name = "pahole"
> > +url = "git://git.kernel.org/pub/scm/devel/pahole/pahole.git"
> > +check_all_branches = false
> > +only_branches = ["next", "master"]
> > +
> > # [[git.custom_remotes]]
> > # name = "remote-name"
> > # url = "git://my-custom.com/remote"
