Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B167148828
	for <dwarves@vger.kernel.org>; Wed, 18 Sep 2024 08:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726648890; cv=none; b=khezBDAYKbIyDjPnju8T1/S9GXvvPIYUsB6t5IVp+z556Dybi7daTvacixFRbPdVEEA20++s1Zv/sg/4wP/Yfvh4nnZYLKYvBX1T57GtxnUBEhowmlRlpZcZ1yErKnw77KiomEbT6+ciCcxDLlUuu7sLDkGgPpG8C6BwQTI5vtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726648890; c=relaxed/simple;
	bh=4nSi3/bIsaMK/G9AQsT3nLqv9f1bAl9LIP66OpByoss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YHljFAMkX3CdWQMVmstRI1L7Z8lQYCo/4kq6wbTWxnZJkJlcm3DIOfREsoCbFoOuAR7DUCDI+WztVRgDKXj0JydGuDygL5ymuzNhMQRA1DvMD/bzgE/RbbZhwNssgdyiOTv/gZ9Q1H+XStWTBcTGDVJRotcmZfu4US+u84Wesjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sV4V2Aor; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sV4V2Aor"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EE21C4CEC3;
	Wed, 18 Sep 2024 08:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726648889;
	bh=4nSi3/bIsaMK/G9AQsT3nLqv9f1bAl9LIP66OpByoss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sV4V2AorqPDgOT1qNVImfIEfklyQw4vlOi1w1T1xUjzi/AjqOLazEWoDuveI8ZEA9
	 McrE58mW/rrxWyFU2zKlvOgdoj9uIh9zuma9g2/cFvx3S+3ea9QAb3k2MAoKrZqsed
	 YKbgWll4KCG/oXmOnMWcsjJTR4dSxHLX2ct4VJt1/rydX+KiUoMAnnW2X1LNQFyXdK
	 dN0OtXxJhxq7UKwAMNHY/nIdWoWHz/gO+aIO1XHEq9cEnNhxDaVFWLwwgJT/Fuw/N2
	 QXUXc5l8OKJ0csH5DQq2xstvoAs6xebprLyHTYo9fm+xb6aY3P7+f+YoaTf0FxAEeW
	 KHAt9a9q5m/Wg==
Date: Wed, 18 Sep 2024 10:41:25 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: dwarves@vger.kernel.org, eddyz87@gmail.com, olsajiri@gmail.com,
	shung-hsi.yu@suse.com, jirislaby@kernel.org
Subject: Re: [PATCH v2 dwarves 3/3] tests: add test validating BTF encoding,
 reasons we skip functions
Message-ID: <ZuqSNU414XALGsuJ@x1>
References: <20240916134946.3893204-1-alan.maguire@oracle.com>
 <20240916134946.3893204-4-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916134946.3893204-4-alan.maguire@oracle.com>

On Mon, Sep 16, 2024 at 02:49:46PM +0100, Alan Maguire wrote:
> use pahole to encode BTF and pfunct to check that
> 
> - DWARF functions that made it into BTF match signatures
> - for functions we say we skipped, we did indeed skip them in BTF
>   encoding; and
> - it was correct to skip these functions
> 
> It is not possible to check everything, as pfunct does not
> print "."-suffixed optimized representations, and it does not
> analyze location calling conventions.  As a starting point we check
> for
> 
> - functions encoded in BTF match signatures with DWARF
> - functions with multiple incompatible return values
> - functions with incompatible parameter count/type
> 
> This test automates manual validation of encoding/skipping,
> and as such will be useful to ensure regressions are not
> introduced, for comparing gcc/LLVM-based DWARF representations
> etc.
> 
> The test takes ~5 minutes to run in all; output looks like this:
> 
> $ vmlinux=~/kbuild/bpf-next/vmlinux bash ./btf_functions.sh

I'm trying without specifying vmlinux, what we have now in the
tests/tests should find the one for the running kernel and use it, but
doing so I got tons of warnings about egrep usage, so I folded this:

diff --git a/tests/btf_functions.sh b/tests/btf_functions.sh
index 45094077809c1e3e..4a60a18845115d3d 100755
--- a/tests/btf_functions.sh
+++ b/tests/btf_functions.sh
@@ -69,7 +69,7 @@ const_insensitive=0
 for f in $funcs ; do
 	btf=$(grep " $f(" $outdir/btf.funcs)
 	# look for non-inline match first
-	dwarf=$(grep " $f(" $outdir/dwarf.funcs |egrep -v "^inline ")
+	dwarf=$(grep " $f(" $outdir/dwarf.funcs | grep -Ev "^inline ")
 	if [[ "$btf" != "$dwarf" ]]; then
 		# function might be declared inline in DWARF.
 		inline_dwarf=$(grep " $f(" $outdir/dwarf.funcs |grep "^inline ")

Running with it now:

root@x1:/home/acme/git/pahole# tests/tests 
  1: Validation of BTF encoding of functions; this may take some time...

