Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E77A379C26
	for <dwarves@vger.kernel.org>; Thu, 18 Jun 2026 04:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781758055; cv=none; b=n0sA9L4FRgpXWulpS8f0f0YfC2YoVroueTQbVEA+zILgibDMToY84/v586j19YXPaRm3ULsN1H5pJZxsM+xhRPDeBC/CdFDIITn3MWRYSb2NV7vIAVDmBxNSEiwMyGgrsvRGI8MpOGwDQrWJqVw4E0NSlO4KuV2vlcTrLAqHJPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781758055; c=relaxed/simple;
	bh=Mb4Zi4FhYXPvafxre44HTnBVfu+eJNVkbkpa53bXA8w=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=gdEHovNW+rxZJlM4X0CYKEgxxnV3dUgA8KLk9NsHsvg79FkviuFu+gvkM1s0GAjLfbTiHbEDm86BXeD2Sj5rgVvjJcwtEAynAFiU/pm0yZWFHboQ69ge/ylETAVnfxu2mFfS3TOzGsH/fagv09oCSKjDA5oCAwTMzOw73dEmoWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=Q6mDncLR; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="Q6mDncLR"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-36d5b11201aso308229a91.2
        for <dwarves@vger.kernel.org>; Wed, 17 Jun 2026 21:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1781758051; x=1782362851; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DwUky26FT/nTCe+WQP1PZFOZPyIRVsu6jmYMD3jo4Ho=;
        b=Q6mDncLRa8k/lQJAAnk6VeLzpilzX64u8/NwPivMAgoDqfhbrRhyCgKJE64lk3MRBW
         Joi83COXJ/UHkbUFlHF2k6dtMI/MiScbNhrMX6+AHB9MYoivs0+GZmSDUQS1jJXRu2Yo
         fBJODtYewRjRFkIF8r68MK82hvD0L/EUt1g/Yl3YpliJ86B6D97FWbpCsKhychKDduHj
         FSu72+fG/LLcpg4xiBbVsRJ2k4AIkrQRUUGQD+0iShujO6AMPJ9B31/ZbWsccoTGJLbl
         ceAlNP7K2YGkresIuxeehfhoUv7VuwExi7C1ZggD/eYP/2/N/ayhH5Tg6DHJVi/aftxR
         BSew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781758051; x=1782362851;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DwUky26FT/nTCe+WQP1PZFOZPyIRVsu6jmYMD3jo4Ho=;
        b=cKRdYxH4apMBzrfPY36hcHZFs40DnE2oNQLixTfneIeD718bOqnYS3CvmIQr+fUH0Y
         GEyUxveYv6Q8UoaL/iInpPFzpz0nw+xbK3P9dPUbwT5jeaIbIDLQThMlBhWRvfpZLKHr
         FhNDFbzxWeNw99ZocD7H3nB4qXDpOuAuTx+IAwfv6WRc5PLgd+ahlrO8lQQGdI3rNoHg
         9nxLnGd9QvWKKxRbJc1ou4nVmfkZlyPSovSILmqP8SKLXerqnKN+CFd1/Nuf5vpOaN3/
         wWo7rxL+pr4OpIfIEF0SZgzRBtySUUf3lVLn1EVvf3hVyXvLeEiUQASC6GWhYBwBABPo
         5yfA==
X-Forwarded-Encrypted: i=1; AFNElJ/5jdS8XAObkHkIu8sY9r5yb5iO/ogxCzdu7y33IQsy8mzbKxne33YSjBCAKopVkLFHQ89iQvXy@vger.kernel.org
X-Gm-Message-State: AOJu0YwN8Hw/5QuBJ5bMcnJ1YkWNUAbQd5Ku53hVkA9Mjcfp8wsT5Xxi
	f60+KuC0EWlSD9LFImZP+ahLekMQNtsZu5dv9pgAy6BbhF0wJVmF2B0MSpYCghbm2fg=
X-Gm-Gg: AfdE7cmysfM5qB6O2R2IRLlr5xWwERzQFpyMNkphf2qVdS5sY7wnVX2k2NLHfbJjTHJ
	OxME2elU6IveYIKME38i88o3o9Ly34ogUll+kdoQMIzAkm/EnFAc828nRdUwUrbej6RHCI0B/Ix
	xCP5r43hoZto1ElLL98ZoynGZUVZizpZ9sGbnnYBJNRkSvFgEvZ+0Ti/6m1OyYt13qgyzoFywDg
	4qj59glYDsR6kJls6DIljaDiiZCo8vOFikie0P65k1qeZl+VZiFWbt+j1PSn+53gLkc56tb/Ob8
	E79sM6Uuc5JFy0GrPFKhPVGw7C7V1VmdxroOCxF6t7YyxTNFDl6iDC9CRRRq62WiEy1s1pABBf7
	dvcf/jW2R8MWyFRD3ZTdMGOM1cAg9K4Aj3BSRWX9dxUG8WTu0X0is2RCeUn5rViiYxAyyNsbCDw
	nuJwh1wNTgqB8M6dous11cGe35eUq5a/i77GYBVZ5Rh7z1uIKnpWewAd0=
