Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26192130E5F
	for <dwarves@vger.kernel.org>; Tue,  6 Feb 2024 12:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707220951; cv=none; b=mENlohMoPlRo0wfkCqc/On2wOaBm/IsjqTY6bzSk0O68IPnRbE/ziwzESTCcYCEQWVIRJ4t/jix+Qy7iPsd0t5v1ZRw7cQtc81wIR5bONhrjnCDKRU/8i+PbdSao2Tsb8dmrZWqVy+fLEuCCakaWzwSKGIXaY2VwRtadcAPLLu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707220951; c=relaxed/simple;
	bh=vRzu0NGczYokgZNIaL9g4UGrHSQkvsaL8Zrkf6ucppI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=B673CzucZ11qr4hhzeeEHM1TT0MFMRrNkl3Iz4w5WIc33MHAaHOG6TSni16CRVQRPL5gb/xx/M1zj9GJ/LyW2VMYET7lwWwzER54A+JYwfKrStsLvIiq9ELlvBEotIa0eq6HSDuDHIbzlzImpxOWYzleYsWg5FZfHNtGx+PXx6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R6SsCF1v; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KFOLPMCM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R6SsCF1v";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KFOLPMCM"
Date: Tue, 6 Feb 2024 13:02:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707220947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=P/MW/EwRkNPO8LABmEQWTOIJyfmnG4kJNiY7q1+Uv4I=;
	b=R6SsCF1vuPYGpiqAKWObvdFFCUDE+9ZxskHH/wysNkuHq9U4cE7q1WurUFq/R3wtqF1D6l
	Y/wRGyQ/eR3Fqw4BuzBwg3/azMPtGuDzcM8gtT7YjJLzut1d5TZc72F2Sy3iELVX0glTmF
	VdnkEec7CsxYn3QrIgy7ZvYGITzcAi9DzBDgY6hm75q5XcZgLUlAp+2Eg4DlPeoGv9UZfu
	kVWunZtOZ7umbDvaU8gGzmYDqio5y6OCCk+5SqT9pYfiFGMrM3k8RQjtUOMAG1NgP8KJw1
	OGHZpyZAhoL630wMo7KmaUqmJ6vYS8+L4LZ+VlqlB7IOuJSLQSI6L2FsWX/xpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707220947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=P/MW/EwRkNPO8LABmEQWTOIJyfmnG4kJNiY7q1+Uv4I=;
	b=KFOLPMCMfLXvBi1GoxLcavqoDY5Vax3UsshvzEg2k8K4QgDGbaKHBtwC3H5A1/HeIw0AD5
	wpu0DXYd9SUieoBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: dwarves@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Subject: Encoding BTF information from DWARF causes "has void type" error.
Message-ID: <20240206120226.6r7n4vQ3@linutronix.de>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi,

with linux kernel v6.8-rc2-RT and the following file as testcase

----->8--------

#include <linux/spinlock.h>
#include <linux/local_lock.h>

struct per_cpu_struct {
        local_lock_t lock;
        unsigned int something;
};

static DEFINE_PER_CPU(struct per_cpu_struct, per_cpu_struct) = {
        .lock = INIT_LOCAL_LOCK(lock),
};

DEFINE_GUARD(ll_lock, local_lock_t __percpu*,
             local_lock(_T),
             local_unlock(_T))

void function(void);
void function(void)
{
        struct per_cpu_struct *pcs = this_cpu_ptr(&per_cpu_struct);

        guard(ll_lock)(&per_cpu_struct.lock);
        pcs->something++;
}

-----8<--------

compiling and running pahole afterwards:
| make kernel/pahole-tc.o && pahole -J --btf_gen_floats -j --lang_exclude=rust  kernel/pahole-tc.o
|   CC      kernel/pahole-tc.o
| error: found variable 'per_cpu_struct' in CU 'kernel/pahole-tc.c' that has void type

This doesn't look good. If I swap the order of "lock" and "something"
within per_cpu_struct then it goes away.
The dwarf/die object it complains about has only DW_AT_abstract_origin
and DW_AT_location set.
At this point I am not sure if gcc wrongly created the dwarf information
or of pahole accidentally matches the internal local_lock_t member as
per_cpu_struct because it starts the same address.

From dumpwarf the problematic entry is:
| 0x0000085b:       DW_TAG_variable
|                     DW_AT_abstract_origin       (0x0000099e "t")
|                     DW_AT_location      (DW_OP_addr 0x0, DW_OP_stack_value)

which looks slightly different in the good case:
| 0x00000852:         DW_TAG_variable
|                       DW_AT_abstract_origin     (0x00000980 "t")
|                       DW_AT_location    (0x00000040: 
|                          [0x0000000000000046, 0x000000000000005b): DW_OP_reg3 RBX
|                          [0x000000000000005b, 0x0000000000000061): DW_OP_addr 0x0, DW_OP_stack_value)
|                       DW_AT_GNU_locviews        (0x0000003c)

I made an archive with c file, the compiled version in bad and good case
(swapped the first two members), the dumpwarf output and uploaded to
	https://breakpoint.cc/pahole-tc.tar.xz

Sebastian
