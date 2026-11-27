Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=81.187.191.129
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795788449;
	b=el3Kj8M4GkE6r5i48odRdCLCcIxpbWDmJwvkDeQW470RRngbdi+TYO00fvs4nXIq3l//
	 Cq6sFsVD2OfKtYFwVHCobMPuJk96DyETKhFzWWfBKiiCZrxL1Sapf/YRVkTsU5hRPZe3/
	 33BN7SA6j8w+nq3i56C4BkOg7FOV/yfqJRlWTHiBwpw0XY6gKi3x25C5qjNJbRezskAzI
	 fz9hJ58n+nYT9dFruo+KwytWE+JxldpwFY2XEL2QKx4mb7iCM7uk6T3g9ujk5NhhjTI+L
	 1NWOxkN+IKnc4EbL/ejxdCTJd6LzXC7r3+ljJRNdqvvSKtkn3Su2vPhO4WnI70Bi3Jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795788449;
	h=DMARC-Filter:Received:From:To:Cc:Subject:In-Reply-To:References:
	 Emacs:Date:Message-ID:User-Agent:MIME-Version:Content-Type:
	 X-DCC--Metrics;
	bh=k3IRFjTa40yijxkZ99mvI6rZpFQBTdXXPJw6CdGe++A=;
	b=DM+EktLlchUPqbPTVV+D9wQ7yEkWYP8QnUNsePsgACb2hFhLUbu0XSg+MzliKlLz0t0O
	 kKDec3RxlLcgllqlES0zrtVn5lMgkNT1ECQM5S4msWj5ICOOH1SPYwDBfDAaRvJrWRX7u
	 O2EVBbtuUy04ale806/taAmid76NtWXgtRRUkELqEO484bFhnoje/Mie/3r7bR4IZOjxQ
	 66mQtv2PaKwBXF/dEhLxsp7bjpr7xLx4/3TZwwNSb+ljhRtHkKuMTt9Mi5N/99lgrF1j1
	 HD3QNcSybEgomIOevpE1iz9w69csv19UQivRFfpfFC+zT+62BJKE9heHSI69t/VHrnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=esperi.org.uk;
	spf=pass smtp.mailfrom=esperi.org.uk;
	arc=none smtp.remote-ip=81.187.191.129
Received: from mail.esperi.org.uk (icebox.esperi.org.uk [81.187.191.129])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB55606A323
	for <dwarves@vger.kernel.org>; Fri, 27 Nov 2026 14:07:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADB55606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=esperi.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=esperi.org.uk
Received: from loom (nix@sidle.srvr.nix [192.168.14.8])
	by mail.esperi.org.uk (8.17.2/8.17.2) with ESMTPS id 6ARE7DIa020970
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Fri, 27 Nov 2026 14:07:14 GMT
From: Nick Alcock <nix@esperi.org.uk>
To: "Jose E. Marchesi" <jemarch@gnu.org>
Cc: "Can" <can@tartanoglu.com>, <bpf@vger.kernel.org>,
        "Alexei
 Starovoitov" <ast@kernel.org>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        "Andrii Nakryiko" <andrii@kernel.org>,
        "Eduard Zingerman"
 <eddyz87@gmail.com>,
        "Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
        "Martin KaFai Lau" <martin.lau@linux.dev>,
        "Song Liu" <song@kernel.org>,
        "Yonghong Song" <yonghong.song@linux.dev>,
        "Jiri Olsa"
 <jolsa@kernel.org>,
        "Emil Tsalapatis" <emil@etsalapatis.com>,
        "Ihor
 Solodrai" <ihor.solodrai@linux.dev>,
        "Alan Maguire"
 <alan.maguire@oracle.com>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>,
        "David Faust" <david.faust@oss.qualcomm.com>,
        "Bruce McCulloch"
 <bruce.mcculloch64@gmail.com>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Nicolas Schier" <nsc@kernel.org>, <linux-kbuild@vger.kernel.org>,
        <dwarves@vger.kernel.org>, <llvm@lists.linux.dev>
Subject: Re: RFC: vmlinux BTF from clang -gbtf, stock lld and a libbpf tool
In-Reply-To: <87fqwmspyg.fsf@gnu.org>
References: <20261121205803.b46d9bd1a88c@tartanoglu.com>
	<87fqwmspyg.fsf@gnu.org>
Emacs: if SIGINT doesn't work, try a tranquilizer.
Date: Fri, 27 Nov 2026 14:07:13 +0000
Message-ID: <87ecc6fjvy.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Post: <mailto:dwarves@vger.kernel.org>
List-Help: <mailto:dwarves+help@vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
List-Owner: <mailto:dwarves+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-DCC--Metrics: loom 1102; Body=23 Fuz1=23 Fuz2=23 rep=100%

