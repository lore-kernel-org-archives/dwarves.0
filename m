Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.51.188.92
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795763884;
	b=dy2EAPOD9DgQGCYk1iGn5ges+7hwqSIIsbk4VjUB4AUyQq8t3y72sfTH7eVq4+6fPbyG
	 prUK3CoBy7YIx/ADHby1Ca1+/cwLyuiIW44+JJFJTo+KkcKnJ0otcraYxKMa9OHnDo2+y
	 UPpgw8RE2yk7FzxhC+uM7Jf5lTlEbUFUt2vcLLADVDxBKXpgPRulvpKvCVtaoiqSxBye4
	 w8tMT9XH8jutXnPUSazr79RTQ5GDmFz6Rr9BudqStGfyUdgfWNNPSrA+xN2vM8W9TtdFB
	 4jDEerBx+eua9aDfnTV5Hsmxc5AufZ+vI/o6pa+CBOzsT9VhlwmdXTANtt9dTBoyuKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795763884;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:User-Agent:MIME-Version:Content-Type;
	bh=1o4py0F93e2e0eyvht3E5NDtytOClGQWFVKs2IV7jV4=;
	b=w2nR0/+B06u9Fo8QF6CfbMGih+NPCxTJb0DGnS8MyHI//Z5BiYyc6nDra9q+gyv9x2iH
	 fsQUfAi9X9LLXDIZh8mjBS1pCWoNuyXcL1+N8adB9lhWZp0BUVut5hYqdsGNbS2Lf/DYx
	 nv2a0Fm7LxwEq5otQjW3HjgOgjaAEdYmGf8DBFBNf7RQcoPuc50mqsAQBXOfVJZbYR9yW
	 xCGCOnWwS69ThHGl5tIjx6HHASWcJLk8prJIoykwuBNq3lXT1gUbtVRS2rbaBT/K7+znQ
	 8FKXcFFPaIzHmGCwgq3G3UQFjZ7b6zirHXYnvu42/euhAVLwlU4ViQYAE5j0DHySKNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gnu.org;
	spf=pass smtp.mailfrom=gnu.org;
	dkim=pass header.d=gnu.org header.i=@gnu.org header.a=rsa-sha256 header.s=fencepost-gnu-org header.b=qKtUW0UF;
	arc=none smtp.remote-ip=209.51.188.92
Received: from eggs.gnu.org (eggs.gnu.org [209.51.188.92])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F17606A33A;
	Fri, 27 Nov 2026 07:18:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05F17606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnu.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gnu.org header.i=@gnu.org header.a=rsa-sha256 header.s=fencepost-gnu-org header.b=qKtUW0UF
Received: from fencepost.gnu.org ([2001:470:142:3::e])
	by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.90_1)
	(envelope-from <jemarch@gnu.org>)
	id 1xWqDX-0005NK-KY; Fri, 27 Nov 2026 02:17:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
	s=fencepost-gnu-org; h=MIME-Version:Date:References:In-Reply-To:Subject:To:
	From; bh=1o4py0F93e2e0eyvht3E5NDtytOClGQWFVKs2IV7jV4=; b=qKtUW0UFX1poFRH6Gcru
	FzRUWaigR9eoIoehnucVSPy4hDEI4SxovrVM5ZAzu4tzQMFPVQj9j+V/3p2LTmikD1XMOCZfRfjVu
	lM1Rv5otHvRhKD/ygyInw8iwozYuUV6N1HhGL0VNExu4MsBd9e5v9MUbPAzqktbfMG1Qi005JoRxu
	fsN/136xWCqKCmsYIjW36CgXoBsSVaSZU7zNfS41D5hmjZZosGOd0QXpXgWfZXRo1My43Ly3Puwkx
	l0rIEjaH1Psm32dHR63EILq7cIxbQogN8hvXPrx4ge9VTMkOkAxn2OMlkyE52gM/sIh60RwaNdJB1
	N0xbF6uzAoW1Eg==;
