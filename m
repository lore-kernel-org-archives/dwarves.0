Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CC24A23
	for <dwarves@vger.kernel.org>; Mon,  1 Dec 2025 19:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764618400; cv=none; b=K0Qvg9GizHWxL/MeMOgLtzEDwALCQ4RhHmKShAReAM+eSKlbKy4Ccf+WxAfCqBTe3E9y6cJQLAnjFoMz8LRXsj7gMRdky5MeAtHrsg4Q3cBgNrBQwdls/YBx2ULUPgOY3Ci2D40JLLH8MxJDnNoNkGcfSK/3WkazFOSK2sPQF4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764618400; c=relaxed/simple;
	bh=Sqsu40jUqDaQIeskcSyJPIG0k5yEwmqwTiIe7tWfonA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZAogYn4D/4i1syU+NTzu7yxNNWulk0Fh+Jg/ikxEkuhC/PLqsO6qL/CRnhzro6vfGXCzVHJIE33R6DogtYOV/HX4zlBxGKW1OoMzKzflmJTE7oojOah3Q7zsp8exhZEjfjQFz4cY6eS+4JkhYxGtkIJ8Xu1COs5FaauD8B4YRHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fO8mqUdH; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fO8mqUdH"
Message-ID: <642f6b68-0691-44a1-844f-a8cddec41fd0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764618385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bLAGDsm60VVIvgbjDFMDd6sP4rr5+0MliPfVs/5ycj8=;
	b=fO8mqUdHukvtNM96ozx36Eo7QkI23WRanHN6iPwmoUiSFIFFaoNrnF3UPhbHXJ4YSB3XoW
	ZDxSvnAjGk18pq0zofoqAtoTECj9JwOeensxoSf8Kc04Dmc8aLeHMljMRIeBEFGz9aByxV
	Ca/IyUmrr9oc4vHN6rMcwV90r5AZC2A=
Date: Mon, 1 Dec 2025 11:46:17 -0800
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 4/4] resolve_btfids: change in-place update
 with raw binary output
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nicolas.schier@linux.dev>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Alan Maguire <alan.maguire@oracle.com>, bpf@vger.kernel.org,
 dwarves@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org
References: <20251127185242.3954132-1-ihor.solodrai@linux.dev>
 <20251127185242.3954132-5-ihor.solodrai@linux.dev>
 <CAErzpmvsgSDe-QcWH8SFFErL6y3p3zrqNri5-UHJ9iK2ChyiBw@mail.gmail.com>
 <bba5017e-a590-480b-ae48-17ae45e44e48@linux.dev>
