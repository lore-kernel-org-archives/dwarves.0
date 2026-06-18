Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219F13905E0;
	Thu, 18 Jun 2026 13:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781789154; cv=none; b=f3JaWuT9FtILG1ZonFjaQSBZ2n1NWkWO6l656Pz7v5CkbHGzeNX91y1J2+DSPLILOmy7G/Dm8lQdJHcFAxWyDeJ6B2LJXo9A9+5ojN2rHWBz7rnVCfLxKvC1P+kq73XrTovFJqqmo35p/h2STbJxrmHCnIxjo/nfS4lofOiOV04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781789154; c=relaxed/simple;
	bh=7a+1nS+3AtvWfltEK3dgAIjCqrbGyBhljeCGCX6fgT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l7CR76MRTGE3qa9F+Ft5ZTSbNUlXkBhZm1TttdZJ2j2a2CzeUL5KRRj0QDyjITsBtP4r69ScRBIQ5+ad8/gbEo4IpuGSXl/fENdeWcQzg4QyijCxzm/AGsIWjxBPZdoLR4yLOsmPIF3qniZfKEDMFf13pnJ/TxZZ63GZWxGeCgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NORQgV68; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NORQgV68"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 259B11F000E9;
	Thu, 18 Jun 2026 13:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781789152;
	bh=4W1RLUE8guFTSrBk9vPFBfdXZNFmUtn9INaAh5FUJcA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NORQgV68tsBb9qLnzn/VWeJ/z2f0tEBXMHUbHzfYAVJHCNX3hOftFWdpW+JT8Qmkq
	 RZtxMSwlK3eNdzVhroINxj7EueCX3qLiOEKHf4wRvT2/GXcmCkUcGVi3GXD9mPRxMo
	 WB/iwdOvrfrQryM7LyhgmC3tR/VRkl+liBQi/RLqPz9tmpsbQUR7JTRq4Wh1zvOuVa
	 UWRVzEejznAZWVNJORRi4MlRmuP8U1a1yzcPFuQ7rG5X3s9kPKi9DJiYEDiunhJqtr
	 6yqBqRTMkW0fx7ihNIApSUfqO2/cyfIpUUdK0cyHONZtt0Y4UmbmOgvftWflR1ky0E
	 RmnEfKvRcWWrQ==
Date: Thu, 18 Jun 2026 10:25:49 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: Vineet Gupta <vineet.gupta@linux.dev>, dwarves@vger.kernel.org,
	bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>, jose.marchesi@oracle.com,
	David Faust <david.faust@oracle.com>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PAHOLE v5 5/5] tests: Add btf_type_tag ordering test
Message-ID: <ajPx3Y-LVhwN0jM4@x1>
References: <20260618005731.273181-1-vineet.gupta@linux.dev>
 <20260618005731.273181-6-vineet.gupta@linux.dev>
 <DJBWIKFFVWDX.124XRXJK8VA48@etsalapatis.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DJBWIKFFVWDX.124XRXJK8VA48@etsalapatis.com>

On Thu, Jun 18, 2026 at 12:47:30AM -0400, Emil Tsalapatis wrote:
> On Wed Jun 17, 2026 at 8:57 PM EDT, Vineet Gupta wrote:
> > From: Alan Maguire <alan.maguire@oracle.com>
> >
> > Add a test that compiles a pointer carrying two btf_type_tags
> > (__tag(outer) __tag(inner)) and checks the BTF that pahole emits to
> > ensure the tag chain is PTR -> TYPE_TAG inner -> TYPE_TAG outer ->
> > struct sample, i.e. the innermost tag is closest to the pointer.
> >
> > This exercises the type_tag ordering for both encodings: LLVM emits the
> > annotations as child DIEs in source order (reversed when building the
> > tag list), while GCC chains them via DW_AT_GNU_annotation already in BTF
> > order. The test runs with gcc and clang when they support btf_type_tag,
> > and is skipped when bpftool is unavailable.
> >
> > Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> > Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
> > ---
> 
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>

- Arnaldo
 