X-Received: by 2002:a17:903:2b03:b0:2c0:d8ee:7d66 with SMTP id d9443c01a7336-2c6e52b7e2dmr22128615ad.36.1781758051470;
        Wed, 17 Jun 2026 21:47:31 -0700 (PDT)
Received: from localhost (S0106d8b37028eeb5.vc.shawcable.net. [24.84.91.85])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8663352fd4sm15529055a12.12.2026.06.17.21.47.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 21:47:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 18 Jun 2026 00:47:30 -0400
Message-Id: <DJBWIKFFVWDX.124XRXJK8VA48@etsalapatis.com>
Cc: <bpf@vger.kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>,
 <acme@kernel.org>, "Alan Maguire" <alan.maguire@oracle.com>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, <jose.marchesi@oracle.com>, "David
 Faust" <david.faust@oracle.com>, "Yonghong Song" <yonghong.song@linux.dev>
Subject: Re: [PAHOLE v5 5/5] tests: Add btf_type_tag ordering test
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Vineet Gupta" <vineet.gupta@linux.dev>, <dwarves@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260618005731.273181-1-vineet.gupta@linux.dev>
 <20260618005731.273181-6-vineet.gupta@linux.dev>
In-Reply-To: <20260618005731.273181-6-vineet.gupta@linux.dev>

On Wed Jun 17, 2026 at 8:57 PM EDT, Vineet Gupta wrote:
> From: Alan Maguire <alan.maguire@oracle.com>
>
> Add a test that compiles a pointer carrying two btf_type_tags
> (__tag(outer) __tag(inner)) and checks the BTF that pahole emits to
> ensure the tag chain is PTR -> TYPE_TAG inner -> TYPE_TAG outer ->
> struct sample, i.e. the innermost tag is closest to the pointer.
>
> This exercises the type_tag ordering for both encodings: LLVM emits the
> annotations as child DIEs in source order (reversed when building the
> tag list), while GCC chains them via DW_AT_GNU_annotation already in BTF
> order. The test runs with gcc and clang when they support btf_type_tag,
> and is skipped when bpftool is unavailable.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
> ---

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

