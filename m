Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D307E131752
	for <dwarves@vger.kernel.org>; Tue,  6 Feb 2024 14:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707229437; cv=none; b=uwh1C0Nb18Knfzy3+t1dg4Wy7tNiMLilL9l/D2aE5pdci+JbNSMCvEvn6gNlz4rdLghbAnWy4pXjINQnNJ6XwZSUwa1y+BwwZb7RwTqvWetmCIx1AiXfOHguCF45RHsioCzqJ/lfIc/RoX6+/fxbKn04jGyQSqw/nE3fvbklvBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707229437; c=relaxed/simple;
	bh=HrDkhAabT4xiBv0slJy9HTMUxCva+P5VbjZolLftsJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PcwRY0yjZBAJPvCvWKNR3WAJcx3hS/mrOln0wlBPTp1AQkK6GQ0bYTVNViFnPneADAknJ09hMUJxkof8W55EmOuj5rKJb2e/KGRI3GUFojeTJJcKI3lmKnQHZTbl/SQCasH6CF9/awc/damAGQKHXrxnthMc78AXuamDzb18MgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=igL0w7eR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="igL0w7eR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9032C433F1;
	Tue,  6 Feb 2024 14:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707229437;
	bh=HrDkhAabT4xiBv0slJy9HTMUxCva+P5VbjZolLftsJ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=igL0w7eRCkHH5LgEPxlzQ8ZKCf/QDfDFsvlsLX3KH82s9w+I6SnHPyOZuswR34q1u
	 ZIBraZc2FXRja5EZhrzfI0GVso+vFASnCZrm35m0H6PiIxB6B0PPAbMcRaMTsgyVoY
	 CFAVZJxsRzdzV45qOkmqOdxHWrpQdM0Bq+jsF7Vpq/knLlFYpysOTssced8lGZly3v
	 yYiX0tfow+ZuBic5Z+WhuTI/uD48CZv4bUMRFiUux0aoaTRkA+ue6mdG5tMD+VE7Tn
	 WASPoU0fzOBwLKwqpzFOUAXiNd1mDttfBmqZSHITdpd+RWxy66X/dE6JOOrkYTYK2w
	 /DHTBRIKL0hZg==
Date: Tue, 6 Feb 2024 11:23:54 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Jiri Olsa <jolsa@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>
Cc: dwarves@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Encoding BTF information from DWARF causes "has void type" error.
Message-ID: <ZcJA-mrVh5qmkxfV@x1>
References: <20240206120226.6r7n4vQ3@linutronix.de>
 <ZcI3TVlOYuQfCWv2@x1>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZcI3TVlOYuQfCWv2@x1>

On Tue, Feb 06, 2024 at 10:42:44AM -0300, Arnaldo Carvalho de Melo wrote:
> On Tue, Feb 06, 2024 at 01:02:26PM +0100, Sebastian Andrzej Siewior wrote:
> > with linux kernel v6.8-rc2-RT and the following file as testcase
> > 
> > ----->8--------
> > 
> > #include <linux/spinlock.h>
> > #include <linux/local_lock.h>
> > 
> > struct per_cpu_struct {
> >         local_lock_t lock;
> >         unsigned int something;
> > };
> > 
> > static DEFINE_PER_CPU(struct per_cpu_struct, per_cpu_struct) = {
> >         .lock = INIT_LOCAL_LOCK(lock),
> > };
> > 
> > DEFINE_GUARD(ll_lock, local_lock_t __percpu*,
> >              local_lock(_T),
> >              local_unlock(_T))
> > 
> > void function(void);
> > void function(void)
> > {
> >         struct per_cpu_struct *pcs = this_cpu_ptr(&per_cpu_struct);
> > 
> >         guard(ll_lock)(&per_cpu_struct.lock);
> >         pcs->something++;
> > }
> > 
> > -----8<--------
> > 
> > compiling and running pahole afterwards:
> > | make kernel/pahole-tc.o && pahole -J --btf_gen_floats -j --lang_exclude=rust  kernel/pahole-tc.o
> > |   CC      kernel/pahole-tc.o
> > | error: found variable 'per_cpu_struct' in CU 'kernel/pahole-tc.c' that has void type
> > 
> > This doesn't look good. If I swap the order of "lock" and "something"
> > within per_cpu_struct then it goes away.
> > The dwarf/die object it complains about has only DW_AT_abstract_origin
> > and DW_AT_location set.

Are you sure?

What I see:

⬢[acme@toolbox pahole]$ cp sebastian-rt-void-variable-btf/pahole-tc/pahole-tc-bad.o .
⬢[acme@toolbox pahole]$ pahole --btf_encode pahole-tc-bad.o
error: found variable 'per_cpu_struct' in CU 'kernel/pahole-tc.c' that has void type
⬢[acme@toolbox pahole]$