From: "Jose E. Marchesi" <jemarch@gnu.org>
To: "Can" <can@tartanoglu.com>
Cc: <bpf@vger.kernel.org>,  "Alexei Starovoitov" <ast@kernel.org>,  "Daniel
 Borkmann" <daniel@iogearbox.net>,  "Andrii Nakryiko" <andrii@kernel.org>,
  "Eduard Zingerman" <eddyz87@gmail.com>,  "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>,  "Martin KaFai Lau" <martin.lau@linux.dev>,  "Song
 Liu" <song@kernel.org>,  "Yonghong Song" <yonghong.song@linux.dev>,  "Jiri
 Olsa" <jolsa@kernel.org>,  "Emil Tsalapatis" <emil@etsalapatis.com>,
  "Ihor Solodrai" <ihor.solodrai@linux.dev>,  "Alan Maguire"
 <alan.maguire@oracle.com>,  "Arnaldo Carvalho de Melo" <acme@kernel.org>,
  "David Faust" <david.faust@oss.qualcomm.com>,  "Nick Alcock"
 <nix@esperi.org.uk>,  "Bruce McCulloch" <bruce.mcculloch64@gmail.com>,
  "Nathan Chancellor" <nathan@kernel.org>,  "Nicolas Schier"
 <nsc@kernel.org>,  <linux-kbuild@vger.kernel.org>,
  <dwarves@vger.kernel.org>,  <llvm@lists.linux.dev>
Subject: Re: RFC: vmlinux BTF from clang -gbtf, stock lld and a libbpf tool
In-Reply-To: <20261121205803.b46d9bd1a88c@tartanoglu.com>
References: <20261121205803.b46d9bd1a88c@tartanoglu.com>
Date: Fri, 27 Nov 2026 08:17:43 +0100
Message-ID: <87fqwmspyg.fsf@gnu.org>
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


[Fixing email adresses of David Faust and Bruce McCullough and Nick
 Alcock]

