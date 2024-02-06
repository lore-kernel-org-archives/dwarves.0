Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F33132C3D
	for <dwarves@vger.kernel.org>; Tue,  6 Feb 2024 13:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707226963; cv=none; b=gGTNtuR1QYKbXG6uXbeezzEs0rDOrIqT21B3b7h6BlCBfWAWAW1lpMVMLOKqXU1VU3I76SuUPWmiGHW8flKuyUGxqS9ShmrfWqntdbmn4vFwE3BSTw2O/e9W0Ri3th+QOnT3BH08ko198iBWuBufYVWXVgmjeycdBOIxeL4QZVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707226963; c=relaxed/simple;
	bh=uI76JmU4hZO2IBS5aEEhqRW7jRM7RmX52sBR+wM+fLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qNydiNHXwrtkeGcjCpw9Z8zAjkf+0gj/mPuKJKk3LlCIdRVChZy4I7+SoNhRZzz3SOZLdeF/FXXa6ksDte1HvkCH/XpfuS2UvqJ9Yg43dYhUs+VOOvwfdH4Te1J3fEM26Dok/s7LRkyl9H0+9c5ZWD3XdnPLhZ7eRoQHHDdA1co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iGnMU68l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iGnMU68l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33335C433F1;
	Tue,  6 Feb 2024 13:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707226962;
	bh=uI76JmU4hZO2IBS5aEEhqRW7jRM7RmX52sBR+wM+fLE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iGnMU68lUjzB6/Y1/MVCGrQs544NGLT+V3BVefMjcqhaq8FZ0OuFWbK+jJCnkutTC
	 WDiH4aZgGbc0UKiwZ4D+qPN8WpLh6nc5JR58k1IGTD0ComVMJ1mjczOw5D/Lr0Aopj
	 7mL0llexfXYFY6OR2cW6j8Xg+iGrHheMEf+PphfmqAxw+tWJNUQ7lVTvgExYxNyXBM
	 hc+LN59dnDFQ+n9SqNnG2X9+epr17ZERtAb6FL6vWm0iCNAYOVwXhWng0u3FdbQYh8
	 M5YqteBUBMec+B8068II1yuCdOzt7JxjknMQIW9AdDk/DDt3UtlvZSqYfpSOfZTkLu
	 Cp02SPM3U7T+Q==
Date: Tue, 6 Feb 2024 10:42:37 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: dwarves@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Encoding BTF information from DWARF causes "has void type" error.
Message-ID: <ZcI3TVlOYuQfCWv2@x1>
References: <20240206120226.6r7n4vQ3@linutronix.de>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206120226.6r7n4vQ3@linutronix.de>

On Tue, Feb 06, 2024 at 01:02:26PM +0100, Sebastian Andrzej Siewior wrote:
> with linux kernel v6.8-rc2-RT and the following file as testcase
> 
> ----->8--------
> 
> #include <linux/spinlock.h>
> #include <linux/local_lock.h>
> 
> struct per_cpu_struct {
>         local_lock_t lock;
>         unsigned int something;
> };
> 
> static DEFINE_PER_CPU(struct per_cpu_struct, per_cpu_struct) = {
>         .lock = INIT_LOCAL_LOCK(lock),
> };
> 
> DEFINE_GUARD(ll_lock, local_lock_t __percpu*,
>              local_lock(_T),
>              local_unlock(_T))
> 
> void function(void);
> void function(void)
> {
>         struct per_cpu_struct *pcs = this_cpu_ptr(&per_cpu_struct);
> 
>         guard(ll_lock)(&per_cpu_struct.lock);
>         pcs->something++;
> }
> 
> -----8<--------
> 
> compiling and running pahole afterwards:
> | make kernel/pahole-tc.o && pahole -J --btf_gen_floats -j --lang_exclude=rust  kernel/pahole-tc.o
> |   CC      kernel/pahole-tc.o
> | error: found variable 'per_cpu_struct' in CU 'kernel/pahole-tc.c' that has void type
> 
> This doesn't look good. If I swap the order of "lock" and "something"
> within per_cpu_struct then it goes away.
> The dwarf/die object it complains about has only DW_AT_abstract_origin
> and DW_AT_location set.
> At this point I am not sure if gcc wrongly created the dwarf information
> or of pahole accidentally matches the internal local_lock_t member as
> per_cpu_struct because it starts the same address.
> 
> >From dumpwarf the problematic entry is:
> | 0x0000085b:       DW_TAG_variable
> |                     DW_AT_abstract_origin       (0x0000099e "t")
> |                     DW_AT_location      (DW_OP_addr 0x0, DW_OP_stack_value)
> 
> which looks slightly different in the good case:
> | 0x00000852:         DW_TAG_variable
> |                       DW_AT_abstract_origin     (0x00000980 "t")
> |                       DW_AT_location    (0x00000040: 
> |                          [0x0000000000000046, 0x000000000000005b): DW_OP_reg3 RBX
> |                          [0x000000000000005b, 0x0000000000000061): DW_OP_addr 0x0, DW_OP_stack_value)
> |                       DW_AT_GNU_locviews        (0x0000003c)
> 
> I made an archive with c file, the compiled version in bad and good case
> (swapped the first two members), the dumpwarf output and uploaded to
> 	https://breakpoint.cc/pahole-tc.tar.xz

Lots of great info, I'm on it.

- Arnaldo
