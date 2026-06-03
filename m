Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959B03FCB27
	for <dwarves@vger.kernel.org>; Wed,  3 Jun 2026 21:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780523580; cv=none; b=c/InjMcz7XpBGgsw6DxcJCfU6nODw6SMOHUIMkajb880loGmJ+jDyZ4T2TZKhPGg5cVVp2WIhN6YPfxHsKOloECLppTvSEqQlOWFo84DsEu28gRf8tR07Wp9+SJDv8zoGVIbrrE4AQwD1Iu6yteT3IWXmdEz98CzYqlg4+mSfbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780523580; c=relaxed/simple;
	bh=1FFA7jfzyC1KLjjPnHUe4vFQ6VOP3AZW5dyL4G/fhXA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pes9SBZHjIEZXzW+M2n20aFbVoUTobAo2PusgaS3T7M97Qi70SbCMJlSzVtQSL8ZrYsiuYU+N0crPoODkusnIMEvCF/i+RKWg0FX4tVvumQV2zccgCsjWPj939LmrZgWUmQwQ6qdrwkxaPr/WpoFK1QqjBTbJHz95FXMqBSJzEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sDvlK58n; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sDvlK58n"
Message-ID: <a3d49856-4d7d-4429-a287-28e70952a56f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780523566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XV14Oh5b22FVMwPnSaRFvnAf0VNIpY/Bg4ibaOikVjQ=;
	b=sDvlK58nA8sYNC1xgjmVe57lds3GU35Q+DPmZWxwNUmJfRMvSWYyvBvoNY1zc8nklZ/eGx
	ntl9DOcZ0sqSyR0aFhRFkINj6E6KrSJJ8qwGmWvNxMfw9qZgxsnh5uNEzW4I+ViV3DW1bj
	R8fgRA7n5L4PEs6MO4ufGugzz1jcV0o=
Date: Wed, 3 Jun 2026 14:52:26 -0700
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PAHOLE v4 3/3] tests: Support GCC in pfunct-btf-decl-tags test
Content-Language: en-GB
To: Vineet Gupta <vineet.gupta@linux.dev>, dwarves@vger.kernel.org
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
 acme@kernel.org, Alan Maguire <alan.maguire@oracle.com>,
 Emil Tsalapatis <emil@etsalapatis.com>, jose.marchesi@oracle.com,
 David Faust <david.faust@oracle.com>
References: <20260602195512.1511013-1-vineet.gupta@linux.dev>
 <20260602195512.1511013-3-vineet.gupta@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260602195512.1511013-3-vineet.gupta@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 6/2/26 12:55 PM, Vineet Gupta wrote:
> GCC 16+ supports btf_decl_tag via DW_TAG_GNU_annotation. Update the
> test to run with both GCC (>= 16) and clang when available, instead
> of requiring clang only.
>
> Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>

LGTM but missing 'pahole -J' for clang test. See below.

Acked-by: Yonghong Song <yonghong.song@linux.dev>

> ---
>   tests/pfunct-btf-decl-tags.sh | 72 +++++++++++++++++++++++++++--------
>   1 file changed, 56 insertions(+), 16 deletions(-)
>
> diff --git a/tests/pfunct-btf-decl-tags.sh b/tests/pfunct-btf-decl-tags.sh
> index 35884b4e8687..a46aa1f3df55 100755
> --- a/tests/pfunct-btf-decl-tags.sh
> +++ b/tests/pfunct-btf-decl-tags.sh
> @@ -6,24 +6,36 @@
>   source test_lib.sh
>   
>   outdir=$(make_tmpdir)
> -tmpobj=$(make_tmpobj)
>   
>   # Comment this out to save test data.
>   trap cleanup EXIT
>   
>   title_log "Check that pfunct can print btf_decl_tags read from BTF."
>   
> -# gcc now also supports decl tags as of gcc commit 43dcea48b8c,
> -# in upstream version 16.
> -# UPTODO: add a check here for that.
> +# gcc 16+ supports decl tags via DW_TAG_GNU_annotation (gcc commit ac7027f180b).
>   
> +GCC=${GCC:-gcc}
>   CLANG=${CLANG:-clang}
> -if ! command -v $CLANG > /dev/null; then
> -	error_log "Need clang for test $0"
> +
> +use_gcc=0
> +if command -v $GCC > /dev/null; then
> +	gcc_ver=$($GCC -dumpversion 2>/dev/null | cut -d. -f1)
> +	if [ "$gcc_ver" -ge 16 ] 2>/dev/null; then
> +		use_gcc=1
> +	fi
> +fi
> +
> +use_clang=0
> +if command -v $CLANG > /dev/null; then
> +	use_clang=1
> +fi
> +
> +if [ "$use_gcc" -eq 0 ] && [ "$use_clang" -eq 0 ]; then
> +	error_log "Need gcc >= 16 or clang for test $0"
>   	test_fail
>   fi
>   
> -(cat <<EOF
> +src=$(cat <<EOF
>   #define __tag(x) __attribute__((btf_decl_tag(#x)))
>   
>   __tag(a) __tag(b) __tag(c) void foo(void) {}
> @@ -31,7 +43,7 @@ __tag(a) __tag(b)          void bar(void) {}
>   __tag(a)                   void buz(void) {}
>   
>   EOF
> -) | $CLANG --target=bpf -c -g -x c -o $tmpobj -
> +)
>   
>   # tags order is not guaranteed
>   sort_tags=$(cat <<EOF
> @@ -54,16 +66,44 @@ a void buz(void);
>   EOF
>   )
>   
> -out=$(pfunct -P -F btf $tmpobj | awk "$sort_tags" | sort)
> -d=$(diff -u <(echo "$expected") <(echo "$out"))
> +run_test() {
> +	local compiler=$1
> +	local tmpobj=$2
> +
> +	info_log "Testing with $compiler"
> +	out=$(pfunct -P -F btf $tmpobj | awk "$sort_tags" | sort)
> +	d=$(diff -u <(echo "$expected") <(echo "$out"))
> +
> +	if [[ "$d" == "" ]]; then
> +		info_log "  passed"
> +		return 0
> +	else
> +		error_log "pfunct output does not match expected ($compiler):"
> +		info_log "$d"
> +		info_log
> +		info_log "Complete output:"
> +		info_log "$out"
> +		return 1
> +	fi
> +}
> +
> +failed=0
> +
> +if [ "$use_gcc" -eq 1 ]; then
> +	tmpobj=$(make_tmpobj)
> +	echo "$src" | $GCC -c -g -x c -o $tmpobj - 2>/dev/null
> +	pahole -J $tmpobj 2>/dev/null
> +	run_test "$GCC (version $gcc_ver)" "$tmpobj" || failed=1
> +fi
> +
> +if [ "$use_clang" -eq 1 ]; then
> +	tmpobj=$(make_tmpobj)
> +	echo "$src" | $CLANG --target=bpf -c -g -x c -o $tmpobj -

missing 'pahole -J $tmpobj 2>/dev/null' here.

> +	run_test "$CLANG" "$tmpobj" || failed=1
> +fi
>   
> -if [[ "$d" == "" ]]; then
> +if [ "$failed" -eq 0 ]; then
>   	test_pass
>   else
> -	error_log "pfunct output does not match expected:"
> -	info_log "$d"
> -	info_log
> -	info_log "Complete output:"
> -	info_log "$out"
>   	test_fail
>   fi