Content-Language: en-US
In-Reply-To: <bba5017e-a590-480b-ae48-17ae45e44e48@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 11/27/25 9:52 PM, Ihor Solodrai wrote:
> On 11/27/25 7:20 PM, Donglin Peng wrote:
>> On Fri, Nov 28, 2025 at 2:53 AM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>>
>>> [...]
>>>
>>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
>>> index bac22265e7ff..ec7e2a7721c7 100644
>>> --- a/tools/testing/selftests/bpf/Makefile
>>> +++ b/tools/testing/selftests/bpf/Makefile
>>> @@ -4,6 +4,7 @@ include ../../../scripts/Makefile.arch
>>>  include ../../../scripts/Makefile.include
>>>
>>>  CXX ?= $(CROSS_COMPILE)g++
>>> +OBJCOPY ?= $(CROSS_COMPILE)objcopy
>>>
>>>  CURDIR := $(abspath .)
>>>  TOOLSDIR := $(abspath ../../..)
>>> @@ -716,6 +717,10 @@ $(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_TEST_OBJS)                  \
>>>         $$(call msg,BINARY,,$$@)
>>>         $(Q)$$(CC) $$(CFLAGS) $$(filter %.a %.o,$$^) $$(LDLIBS) $$(LLVM_LDLIBS) $$(LDFLAGS) $$(LLVM_LDFLAGS) -o $$@
>>>         $(Q)$(RESOLVE_BTFIDS) --btf $(TRUNNER_OUTPUT)/btf_data.bpf.o $$@
>>> +       $(Q)if [ -f $$@.btf_ids ]; then \
>>> +               $(OBJCOPY) --update-section .BTF_ids=$$@.btf_ids $$@; \
>>
>> I encountered a resolve_btfids self-test failure when enabling the
>> BTF sorting feature, with the following error output:
>>
>> All error logs:
>> resolve_symbols:PASS:resolve 0 nsec
>> test_resolve_btfids:PASS:id_check 0 nsec
>> test_resolve_btfids:PASS:id_check 0 nsec
>> test_resolve_btfids:FAIL:id_check wrong ID for T (7 != 5)
>> #369     resolve_btfids:FAIL
>>
>> The root cause is that prog_tests/resolve_btfids.c retrieves type IDs
>> from btf_data.bpf.o and compares them against the IDs in test_progs.
>> However, while the IDs in test_progs are sorted, those in btf_data.bpf.o
>> remain in their original unsorted state, causing the validation to fail.
>>
>> This presents two potential solutions:
>> 1. Update the relevant .BTF.* section datas in btf_data.bpf.o, including
>>     the .BTF and .BTF.ext sections
>> 2. Modify prog_tests/resolve_btfids.c to retrieve IDs from test_progs.btf
>>     instead. However, I discovered that test_progs.btf is deleted in the
>>     subsequent code section.
>>
>> What do you think of it?
> 
> Within resolve_btfids it's clear that we have to update (sort in this
> case) BTF first, and then resolve the ids based on the changed BTF.
> 
> As for the test, we should probably change it to become closer to an
> actual resolve_btfids use-case. Maybe even replace or remove it.
> 
> resolve_btfids operates on BTF generated by pahole for
> kernel/module. And the .BTF_ids section makes sense only in kernel
> space AFAIU (might be wrong, let me know if I am).
> 
> And in this test we are using BTF produced by LLVM for a BPF program,
> and then create a .BTF_ids section in a user-space app (test_progs /
> resolve_btfids.test.o), although using proper kernel macros.
> 
> By the way, the test was written more than 5y ago [1], so it might be
> outdated too.
> 
> I think the behavior that we care about is already indirectly tested
> by bpf_testmod module tests, with custom BPF kfuncs and BTF_ID_*
> declarations etc. If resolve_btfids is broken, those tests will fail.
> 
> But it's also reasonable to have some tests targeting resolve_btfids
> app itself, of course. This one doesn't fit though IMO.
> 
> I'll try to think of something.

Hi Donglin,

I discussed this off-list with Andrii, and we agreed that the selftest
itself is reasonable with respect to testing resolve_btfids output.

In this series, I only have to change the test_progs build recipe.

The problem that you've encountered I think can be fixed in the test,
which is basically what you suggested as option 2:

  static int resolve_symbols(void)
  {
	struct btf *btf;
	int type_id;
	__u32 nr;

	btf = btf__parse_elf("btf_data.bpf.o", NULL); /* <--- this */

        [...]

Instead of reading in the source BTF, we have to load .btf produced by
resolve_btfids. A complication is that it's going to be a different
file for every TRUNNER_BINARY, which has to be accounted for, although
the BTF itself would be identical between relevant runners.

If go this route, I think we should add .btf cleanup to the Makefile
and update local .gitignore

This change is not strictly necessary in this series, but it is for
the BTF sorting series. Let me know if you would like to take this on,
so we don't do the same work twice.

> 
> [1] https://lore.kernel.org/bpf/20200703095111.3268961-10-jolsa@kernel.org/
> 
> 
>>
>> Thanks,
>> Donglin
>>
>>> +       fi
>>> +       $(Q)rm -f $$@.btf_ids $$@.btf
>>>         $(Q)ln -sf $(if $2,..,.)/tools/build/bpftool/$(USE_BOOTSTRAP)bpftool \
>>>                    $(OUTPUT)/$(if $2,$2/)bpftool
>>>
>>> --
>>> 2.52.0
>>>
> 

