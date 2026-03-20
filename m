Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9FE1A9F8D
	for <dwarves@vger.kernel.org>; Fri, 20 Mar 2026 04:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773982377; cv=none; b=hX5OnnXFB+adT06h5QFhEX3MK2YZ9i6626/UeTOTOmx2InsFTHL8/+wOcDym0l/xrTlx2GD7KMtDB88FELKFNCEUrWCk9Z0C4NM6k3BJl2cHKmsgplijorGGNSV2/PHPPLAYZZSWmR51r5+VH7b7nMlnHxZQ9DZjGnuONn1sWVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773982377; c=relaxed/simple;
	bh=sMpAJWRiMoczmK9FXt2ABPYWhJ/J8T0E019kQ+XfAUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f72QOGzeLasWoxyZWeI3U6VaHPb9kHAAt0R+AwCazO23SD8JyC8HHIypgrIVd5ImBIIo3LybtKBgQEN4jtZ6uDPq8dTTLuCcfa235xeIC0FHQv22KY1kfsl6m3mRiGlu5jZnGGe7YaJVXMHzMSgA7WywC8Of5fnmXtKZcaYj+2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UJ52eabS; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UJ52eabS"
Message-ID: <7a30f200-9f70-4091-a770-8b9f31810c9a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773982363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b/60SDR12VDRijm+lUVRHae0YEmRg+Cvc86I0EZ5+mU=;
	b=UJ52eabS7hFs6wVivN+akZuYmQ5I99LxK77fV4oE06VmWenkcxWSe9JqJPhOwWz1AH+xrx
	nb1V6z/UpbTyiGZp3N7+QcJV4Oet3YUC4x+41ZfZmehXfDsgEGZuq8qvYH0WfZ9H1ZRiqK
	xLVCUkXbxon4F2+ypuFVIAU7emhQ5nc=
Date: Thu, 19 Mar 2026 21:52:35 -0700
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH dwarves 9/9] tests: Add a few clang true signature tests
Content-Language: en-GB
To: Alan Maguire <alan.maguire@oracle.com>,
 Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org, kernel-team@fb.com
References: <20260305225455.1151066-1-yonghong.song@linux.dev>
 <20260305225542.1158464-1-yonghong.song@linux.dev>
 <e2096d0a-5c78-496e-a269-1daf2a3784b5@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <e2096d0a-5c78-496e-a269-1daf2a3784b5@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 3/19/26 11:48 AM, Alan Maguire wrote:
> On 05/03/2026 22:55, Yonghong Song wrote:
>> Three tests are added.
>>
>> Test 1: clang_parm_optimized.sh
>>    BTF:   char * foo(struct t * a, struct t * d);
>>    DWARF: char * foo(struct t * a, int b, struct t * d);
>> where parameber 'b' is unused.
>>
>> Test 2: clang_parm_optimized_stack.sh
>>    BTF:   char * foo(struct t * a, struct t * d);
>>    DWARF: char * foo(struct t * a, int b1, int b2, int b3, int b4, int b5, int b6, struct t * d);
>> where parameters 'b1' to 'b6' are unused.
>>
>> Test 3: clang_parm_aggregate.sh
>>    BTF:   long foo(long a__f1, struct t b, int i);
>>    DWARF: long foo(struct t a, struct t b, int i);
>> where the 'struct t' definition is 'struct t { long f1; long f2; };', and
>> a.f2 is not used in the function.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> tests look good but we need to ensure they are run by the ./tests script
> so that they will be run in CI. also take a look at Bruce's work to
> add common test functions [1], will probably simplify aspects of the tests.

Okay. The [1] is recently added. I will follow the convention in the next revision.

