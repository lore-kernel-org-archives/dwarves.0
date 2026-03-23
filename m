Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35263E023A
	for <dwarves@vger.kernel.org>; Mon, 23 Mar 2026 19:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774295949; cv=none; b=XvBG6TXjojjIbdjZz9yItesO7/WN7grzeZrCZEivXzvPN/BTSe8vVfsULyh7cjd4O5wzMK04omBoCOU78VTfGSM2RsJYYWL2m95TRJQhIcaqQyZtkO7CWSxomj7kuSRtjQuoZOIlJDlJTstvTjqNpUBvbFAe1p3wYOSqH2tw1Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774295949; c=relaxed/simple;
	bh=M4yO6TjBA0OEENXwXwdCe/SCclIYODB4pFdtXgeAVi8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PYx1JTPiDq9bY9BsSdYFkXnOwNP7E0kDF3AjBI2DD40fmrJEUEMMaJpZbpijxTmXPeBxyzoEViA2hE7eGb/JOESrBfI0SxvzX75Cr0sAcrcUfdQP6r1wnQDR90lY4HsbtHzmbdrWqZXMjMFrXM/tPAv8Tbs60Omex53uhievw7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pSVhEbdF; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pSVhEbdF"
Message-ID: <f9ae52c7-af13-4c94-8ca1-0cef5ce280e8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774295935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/kVdlw+YtDSJgKAX/XVHjl6DgM0SLzF4jkLh1QN/52Y=;
	b=pSVhEbdFKVqchw4BPEE8GQEgakTQ6e1zXujeiPB2pQiJ94CpppC7T6WjJgOUh1xymsE0Rn
	SHCWHztZCByZoxARNzw/dCc77oG934JGMqm7bTNx21V7cUMapzinKiZw7KJ5HnliF8W9u9
	8JubAtf1oltEg8xhdkZx1BWRvslhTUE=
Date: Mon, 23 Mar 2026 12:58:40 -0700
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH dwarves v3 9/9] tests: Add a few clang true signature
 tests
Content-Language: en-GB
To: Alan Maguire <alan.maguire@oracle.com>,
 Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org, kernel-team@fb.com
References: <20260320190917.1970524-1-yonghong.song@linux.dev>
 <20260320191003.1975752-1-yonghong.song@linux.dev>
 <0ee4bc7a-692f-46a1-9373-2f405e5305d1@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <0ee4bc7a-692f-46a1-9373-2f405e5305d1@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 3/23/26 8:41 AM, Alan Maguire wrote:
> On 20/03/2026 19:10, Yonghong Song wrote:
>> Three tests are added.
>>
>> Test 1: VERBOSE=1 ./clang_parm_optimized.sh
>>    BTF:   char * foo(struct t * a, struct t * d);
>>    DWARF: char * foo(struct t * a, int b, struct t * d);
>> where parameber 'b' is unused.
>>
>> Test 2: VERBOSE=1 ./clang_parm_optimized_stack.sh
>>    BTF:   char * foo(struct t * a, struct t * d);
>>    DWARF: char * foo(struct t * a, int b1, int b2, int b3, int b4, int b5, int b6, struct t * d);
>> where parameters 'b1' to 'b6' are unused.
>>
>> Test 3: VERBOSE=1 ./clang_parm_aggregate.sh
>>    BTF:   long foo(long a__f1, struct t b, int i);
>>    DWARF: long foo(struct t a, struct t b, int i);
>> where the 'struct t' definition is 'struct t { long f1; long f2; };', and
>> a.f2 is not used in the function.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> thanks for the tests! Ran this through CI [1] and got a failure on aarch64:
>
> 2: clang_parm_aggregate.sh
> Validation of BTF encoding of true_signatures.
>     BTF and DWARF signatures should be different and they are not: BTF: long foo(struct t a, struct t b, int i); ; DWARF long foo(struct t a, struct t b, int i);
> Test ./clang_parm_aggregate.sh failed
> Test data is in /tmp/clang_parm_aggregate.sh.YC44qj

Thanks for spotting this. I forgot to verify it on aarch64.
For x86, we have:

