Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A462D73BC
	for <dwarves@vger.kernel.org>; Wed, 29 Oct 2025 19:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761764503; cv=none; b=WuqFNG/HZsGot7Ma3R1dJRC/q15U5PB862lhceMNlcSqIMlwYhRSaT13xP9jc/ORRGtBnkj5xqvCdPNaOUXB+o9le7CsDs9FYKf4YiGALRs66YDCZ74mgaI8rkZ+y/CSb/1T75OrEPj+ja6vqulsg9zRBUcwCfa66dmKRGZIAM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761764503; c=relaxed/simple;
	bh=xiw0bLp2c9JOEViF91IHFYF97wRlPghXrbTLiPT5DB4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lA2y738NupkQEGeEn1c8PMuCaLeF+F1N7eqtWvxckN/Tpa4XhpXdW07w+ZGkg5wNOk4Wo/Zp4yLOatEiono7jp7RfpqlR/SYy5uB3S64LMsiezCplYoFpWcdB3Bqj7PEBpTWARcw0/IJRMqMaMrV3pVRWm2FqDv+Xv6tAVQzozw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aNv7PI6u; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aNv7PI6u"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761764498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2+yoMLfXN+6jzBrw5Ltl075BE23WDMCSRzN6Q6zJ73Y=;
	b=aNv7PI6uzl/KNeuHtYXm2UNQRJ/H9l5CxZ7uiDGp1IZMhpdoeF/I3jS4qa+73W6BfYR6ko
	febcLWBwExnEVIh4rUwRTJb19Gzl94IE8KPvnr8yIDBSzDwyLip/bsrh5qwxiYcVjDpS6S
	dWiN9CYVgTJQd+4p0SSlFM3v9ZTAq9Y=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: bpf@vger.kernel.org,
	andrii@kernel.org,
	ast@kernel.org
Cc: dwarves@vger.kernel.org,
	alan.maguire@oracle.com,
	acme@kernel.org,
	eddyz87@gmail.com,
	tj@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 0/8] bpf: magic kernel functions
Date: Wed, 29 Oct 2025 12:01:05 -0700
Message-ID: <20251029190113.3323406-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This series develops the idea of implicit prog_aux argument for kfuncs
[1] into a generic "magic kfuncs" feature.

A mechanism is created for kfuncs to have arguments that are not
visible to the BPF programs, and are provided to the kernel function
implementation by the verifier.

This mechanism is then used in kfuncs that have an argument with
__prog annotation [2], which is the current way of passing struct
bpf_prog_aux pointer to kfuncs.

==== "Magic" ???

The usage of term "magic" is up for debate of course, I am open to
suggestions. I used it as a placeholder first and now it weirdly makes
sense. After all, "bpf" by itself doesn't mean anything either.

The feature effectively produces two variants of a kfunc
signature/prototype: one with the full argument list, and another with
particular arguments omitted.

There are many terms that in other contexts are used to describe
similar properties: implicit, optional, virtual, overloaded,
polymorphic, interface etc.  None of them is quite right for this use
case in BPF, and may trigger incorrect intuition if used.

An accurate term could be something like "verifier provided arguments"
and "kfuncs with verifier provided arguments", but that's too long for
usage in the identifiers.  "Magic" on the other hand is a short and
ambiguous adjective, which hopefully will prompt people to check the
documentation.

==== Implementation

pahole's BTF encoding is changed [3] to detect magic kfuncs and emit
two BTF functions from a single kfunc declaration:
  * kfunc_impl() with the arguments matching kernel declaration
  * kfunc() with __magic arguments omitted

BPF programs then can use both variants of the kfunc (to preserve
backwards compatibility for BPF programs that include vmlinux.h),
although non-_impl variant would be a preferred API.

To achieve this a few pieces of information must be possible to
decode in pahole from kernel side kfunc declaration:
  * which kfuncs are magic
  * what arguments should be omitted

