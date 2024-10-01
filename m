Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3341CBE8E
	for <dwarves@vger.kernel.org>; Tue,  1 Oct 2024 18:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727807450; cv=none; b=dro/DW5K5+p4YvT/w7KqWSR1k+cF1O05wg0SNDtKTQYRGeoe5Vp/Eg3lZmYTU2b3aqRk3QXi/FDVEQ6l4AozYI8HlVmsmiidWR17kkA7WwZLos9SK3au8kk3Iak1OwXRlUaT8+RlaN09G+27VvoF6TEgB3lFRrd3mngXaH+9bB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727807450; c=relaxed/simple;
	bh=lRAVtriBo2lB4TIoQnzWMmBrFNL4m5Q3BoJGGM1L9n8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rqoFsq2s5Kf2XKPSJ6OuXeBMGMJhmaloTp+mEVD3ygNOLtk2sBDbfyVplpbQy57cokdDoWpMmlnTC+95XFj/Lvw1POP88h4SVc1fSKPkfxdvF0AEQrR0LIK/RLnf7taKkJSLKaGeL8oWIm3TLqRVJ7NysdguwPbkxzyeWxWJn+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kTd1Mm8n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTd1Mm8n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE8BDC4CEC6;
	Tue,  1 Oct 2024 18:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727807450;
	bh=lRAVtriBo2lB4TIoQnzWMmBrFNL4m5Q3BoJGGM1L9n8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kTd1Mm8nH62a2IiCTAHQQ53RkXQMtZhdrceT6gH4uQpBVwFnZXxUN4AlL14pYMXUa
	 C3FA3BSP8KbytT+qPfsYg6LnD0ydLmkqCduhYhxPjJq/xLzzvE4tgwZ4X05LdNtX8i
	 cEf3OSgqrbgkdfIcSBCFY9FJfcm8ISy5REuaPjc2uM3Tw+HDLb5MSs9UU5uaDeNu6T
	 Fomzxhwu1MQNdrZ2I2xVpXrZGBn186+fELSANkKCI3ggEPFZikbuUfUOxwyr5KOyli
	 5jyLNXf88pKOVul1MBeus8pew73Rhz1Wd9SBWGd/+EbU/M1Jt4J8WJOLQKyw8MwIfn
	 pbIR3Jy4FzVFg==
Date: Tue, 1 Oct 2024 15:30:45 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: dwarves@vger.kernel.org, eddyz87@gmail.com, olsajiri@gmail.com,
	shung-hsi.yu@suse.com, jirislaby@kernel.org
Subject: Re: [RFC dwarves] btf_encoder: record BTF-centric function state
 instead of DWARF-centric
Message-ID: <Zvw_1S9UMyU3GSic@x1>
References: <20240909155031.1596249-1-alan.maguire@oracle.com>
 <ZvwXmH1IR9gWQ1wZ@x1>
 <9c63aab6-bed6-4e6d-ab07-6b3b1bb89ea2@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9c63aab6-bed6-4e6d-ab07-6b3b1bb89ea2@oracle.com>