⬢[acme@toolbox pahole]$ readelf -wi sebastian-rt-void-variable-btf/pahole-tc/pahole-tc-bad.o | grep DW_TAG_variable -A5 | grep -w per_cpu_struct -B1 -A4
 <1><764>: Abbrev Number: 29 (DW_TAG_variable)
    <765>   DW_AT_name        : (indirect string, offset: 0x184): per_cpu_struct
    <769>   DW_AT_decl_file   : 1
    <769>   DW_AT_decl_line   : 9
    <76a>   DW_AT_decl_column : 8
    <76b>   DW_AT_type        : <0x73c>
⬢[acme@toolbox pahole]$

⬢[acme@toolbox pahole]$ readelf -wi sebastian-rt-void-variable-btf/pahole-tc/pahole-tc-bad.o | grep '<73c>.*DW_TAG_structure_type' -A7
 <1><73c>: Abbrev Number: 4 (DW_TAG_structure_type)
    <73d>   DW_AT_name        : (indirect string, offset: 0x184): per_cpu_struct
    <741>   DW_AT_byte_size   : 136
    <742>   DW_AT_decl_file   : 1
    <743>   DW_AT_decl_line   : 4
    <744>   DW_AT_decl_column : 8
    <745>   DW_AT_sibling     : <0x764>
 <2><749>: Abbrev Number: 1 (DW_TAG_member)
⬢[acme@toolbox pahole]$

But when using verbose mode:

[95] FUNC function type_id=94
search cu 'kernel/pahole-tc.c' for percpu global variables.
Variable 'per_cpu_struct' from CU 'kernel/pahole-tc.c' at address 0x0 encoded
[96] VAR per_cpu_struct type=90 linkage=0
Variable 'per_cpu_struct' from CU 'kernel/pahole-tc.c' at address 0x0 encoded
[97] VAR per_cpu_struct type=91 linkage=0
error: found variable 'per_cpu_struct' in CU 'kernel/pahole-tc.c' that has void type
[98] DATASEC .data..percpu size=136 vlen=2
	type=96 offset=0 size=136
	type=97 offset=0 size=136
⬢[acme@toolbox pahole]$ pahole -V --btf_encode pahole-tc-bad.o

It ends up considering two variables with that name?

⬢[acme@toolbox pahole]$ readelf -wi sebastian-rt-void-variable-btf/pahole-tc/pahole-tc-bad.o | grep per_cpu_struct -B1 -A5
 <1><73c>: Abbrev Number: 4 (DW_TAG_structure_type)
    <73d>   DW_AT_name        : (indirect string, offset: 0x184): per_cpu_struct
    <741>   DW_AT_byte_size   : 136
    <742>   DW_AT_decl_file   : 1
    <743>   DW_AT_decl_line   : 4
    <744>   DW_AT_decl_column : 8
    <745>   DW_AT_sibling     : <0x764>
--
 <1><764>: Abbrev Number: 29 (DW_TAG_variable)
    <765>   DW_AT_name        : (indirect string, offset: 0x184): per_cpu_struct
    <769>   DW_AT_decl_file   : 1
    <769>   DW_AT_decl_line   : 9
    <76a>   DW_AT_decl_column : 8
    <76b>   DW_AT_type        : <0x73c>
    <76f>   DW_AT_location    : 9 byte block: 3 0 0 0 0 0 0 0 0 	(DW_OP_addr: 0)
⬢[acme@toolbox pahole]$

Just dumping some more info in case Jiri or Alan thinks about something.

- Arnaldo

> > At this point I am not sure if gcc wrongly created the dwarf information
> > or of pahole accidentally matches the internal local_lock_t member as
> > per_cpu_struct because it starts the same address.
> > 
> > >From dumpwarf the problematic entry is:
> > | 0x0000085b:       DW_TAG_variable
> > |                     DW_AT_abstract_origin       (0x0000099e "t")
> > |                     DW_AT_location      (DW_OP_addr 0x0, DW_OP_stack_value)
> > 
> > which looks slightly different in the good case:
> > | 0x00000852:         DW_TAG_variable
> > |                       DW_AT_abstract_origin     (0x00000980 "t")
> > |                       DW_AT_location    (0x00000040: 
> > |                          [0x0000000000000046, 0x000000000000005b): DW_OP_reg3 RBX
> > |                          [0x000000000000005b, 0x0000000000000061): DW_OP_addr 0x0, DW_OP_stack_value)
> > |                       DW_AT_GNU_locviews        (0x0000003c)
> > 
> > I made an archive with c file, the compiled version in bad and good case
> > (swapped the first two members), the dumpwarf output and uploaded to
> > 	https://breakpoint.cc/pahole-tc.tar.xz
> 
> Lots of great info, I'm on it.
> 
> - Arnaldo