A simple way to mark magic kfuncs is with a KF_MAGIC_ARGS flag.

As for the arguments, I considered a couple of options:
  * look at argument types and hardcode a list of types in pahole
  * have multiple KF_MAGIC_ARGS_<N> flags, which would indicate the
    number of arguments omitted
  * use a special arg name suffix (annotation), i.e. "__magic"

Of the three, the last one seems to be the simplest and most flexible.

It is also necessary for pahole to use conventional names for the
emitted kfunc pair for the verifier to be able to recognize them.

These changes in BTF create discrepancies in the verifier:
  * kfunc() now has an incorrect BTF function prototype
  * kfunc_impl() doesn't have a corresponding ksym and BTF flags

In order to handle them correctly, it's necessary to be able to lookup
kfunc() <-> kfunc_impl() pairs efficiently. Naive string lookup in BTF
is possible, but it is slow, which may negatively impact verification
performance for programs using relevant kfuncs.

Since the magic kfuncs are constant within a kernel, and their names
in BTF are conventional, we can define a constant table of magic
kfuncs using existing BTF_ID_LIST mechanism. A `magic_kfuncs` BTF ids
table is therefore defined and used for efficient lookups.

An inconvenience of the implementation described above is that the
writers of a magic kfunc have to do a couple of things:
  * mark the kfunc with KF_MAGIC_ARGS
  * mark the args with __magic annotation
  * add kfunc to magic_kfuncs table

Another one is that for special kfuncs the relevant checks in the
verifier must test for both original and _impl funcs. See changes to
bpf_wq_set_callback_impl for an example.

==== Testing

A number of selftests are already using aux__prog -> magic kfuncs.

Successful BPF CI run with modified pahole:
https://github.com/kernel-patches/bpf/actions/runs/18918350607

[1] https://lore.kernel.org/bpf/20250924211716.1287715-1-ihor.solodrai@linux.dev/
[2] https://docs.kernel.org/bpf/kfuncs.html#prog-annotation
[3] https://github.com/theihor/dwarves/tree/magic-args.draft

Ihor Solodrai (8):
  bpf: Add BTF_ID_LIST_END and BTF_ID_LIST_SIZE macros
  bpf: Refactor btf_kfunc_id_set_contains
  bpf: Support for kfuncs with KF_MAGIC_ARGS
  bpf: Support __magic prog_aux arguments for kfuncs
  bpf: Re-define bpf_wq_set_callback as magic kfunc
  bpf,docs: Document KF_MAGIC_ARGS flag and __magic annotation
  bpf: Re-define bpf_task_work_schedule_* kfuncs as magic
  bpf: Re-define bpf_stream_vprintk as a magic kfunc

 Documentation/bpf/kfuncs.rst                  |  49 ++++-
 include/linux/btf.h                           |   7 +-
 include/linux/btf_ids.h                       |  10 ++
 kernel/bpf/btf.c                              |  70 ++++++--
 kernel/bpf/helpers.c                          |  31 ++--
 kernel/bpf/stream.c                           |   9 +-
 kernel/bpf/verifier.c                         | 167 ++++++++++++++++--
 tools/lib/bpf/bpf_helpers.h                   |   7 +-
 .../testing/selftests/bpf/bpf_experimental.h  |   5 -
 .../testing/selftests/bpf/progs/file_reader.c |   2 +-
 .../testing/selftests/bpf/progs/stream_fail.c |   6 +-
 tools/testing/selftests/bpf/progs/task_work.c |   6 +-
 .../selftests/bpf/progs/task_work_fail.c      |   8 +-
 .../selftests/bpf/progs/task_work_stress.c    |   2 +-
 .../bpf/progs/verifier_async_cb_context.c     |   4 +-
 tools/testing/selftests/bpf/progs/wq.c        |   2 +-
 .../testing/selftests/bpf/progs/wq_failures.c |   4 +-
 17 files changed, 312 insertions(+), 77 deletions(-)

-- 
2.51.1