>
> Thanks!
>
> Alan
>
> [1] https://lore.kernel.org/dwarves/20260309205643.1985134-2-bruce.mcculloch@oracle.com/
>
>> ---
>>   tests/true_signatures/clang_parm_aggregate.sh | 83 ++++++++++++++++
>>   tests/true_signatures/clang_parm_optimized.sh | 95 +++++++++++++++++++
>>   .../clang_parm_optimized_stack.sh             | 95 +++++++++++++++++++
>>   .../gcc_true_signatures.sh                    |  0
>>   4 files changed, 273 insertions(+)
>>   create mode 100755 tests/true_signatures/clang_parm_aggregate.sh
>>   create mode 100755 tests/true_signatures/clang_parm_optimized.sh
>>   create mode 100755 tests/true_signatures/clang_parm_optimized_stack.sh
>>   rename tests/{ => true_signatures}/gcc_true_signatures.sh (100%)
>>
>> diff --git a/tests/true_signatures/clang_parm_aggregate.sh b/tests/true_signatures/clang_parm_aggregate.sh
>> new file mode 100755
>> index 0000000..6d92701
>> --- /dev/null
>> +++ b/tests/true_signatures/clang_parm_aggregate.sh
>> @@ -0,0 +1,83 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +
>> +outdir=
>> +
>> +fail()
>> +{
>> +	# Do not remove test dir; might be useful for analysis
>> +	trap - EXIT
>> +	if [[ -d "$outdir" ]]; then
>> +		echo "Test data is in $outdir"
>> +	fi
>> +	exit 1
>> +}
>> +
>> +cleanup()
>> +{
>> +	rm ${outdir}/*
>> +	rmdir $outdir
>> +}
>> +
>> +outdir=$(mktemp -d /tmp/clang_true.sh.XXXXXX)
>> +
>> +trap cleanup EXIT
>> +
>> +echo -n "Validation of BTF encoding of true_signatures: "
>> +
>> +clang_true="${outdir}/clang_true"
>> +CC=$(which clang 2>/dev/null)
>> +
>> +if [[ -z "$CC" ]]; then
>> +	echo "skip: clang not available"
>> +	exit 2
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
>> +	echo "Could not compile ${clang_true}.c" >& 2
>> +	exit 1
>> +fi
>> +LLVM_OBJCOPY=objcopy pahole -J --btf_features=+true_signature $clang_true
>> +if [[ $? -ne 0 ]]; then
>> +	echo "Could not encode BTF for $clang_true"
>> +	exit 1
>> +fi
>> +
>> +btf_optimized=$(pfunct --all --format_path=btf $clang_true |grep "foo")
>> +if [[ -z "$btf_optimized" ]]; then
>> +	echo "skip: no optimizations applied."
>> +	exit 2
>> +fi
>> +
>> +btf_cmp=$btf_optimized
>> +dwarf=$(pfunct --all $clang_true |grep "foo")
>> +
>> +test -n "$VERBOSE" && printf "\nBTF: $btf_optimized  DWARF: $dwarf \n"
>> +
>> +if [[ "$btf_cmp" == "$dwarf" ]]; then
>> +	echo "BTF and DWARF signatures should be different and they are not: BTF: $btf_optimized ; DWARF $dwarf"
>> +	exit 1
>> +else
>> +        echo ""
>> +        echo "  BTF:   $btf_optimized"
>> +        echo "  DWARF: $dwarf"
>> +fi
>> +echo "Ok"
>> +exit 0
>> diff --git a/tests/true_signatures/clang_parm_optimized.sh b/tests/true_signatures/clang_parm_optimized.sh
>> new file mode 100755
>> index 0000000..3022e2b
>> --- /dev/null
>> +++ b/tests/true_signatures/clang_parm_optimized.sh
>> @@ -0,0 +1,95 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +
>> +outdir=
>> +
>> +fail()
>> +{
>> +	# Do not remove test dir; might be useful for analysis
>> +	trap - EXIT
>> +	if [[ -d "$outdir" ]]; then
>> +		echo "Test data is in $outdir"
>> +	fi
>> +	exit 1
>> +}
>> +
>> +cleanup()
>> +{
>> +	rm ${outdir}/*
>> +	rmdir $outdir
>> +}
>> +
>> +outdir=$(mktemp -d /tmp/clang_true.sh.XXXXXX)
>> +
>> +trap cleanup EXIT
>> +
>> +echo -n "Validation of BTF encoding of true_signatures: "
>> +
>> +clang_true="${outdir}/clang_true"
>> +CC=$(which clang 2>/dev/null)
>> +
>> +if [[ -z "$CC" ]]; then
>> +	echo "skip: clang not available"
>> +	exit 2
>> +fi
>> +
>> +cat > ${clang_true}.c << EOF
>> +struct t { int a; };
>> +__attribute__((noinline)) char *tar(struct t *a, struct t *d)
>> +{
>> +	if (a->a == d->a)
>> +		return (char *)10;
>> +	else
>> +		return (char *)0;
>> +}
>> +
>> +__attribute__((noinline)) static char * foo(struct t *a, int b, struct t *d)
>> +{
>> +	return tar(a, d);
>> +}
>> +
>> +__attribute__((noinline)) char *bar(struct t *a, struct t *d)
>> +{
>> +	return foo(a, 1, d);
>> +}
>> +
>> +struct t p1, p2;
>> +int main()
>> +{
>> +	return !!bar(&p1, &p2);
>> +}
>> +EOF
>> +
>> +CFLAGS="$CFLAGS -g -O2"
>> +${CC} ${CFLAGS} -o $clang_true ${clang_true}.c
>> +if [[ $? -ne 0 ]]; then
>> +	echo "Could not compile ${clang_true}.c" >& 2
>> +	exit 1
>> +fi
>> +LLVM_OBJCOPY=objcopy pahole -J --btf_features=+true_signature $clang_true
>> +if [[ $? -ne 0 ]]; then
>> +	echo "Could not encode BTF for $clang_true"
>> +	exit 1
>> +fi
>> +
>> +btf_optimized=$(pfunct --all --format_path=btf $clang_true |grep "foo")
>> +if [[ -z "$btf_optimized" ]]; then
>> +	echo "skip: no optimizations applied."
>> +	exit 2
>> +fi
>> +
>> +btf_cmp=$btf_optimized
>> +dwarf=$(pfunct --all $clang_true |grep "foo")
>> +
>> +test -n "$VERBOSE" && printf "\nBTF: $btf_optimized  DWARF: $dwarf \n"
>> +
>> +if [[ "$btf_cmp" == "$dwarf" ]]; then
>> +	echo "BTF and DWARF signatures should be different and they are not: BTF: $btf_optimized ; DWARF $dwarf"
>> +	exit 1
>> +else
>> +        echo ""
>> +        echo "  BTF:   $btf_optimized"
>> +        echo "  DWARF: $dwarf"
>> +fi
>> +echo "Ok"
>> +exit 0
>> diff --git a/tests/true_signatures/clang_parm_optimized_stack.sh b/tests/true_signatures/clang_parm_optimized_stack.sh
>> new file mode 100755
>> index 0000000..1abb96d
>> --- /dev/null
>> +++ b/tests/true_signatures/clang_parm_optimized_stack.sh
>> @@ -0,0 +1,95 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +
>> +outdir=
>> +
>> +fail()
>> +{
>> +	# Do not remove test dir; might be useful for analysis
>> +	trap - EXIT
>> +	if [[ -d "$outdir" ]]; then
>> +		echo "Test data is in $outdir"
>> +	fi
>> +	exit 1
>> +}
>> +
>> +cleanup()
>> +{
>> +	rm ${outdir}/*
>> +	rmdir $outdir
>> +}
>> +
>> +outdir=$(mktemp -d /tmp/clang_true.sh.XXXXXX)
>> +
>> +trap cleanup EXIT
>> +
>> +echo -n "Validation of BTF encoding of true_signatures: "
>> +
>> +clang_true="${outdir}/clang_true"
>> +CC=$(which clang 2>/dev/null)
>> +
>> +if [[ -z "$CC" ]]; then
>> +	echo "skip: clang not available"
>> +	exit 2
>> +fi
>> +
>> +cat > ${clang_true}.c << EOF
>> +struct t { int a; };
>> +__attribute__((noinline)) char *tar(struct t *a, struct t *d)
>> +{
>> +        if (a->a == d->a)
>> +                return (char *)10;
>> +        else
>> +                return (char *)0;
>> +}
>> +
>> +__attribute__((noinline)) static char * foo(struct t *a, int b1, int b2, int b3, int b4, int b5, int b6, struct t *d)
>> +{
>> +        return tar(a, d);
>> +}
>> +
>> +__attribute__((noinline)) char *bar(struct t *a, struct t *d)
>> +{
>> +        return foo(a, 1, 2, 3, 4, 5, 6, d);
>> +}
>> +
>> +struct t p1, p2;
>> +int main()
>> +{
>> +        return !!bar(&p1, &p2);
>> +}
>> +EOF
>> +
>> +CFLAGS="$CFLAGS -g -O2"
>> +${CC} ${CFLAGS} -o $clang_true ${clang_true}.c
>> +if [[ $? -ne 0 ]]; then
>> +	echo "Could not compile ${clang_true}.c" >& 2
>> +	exit 1
>> +fi
>> +LLVM_OBJCOPY=objcopy pahole -J --btf_features=+true_signature $clang_true
>> +if [[ $? -ne 0 ]]; then
>> +	echo "Could not encode BTF for $clang_true"
>> +	exit 1
>> +fi
>> +
>> +btf_optimized=$(pfunct --all --format_path=btf $clang_true |grep "foo")
>> +if [[ -z "$btf_optimized" ]]; then
>> +	echo "skip: no optimizations applied."
>> +	exit 2
>> +fi
>> +
>> +btf_cmp=$btf_optimized
>> +dwarf=$(pfunct --all $clang_true |grep "foo")
>> +
>> +test -n "$VERBOSE" && printf "\nBTF: $btf_optimized  DWARF: $dwarf \n"
>> +
>> +if [[ "$btf_cmp" == "$dwarf" ]]; then
>> +	echo "BTF and DWARF signatures should be different and they are not: BTF: $btf_optimized ; DWARF $dwarf"
>> +	exit 1
>> +else
>> +        echo ""
>> +        echo "  BTF:   $btf_optimized"
>> +        echo "  DWARF: $dwarf"
>> +fi
>> +echo "Ok"
>> +exit 0
>> diff --git a/tests/gcc_true_signatures.sh b/tests/true_signatures/gcc_true_signatures.sh
>> similarity index 100%
>> rename from tests/gcc_true_signatures.sh
>> rename to tests/true_signatures/gcc_true_signatures.sh