> Alexei asked in llvm/llvm-project#183915 [1][2] for native-vs-pahole
> results to come here, and suggested dropping BTF dedup from lld in
> favour of a stock link plus a libbpf-based kernel tool. I closed
> #183915 and tested that route on saved x86-64 kernel objects.
>
> Two headline findings up front:
>
> 1. On those saved objects, unmodified ld.lld plus a libbpf prototype
> reproduced the patched linker's decoded vmlinux BTF (bpftool raw
> dumps match) and byte-identical .BTF_ids, though not byte-identical
> .BTF and without booting a host-tool image.
> 2. On the booted native kernel from the earlier patched-lld run, a
> verifier negative test (flex_array_unaligned_step in
> verifier_btf_array_access) unexpectedly loads across all three
> test_progs flavours because struct vring_used is only a FWD in
> native BTF. Static checks also show shifted-register FUNC
> prototypes (e.g. __add_to_kill) and two duplicate-ID warnings in
> resolve_btfids that fail CONFIG_WERROR=y.
>
> The compiler side is LLVM #183929 (-gbtf for non-BPF ELF targets);
> its
> Discourse RFC [3] drew a key question from LLVM DebugInfo
> maintainers:
> LLVM debug info is best-effort, whereas the verifier and trampolines
> treat vmlinux BTF as trusted safety and ABI metadata. Before
> reshaping
> #183929 or proposing kbuild patches, I'd like feedback on where that
> trust boundary sits, how functions and DATASECs should be handled,
> and
> what GCC/Clang/linker contract makes sense.
>
> Prior art: Arnaldo outlined GCC -gbtf, linker dedup and pahole fixups
> at LSF/MM/BPF 2025 [4]; Nick and Bruce have GNU ld BTF dedup work in
> progress [5]; Ihor's resolve_btfids / gen-btf.sh series [6] moved BTF
> post-processing into the tree; and pahole 1.32 now ships opt-in
> true_signature [7]. Whatever comes out of this should work for GCC
> objects too.
>
>
> Setup and compiler behaviour
> ----------------------------
>
> Three separate comparisons were run (revisions, config, lists and
> tool
> source are in the gist linked below):
>
> - Run B (booted x86-64 non-LTO kernels, QEMU TCG, no KVM): local
> branch
> 58b6bf74fe on bpf-next 32b66b94c, identical .config (no LTO, no IBT,
> CONFIG_WERROR=n, DWARF enabled, existing pahole Kconfig dependency
> retained; CONFIG_DEBUG_INFO_BTF_INLINE is rejected on the native
> path). Native vmlinux C objects used combined LLVM 0737facd716f
> (main 3bfae959fb6f + #183915 + #183929) with -gbtf and no pahole for
> vmlinux; control used DWARF and pahole 1.31 with this config's flags.
> Modules used pahole --btf_base in both. The native arm also compiled
> a local __used bpf_ctx_convert anchor in kernel/bpf/btf.c so complete
> program context types were retained, and selftests omitted
> callx_rodata_elem_addr (LLVM BPF MC assert #244366). Original Run B
> built separate selftest payloads; the coverage rerun used the same
> baseline selftest initramfs against both saved kernels.
>
> - Stock-link replay (not booted): saved Run B native objects relinked
> with unmodified ld.lld 3bfae959fb6f and a 329-line libbpf prototype.
>
> - Run A (selftest compiler check): one pahole kernel, selftests/bpf
> built with stock clang 3bfae959fb6f vs #183929 clang 76d97ce620bf.
>
> Compiler-flag gap vs GCC (verified on GCC 15.2 x86-64): GCC -gbtf
> alone
> emits .BTF without DWARF (both require -g -gbtf), emits no .BTF.ext
> on
> x86-64, and controls pointee pruning with -gprune-btf/-gno-prune-btf
> (full pointees by default on x86-64). #183929 currently forces DWARF
> on
> and emits .BTF.ext (~49 MB and 3.1M relocations in the archive
> replay,
> all discarded at the executable link).
>
>
> Saved-object replay (experimental instrument, not a kbuild API)
> ---------------------------------------------------------------
>
> 1. Stock ld.lld -r on the .tmp_vmlinux1 inputs (vmlinux.a plus
> .vmlinux.export.o, init/version-timestamp.o and
> .tmp_vmlinux0.kallsyms.o), with -Map, keeping all 3,602 .BTF blobs
> and their .rela.BTF. Using archive-only vmlinux.o missed 3,324
> .modinfo entries from .vmlinux.export.o and picked weak
> linux_banner/init_uts_ns over the strong definitions in
> init/version-timestamp.o; ET_REL offsets also don't give final
> section placement.
>
> 2. Stock first executable link (.tmp_vmlinux1) with -Map and a
> discard
> script dropping .BTF, .BTF.ext and their relocations. Keeping .BTF
> in this link fails on x86-64 because #183929's BTFKindDataSec calls
> emitLabelReference(sym, 4) (non-section-relative), emitting absolute
> R_X86_64_32 (S+A) instead of a section-relative offset; lld rightly
> rejects high-half kernel VAs. That is a producer-side encoding
> problem for ordinary final links, not a linker quirk.
>
> 3. The host prototype strips input DATASECs and extern FUNCs, appends
> blobs via libbpf, places surviving non-empty/non-overlapping entries
> from the -r relocations and two lld text maps, emits one DATASEC per
> non-empty output section and runs btf__dedup(). It is an x86-64
> prototype: it hardcodes lld map prefixes, pairs repeated input
> sections by ordinal/size, uses name/size/bytes fallback for 167
> SHF_MERGE entries, drops 14 overlaps and 27,422 script discards, and
> retains all 96,069 VAR records even when 68,570 entries are placed.
>
> 4. resolve_btfids runs unchanged (doing its own fixups, finalize_btf
> ()
> dedup/sort and ID patching).
>
> Single-sample replay timings (not a controlled kbuild benchmark):
> 2.97M -> 276k types before resolve_btfids; dedup 0.45 s, tool 8.4 s
> and
> ~555 MiB peak RSS. The extra augmented -r link took 2:57 (with 177k
> major page faults; archive-only -r took 1.55 s, stock exec 1.76 s,
> patched exec 6.65 s).
>
>
> Results
> -------
>
> - Stock-link replay: for the augmented replay, post-resolver bpftool
> raw dumps compare equal to the patched-lld kernel and .BTF_ids is
> byte-identical (15,568 bytes) with no unresolved IDs. Raw .BTF
> differs in bytes (13,554,061 vs 13,554,053, 32- vs 24-byte header and
> string table). Both logs emit two duplicate-ID warnings
> (bpf_lsm_inode_init_security and bpf_lsm_mmap_file), which would fail
> CONFIG_WERROR=y (--fatal_warnings). Augmented sections were embedded
> and extracted cleanly, but no host-tool image was booted.
>
> - Boot and selftests (Run B, patched-lld vs pahole kernel): both boot
> and expose /sys/kernel/btf/vmlinux. Original Run B ran only plain
> test_progs; observed rows matched (OK/FAIL/SKIP 2557/382/113,
> including subtests) up to a shared userspace segfault in tailcalls
> (exit 139). bpf_testmod.ko failed with -EINVAL on both, causing
> failures and skips and limiting module/kfunc coverage. The -cpuv4 and
> -no_alu32 runners didn't start there. With tailcalls excluded and the
> shared baseline selftest payload, all 2,099 missing flavour/group
> invocations ran on both kernels. Five initial diffs did not persist
> as native-only failures on retry (timer_async_cancel failed 2/7
> native vs 1/7 pahole; tracing_multi_bench_attach passed on both on
> retry). The sole persistent native-only failure is
> verifier_btf_array_access/flex_array_unaligned_step (see vring_used
> below).
>
> - Size and per-CPU filter: unfiltered native .BTF is 13.6 MB (96,069
> VAR records, 68,570 DATASEC entries in 15 sections) vs 8.0 MB
> (7,984,202 B) pahole. Filtering the host prototype on the saved
> objects to keep only .data..percpu VARs and DATASEC entries gives
> 8.00 MB (8,003,505 B) pre-resolver (0.29 s dedup, 4.8 s runtime,
> 544,072 KiB process RSS high-water after dedup), 180,130 types, and
> 369/369 exact matches against both the final shipped ELF (zero stale
> offsets) and pahole's (name, offset, size). Post-resolver kfunc and
> bpf_fastcall decl-tag sets match (raw TYPE_TAG counts are 1,059 vs
> 1,061; raw FUNC linkage is 41,566 static / 39,089 global native vs
> 78,798 static / 0 global pahole).
>
> - Run A: no reproducible regression attributable to #183929 (initial
> run: 10,204/1,604/375 vs 10,204/1,603/375 across binary, test and
> subtest rows, 5 diffs, shared tailcalls crash; a separate 954-group
> rerun matched on subtests, with 4 initial group diffs settling to
> timer_async_cancel 3/7 stock vs 0/7 PR on identical normalized
> timer.bpf.o).
>
>
> Differences from pahole
> -----------------------
>
> Types. In raw BTF, 132 STRUCT/UNION definitions present in pahole are
> FWD-only in native. In the normalized C-dump comparison (23,109 exact
> of 23,216 native and 23,490 pahole declaration rows), only 39 show up
> in fwd_vs_definition.txt; the other 93 (including vring_used) were
> paired as "exact" against bpftool's synthetic forward declarations
> and
> filed under extras.txt (111 pahole rows = 93 missing definitions + 18
> extra FWDs; 2 native FWDs). Walking pahole's BTF from those 132 roots
> reaches 149 of 178 pahole-only rows (e.g. acpi_gpio_params via
> acpi_gpio_mapping).
>
> The cause confirmed per-object in libahci.o (ahci_cmd_hdr) and
> e1000_hw.o (e1000_shadow_ram) is clang's deferred pointee traversal,
> which emits a FWD even when the CU's DWARF has the full definition.
> That has two concrete failures here:
>
> - Verifier false acceptance: struct vring_used is FWD-only in native
> BTF (ID 271968), so flex_array_unaligned_step in
> verifier_btf_array_access (which expects rejection of an unaligned
> variable offset into vring_used's flexible ring[] array) gets
> unexpected_load_success in all three test_progs flavours and on
> confirmation, while pahole rejects it as expected.
> - Wrong linked type: e1000_hw.o emits only a FWD for
> e1000_shadow_ram,
> and in the merged BTF e1000's member points at e1000e's different
> same-name struct (different field name).
>
> Pruning pointees is a retention policy, not a BTF-format limit (GCC
> exposes -gprune-btf/-gno-prune-btf). Remaining C-dump diffs: 51 pairs
> differing in nested vs flat array shape (e.g. u8 data[4][13] vs [52];
> input DWARF not traced); ima_hooks NONE vs NONE___2 dumper spelling;
> two anonymous enums paired with pahole typedefs; and 29 unreached
> pahole-only / 11 non-enum native-only rows not yet traced.
>
> Functions. Native has 80,655 FUNC records under 80,024 names vs
> pahole
> 1.31's 78,798 (1,227 native-only names, 1 pahole-only name, and 600
> names with multiple native records: 17 differing only in linkage, 484
> only in parameter names -- including 447 shared single-address
> syscalls -- and 99 differing in arity or types). The one pahole-only
> name is native_save_fl: an assembly STT_FUNC in
> arch/x86/kernel/irqflags.S that pahole joins by name to an inline
> DWARF
> signature, which clang's machine-function emitter omits.
>
> Replaying pahole 1.31's flags on the control DWARF classifies the
> 1,227
> native-only names by inference as:
>
> - 780 ambiguous ELF addresses (625), inconsistent DWARF prototypes
> (60), or both (95, e.g. add_grec in igmp.c vs mcast.c, 5 vs 6
> params);
> - 36 with no matching STT_FUNC in .tmp_vmlinux1;
> - 411 attributed by exclusion to the unexpected-register check (which
> can also drop valid ABIs such as ZSTD_findFrameSizeInfo's hidden
> struct-return pointer).
>
> For __add_to_kill, native BTF lists (tsk, p, vma, to_kill, addr),
> while
> DWARF and entry disassembly put to_kill and addr in the 3rd and 4th
> argument registers. It has an ftrace site, so an fentry attach using
> that prototype would read the wrong registers if admitted (attachment
> was not tested). Counting by name with a concrete native DW_CC_nocall
> DIE catches 339 of the 411, misses 72, and also marks 601 names
> present
> in pahole 1.31 -- including kcore_update_ram, whose return value is
> discarded in disassembly while pahole still emits int(void).
>
> In a detached check on the saved baseline .tmp_vmlinux1, pahole 1.32
> emits 78,435 FUNCs with default flags and 79,077 (+642) with
> true_signature, recovering 343 of the 1,227 native-only names (284
> unexpected-reg, 59 inconsistent) -- including __add_to_kill with its
> true 4-parameter ABI (tsk, p, to_kill, addr), while kcore_update_ram
> stays int(void).
>
> Filtering in a host tool using ELF + BTF can address some ambiguous
> and missing-symbol cases if per-object provenance is kept (while
> preserving kfuncs and single-address parameter-name variants like
> weak
> sys_ni.o stubs), but ELF + source BTF alone cannot prove parameter
> registers or dropped returns.
>
> Lists, config, host.c, pahole 1.32 notes and coverage diffs:
>
> https://gist.github.com/caniko/24da79feb8f405ada030bb5ee18d27ed/
> a0ba0b01951d6d2447e6490deba16badb36bda38
>
>
> Known problems
> --------------
>
> - Final-ELF layout drift: against the shipped patched-lld vmlinux,
> both
> unfiltered native graphs match 65,951/68,570 DATASEC entries, with
> 2,618 stale .rodata offsets (non-uniform deltas after kallsyms), a
> stale .rodata section size (4,361,141 vs 10,128,309 bytes), and one
> first+final name mismatch (bringup_idt_table vs
> __pi_bringup_idt_table
> from x86 .pi.o prefixing). The per-CPU-only filter avoided all of
> these in this build (369/369 exact on final vmlinux); keeping other
> sections requires refreshing placement across link-vmlinux.sh passes
> without breaking kallsyms convergence or .BTF_ids.
>
> - GCC 15.2 -gbtf fixtures deliberately write zero DATASEC offsets
> with
> no relocations outside CO-RE, so host.c cannot place GCC VARs.
>
> - Modules still get BTF from pahole --btf_base. One existing
> split-BTF
> bpf_testmod.ko decodes identically in userspace bpftool against both
> native bases, but native split-BTF generation, .BTF.base distillation
> and module .BTF_ids patching are untested, loading against a
> stock-link replay image was not tested, and Run B's load attempts for
> bpf_testmod.ko failed with -EINVAL on both kernels.
>
> - No LTO, IBT, GNU ld, GCC kernel, Rust, section-GC/COMDAT-loser or
> non-x86 tests yet.
>
>
> Questions
> ---------
>
> 0. Trust boundary: if compiler BTF is best-effort debug output (per
> LLVM DebugInfo feedback [3]), what independent rule lets the kernel
> promote it to trusted verifier/trampoline input -- and should an
> incomplete FWD like struct vring_used independently make the
> verifier fail closed?
>
> 1. Functions and ABI: what evidence must bind a FUNC and its argument
> /
> return ABI to the prevailing body, and what must be omitted when
> that evidence is absent? Given pahole 1.32's true_signature, is
> there a post-lowering compiler fact worth standardizing separately
> from ordinary debug metadata?
>
> 2. Variable scope: is the tested per-CPU-only policy the right
> initial
> scope for native vmlinux BTF, or is there a concrete consumer
> justifying final-layout placement for other sections (pahole 1.31
> already has opt-in global_var; cf. Brennan's 2022 proposal [8])?
>
> 3. Kbuild and linker inputs: can the minimum policy work from
> ordinary
> kbuild artifacts without an extra full -r link, lld-specific text
> -Map parsing, or a final-layout/ID cycle? If not, what stable
> provenance interface should linkers provide, and where should the
> merge step live (tools/bpf vs resolve_btfids)?
>
> 4. Cross-compiler ET_REL contract and flags (GCC + Clang + linkers):
> (a) What common ET_REL representation should identify each DATASEC
> entry's defining symbol/section and distinguish real zero offsets
> from discards and losing definitions (instead of Clang's absolute
> R_X86_64_32)?
> (b) For GCC maintainers (asked on the LLVM RFC [3]): is GCC's
> behaviour -- -gbtf omitting DWARF unless -g is also passed, no
> .BTF.ext on non-BPF, and -gprune-btf controlling pointee pruning --
> still the intended model for Clang to match?
>
> Until there is agreement on the compiler/kernel contract, I'll hold
> off
> on ABI-signature changes and focus #183929 on matching GCC's -gbtf /
> -gprune-btf / non-BPF .BTF.ext behaviour cleanly without
> target-triple
> checks.
>
> [1] https://github.com/llvm/llvm-project/pull/183915#
> issuecomment-4409372304
> [2] https://github.com/llvm/llvm-project/pull/183915#
> pullrequestreview-5960724788
> [3] https://discourse.llvm.org/t/
> rfc-btf-debug-info-for-non-bpf-elf-targets-gbtf/92909
> [4] https://lwn.net/Articles/1016243/
> [5] https://lpc.events/event/20/contributions/2395/attachments/2141/
> 4739/2026-lpc.pdf
> [6] https://lore.kernel.org/bpf/
> 20251205223046.4155870-1-ihor.solodrai@linux.dev/
> [7] https://lore.kernel.org/bpf/
> 20251130040340.2636458-1-yonghong.song@linux.dev/
> [8] https://lore.kernel.org/bpf/
> 20221104231103.752040-1-stephen.s.brennan@oracle.com/
>
> Thanks,
> Can
>
> Note: Claude Code and OpenCode were used to help run artifact
> analyses,
> fact-check numbers against saved dumps, and review this draft.
