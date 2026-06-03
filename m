Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BA7304976
	for <dwarves@vger.kernel.org>; Wed,  3 Jun 2026 20:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780519468; cv=none; b=X8DYZAjZgNNyBburbgfPF6F1D49bVdGw8K59VfbeMCkPO6jxhUn/geOITJzWb6BtNSvqgp2NtImnX6orFhrg9cjJhGz3aed6H52GrxPRQyBqNce7NBZeo5rSkpfvIrh29Tq0bylVBTK4jzYCkaNY8BQ81qEUFJrJW59awZQItyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780519468; c=relaxed/simple;
	bh=Xsxnu+t7r2JLJ+HvQNxgV/7N37onpmizU7YvE2O91Z8=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=o8D5JUdXchic8P/7gZFhdoUy7wZ+6BX1NB8ZQPlXTuc5QzeKk0zkSSFsgtmNEPgLpyIvq9Z1zDrP/8Md07YQZY7IhYBZsqrSx/mGbX7USfV+LCbw9D/q3uN7mzvPcjOpFALCZSGCe4RmH0HNx5X6dthZPrrn47HZGi+ZioZonWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=wEguWJEb; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="wEguWJEb"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1370417c01cso13437023c88.1
        for <dwarves@vger.kernel.org>; Wed, 03 Jun 2026 13:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1780519466; x=1781124266; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=49U9zuaCrRFc16K07IX5eMfLgjnW0VawFcMW+R70KvI=;
        b=wEguWJEb3Xlwgz1EZWtcX6RPsuriKVQe9wgGalGoRrVCUXxmlsmg2SC3hr0jfSwDf5
         AX4EKeDlKVmZoxqvsGunTsDGpSXGJlxG/KS+vQAFipZYBxRF4tRVEWalU1e0h6rJLKnj
         b6zoch1dSLiCDH/r/kzaAalJRtZAPfo4Yhbcgz06DTZPuZP9wur6yCTC20ICPoPGA6UY
         O5YMHZ8ybJESpooJoApQPAwDhKG4in7Y9tSdIhPER3qglVKEb+bbPzOQJexHjJVBKMWE
         +MJjASbFx2GmCLyt/QZMbI3BCU+lpL+AEWFZh7d+gOf+BBHeNetadPoEFlv9V3ZSL0bX
         PxHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780519466; x=1781124266;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=49U9zuaCrRFc16K07IX5eMfLgjnW0VawFcMW+R70KvI=;
        b=rOhd7yaJ4QvvnKBNyAZIAn5zfxJFgm3pAee5O0Gtp94MG5ygJl3c1bymeoKikuPh8p
         H1UlE8f7lFz90MYs02wodOaAO0ZYqUupv4Jb0kjc8nHi5P3bfqyfFQ3sajNcUQYShDvD
         vnRuULk657Cuj4NQlPGF0vzxa7pzWy+lo5vPncIehwQXy+EBlgD9xT6XXVULjXtVg5DC
         3Sl8WGUi75i3Uwd4fnRTLM4HihWvVQ7aSZbEgbMKAlkPO/uAGBaikiyqjvGFzm8sgWPr
         8CcueutsiKNCAhFwSxu+JJqz5Yu256HW2+GylUBiXjGQv0zdScX9gVpZu8LaPMM7H9Qv
         qZmQ==
X-Forwarded-Encrypted: i=1; AFNElJ9thnYcju8A3kjuikNv0Sggw0wNlKUuSyflnzT7RWq8Yn6dxlQ4Jzk98xaQviLOAax0TDXMXcI4@vger.kernel.org
X-Gm-Message-State: AOJu0YwVLmmPk192gwrsBl4Z6wbNKCHXQvjeItvgvGltV2oP0T71hsEB
	6CvwE36ZWnfuVObwbO7khVEyXqOsHT8oDjhr4/PJpHwiu3SvCyH/MNHGe+QEhZegdp8=
X-Gm-Gg: Acq92OEXkd+/+XCiqk4Mrgui7SC5eQFzbkcpX2SSxNsQO/b84sFlEprYcIq/fFW8CIy
	TcPuJ79jADAjbZLQR7kmSogAOIISsbg9xMMGn9dywt+GLka35wj9BCHyUW6LuCBIkyESB+OotWw
	acG1BNItb2qGFviQj5D2BA+ZJYMKF8mR5gkRGsDE7+dB11Ce3Cb7BTMl6w+uK3r8qTpHjHsdkRZ
	VoSWh+dDpNpESiaz095GpJAblTZ6IoXH/esK+PFtc/YZV8SAvY/mXwpW7BUjr+euhBpK2BH4G9G
	7D+Vjg7S51axCBqezeNVtEX2liV2lziWb9Zeif/pCI59WUyJthQudhGYmllfDIF04sSeBmjgj8H
	mMTRZQIJpJl9n9YxxLI+sEmVo7JGfMMAGP5UVHCKPU7CJb/FNuqOYf3Z5wpeMqrClGTjvHa8ooV
	+WKHAsi3kVCo00Hjk=
X-Received: by 2002:a05:7022:60d:b0:130:760b:77aa with SMTP id a92af1059eb24-137f6c25649mr2259484c88.41.1780519466200;
        Wed, 03 Jun 2026 13:44:26 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::4ada])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137f716017esm3108451c88.15.2026.06.03.13.44.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 13:44:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 03 Jun 2026 16:44:23 -0400
