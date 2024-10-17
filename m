Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999301D63C2
	for <dwarves@vger.kernel.org>; Thu, 17 Oct 2024 22:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729202610; cv=none; b=rfiQqBYyZJ99P2LVVmVd0A96L71a3UkvdovBqRjvD6Bbu0BkcvotWV7QAYjqzzq1sspbZJCrTjxM5ijosx9bm4PzuVxXp5Pv3PEuW9XbUOcJqOuEl39LhB2DpStOf1OhXZ1Q2dL15/q8km2uyvfLcTzrKorS6dCXfWXnwGhjftM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729202610; c=relaxed/simple;
	bh=yhnyABzYOSrp+I7UVKMVDT94YiuBucYGv8we4ewKKMw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dppqYU66MDpQRF0dzaWOROAzbttf8UZpIqTqmHTXkUIpAh+CDGgKlf+uOgOIjVUPxhZoNNBNIuEf3RbNApJshlYjcb274+TcVq4Ce2rJ4JWMPRhzY3erGeLvTNlL04tm09IYjB4ShEqZXwM9fhRx6/Qo5hjwTmvfvfdwXjjDAVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XckHJvp9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XckHJvp9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6BCDC4CEC3;
	Thu, 17 Oct 2024 22:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729202610;
	bh=yhnyABzYOSrp+I7UVKMVDT94YiuBucYGv8we4ewKKMw=;
	h=Date:From:To:Cc:Subject:From;
	b=XckHJvp9ac0fzBG1PrYlSYD+BtFfusLw+9cf8zCyixqZiMFF+huC/5KL5ifYJAtQM
	 L2JMak19XKK5goIGwtVPdGjkYWg4yEHEUtWz3JGNpPzI3kmWmFKs8jOXstOhd93/55
	 ebXHyenDbsYlt7NqUsdmKkRYxcQam2he61nuW9CXWpbhft0Kg79h+jnLiUDK067NDK
	 NufhxqG1J2QbVVxE2WIDpuRVyDZXAyW0Ccs9tMfDDKFoEOgnu6gFzLrKLh5jzMSjwj
	 1e+iGeESuh9qOhE/fH4RtvQdflBCHKiBlz8wGImYVv7R76fDPJNSI/C2E89fhZEIIO
	 9NNbp0Cs/Yyag==
Date: Thu, 17 Oct 2024 19:03:26 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>, Miguel Ojeda <ojeda@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>, dwarves@vger.kernel.org
Subject: Fedora kernel enabling Rust
Message-ID: <ZxGJruLvv9NRUT19@x1>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

	While testing the latest patches on a fedora 40 system I
noticed:

  Compilation Unit @ offset 0x77fda3d:
   Length:        0xd527 (32-bit)
   Version:       5
   Unit Type:     DW_UT_compile (1)
   Abbrev Offset: 0x38012d
   Pointer Size:  8
 <0><77fda49>: Abbrev Number: 6 (DW_TAG_compile_unit)
    <77fda4a>   DW_AT_producer    : (indirect string, offset: 0x4ec527): GNU C11 14.2.1 20240912 (Red Hat 14.2.1-3) -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx -m64 -mno-80387 -mno-fp-ret
-in-387 -mpreferred-stack-boundary=3 -mskip-rax-setup -mtune=generic -mno-red-zone -mcmodel=kernel -mindirect-branch=thunk-extern -mindirect-branch-register -mindirect-branch-cs-prefix -mfunc
tion-return=thunk-extern -mharden-sls=all -mrecord-mcount -mfentry -march=x86-64 -g -O2 -std=gnu11 -p -fshort-wchar -funsigned-char -fno-common -fno-PIE -fno-strict-aliasing -fcf-protection=b
ranch -falign-jumps=1 -falign-loops=1 -fno-asynchronous-unwind-tables -fno-jump-tables -fpatchable-function-entry=16,16 -fno-delete-null-pointer-checks -fno-allow-store-data-races -fstack-pro
tector-strong -ftrivial-auto-var-init=zero -fno-stack-clash-protection -fmin-function-alignment=16 -fstrict-flex-arrays=3 -fno-strict-overflow -fstack-check=no -fconserve-stack -fsanitize=bou
nds-strict -fsanitize=shift
    <77fda4e>   DW_AT_language    : 29  (C11)
    <77fda4f>   DW_AT_name        : (indirect line string, offset: 0xfa3e): rust/exports.c
    <77fda53>   DW_AT_comp_dir    : (indirect line string, offset: 0x4db): /usr/src/debug/kernel-6.11.3/linux-6.11.3-200.fc40.x86_64