Seems stuck, so:

root@x1:/home/acme/git/pahole# pahole --running_kernel_vmlinux
/usr/lib/debug/lib/modules/6.10.8-200.fc40.x86_64/vmlinux
root@x1:/home/acme/git/pahole#

Had to stop (traveling/LPC participation), so sending it now, what is
written above should already be useful :)

- Arnaldo

> Validation of BTF encoding of functions; this may take some time...
> Matched 55969 functions exactly.
> Matched 239 functions with inlines.
> Matched 1 functions with multiple const/non-const instances.
> Ok
> Validation of skipped function logic...
> Validating skipped functions are absent from BTF...
> Skipped encoding 748 functions in BTF.
> Ok
> Validating skipped functions have incompatible return values...
> Found 8 functions with multiple incompatible return values.
> Ok
> Validating skipped functions have incompatible params/counts...
> Found 116 instances with multiple instances with incompatible parameters.
> Found 2 instances where inline functions were not inlined and had incompatible parameters.
> Found 351 instances where the function name suggests optimizations led to inconsistent parameters.
> Ok
> 
> Suggested-by: Jiri Olsa <olsajiri@gmail.com>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tests/btf_functions.sh | 192 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 192 insertions(+)
>  create mode 100755 tests/btf_functions.sh
> 
> diff --git a/tests/btf_functions.sh b/tests/btf_functions.sh
> new file mode 100755
> index 0000000..4509407
> --- /dev/null
> +++ b/tests/btf_functions.sh
> @@ -0,0 +1,192 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Copyright (c) 2024, Oracle and/or its affiliates.
> +#
> +# Examine functions - especially those for which we skipped BTF encoding -
> +# to validate that they were indeed skipped for BTF encoding, and that they
> +# also should have been.
> +#
> +
> +outdir=
> +
> +fail()
> +{
> +	# Do not remove test dir; might be useful for analysis
> +	trap - EXIT
> +	if [[ -d "$outdir" ]]; then
> +		echo "Test data is in $outdir"
> +	fi
> +	exit 1
> +}
> +
> +cleanup()
> +{
> +	rm ${outdir}/*
> +	rmdir $outdir
> +}
> +
> +vmlinux=${vmlinux:-$1}
> +
> +if [ -z "$vmlinux" ] ; then
> +	vmlinux=$(pahole --running_kernel_vmlinux)
> +	if [ -z "$vmlinux" ] ; then
> +		echo "Please specify a vmlinux file to operate on"
> +		exit 1
> +	fi
> +fi
> +
> +if [ ! -f "$vmlinux" ] ; then
> +	echo "$vmlinux file not available, please specify another"
> +	exit 1
> +fi
> +
> +outdir=$(mktemp -d /tmp/btf_functions.sh.XXXXXX)
> +
> +trap cleanup EXIT
> +
> +test -n "$VERBOSE" && printf "Encoding..."
> +
> +pahole --btf_features=default --btf_encode_detached=$outdir/vmlinux.btf --verbose $vmlinux |grep "skipping BTF encoding of function" > ${outdir}/skipped_fns
> +
> +test -n "$VERBOSE" && printf "done.\n"
> +
> +echo "Validation of BTF encoding of functions; this may take some time..."
> +
> +funcs=$(pfunct --format_path=btf $outdir/vmlinux.btf |sort)
> +
> +# all functions from DWARF; some inline functions are not inlined so include them too
> +pfunct --all --no_parm_names --format_path=dwarf $vmlinux | \
> +	awk '{ print $0}'|sort|uniq > $outdir/dwarf.funcs
> +# all functions from BTF (removing bpf_kfunc prefix where found)
> +pfunct --all --no_parm_names --format_path=btf $outdir/vmlinux.btf |\
> +	awk '{ gsub("^bpf_kfunc ",""); print $0}'|sort|uniq > $outdir/btf.funcs
> +
> +exact=0
> +inline=0
> +const_insensitive=0
> +
> +for f in $funcs ; do
> +	btf=$(grep " $f(" $outdir/btf.funcs)
> +	# look for non-inline match first
> +	dwarf=$(grep " $f(" $outdir/dwarf.funcs |egrep -v "^inline ")
> +	if [[ "$btf" != "$dwarf" ]]; then
> +		# function might be declared inline in DWARF.
> +		inline_dwarf=$(grep " $f(" $outdir/dwarf.funcs |grep "^inline ")
> +		if [[ "inline $btf" != "$inline_dwarf" ]]; then
> +			# some functions have multiple instances in DWARF where one has
> +			# const param(s) and another does not (see errpos()).  We do not
> +			# mark these functions inconsistent as though they technically
> +			# have different prototypes, the data itself is not different.
> +			btf_noconst=$(echo $btf | awk '{gsub("const ",""); print $0 }')
> +			dwarf_noconst=$(echo $dwarf | awk '{gsub("const ",""); print $0 }')
> +			if [[ "$dwarf_noconst" =~ "$btf_noconst" ]]; then
> +				const_insensitive=$((const_insensitive+1))
> +			else
> +				echo "ERROR: mismatch for '$f()' : BTF '$btf' not found; DWARF '$dwarf'"
> +				fail
> +			fi
> +		else
> +			inline=$((inline+1))
> +		fi
> +	else
> +		exact=$((exact+1))
> +	fi
> +done
> +
> +echo "Matched $exact functions exactly."
> +echo "Matched $inline functions with inlines."
> +echo "Matched $const_insensitive functions with multiple const/non-const instances."
> +echo "Ok"
> +
> +echo "Validation of skipped function logic..."
> +
> +skipped_cnt=$(wc -l ${outdir}/skipped_fns | awk '{ print $1}')
> +
> +if [[ "$skipped_cnt" == "0" ]]; then
> +	echo "No skipped functions.  Done."
> +	exit 0
> +fi
> +
> +echo "Validating skipped functions are absent from BTF..."
> +
> +skipped_fns=$(awk '{print $1}' $outdir/skipped_fns)
> +for s in $skipped_fns ; do
> +	# Ensure the skipped function are not in BTF
> +	inbtf=$(grep " $s(" $outdir/btf.funcs)
> +	if [[ -n "$inbtf" ]]; then
> +		echo "ERROR: '${s}()' was added incorrectly to BTF: '$inbtf'"
> +		fail
> +	fi
> +done
> +
> +echo "Skipped encoding $skipped_cnt functions in BTF."
> +echo "Ok"
> +
> +echo "Validating skipped functions have incompatible return values..."
> +
> +return_mismatches=$(awk '/return type mismatch/ { print $1 }' $outdir/skipped_fns)
> +return_count=0
> +
> +for r in $return_mismatches ; do
> +	# Ensure there are multiple instances with incompatible return values
> +	grep " $r(" $outdir/dwarf.funcs | \
> +	awk -v FN=$r '{i = index($0, FN); if (i>0) print substr($0, 0, i-1) }' \
> +	| uniq > ${outdir}/retvals.$r
> +	test -n "$VERBOSE" && echo "'${r}()' has return values:"
> +	test -n "$VERBOSE" && cat ${outdir}/retvals.$r
> +	cnt=$(wc -l ${outdir}/retvals.$r | awk '{ print $1 }')
> +	if [[ $cnt -lt 2 ]]; then
> +		echo "ERROR: '${r}()' has only one return value; it should not be reported as having incompatible return values"
> +		fail
> +	fi
> +	return_count=$((return_count+1))
> +done
> +
> +echo "Found $return_count functions with multiple incompatible return values."
> +echo "Ok"
> +
> +echo "Validating skipped functions have incompatible params/counts..."
> +
> +param_mismatches=$(awk '/due to param / { print $1 }' $outdir/skipped_fns)
> +
> +multiple=0
> +multiple_inline=0
> +optimized=0
> +warnings=0
> +
> +for p in $param_mismatches ; do
> +	skipmsg=$(awk -v FN=$p '{ if ($1 == FN) print $0 }' $outdir/skipped_fns)
> +	altname=$(echo $skipmsg | awk '{ i=index($2,")"); print substr($2,2,i-2); }')
> +	if [[ "$altname" != "$p" ]]; then
> +		test -n "$VERBOSE" && echo "skipping optimized function $p ($altname); pfunct may not reflect late optimizations."
> +		optimized=$((optimized+1))
> +		continue
> +	fi
> +	# Ensure there are multiple instances with incompatible params
> +	grep " $p(" $outdir/dwarf.funcs | uniq > ${outdir}/protos.$p
> +	test -n "$VERBOSE" && echo "'${p}()' has prototypes:"
> +	test -n "$VERBOSE" && cat ${outdir}/protos.$p
> +	cnt=$(wc -l ${outdir}/protos.$p | awk '{ print $1 }')
> +	if [[ $cnt -lt 2 ]]; then
> +		# function may be inlined in multiple sites with different protos
> +		inlined=$(grep inline ${outdir}/protos.$p)
> +		if [[ -n "$inlined" ]]; then
> +			multiple_inline=$((multiple_inline+1))
> +		else
> +			echo "WARN: '${p}()' has only one prototype; if it was subject to late optimization, pfunct may not reflect inconsistencies pahole found."
> +			echo "Full skip message from pahole: $skipmsg"
> +			warnings=$((warnings+1))
> +		fi
> +	else
> +		multiple=$((multiple+1))
> +	fi
> +done
> +
> +echo "Found $multiple instances with multiple instances with incompatible parameters."
> +echo "Found $multiple_inline instances where inline functions were not inlined and had incompatible parameters."
> +echo "Found $optimized instances where the function name suggests optimizations led to inconsistent parameters."
> +echo "Found $warnings instances where pfunct did not notice inconsistencies."
> +echo "Ok"
> +
> +exit 0
> -- 
> 2.43.5