On 27 Nov 2026, Jose E. Marchesi uttered the following:

> [Fixing email adresses of David Faust and Bruce McCullough and Nick
>  Alcock]

Thanks!

>> Alexei asked in llvm/llvm-project#183915 [1][2] for native-vs-pahole
>> results to come here, and suggested dropping BTF dedup from lld in
>> favour of a stock link plus a libbpf-based kernel tool. I closed
>> #183915 and tested that route on saved x86-64 kernel objects.
>>
>> Two headline findings up front:
>>
>> 1. On those saved objects, unmodified ld.lld plus a libbpf prototype
>> reproduced the patched linker's decoded vmlinux BTF (bpftool raw
>> dumps match) and byte-identical .BTF_ids, though not byte-identical
>> .BTF and without booting a host-tool image.
>> 2. On the booted native kernel from the earlier patched-lld run, a
>> verifier negative test (flex_array_unaligned_step in
>> verifier_btf_array_access) unexpectedly loads across all three
>> test_progs flavours because struct vring_used is only a FWD in
>> native BTF. Static checks also show shifted-register FUNC
>> prototypes (e.g. __add_to_kill) and two duplicate-ID warnings in
>> resolve_btfids that fail CONFIG_WERROR=y.
>>
>> The compiler side is LLVM #183929 (-gbtf for non-BPF ELF targets);
>> its

Ooh! I thought I was going to have to implement this. :)

>> Discourse RFC [3] drew a key question from LLVM DebugInfo
>> maintainers:
>> LLVM debug info is best-effort, whereas the verifier and trampolines
>> treat vmlinux BTF as trusted safety and ABI metadata. Before
>> reshaping #183929 or proposing kbuild patches, I'd like feedback on where that
>> trust boundary sits, how functions and DATASECs should be handled,
>> and what GCC/Clang/linker contract makes sense.

I'm quite interested in this too, given my past, ah, arguments over the
possibility of structs with conflicting definitions in different TUs,
the mess pahole makes of them (because it assumes they don't exist, and
accepts the first available struct with a given name it sees), and their
occasional appearance in the kernel. We've even had cases where setting
the wrong kconfig options can cause wildly different duplicate
definitions of things like task_struct, though having structs this
important with the wrong definitions causes the BTF self-tests to fail
disastrously so hopefully nobody would actually ship a kernel that
turned those on.

(I am willing to believe that there is an intent that no such structures
exist in the kernel and thus the file format need not accommodate them,
though CTF, being meant for userspace, has to be more flexible. I stil
don't believe that they don't *appear*, because I've seen them, and
there is no obvious means to keep them from reappearing accidentally.
A deduplicator is of course the perfect place to implement guards
against such things appearing in built kernels, but it has to be able to
spot them first...)

>> true_signature [7]. Whatever comes out of this should work for GCC
>> objects too.

I intend to build CTFv4 support for LLVM on top of it, too, following
which BTF-compatible (CTFv4) support in LLVM-compiled userspace should
be practical, modulo bugs.

>> Saved-object replay (experimental instrument, not a kbuild API)

This is really neat :)

>> Types. In raw BTF, 132 STRUCT/UNION definitions present in pahole are
>> FWD-only in native. In the normalized C-dump comparison (23,109 exact
>> of 23,216 native and 23,490 pahole declaration rows), only 39 show up
>> in fwd_vs_definition.txt; the other 93 (including vring_used) were
>> paired as "exact" against bpftool's synthetic forward declarations
>> and
>> filed under extras.txt (111 pahole rows = 93 missing definitions + 18
>> extra FWDs; 2 native FWDs). Walking pahole's BTF from those 132 roots
>> reaches 149 of 178 pahole-only rows (e.g. acpi_gpio_params via
>> acpi_gpio_mapping).
>>
>> The cause confirmed per-object in libahci.o (ahci_cmd_hdr) and
>> e1000_hw.o (e1000_shadow_ram) is clang's deferred pointee traversal,
>> which emits a FWD even when the CU's DWARF has the full definition.

libctf fuses such things together when it sees them (addition of
structs/unions to a dict when a forward already exists mutates the
forward into a struct/union; addition of a forward when a struct/union
already exists just returns the struct/union; the deduplicator also
avoids emitting forwards unless no concrate definition is visible, and
by the time it emits anything it's already seen everything there is to
see.)

This sort of thing may not be practical in your model though.