0x00000041:   DW_TAG_subprogram
                 DW_AT_low_pc    (0x0000000000000020)
                 DW_AT_high_pc   (0x000000000000002d)
                 DW_AT_frame_base        (DW_OP_reg7 RSP)
                 DW_AT_call_all_calls    (true)
                 DW_AT_name      ("foo")
                 DW_AT_decl_file ("/home/yhs/tmp/tmp4/t.c")
                 DW_AT_decl_line (2)
                 DW_AT_prototyped        (true)
                 DW_AT_calling_convention        (DW_CC_nocall)
                 DW_AT_type      (0x00000094 "long")
                                  
0x00000051:     DW_TAG_formal_parameter
                   DW_AT_location        (DW_OP_reg5 RDI, DW_OP_piece 0x8)
                   DW_AT_name    ("a")
                   DW_AT_decl_file       ("/home/yhs/tmp/tmp4/t.c")
                   DW_AT_decl_line       (2)
                   DW_AT_type    (0x0000007c "t")
                                  
0x0000005d:     DW_TAG_formal_parameter
                   DW_AT_location        (indexed (0x0) loclist = 0x00000010:
                      [0x0000000000000020, 0x0000000000000023): DW_OP_reg4 RSI, DW_OP_piece 0x8, DW_OP_reg1 RDX, DW_OP_piece 0x8
                      [0x0000000000000023, 0x000000000000002d): DW_OP_piece 0x8, DW_OP_reg1 RDX, DW_OP_piece 0x8)
                   DW_AT_name    ("b")
                   DW_AT_decl_file       ("/home/yhs/tmp/tmp4/t.c")
                   DW_AT_decl_line       (2)
                   DW_AT_type    (0x0000007c "t")
                                                                   
0x00000066:     DW_TAG_formal_parameter
                   DW_AT_location        (DW_OP_reg2 RCX)
                   DW_AT_name    ("i")
                   DW_AT_decl_file       ("/home/yhs/tmp/tmp4/t.c")
                   DW_AT_decl_line       (2)
                   DW_AT_type    (0x00000027 "int")
                                                                   
0x00000070:     NULL

So for x84, we can find true signature.

For aarch64:

0x00000041:   DW_TAG_subprogram
                 DW_AT_low_pc    (0x0000000000000034)
                 DW_AT_high_pc   (0x0000000000000044)
                 DW_AT_frame_base        (DW_OP_reg31 WSP)
                 DW_AT_call_all_calls    (true)
                 DW_AT_name      ("foo")
                 DW_AT_decl_file ("/home/yhs/tmp/t.c")
                 DW_AT_decl_line (2)
                 DW_AT_prototyped        (true)
                 DW_AT_type      (0x00000090 "long")
                                                                          
0x00000050:     DW_TAG_formal_parameter
                   DW_AT_location        (indexed (0x0) loclist = 0x00000014:
                      [0x0000000000000034, 0x0000000000000040): DW_OP_reg0 W0, DW_OP_piece 0x8)
                   DW_AT_name    ("a")
                   DW_AT_decl_file       ("/home/yhs/tmp/t.c")
                   DW_AT_decl_line       (2)
                   DW_AT_type    (0x00000078 "t")
                                                                          
0x00000059:     DW_TAG_formal_parameter
                   DW_AT_location        (indexed (0x1) loclist = 0x0000001c:
                      [0x0000000000000034, 0x0000000000000044): DW_OP_reg2 W2, DW_OP_piece 0x8, DW_OP_reg3 W3, DW_OP_piece 0x8)
                   DW_AT_name    ("b")
                   DW_AT_decl_file       ("/home/yhs/tmp/t.c")
                   DW_AT_decl_line       (2)
                   DW_AT_type    (0x00000078 "t")
                                                                          
0x00000062:     DW_TAG_formal_parameter
                   DW_AT_location        (DW_OP_reg4 W4)
                   DW_AT_name    ("i")
                   DW_AT_decl_file       ("/home/yhs/tmp/t.c")
                   DW_AT_decl_line       (2)
                   DW_AT_type    (0x00000027 "int")
                                     
0x0000006c:     NULL

In this case, the parameter 'a' only uses the first 8 byte which encoded into W0. The argument 'b'
uses W2/W3. For this particular case, the original signature should be used. I will try to find a
way to resolve this.