Message-Id: <DIZPH1MFO1TW.NPPNVHBBCMHT@etsalapatis.com>
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Vineet Gupta" <vineet.gupta@linux.dev>, <dwarves@vger.kernel.org>
Cc: <bpf@vger.kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>,
 <acme@kernel.org>, "Alan Maguire" <alan.maguire@oracle.com>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, <jose.marchesi@oracle.com>, "David
 Faust" <david.faust@oracle.com>
Subject: Re: [PAHOLE v4 3/3] tests: Support GCC in pfunct-btf-decl-tags test
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260602195512.1511013-1-vineet.gupta@linux.dev>
 <20260602195512.1511013-3-vineet.gupta@linux.dev>
In-Reply-To: <20260602195512.1511013-3-vineet.gupta@linux.dev>

On Tue Jun 2, 2026 at 3:55 PM EDT, Vineet Gupta wrote:
> GCC 16+ supports btf_decl_tag via DW_TAG_GNU_annotation. Update the
> test to run with both GCC (>=3D 16) and clang when available, instead
> of requiring clang only.
>
> Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  tests/pfunct-btf-decl-tags.sh | 72 +++++++++++++++++++++++++++--------
>  1 file changed, 56 insertions(+), 16 deletions(-)
>
> diff --git a/tests/pfunct-btf-decl-tags.sh b/tests/pfunct-btf-decl-tags.s=
h
> index 35884b4e8687..a46aa1f3df55 100755
> --- a/tests/pfunct-btf-decl-tags.sh
> +++ b/tests/pfunct-btf-decl-tags.sh
> @@ -6,24 +6,36 @@
>  source test_lib.sh
> =20
>  outdir=3D$(make_tmpdir)
> -tmpobj=3D$(make_tmpobj)
> =20
>  # Comment this out to save test data.
>  trap cleanup EXIT
> =20
>  title_log "Check that pfunct can print btf_decl_tags read from BTF."
> =20
> -# gcc now also supports decl tags as of gcc commit 43dcea48b8c,
> -# in upstream version 16.
> -# UPTODO: add a check here for that.
> +# gcc 16+ supports decl tags via DW_TAG_GNU_annotation (gcc commit ac702=
7f180b).
> =20
> +GCC=3D${GCC:-gcc}
>  CLANG=3D${CLANG:-clang}
> -if ! command -v $CLANG > /dev/null; then
> -	error_log "Need clang for test $0"
> +
> +use_gcc=3D0
> +if command -v $GCC > /dev/null; then
> +	gcc_ver=3D$($GCC -dumpversion 2>/dev/null | cut -d. -f1)
> +	if [ "$gcc_ver" -ge 16 ] 2>/dev/null; then
> +		use_gcc=3D1
> +	fi
> +fi
> +
> +use_clang=3D0
> +if command -v $CLANG > /dev/null; then
> +	use_clang=3D1
> +fi
> +
> +if [ "$use_gcc" -eq 0 ] && [ "$use_clang" -eq 0 ]; then
> +	error_log "Need gcc >=3D 16 or clang for test $0"
>  	test_fail
>  fi
> =20
> -(cat <<EOF
> +src=3D$(cat <<EOF
>  #define __tag(x) __attribute__((btf_decl_tag(#x)))
> =20
>  __tag(a) __tag(b) __tag(c) void foo(void) {}
> @@ -31,7 +43,7 @@ __tag(a) __tag(b)          void bar(void) {}
>  __tag(a)                   void buz(void) {}
> =20
>  EOF
> -) | $CLANG --target=3Dbpf -c -g -x c -o $tmpobj -
> +)
> =20
>  # tags order is not guaranteed
>  sort_tags=3D$(cat <<EOF
> @@ -54,16 +66,44 @@ a void buz(void);
>  EOF
>  )
> =20
> -out=3D$(pfunct -P -F btf $tmpobj | awk "$sort_tags" | sort)
> -d=3D$(diff -u <(echo "$expected") <(echo "$out"))
> +run_test() {
> +	local compiler=3D$1
> +	local tmpobj=3D$2
> +
> +	info_log "Testing with $compiler"
> +	out=3D$(pfunct -P -F btf $tmpobj | awk "$sort_tags" | sort)
> +	d=3D$(diff -u <(echo "$expected") <(echo "$out"))
> +
> +	if [[ "$d" =3D=3D "" ]]; then
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
> +failed=3D0
> +
> +if [ "$use_gcc" -eq 1 ]; then
> +	tmpobj=3D$(make_tmpobj)
> +	echo "$src" | $GCC -c -g -x c -o $tmpobj - 2>/dev/null
> +	pahole -J $tmpobj 2>/dev/null
> +	run_test "$GCC (version $gcc_ver)" "$tmpobj" || failed=3D1
> +fi
> +
> +if [ "$use_clang" -eq 1 ]; then
> +	tmpobj=3D$(make_tmpobj)
> +	echo "$src" | $CLANG --target=3Dbpf -c -g -x c -o $tmpobj -
> +	run_test "$CLANG" "$tmpobj" || failed=3D1
> +fi
> =20
> -if [[ "$d" =3D=3D "" ]]; then
> +if [ "$failed" -eq 0 ]; then
>  	test_pass
>  else
> -	error_log "pfunct output does not match expected:"
> -	info_log "$d"
> -	info_log
> -	info_log "Complete output:"
> -	info_log "$out"
>  	test_fail
>  fi