On Tue, Oct 01, 2024 at 06:11:07PM +0100, Alan Maguire wrote:
> On 01/10/2024 16:39, Arnaldo Carvalho de Melo wrote:
> > On Mon, Sep 09, 2024 at 04:50:31PM +0100, Alan Maguire wrote:
> >> When recording function information for later comparison (as we
> >> do when skipping inconsistent function descriptions), we utilize
> >> DWARF-based representations because we do not want to jump the
> >> gun and add BTF representations for functions that have inconsistent
> >> representations across CUs (and across encoders in parallel mode).
> >>
> >> So to handle this, we save info about functions, and we can then add
> >> them later once we have ensured their various representations are
> >> in fact consistent.  However to ensure that the function info
> >> is still valid, we need to specify LSK__KEEPIT for CUs, which
> >> bloats memory usage (in some cases to ~4Gb).  This is not a good
> >> approach, mea culpa.
> >>
> >> Instead, store a BTF-centric representation where we
> >>
> >> - store the number of parameters
> >> - store the BTF ids of return type and parameters
> >> - store the name of the parameters where present
> >> - store any LLVM annotation values, component idxs if present
> >>
> >> So in summary, store everything we need to add the BTF_KIND_FUNC
> >> and BTF_KIND_FUNC_PROTO and any associated annotations.  This will
> >> allow us to free CUs as we go but make it possible to add functions
> >> later.
> >>
> >> For name storage we can take advantage of the fact that
> >> BTF will avoid re-adding a name string so we btf__add_str()
> >> to add the parameter name and store the string offset instead;
> >> this prevents duplicate name storage while ensuring the parameter
> >> name is in BTF.
> >>
> >> When we cross-compare functions for consistency, do a shallow
> >> analysis akin to what was done with DWARF prototype comparisons;
> >> compare base types by name, reference types by target type,
> >> match loosely between fwds, structs and unions etc.
> >>
> >> When this is done, memory consumption peaks at 1Gb rather than
> >> ~4Gb for vmlinux generation.  Time taken appears to be approximately
> >> the same for -j1, but slightly faster for multiple threads;
> >> for example:
> >>
> >> Baseline
> >>
> >> $ time pahole -J vmlinux -j1 --btf_features=default
> >>
> >> real	0m17.268s
> >> user	0m15.808s
> >> sys	0m1.415s
> >>
> >> $ time pahole -J vmlinux -j8 --btf_features=default
> >>
> >> real	0m10.768s
> >> user	0m30.793s
> >> sys	0m4.199s
> >>
> >> With these changes:
> >>
> >> $ time pahole -J vmlinux -j1 --btf_features=default
> >>
> >> real	0m16.564s
> >> user	0m16.029s
> >> sys	0m0.492s
> >>
> >> $ time pahole -J vmlinux -j8 --btf_features=default
> >>
> >> real	0m8.332s
> >> user	0m30.627s
> >> sys	0m0.714s
> >>
> >> In terms of functions encoded, 360 fewer functions make it into
> >> BTF due to the different approach in consistency checking, but after
> >> examining these cases, they do appear to be legitimately inconsistent
> >> functions where the optimized versions have parameter mismatches
> >> with the non-optimized expectations.
> >>
> >> Mileage may vary of course, and any testing folks could do would
> >> be greatly appreciated!
> > 
> > So this is what I'm getting here:
> > 
> >   acme@x1:~/git/pahole$ pahole --running_kernel_vmlinux
> >   /usr/lib/debug/lib/modules/6.10.11-200.fc40.x86_64/vmlinux
> >   acme@x1:~/git/pahole$
> >   
> >   acme@x1:~/git/pahole$ time tests/tests 
> >     1: Validation of BTF encoding of functions; this may take some time...
> >   Matched 60956 functions exactly.
> >   Matched 205 functions with inlines.
> >   Matched 127 functions with multiple const/non-const instances.
> >   Ok
> >   Validation of skipped function logic...
> >   Validating skipped functions are absent from BTF...
> >   Skipped encoding 709 functions in BTF.
> >   Ok
> >   Validating skipped functions have incompatible return values...
> >   Found 14 functions with multiple incompatible return values.
> >   Ok
> >   Validating skipped functions have incompatible params/counts...
> >   WARN: 'irq_domain_alloc_descs()' has only one prototype; if it was subject to late optimization, pfunct may not reflect inconsistencies pahole found.
> >   Full skip message from pahole: irq_domain_alloc_descs (irq_domain_alloc_descs): skipping BTF encoding of function due to param type mismatch for param#1 cnt != virq
> > 
> > Humm:
> > 
> > acme@x1:~/git/pahole$ time pfunct --prototypes irq_domain_alloc_descs -F btf
> > int irq_domain_alloc_descs(int virq, unsigned int cnt, irq_hw_number_t hwirq, int node, const struct irq_affinity_desc  * affinity);
> > 
> > real	0m0.128s
> > user	0m0.073s
> > sys	0m0.053s
> > acme@x1:~/git/pahole$
> > 
> > acme@x1:~/git/pahole$ time pfunct --prototypes irq_domain_alloc_descs -F dwarf `pahole --running_kernel_vmlinux`
> > int irq_domain_alloc_descs(int virq, unsigned int cnt, irq_hw_number_t hwirq, int node, const struct irq_affinity_desc  * affinity);
> > 
> > real	0m1.783s
> > user	0m1.577s
> > sys	0m0.199s
> > acme@x1:~/git/pahole$ 
> > 
> > ⬢[acme@toolbox pahole]$ grep irq_domain_alloc_descs /proc/kallsyms 
> > 0000000000000000 t __pfx_irq_domain_alloc_descs.part.0
> > 0000000000000000 t irq_domain_alloc_descs.part.0
> > 0000000000000000 T __pfx_irq_domain_alloc_descs
> > 0000000000000000 T irq_domain_alloc_descs
> > ⬢[acme@toolbox pahole]$
> > 
> > So it is inlined:
> > 
> >  <1><1c21f2f>: Abbrev Number: 100 (DW_TAG_subprogram)
> >     <1c21f30>   DW_AT_external    : 1
> >     <1c21f30>   DW_AT_name        : (indirect string, offset: 0x3ac7ae): irq_domain_alloc_descs
> >     <1c21f34>   DW_AT_decl_file   : 1
> >     <1c21f34>   DW_AT_decl_line   : 1086
> >     <1c21f36>   DW_AT_decl_column : 5
> >     <1c21f37>   DW_AT_prototyped  : 1
> >     <1c21f37>   DW_AT_type        : <0x1c110b2>
> >     <1c21f3b>   DW_AT_inline      : 1   (inlined)
> >     <1c21f3b>   DW_AT_sibling     : <0x1c21f8e>
> >  <2><1c21f3f>: Abbrev Number: 14 (DW_TAG_formal_parameter)
> >     <1c21f40>   DW_AT_name        : (indirect string, offset: 0x36eaef): virq
> >     <1c21f44>   DW_AT_decl_file   : 1
> >     <1c21f45>   DW_AT_decl_line   : 1086
> >     <1c21f47>   DW_AT_decl_column : 32
> >     <1c21f48>   DW_AT_type        : <0x1c110b2>
> >  <2><1c21f4c>: Abbrev Number: 43 (DW_TAG_formal_parameter)
> >     <1c21f4d>   DW_AT_name        : cnt
> >     <1c21f51>   DW_AT_decl_file   : 1
> >     <1c21f52>   DW_AT_decl_line   : 1086
> >     <1c21f54>   DW_AT_decl_column : 51
> >     <1c21f55>   DW_AT_type        : <0x1c11049>
> > 
> > And then we have inlined subroutines pointing back (abstract origin) to
> > 0x1c21f2f (DW_TAG_subprogram)
> > 
> >  <2><1c236f2>: Abbrev Number: 29 (DW_TAG_inlined_subroutine)
> >     <1c236f3>   DW_AT_abstract_origin: <0x1c21f2f>
> >     <1c236f7>   DW_AT_entry_pc    : 0xffffffff811d3a56
> >     <1c236ff>   DW_AT_GNU_entry_view: 3
> >     <1c23701>   DW_AT_low_pc      : 0xffffffff811d3a56
> >     <1c23709>   DW_AT_high_pc     : 0x17
> >     <1c23711>   DW_AT_call_file   : 1
> >     <1c23712>   DW_AT_call_line   : 698
> >     <1c23714>   DW_AT_call_column : 9
> >     <1c23715>   DW_AT_sibling     : <0x1c2378e>
> >  <3><1c23719>: Abbrev Number: 8 (DW_TAG_formal_parameter)
> >     <1c2371a>   DW_AT_abstract_origin: <0x1c21f3f>
> >     <1c2371e>   DW_AT_location    : 0x36add1 (location list)
> >     <1c23722>   DW_AT_GNU_locviews: 0x36adcd
> >  <3><1c23726>: Abbrev Number: 8 (DW_TAG_formal_parameter)
> >     <1c23727>   DW_AT_abstract_origin: <0x1c21f4c>
> >     <1c2372b>   DW_AT_location    : 0x36adee (location list)
> >     <1c2372f>   DW_AT_GNU_locviews: 0x36adec
> > 
> > But then the first arg points back to the right place, no?
> > 
> >  <2><1c21f3f>: Abbrev Number: 14 (DW_TAG_formal_parameter)
> >     <1c21f40>   DW_AT_name        : (indirect string, offset: 0x36eaef): virq
> >     <1c21f44>   DW_AT_decl_file   : 1
> >     <1c21f45>   DW_AT_decl_line   : 1086
> >     <1c21f47>   DW_AT_decl_column : 32
> >     <1c21f48>   DW_AT_type        : <0x1c110b2>
> >  <2><1c21f4c>: Abbrev Number: 43 (DW_TAG_formal_parameter)
> >     <1c21f4d>   DW_AT_name        : cnt
> >     <1c21f51>   DW_AT_decl_file   : 1
> >     <1c21f52>   DW_AT_decl_line   : 1086
> >     <1c21f54>   DW_AT_decl_column : 51
> >     <1c21f55>   DW_AT_type        : <0x1c11049>
> > 
> > I.e. can you please elaborate a bit here on this test/WARN as I am
> > missing something... :-\
> >
> 
> So this looks like a case where - because we don't have address-level
> specificity in mapping between DWARF and ELF representations - we have
> mis-applied our consistency checks to the partially-inlined version of
> the function irq_domain_alloc_descs.part.0(). I suspect what happened is
> this - we compared across the function itself and its partially-inlined
> component; the latter's late DWARF _did_ eliminate the first parameter
> so we labeled this incorrectly as an inconsistent representation across
> all instances of irq_domain_alloc_descs().
> 
> The next step we need to make in order to ensure this works more
> accurately is to use function addresses to link between DWARF and ELF
> symbol table entries; this will allow us to know that a particular DWARF
> representation refers to the ".part.0" instance of a function, and as a
> result is not relevant to the actual function representation.
> 
> Today we just use name prefix matching to link between ELF and DWARF,
> and in some cases that can lead us astray, making us reject functions
> that are in fact consistent in their prototypes. Equally in other cases
> it steers us right, allowing us to notice that a .isra.0 version of a
> function has eliminated a parameter for example.
> 
> I have started looking add address-based matching, but don't have
> anything ready yet I'm afraid. Worst case here is we reject a few too
> many functions from BTF representation where they were actually safe to
> put into BTF (and support fentry). Looks like the absolute numbers are
> relatively low thankfully, but it's definitely something we need a more
> nuanced solution for.