> >  tests/btf_type_tag_order.sh | 179 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 179 insertions(+)
> >  create mode 100755 tests/btf_type_tag_order.sh
> >
> > diff --git a/tests/btf_type_tag_order.sh b/tests/btf_type_tag_order.sh
> > new file mode 100755
> > index 000000000000..09d1ac346000
> > --- /dev/null
> > +++ b/tests/btf_type_tag_order.sh
> > @@ -0,0 +1,179 @@
> > +#!/bin/bash
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +
> > +# Check that pahole preserves btf_type_tag order when emitting BTF from DWARF.
> > +
> > +source test_lib.sh
> > +
> > +outdir=$(make_tmpdir)
> > +
> > +# Comment this out to save test data.
> > +trap cleanup EXIT
> > +
> > +title_log "Check BTF type tag order."
> > +
> > +GCC=${GCC:-gcc}
> > +CLANG=${CLANG:-clang}
> > +PAHOLE=${PAHOLE:-pahole}
> > +BPFTOOL=${BPFTOOL:-bpftool}
> > +
> > +if ! command -v "$BPFTOOL" > /dev/null; then
> > +	info_log "skip: bpftool not available"
> > +	test_skip
> > +fi
> > +
> > +compiler_has_btf_type_tag()
> > +{
> > +	local compiler=$1
> > +
> > +	if ! command -v "$compiler" > /dev/null; then
> > +		return 1
> > +	fi
> > +
> > +	"$compiler" -x c -E -P - <<'EOF' 2>/dev/null | grep -qx 1
> > +#ifndef __has_attribute
> > +#define __has_attribute(x) 0
> > +#endif
> > +#if __has_attribute(btf_type_tag)
> > +1
> > +#else
> > +0
> > +#endif
> > +EOF
> > +}
> > +
> > +use_gcc=0
> > +if compiler_has_btf_type_tag "$GCC"; then
> > +	use_gcc=1
> > +fi
> > +
> > +use_clang=0
> > +if compiler_has_btf_type_tag "$CLANG"; then
> > +	use_clang=1
> > +fi
> > +
> > +if [ "$use_gcc" -eq 0 ] && [ "$use_clang" -eq 0 ]; then
> > +	error_log "Need gcc or clang with btf_type_tag support for test $0"
> > +	test_fail
> > +fi
> > +
> > +src=$(cat <<EOF
> > +#define __tag(x) __attribute__((btf_type_tag(#x)))
> > +
> > +struct sample {
> > +	int value;
> > +};
> > +
> > +struct sample __tag(outer) __tag(inner) *global_ptr;
> > +
> > +EOF
> > +)
> > +
> > +check_type_tag_order()
> > +{
> > +	local btf=$1
> > +	local dump
> > +
> > +	if ! dump=$("$BPFTOOL" btf dump file "$btf"); then
> > +		return 1
> > +	fi
> > +
> > +	printf '%s\n' "$dump" | awk '
> > +	function parse_id(line, m) {
> > +		if (match(line, /^\[([0-9]+)\]/, m))
> > +			return m[1]
> > +		return 0
> > +	}
> > +	function parse_name(line, m) {
> > +		if (match(line, /\047([^\047]*)\047/, m))
> > +			return m[1]
> > +		return ""
> > +	}
> > +	function parse_type(line, m) {
> > +		if (match(line, /type_id=([0-9]+)/, m))
> > +			return m[1]
> > +		return 0
> > +	}
> > +	function check_ptr(ptr, id, tags, seen) {
> > +		id = type[ptr]
> > +		while (id != 0 && !seen[id]) {
> > +			seen[id] = 1
> > +			if (kind[id] == "TYPE_TAG") {
> > +				tags = tags (tags == "" ? "" : " -> ") name[id]
> > +				id = type[id]
> > +				continue
> > +			}
> > +			if (kind[id] == "STRUCT" && name[id] == "sample") {
> > +				if (tags == "inner -> outer")
> > +					exit 0
> > +				candidates = candidates (candidates == "" ? "" : ", ") tags
> > +			}
> > +			return
> > +		}
> > +	}
> > +	/^\[[0-9]+\]/ {
> > +		id = parse_id($0)
> > +		kind[id] = $2
> > +		name[id] = parse_name($0)
> > +		type[id] = parse_type($0)
> > +		if (kind[id] == "PTR")
> > +			ptrs[++nr_ptrs] = id
> > +	}
> > +	END {
> > +		for (i = 1; i <= nr_ptrs; i++)
> > +			check_ptr(ptrs[i])
> > +		if (candidates != "") {
> > +			print "type tag order mismatch; expected inner -> outer, found " candidates > "/dev/stderr"
> > +			exit 1
> > +		}
> > +		print "could not find tagged pointer to struct sample" > "/dev/stderr"
> > +		exit 1
> > +	}'
> > +}
> > +
> > +run_test()
> > +{
> > +	local compiler=$1
> > +	local tmpobj=$2
> > +	local btf=$3
> > +
> > +	info_log "Testing with $compiler"
> > +
> > +	if ! echo "$src" | "$compiler" -g -c -x c -o "$tmpobj" - 2>/dev/null; then
> > +		error_log "Could not compile type tag order test with $compiler"
> > +		return 1
> > +	fi
> > +
> > +	if ! "$PAHOLE" --btf_features=+type_tag --btf_encode_detached="$btf" "$tmpobj" 2>/dev/null; then
> > +		error_log "Could not encode BTF for $tmpobj"
> > +		return 1
> > +	fi
> > +
> > +	if check_type_tag_order "$btf"; then
> > +		info_log "  passed"
> > +		return 0
> > +	fi
> > +
> > +	error_log "BTF type tag order does not match expected order ($compiler)"
> > +	return 1
> > +}
> > +
> > +failed=0
> > +
> > +if [ "$use_gcc" -eq 1 ]; then
> > +	tmpobj=$(make_tmpobj)
> > +	btf=${tmpobj%.o}.btf
> > +	run_test "$GCC" "$tmpobj" "$btf" || failed=1
> > +fi
> > +
> > +if [ "$use_clang" -eq 1 ]; then
> > +	tmpobj=$(make_tmpobj)
> > +	btf=${tmpobj%.o}.btf
> > +	run_test "$CLANG" "$tmpobj" "$btf" || failed=1
> > +fi
> > +
> > +if [ "$failed" -eq 0 ]; then
> > +	test_pass
> > +else
> > +	test_fail
> > +fi
