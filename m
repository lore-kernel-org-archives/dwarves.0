Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8F23161A4
	for <dwarves@vger.kernel.org>; Tue,  2 Jun 2026 01:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780362337; cv=none; b=R1Cwf4UfCosTy7mKXvN0k8nZ/pJe+aWdcCNjgXTvKz3ID8gpDXXIEdMTEfgCY90nVWVhfSMoh7eL3grpCXkIM1Oj4X6I201oe+m865i/skeD7EJRfaaGR7E/Og70Qf0/jrnqT9oA9lonpemjkQ4RZfjX/5kSYjJbF240oR+3BGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780362337; c=relaxed/simple;
	bh=ToHc5GxUKwINZrR3fzfLrAxSuFarAZPeqI5xQbIJZDw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=G8gI576Nxhw1HIx8/Sce7US/9HQ4vNbaz51u4AO9hZdMEDLd4ZAzlbOMg/BI38Y1eMLt1E7NDiWgGFGkr4uTdR8CrJmzdKAh1PDSaKIogkWlSePL2Io421W803mdbPaH20Mm3ugoJTp7foJLaX5lYfCgC9U/kxzFDoKOR4IqvAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=eCTUpvuV; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="eCTUpvuV"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-136b46c3540so11309100c88.1
        for <dwarves@vger.kernel.org>; Mon, 01 Jun 2026 18:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1780362335; x=1780967135; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oZQoA4UaQO9wE6A7Q5YCAeXhGRjXxFgUqc5coKVMKck=;
        b=eCTUpvuVkbHsNZygE5qK5jOmWYhAGg+DkgrMvI/zcsyVSLwTh8+IOxaOUwEoKyMkMf
         hb+NNcwJx7i1spFZafRgcb3g+D/FSD4QWwvGSuL1UYbiHoaIv3hxe4+NFUxfGerZ38ff
         CUJur73eWU6tM9xNWVHNrgBLxqj9jKto6BbH5mUyp93jRihz6rWpyY0948l7lbHPu96T
         zmVDcl0QN1ge2AyK4TOPNQr1HyRqn+hWYX9m1mI/6vMWrAs4+ueFvvH3iYDOaSh0n6JM
         kZ7DjiUqLaZ9VTbIMLi+eONbScn09oKfdVCudfpbJ5CJzlTQdXB/F9NzHJe/LWcOGKen
         4law==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780362335; x=1780967135;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oZQoA4UaQO9wE6A7Q5YCAeXhGRjXxFgUqc5coKVMKck=;
        b=fCz2WUKz75eHvuFVddgXWU8ixoQibWL4i/Fg4hFgHKaYeEDO2VvC9cT252cY/MTokB
         EknAm7m4itFsTYBK/hCbl6w5TQ7+jIsz5SOBNbh3pNRckHHlgPaKknRDIUry8saL3z5T
         upm4kZ+VMYsJgX075MbZMcksv5jUbtOnIgUqXFrTvxWSDKJoJ+CrowSSsUW93cqzaJl9
         dQoI9B/QJtEF1PRuZMHvF9ihT447EggVQzPYvxTcjh/b5tQl+LDwi7WQdiGxOsVWngKw
         OMdKsxnKGlC8lHb09ZFB0FxaRu340JDTblnDftyicYYPbEpZtt6poG7Q0OrF3l0RLJWx
         Qv/w==
X-Forwarded-Encrypted: i=1; AFNElJ+Ml0ZCy4YrAwAXXyBLk1oQmWM5BKADtAO/osjANc725jrGR09TDJ2FjCXYy27KlS4Yao7vrlsN@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ/OQe4T+Pxo7zbVHBqKCIAO0oT13eaNTC++voLmgEDq880aV4
	Yk7MRYFjZ1udmkNIE30MHlci1s5ulfnAKb/voDnYjsm6d3bbPHxfJu/R8ISqUop7How=
X-Gm-Gg: Acq92OFCqY/W5m5ZQO3TMdHN56i7BTzJ/RpyubvDV8iimSTvDt/kHo82oEp9MUtarvc
	1G4ZktbAD7u9pt0Kocrqv/ksKJlciMrlXB8gD990aXrZpdgcWCIygUGKNZ4mtJtcy0iOxTcWFvh
	nbHSfX3lGUVX14ekmro6oXznMsZoU8i7YqVJDWUuCLzTGZDkw83iMd0HJQQgqK7kL8+wZ2HlA18
	7BXPfHoS4IcSqsrltse7SggQFant716qA5dLI9NVh4X29NGbIDz/pD4Iw/vCGkfEDODKwixWR3G
	l+V69WvUCEdUnDSMuu1L2exFptKfRnvbG7Qa+FWjYBAii6GEL4Jp0xjIeS5RipeGLW5BJX0Vf2J
	vvsJM7Si0q2cZ4P2LEZjOdV4eD1MBEFfkfRuhOMr8TZQDUs6ZkpzKAlhULBlFAgaIN5sPS1+ZrP
	xWavP7IoJ8Q+TyOaadO/FPyielUQ==
X-Received: by 2002:a05:7022:f502:b0:137:ddaf:7e89 with SMTP id a92af1059eb24-137ddaf7f47mr2297872c88.15.1780362334922;
        Mon, 01 Jun 2026 18:05:34 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::4f12])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137b3d8f839sm7441673c88.15.2026.06.01.18.05.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 18:05:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 01 Jun 2026 21:05:32 -0400
Message-Id: <DIY5RWLRH7C1.8YT4ECR1ZALU@etsalapatis.com>
Cc: <bpf@vger.kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>,
 <acme@kernel.org>, "Alan Maguire" <alan.maguire@oracle.com>,
 <jose.marchesi@oracle.com>, "David Faust" <david.faust@oracle.com>
Subject: Re: [PAHOLE v3 3/3] tests: Support GCC in pfunct-btf-decl-tags test
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Vineet Gupta" <vineet.gupta@linux.dev>, <dwarves@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260601183511.594100-1-vineet.gupta@linux.dev>
 <20260601183511.594100-3-vineet.gupta@linux.dev>
In-Reply-To: <20260601183511.594100-3-vineet.gupta@linux.dev>

On Mon Jun 1, 2026 at 2:35 PM EDT, Vineet Gupta wrote:
> GCC 16+ supports btf_decl_tag via DW_TAG_GNU_annotation.
> Update the test to run with either of GCC (>=3D 16) and clang.
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