> ---
>
> And for a kernel LLVM build (enabled with [2]) we also see:
>
> 1: btf_functions.sh
> Validation of BTF encoding of functions.
>     This may take some time.
>     ERROR: mismatch : BTF 'bool __scm_recv_common(struct sock *, struct msghdr *, struct scm_cookie *);' not found; DWARF ''
> Test ./btf_functions.sh failed
> Test data is in /tmp/btf_functions.sh.P23ipZ
>
> This test compares BTF and DWARF representations, trying to ensure we see matches
> between DWARF function signatures reported by pfunct for both BTF and DWARF. It might
> be worth looking to see if we can refine the test here to handle functions with changed
> signatures in DWARF, skipping those that have DW_CC_nocall say.
>
> In the above case pfunct is reporting a signature with the flags field omitted. The
> original signature looks like this:
>
> static bool __scm_recv_common(struct sock *sk, struct msghdr *msg, struct scm_cookie *scm, int flags);
>
> ...so we don't find an equivalent match in DWARF as a result.

Currently, without +true_signature flag, clang may still generate true signatures
by filtering the dead arguments which are at the end of function parameters.
I think we should require +true_signagure flag to do this.
I will fix this. Thanks for spotting.

>
> [1] https://github.com/alan-maguire/dwarves/actions/runs/23443008554/job/68198951034
> [2] https://lore.kernel.org/dwarves/20260323130503.857217-1-alan.maguire@oracle.com/
>
>> ---
>>   tests/clang_parm_aggregate.sh       | 63 +++++++++++++++++++++++
>>   tests/clang_parm_optimized.sh       | 77 +++++++++++++++++++++++++++++
>>   tests/clang_parm_optimized_stack.sh | 77 +++++++++++++++++++++++++++++
>>   3 files changed, 217 insertions(+)
>>   create mode 100755 tests/clang_parm_aggregate.sh
>>   create mode 100755 tests/clang_parm_optimized.sh
>>   create mode 100755 tests/clang_parm_optimized_stack.sh
>>
>> diff --git a/tests/clang_parm_aggregate.sh b/tests/clang_parm_aggregate.sh
>> new file mode 100755
>> index 0000000..bf47c8c
>> --- /dev/null
>> +++ b/tests/clang_parm_aggregate.sh
>> @@ -0,0 +1,63 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +
>> +source test_lib.sh
>> +
>> +outdir=$(make_tmpdir)
>> +
>> +# Comment this out to save test data.
>> +trap cleanup EXIT
>> +
>> +title_log "Validation of BTF encoding of true_signatures."
>> +
>> +clang_true="${outdir}/clang_true"
>> +CC=$(which clang 2>/dev/null)
>> +
>> +if [[ -z "$CC" ]]; then
>> +	info_log "skip: clang not available"
>> +	test_skip
>> +fi
>> +
>> +cat > ${clang_true}.c << EOF
>> +struct t { long f1; long f2; };
>> +__attribute__((noinline)) static long foo(struct t a, struct t b, int i)
>> +{
>> +        return a.f1 + b.f1 + b.f2 + i;
>> +}
>> +
>> +struct t p1, p2;
>> +int i;
>> +int main()
>> +{
>> +        return (int)foo(p1, p2, i);
>> +}
>> +EOF
>> +
>> +CFLAGS="$CFLAGS -g -O2"
>> +${CC} ${CFLAGS} -o $clang_true ${clang_true}.c
>> +if [[ $? -ne 0 ]]; then
>> +	error_log "Could not compile ${clang_true}.c"
>> +	test_fail
>> +fi
>> +LLVM_OBJCOPY=objcopy pahole -J --btf_features=+true_signature $clang_true
>> +if [[ $? -ne 0 ]]; then
>> +	error_log "Could not encode BTF for $clang_true"
>> +	test_fail
>> +fi
>> +
>> +btf_optimized=$(pfunct --all --format_path=btf $clang_true |grep "foo")
>> +if [[ -z "$btf_optimized" ]]; then
>> +	info_log "skip: no optimizations applied."
>> +	test_skip
>> +fi
>> +
>> +btf_cmp=$btf_optimized
>> +dwarf=$(pfunct --all $clang_true |grep "foo")
>> +
>> +verbose_log "BTF: $btf_optimized  DWARF: $dwarf"
>> +
>> +if [[ "$btf_cmp" == "$dwarf" ]]; then
>> +	error_log "BTF and DWARF signatures should be different and they are not: BTF: $btf_optimized ; DWARF $dwarf"
>> +	test_fail
>> +fi
>> +test_pass

[...]