>  tests/btf_type_tag_order.sh | 179 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 179 insertions(+)
>  create mode 100755 tests/btf_type_tag_order.sh
>
> diff --git a/tests/btf_type_tag_order.sh b/tests/btf_type_tag_order.sh
> new file mode 100755
> index 000000000000..09d1ac346000
> --- /dev/null
> +++ b/tests/btf_type_tag_order.sh
> @@ -0,0 +1,179 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +# Check that pahole preserves btf_type_tag order when emitting BTF from =
DWARF.
> +
> +source test_lib.sh
> +
> +outdir=3D$(make_tmpdir)
> +
> +# Comment this out to save test data.
> +trap cleanup EXIT
> +
> +title_log "Check BTF type tag order."
> +
> +GCC=3D${GCC:-gcc}
> +CLANG=3D${CLANG:-clang}
> +PAHOLE=3D${PAHOLE:-pahole}
> +BPFTOOL=3D${BPFTOOL:-bpftool}
> +
> +if ! command -v "$BPFTOOL" > /dev/null; then
> +	info_log "skip: bpftool not available"
> +	test_skip
> +fi
> +
> +compiler_has_btf_type_tag()
> +{
> +	local compiler=3D$1
> +
> +	if ! command -v "$compiler" > /dev/null; then
> +		return 1
> +	fi
> +
> +	"$compiler" -x c -E -P - <<'EOF' 2>/dev/null | grep -qx 1
> +#ifndef __has_attribute
> +#define __has_attribute(x) 0
> +#endif
> +#if __has_attribute(btf_type_tag)
> +1
> +#else
> +0
> +#endif
> +EOF
> +}
> +
> +use_gcc=3D0
> +if compiler_has_btf_type_tag "$GCC"; then
> +	use_gcc=3D1
> +fi
> +
> +use_clang=3D0
> +if compiler_has_btf_type_tag "$CLANG"; then
> +	use_clang=3D1
> +fi
> +
> +if [ "$use_gcc" -eq 0 ] && [ "$use_clang" -eq 0 ]; then
> +	error_log "Need gcc or clang with btf_type_tag support for test $0"
> +	test_fail
> +fi
> +
> +src=3D$(cat <<EOF
> +#define __tag(x) __attribute__((btf_type_tag(#x)))
> +
> +struct sample {
> +	int value;
> +};
> +
> +struct sample __tag(outer) __tag(inner) *global_ptr;
> +
> +EOF
> +)
> +
> +check_type_tag_order()
> +{
> +	local btf=3D$1
> +	local dump
> +
> +	if ! dump=3D$("$BPFTOOL" btf dump file "$btf"); then
> +		return 1
> +	fi
> +
> +	printf '%s\n' "$dump" | awk '
> +	function parse_id(line, m) {
> +		if (match(line, /^\[([0-9]+)\]/, m))
> +			return m[1]
> +		return 0
> +	}
> +	function parse_name(line, m) {
> +		if (match(line, /\047([^\047]*)\047/, m))
> +			return m[1]
> +		return ""
> +	}
> +	function parse_type(line, m) {
> +		if (match(line, /type_id=3D([0-9]+)/, m))
> +			return m[1]
> +		return 0
> +	}
> +	function check_ptr(ptr, id, tags, seen) {
> +		id =3D type[ptr]
> +		while (id !=3D 0 && !seen[id]) {
> +			seen[id] =3D 1
> +			if (kind[id] =3D=3D "TYPE_TAG") {
> +				tags =3D tags (tags =3D=3D "" ? "" : " -> ") name[id]
> +				id =3D type[id]
> +				continue
> +			}
> +			if (kind[id] =3D=3D "STRUCT" && name[id] =3D=3D "sample") {
> +				if (tags =3D=3D "inner -> outer")
> +					exit 0
> +				candidates =3D candidates (candidates =3D=3D "" ? "" : ", ") tags
> +			}
> +			return
> +		}
> +	}
> +	/^\[[0-9]+\]/ {
> +		id =3D parse_id($0)
> +		kind[id] =3D $2
> +		name[id] =3D parse_name($0)
> +		type[id] =3D parse_type($0)
> +		if (kind[id] =3D=3D "PTR")
> +			ptrs[++nr_ptrs] =3D id
> +	}
> +	END {
> +		for (i =3D 1; i <=3D nr_ptrs; i++)
> +			check_ptr(ptrs[i])
> +		if (candidates !=3D "") {
> +			print "type tag order mismatch; expected inner -> outer, found " cand=
idates > "/dev/stderr"
> +			exit 1
> +		}
> +		print "could not find tagged pointer to struct sample" > "/dev/stderr"
> +		exit 1
> +	}'
> +}
> +
> +run_test()
> +{
> +	local compiler=3D$1
> +	local tmpobj=3D$2
> +	local btf=3D$3
> +
> +	info_log "Testing with $compiler"
> +
> +	if ! echo "$src" | "$compiler" -g -c -x c -o "$tmpobj" - 2>/dev/null; t=
hen
> +		error_log "Could not compile type tag order test with $compiler"
> +		return 1
> +	fi
> +
> +	if ! "$PAHOLE" --btf_features=3D+type_tag --btf_encode_detached=3D"$btf=
" "$tmpobj" 2>/dev/null; then
> +		error_log "Could not encode BTF for $tmpobj"
> +		return 1
> +	fi
> +
> +	if check_type_tag_order "$btf"; then
> +		info_log "  passed"
> +		return 0
> +	fi
> +
> +	error_log "BTF type tag order does not match expected order ($compiler)=
"
> +	return 1
> +}
> +
> +failed=3D0
> +
> +if [ "$use_gcc" -eq 1 ]; then
> +	tmpobj=3D$(make_tmpobj)
> +	btf=3D${tmpobj%.o}.btf
> +	run_test "$GCC" "$tmpobj" "$btf" || failed=3D1
> +fi
> +
> +if [ "$use_clang" -eq 1 ]; then
> +	tmpobj=3D$(make_tmpobj)
> +	btf=3D${tmpobj%.o}.btf
> +	run_test "$CLANG" "$tmpobj" "$btf" || failed=3D1
> +fi
> +
> +if [ "$failed" -eq 0 ]; then
> +	test_pass
> +else
> +	test_fail
> +fi