<SNIP>
    <78078ce>   DW_AT_name        : (indirect string, offset: 0x5310d): __UNIQUE_ID___addressable__RNvXshK_NtCshatLywNUlpX_8bindings12bindings_rawNtB6_28mei_connect_client_data_vtagNtNtCs2vSfyxKMEZc_4core7default7Default7default1222
    <78078d2>   DW_AT_decl_file   : 4
    <78078d3>   DW_AT_decl_line   : 740
    <78078d5>   DW_AT_decl_column : 1
    <78078d5>   DW_AT_type        : <0x77fdac9>
    <78078d9>   DW_AT_location    : 9 byte block: 3 0 0 0 0 0 0 0 0     (DW_OP_addr: 0)
 <1><78078e3>: Abbrev Number: 1 (DW_TAG_variable)
    <78078e4>   DW_AT_name        : (indirect string, offset: 0x51af69): _RNvXshL_NtCshatLywNUlpX_8bindings12bindings_rawNtB6_13hda_device_idNtNtCs2vSfyxKMEZc_4core7default7Default7default
    <78078e8>   DW_AT_decl_file   : 4
    <78078e9>   DW_AT_decl_line   : 741
    <78078eb>   DW_AT_decl_column : 1
    <78078eb>   DW_AT_type        : <0x77fda8c>
    <78078ef>   DW_AT_external    : 1
    <78078ef>   DW_AT_declaration : 1
 <1><78078ef>: Abbrev Number: 2 (DW_TAG_variable)
    <78078f0>   DW_AT_name        : (indirect string, offset: 0x83a79): __UNIQUE_ID___addressable__RNvXshL_NtCshatLywNUlpX_8bindings12bindings_rawNtB6_13hda_device_idNtNtCs2vSfyxKMEZc_4core7default7Default7default1223

That caused:

acme@number:~/git/pahole$ tests/btf_functions.sh 
Validation of BTF encoding of functions; this may take some time: PAHOLE: Warning: Found invalid variable name when encoding btf, ignored (sym: '__UNIQUE_ID___addressable__RNvXsa_NtCs2vSfyxKMEZc_4core4charNtB5_11EscapeDebugNtNtNtNtB7_4iter6traits10exact_size17ExactSizeIterator3len57').
PAHOLE: Warning: Found invalid variable name when encoding btf, ignored (sym: '__UNIQUE_ID___addressable__RNvXse_NtCs2vSfyxKMEZc_4core4charNtB5_15CaseMappingIterNtNtNtNtB7_4iter6traits8iterator8Iterator4next59').
PAHOLE: Warning: Found invalid variable name when encoding btf, ignored (sym: '__UNIQUE_ID___addressable__RNvXse_NtCs2vSfyxKMEZc_4core4charNtB5_15CaseMappingIterNtNtNtNtB7_4iter6traits8iterator8Iterator9size_hint60').
PAHOLE: Warning: Found invalid variable name when encoding btf, ignored (sym: '__UNIQUE_ID___addressable__RNvXse_NtCs2vSfyxKMEZc_4core4charNtB5_15CaseMappingIterNtNtNtNtB7_4iter6traits8iterator8Iterator5count61').
PAHOLE: Warning: Found invalid variable name when encoding btf, ignored (sym: '__UNIQUE_ID___addressable__RNvXse_NtCs2vSfyxKMEZc_4core4charNtB5_15CaseMappingIterNtNtNtNtB7_4iter6traits8iterator8Iterator4last62').
PAHOLE: Warning: Found invalid variable name when encoding btf, ignored (sym: '__UNIQUE_ID___addressable__RNvXse_NtCs2vSfyxKMEZc_4core4charNtB5_15CaseMappingIterNtNtNtNtB7_4iter6traits8iterator8Iterator10advance_by63').
PAHOLE: Warning: Found invalid variable name when encoding btf, ignored (sym: '__UNIQUE_ID___addressable__RNvXsf_NtCs2vSfyxKMEZc_4core4charNtB5_15CaseMappingIterNtNtNtNtB7_4iter6traits12double_ended19DoubleEndedIterator9next_back64').
PAHOLE: Warning: Found invalid variable name when encoding btf, ignored (sym: '__UNIQUE_ID___addressable__RNvXsf_NtCs2vSfyxKMEZc_4core4charNtB5_15CaseMappingIterNtNtNtNtB7_4iter6traits12double_ended19DoubleEndedIterator15advance_back_by65').
PAHOLE: Warning: Found invalid variable name when encoding btf, ignored (sym: '__UNIQUE_ID___addressable__RNvXsg_NtCs2vSfyxKMEZc_4core4charNtB5_15CaseMappingIterNtNtNtNtB7_4iter6traits10exact_size17ExactSizeIterator3len66').
PAHOLE: Warning: Found invalid variable name when encoding btf, ignored (sym: '__UNIQUE_ID___addressable__RNvXsg_NtCs2vSfyxKMEZc_4core4charNtB5_15CaseMappingIterNtNtNtNtB7_4iter6traits10exact_size17ExactSizeIterator8is_empty67').
PAHOLE: Warning: Found invalid variable name when encoding btf, ignored (sym: '__UNIQUE_ID___addressable__RNvXs0_NtNtCs2vSfyxKMEZc_4core3net6parserNtNtB7_7ip_addr6IpAddrNtNtNtB9_3str6traits7FromStr8from_str95').
PAHOLE: Warning: Found invalid variable name when encoding btf, ignored (sym: '__UNIQUE_ID___addressable__RNvXs2_NtNtCs2vSfyxKMEZc_4core3net6parserNtNtB7_7ip_addr8Ipv4AddrNtNtNtB9_3str6traits7FromStr8from_str97').


At first I thought that was from Rust source code, but nope, its things
in C to connect to Rust, have you guys thought about this? The warning
is not that good, invalid why? Lenght of the symbol name?

Its the end of my work day, so I have yet to think this through, so just
reporting it here to initiate a discussion.

acme@number:~/git/pahole$ grep RUST /boot/config-6.11.3-200.fc40.x86_64 
CONFIG_RUST_IS_AVAILABLE=y
CONFIG_RUST=y
CONFIG_RUSTC_VERSION_TEXT="rustc 1.81.0 (eeb90cda1 2024-09-04) (Fedora 1.81.0-1.fc40)"
CONFIG_HAVE_RUST=y
CONFIG_RUST_FW_LOADER_ABSTRACTIONS=y
CONFIG_BLK_DEV_RUST_NULL=m
CONFIG_RUST_PHYLIB_ABSTRACTIONS=y
CONFIG_AX88796B_RUST_PHY=y
CONFIG_HID_THRUSTMASTER=m
CONFIG_THRUSTMASTER_FF=y
CONFIG_TRUSTED_KEYS=y
CONFIG_HAVE_TRUSTED_KEYS=y
CONFIG_TRUSTED_KEYS_TPM=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT=y
CONFIG_SYSTEM_TRUSTED_KEYRING=y
# CONFIG_SYSTEM_TRUSTED_KEYS="certs/rhel.pem"
CONFIG_SYSTEM_TRUSTED_KEYS=""
CONFIG_SECONDARY_TRUSTED_KEYRING=y
# CONFIG_SECONDARY_TRUSTED_KEYRING_SIGNED_BY_BUILTIN is not set
# CONFIG_RUST_DEBUG_ASSERTIONS is not set
CONFIG_RUST_OVERFLOW_CHECKS=y
# CONFIG_RUST_BUILD_ASSERT_ALLOW is not set
acme@number:~/git/pahole$

- Arnaldo