Thanks for the thorough explanation, makes sense to me now. But see
below.
 
> 
> >   WARN: 'rcu_nocb_unlock_irqrestore()' has only one prototype; if it was subject to late optimization, pfunct may not reflect inconsistencies pahole found.
> >   Full skip message from pahole: rcu_nocb_unlock_irqrestore (rcu_nocb_unlock_irqrestore): skipping BTF encoding of function due to param type mismatch for param#1 flags != rdp
> >   WARN: 'validate_device_path()' has only one prototype; if it was subject to late optimization, pfunct may not reflect inconsistencies pahole found.
> >   Full skip message from pahole: validate_device_path (validate_device_path): skipping BTF encoding of function due to param type mismatch for param#1 buffer != var_name
> >   WARN: 'blk_rq_map_user_io()' has only one prototype; if it was subject to late optimization, pfunct may not reflect inconsistencies pahole found.
> >   Full skip message from pahole: blk_rq_map_user_io (blk_rq_map_user_io): skipping BTF encoding of function due to param type mismatch for param#6 iov_count != vec
> >   WARN: 'acpi_ec_setup()' has only one prototype; if it was subject to late optimization, pfunct may not reflect inconsistencies pahole found.
> >   Full skip message from pahole: acpi_ec_setup (acpi_ec_setup): skipping BTF encoding of function due to param type mismatch for param#2 call_reg != device
> >   WARN: 'acpi_button_notify()' has only one prototype; if it was subject to late optimization, pfunct may not reflect inconsistencies pahole found.
> >   Full skip message from pahole: acpi_button_notify (acpi_button_notify): skipping BTF encoding of function due to param type mismatch for param#1 data != handle
> >   WARN: 'bpf_sock_is_valid_access()' has only one prototype; if it was subject to late optimization, pfunct may not reflect inconsistencies pahole found.
> >   Full skip message from pahole: bpf_sock_is_valid_access (bpf_sock_is_valid_access): skipping BTF encoding of function due to param type mismatch for param#3 info != type
> >   Found 118 instances with multiple instances with incompatible parameters.
> >   Found 1 instances where inline functions were not inlined and had incompatible parameters.
> >   Found 295 instances where the function name suggests optimizations led to inconsistent parameters.
> >   Found 7 instances where pfunct did not notice inconsistencies.
> >   Ok
> >     2: Pretty printing of files using DWARF type information: pahole: type 'perf_event_type' not found
> >   skip: /home/acme/bin/perf doesn't have 'enum perf_event_type' type info
> >   skipping...
> >     3: 1 file not available, please specify another
> >   skipping...
> >   /home/acme/git/pahole
> >   
> >   real	7m46.729s
> >   user	4m21.097s
> >   sys	3m27.223s
> >   acme@x1:~/git/pahole$ 
> > 
> > 
> > Test #2 needs a perf binary with debugging info, if I provide one:
> > 
> > acme@x1:~/git/pahole$ time tests/prettify_perf.data.sh 
> > Pretty printing of files using DWARF type information: Ok
> > 
> > real	0m1.705s
> > user	0m1.083s
> > sys	0m0.595s
> > acme@x1:~/git/pahole$
> > 
> > I'll try to improve that message...
 
> Yeah, not sure what to say here exactly. It can be true that there is an
> inconsistency; I guess we could add that sometimes we get false
> positives and reject valid functions? Thanks!

One thing I think we should have in tests/tests is a verbose mode, as I
think we're emitting too much info right now and that is not reasuring
for a casual tester.

I think we should have just the "Ok" at the end of each line if what we
see is expected, i.e. the algorithm is excluding inconsistencies as
design. In verbose mode we can show all those statistics and
inconsistencies.

Its only when something is really out of what was designed that we
should FAIL and give a short message indicating what went wrong, telling
the user to use verbose mode to get more information, perhaps to help in
hacking and fixing the problem.

- Arnaldo
