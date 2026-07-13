Received: from mail.smrk.net (mail.smrk.net [45.76.87.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A449838BF96
	for <dwarves@vger.kernel.org>; Mon, 13 Jul 2026 22:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.76.87.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783980912; cv=none; b=I232rzlHccMFlC4XbT0BQtoIqfFx8auSajghUuX+DYVwIegAo8TyspFjN9tTzq7PRS3UdZfi8fRe2JKlZSAnlkqzXfWOmhne35jXQr626kRbZhrMPhWt+4vPudgoQ6FWATqYZzOD5NyD2kJkjLRgFD70X+zwZkG82ksh9TB8D9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783980912; c=relaxed/simple;
	bh=XJhHLeOjgvlxxEH95UDTJzEKHBLYNEPgH8FDjp3hXOw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HrhrEIhTGoH8kteDXfSbOwJPDHrbkpQPaJamjLCFP5Yo9L2ERB1zaKQaTIQchuwjIPonVyTLv2v3bMEjbHNo7YAYsbcS2EFh1jlGgXLkb4jPM6zDW+ljsq+BlV1StMKkBVsOee9yMCGWA3hOgkTHC+jCIHnS0stBl4xMRzP34XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smrk.net; spf=pass smtp.mailfrom=smrk.net; dkim=pass (2048-bit key) header.d=smrk.net header.i=@smrk.net header.b=Gw7BaGdJ; arc=none smtp.client-ip=45.76.87.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smrk.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smrk.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smrk.net header.i=@smrk.net header.b="Gw7BaGdJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smrk.net; s=20221002;
	t=1783980905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VAkXphgKPAi8x6Oirl1lxoh73QW68YyXLswW5RkpTAI=;
	b=Gw7BaGdJcUoVIZlawqNRgdxTQiVxN9r0HIicVSCaKwp7KKa2nyGXOqX9l2YB1gInBupExK
	rAqAyjMlla/dc1Im8fdCfkdYjr+RrZvshgGVf8q4jxjmbM5izBMt2il/8YtFeR2qGmKwG2
	RRF9XP9+3b5nkPK69SpPQpgfpa1usoHMsBeW8imgkHhdmoA1adStMUKiWbFBrAhZyoTx1P
	kg3WzfdQw0ZQcET/0N/I8IQbQO8NCdrVi6GmOdXV7nrgix1xl5Z29YxCGn+ZAoDYcza8fV
	+vZ2GHz1r/mBAuF9hKmq88YZpWVi5cXIWdtWF2AIab72efriospJJ9+bsX95DQ==
Received: from localhost (<unknown> [192.168.5.2])
	by smrk (OpenSMTPD) with ESMTPSA id f8b9070b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 14 Jul 2026 00:15:04 +0200 (CEST)
From: =?UTF-8?q?=C5=A0t=C4=9Bp=C3=A1n=20N=C4=9Bmec?= <stepnem@smrk.net>
To: dwarves@vger.kernel.org
Subject: [PATCH] man-pages: improve language and formatting
Date: Tue, 14 Jul 2026 00:15:04 +0200
Message-ID: <20260713221504.393412-1-stepnem@smrk.net>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

- fix some typos, grammar and wording issues

- use conventional formatting (imperative, no capital or
  period) for .SH NAME summary

- start sentences on a new line, resulting in consistent
  sentence spacing in formatted output

Signed-off-by: Štěpán Němec <stepnem@smrk.net>
---
 man-pages/pahole.1 | 154 ++++++++++++++++++++++++++++-----------------
 1 file changed, 95 insertions(+), 59 deletions(-)

diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
index b1be472de2b1..21378a224847 100644
--- a/man-pages/pahole.1
+++ b/man-pages/pahole.1
@@ -4,20 +4,20 @@
 .TH pahole 1 "January 16, 2020" "dwarves" "dwarves"
 .\"
 .SH NAME
-pahole \- Shows, manipulates data structure layout and pretty prints raw data.
+pahole \- show or manipulate data structure layout and pretty print raw data
 .SH SYNOPSIS
 \fBpahole\fR [\fIoptions\fR] \fIfiles\fR
 .SH DESCRIPTION
 .B pahole
-shows data structure layouts encoded in debugging information formats,
-DWARF, CTF and BTF being supported.
+shows data structure layouts encoded in debugging information formats.
+DWARF, CTF and BTF are supported.
 
 This is useful for, among other things: optimizing important data structures by
-reducing its size, figuring out what is the field sitting at an offset from the
+reducing their size, identifying the field sitting at an offset from the
 start of a data structure, investigating ABI changes and more generally
 understanding a new codebase you have to work with.
 
-It also uses these structure layouts to pretty print data feed to its standard
+It also uses these structure layouts to pretty print data fed to its standard
 input, e.g.:
 .PP
 .nf
@@ -43,14 +43,17 @@ .SH DESCRIPTION
 
 See the PRETTY PRINTING section for further examples and documentation.
 
-The files must have associated debugging information.  This information may be
-inside the file itself, in ELF sections, or in another file.
+The files must have associated debugging information.
+This information may be inside the file itself, in ELF sections,
+or in another file.
 
 One way to have this information is to specify the \fB\-g\fR option to the
-compiler when building it. When this is done the information will be stored in
-an ELF section. For the DWARF debugging information format this, adds, among
-others, the \fB.debug_info\fR ELF section. For CTF it is found in just one ELF
-section, \fB.SUNW_ctf\fR. BTF comes in at least the \fB.BTF\fR ELF section, and
+compiler when building it.
+When this is done, the information will be stored in an ELF section.
+For the DWARF debugging information format this adds, among
+others, the \fB.debug_info\fR ELF section.
+For CTF it is found in just one ELF section, \fB.SUNW_ctf\fR.
+BTF comes with at least the \fB.BTF\fR ELF section, and
 may come also with the \fB.BTF.ext\fR ELF section.
 
 The \fBdebuginfo\fR packages available in most Linux distributions are also
@@ -60,9 +63,9 @@ .SH DESCRIPTION
 By default, \fBpahole\fR shows the layout of all named structs in the files
 specified.
 
-If no files are specified, then it will look if the /sys/kernel/btf/vmlinux
-is present, using the BTF information present in it about the running kernel,
-i.e. this works:
+If no files are specified, then it will look if /sys/kernel/btf/vmlinux
+is present, using the BTF information contained in it about the running kernel,
+i.e., this works:
 .PP
 .nf
 $ pahole list_head
@@ -75,10 +78,12 @@ .SH DESCRIPTION
 };
 $
 .fi
+
 It is possible to override the /sys/kernel/btf/vmlinux file location by setting
-the PAHOLE_VMLINUX_BTF_FILENAME environment variable. This may be useful for
-testing, scripting when using a different BTF for vmlinux. Used in the pahole
-regression tests.
+the PAHOLE_VMLINUX_BTF_FILENAME environment variable.
+This may be useful for testing or scripting when using a different BTF for
+vmlinux.
+Used in the pahole regression tests.
 
 If BTF is not present and no file is passed, then a vmlinux that matches the
 build-id for the running kernel will be looked up in the usual places,
@@ -88,16 +93,16 @@ .SH DESCRIPTION
 See the EXAMPLES section for more usage suggestions.
 
 It also pretty prints whatever is fed to its standard input, according to the
-type specified, see the EXAMPLE session.
+type specified, see the EXAMPLES session.
 
 Use --count to state how many records should be pretty printed.
 
 .SH OPTIONS
-pahole supports the following options.
 
 .TP
 .B \-C, \-\-class_name=CLASS_NAMES
-Show just these classes. This can be a comma separated list of class names
+Show just these classes.
+This can be a comma separated list of class names
 or file URLs (e.g.: file://class_list.txt)
 
 .TP
@@ -121,14 +126,15 @@ .SH OPTIONS
 $ pahole --compile > vmlinux.h
 .fi
 
-Produces a header that can be included in a C source file and built. In
-the example provided it will use the BTF info if available, otherwise will
+Produces a header that can be included in a C source file and built.
+In the example provided it will use the BTF info if available, otherwise will
 look for a DWARF file matching the running kernel build-id.
 
 .TP
 .B \-\-skip_emitting_atomic_typedefs
 Do not emit 'typedef _Atomic int atomic_int' & friends when used with options
-like --compile. Use it if the compiler provides these already, as of circa
+like --compile.
+Use it if the compiler provides these already, as of circa
 2022 with gcc 12.2.1 those are not encoded in DWARF so to generate compilable
 code we need emit those typedefs for the atomic types used in the data structures
 being emitted from debugging information.
@@ -143,21 +149,23 @@ .SH OPTIONS
 
 .TP
 .B \-E, \-\-expand_types
-Expand class members. Useful to find in what member of inner structs where an
+Expand class members.
+Useful to find in what member of inner structs where an
 offset from the beginning of a struct is.
 
 .TP
 .B \-F, \-\-format_path
-Allows specifying a list of debugging formats to try, in order. Right now this
-includes "btf", "ctf" and "dwarf". The default format path used is equivalent to
-"-F dwarf,btf,ctf".
+Allows specifying a list of debugging formats to try, in order.
+Right now this includes "btf", "ctf" and "dwarf".
+The default format path used is equivalent to "-F dwarf,btf,ctf".
 
 .TP
 .B \-\-hashbits=BITS
 Allows specifying the number of bits for the debugging format loader to use.
 The only one affected so far is the "dwarf" one, its default now is 15, the
-maximum for it is now 21 bits. Tweak it to see if it improves performance as
-the kernel evolves and more types and functions have to be loaded.
+maximum for it is now 21 bits.
+Tweak it to see if it improves performance as the kernel evolves and more
+types and functions have to be loaded.
 
 .TP
 .B \-\-hex
@@ -242,9 +250,9 @@ .SH OPTIONS
 
 .TP
 .B \-\-skip_encoding_btf_vars
-By default, VARs are encoded only for percpu variables. When specified, this
-option prevents encoding any VARs. Note that this option can be overridden
-by the feature "global_var".
+By default, VARs are encoded only for percpu variables.
+When specified, this option prevents encoding any VARs.
+Note that this option can be overridden by the feature "global_var".
 
 .TP
 .B \-\-skip_encoding_btf_decl_tag
@@ -260,18 +268,21 @@ .SH OPTIONS
 
 .TP
 .B \-\-skip_encoding_btf_inconsistent_proto
-Do not encode functions with multiple inconsistent prototypes or unexpected register use for their parameters, where the registers used do not match calling conventions.
+Do not encode functions with multiple inconsistent prototypes or unexpected
+register use for their parameters, where the registers used do not match
+calling conventions.
 
 .TP
 .B \-j, \-\-jobs=N
-Run N jobs in parallel. Defaults to number of online processors + 10% (like
+Run N jobs in parallel.
+Defaults to number of online processors + 10% (like
 the 'ninja' build system) if no argument is specified.
 
 .TP
 .B \-J, \-\-btf_encode
 Encode BTF information from DWARF, used in the Linux kernel build process when
-CONFIG_DEBUG_INFO_BTF=y is present, introduced in Linux v5.2. Used to implement
-features such as BPF CO-RE (Compile Once - Run Everywhere).
+CONFIG_DEBUG_INFO_BTF=y is present, introduced in Linux v5.2.
+Used to implement features such as BPF CO-RE (Compile Once - Run Everywhere).
 
 See \fIhttps://nakryiko.com/posts/bpf-portability-and-co-re/\fR.
 
@@ -304,7 +315,16 @@ .SH OPTIONS
 
 .TP
 .B \-\-btf_features=FEATURE_LIST
-Encode BTF using the specified feature list, or specify 'default' for all standard features supported.  This option can be used as an alternative to using multiple BTF-related options, and 'default' represents the standard set of BTF features that are in use for kernel BTF generation, so is useful as a shortcut for testing the latest set of standard features.  However kernel builds will call out specific features rather than using 'default' to ensure that the desired features are enabled regardless of pahole version and associated 'default' set.  Supported standard features are
+Encode BTF using the specified feature list, or specify 'default' for all
+standard features supported.
+This option can be used as an alternative to using multiple BTF-related options,
+and 'default' represents the standard set of BTF features that are in use for
+kernel BTF generation, so is useful as a shortcut for testing the latest set of
+standard features.
+However, kernel builds will call out specific features rather than using
+\&'default' to ensure that the desired features are enabled regardless of pahole
+version and associated 'default' set.
+Supported standard features are
 
 .nf
 	encode_force       Ignore invalid symbols when encoding BTF; for example
@@ -340,31 +360,38 @@ .SH OPTIONS
 	true_signature     Encode functions ensuring that binary-level
 	                   (rather than source-level) signatures are used;
                            for gcc these are ".isra.0" and ".costprop.0"
-                           optimized functions
+                           optimized functions.
 	layout             Encode information about BTF kinds available at encoding     
 	                   time in layout section in BTF.
 
 .fi
 
-So for example, specifying \-\-btf_encode=var,enum64 will result in a BTF encoding that (as well as encoding basic BTF information) will contain variables and enum64 values.
+So for example, specifying \-\-btf_encode=var,enum64 will result in a BTF
+encoding that (as well as encoding basic BTF information) will contain
+variables and enum64 values.
 
 .fi
 
-If one wants to add an extra feature to the set of standard ones, the '+' prefix can be used, i.e.:
-\-\-btf_features=+reproducible_build will add all default features plus the 'reproducible_build' extra
-feature.
+If one wants to add an extra feature to the set of standard ones,
+the '+' prefix can be used, e.g.:
+\-\-btf_features=+reproducible_build will add all default features
+plus the 'reproducible_build' extra feature.
 
 .TP
 .B \-\-btf_features_strict
-Identical to \-\-btf_features above, but pahole will exit if it encounters an unrecognized feature.
+Identical to \-\-btf_features above, but pahole will exit if it encounters
+an unrecognized feature.
 
 .TP
 .B \-\-supported_btf_features
-Show set of BTF features supported by \-\-btf_features option and exit.  Useful for checking which features are supported since \-\-btf_features will not emit an error if an unrecognized feature is specified.
+Show set of BTF features supported by \-\-btf_features option and exit.
+Useful for checking which features are supported since \-\-btf_features will
+not emit an error if an unrecognized feature is specified.
 
 .TP
 .B \-\-running_kernel_vmlinux,
-Search for, possibly getting from a debuginfo server, a vmlinux matching the running kernel build-id (from /sys/kernel/notes).
+Search for, possibly getting from a debuginfo server, a vmlinux matching the
+running kernel build-id (from /sys/kernel/notes).
 
 .TP
 .B \-l, \-\-show_first_biggest_size_base_type_member
@@ -372,8 +399,8 @@ .SH OPTIONS
 
 .TP
 .B \-m, \-\-nr_methods
-Show number of methods of all classes, i.e. the number of functions have arguments that
-are pointers to a given class.
+Show number of methods of all classes, i.e., the number of functions have
+arguments that are pointers to a given class.
 
 To get the number of methods for an specific class, please use:
 
@@ -411,7 +438,8 @@ .SH OPTIONS
 
 .TP
 .B     \-\-with_embedded_flexible_array
-Show only structs that have an embedded flexible array, i.e. a contained struct that has flexible arrays, a flexible array "in the middle".
+Show only structs that have an embedded flexible array, i.e., a contained struct
+that has flexible array(s) "in the middle".
 
 .TP
 .B \-q, \-\-quiet
@@ -558,9 +586,10 @@ .SH NOTES
 To enable the generation of debugging information in the Linux kernel build
 process select CONFIG_DEBUG_INFO. This can be done using make menuconfig by
 this path: "Kernel Hacking" -> "Compile-time checks and compiler options" ->
-"Compile the kernel with debug info". Consider as well enabling
-CONFIG_DEBUG_INFO_BTF by going thru the aforementioned menuconfig path and then
-selecting "Generate BTF typeinfo". Most modern distributions with eBPF support
+"Compile the kernel with debug info".
+Consider as well enabling CONFIG_DEBUG_INFO_BTF by going thru the aforementioned
+menuconfig path and then selecting "Generate BTF typeinfo".
+Most modern distributions with eBPF support
 should come with that in all its kernels, greatly facilitating the use of
 pahole.
 
@@ -678,7 +707,8 @@ .SH EXAMPLES
 
 .P
 OK, I know the offset that causes its a 'struct thread_struct' and that the offset is 0x178,
-so must be in that 'fpu' struct... No problem, expand 'struct thread_struct' and combine with \fBgrep\fR:
+so must be in that 'fpu' struct...
+No problem, expand 'struct thread_struct' and combine with \fBgrep\fR:
 .PP
 .nf
 $ pahole --hex -E thread_struct | egrep '(0x178|struct fpu)' -B4 -A4
@@ -835,8 +865,8 @@ .SH PRETTY PRINTING
 (variable sized records), that the 'enum perf_event_type' should be used to pretty print the
 numeric value in perf_event_header->type and furthermore that it should be used to heuristically
 look for structs with the same name (lowercase) of the enum entry that is converted from the
-type field, using it to pretty print instead of the base 'perf_event_header' type. See the
-PRETTY PRINTING EXAMPLES section below.
+type field, using it to pretty print instead of the base 'perf_event_header' type.
+See the PRETTY PRINTING EXAMPLES section below.
 .P
 
 Furthermore the 'filter=' part can be used, so far with only the '==' operator to filter based
@@ -845,7 +875,7 @@ .SH PRETTY PRINTING
 .P
 
 The 'sizeof' arg defaults to the 'size' member name, if the name is different, one can use
- 'sizeof=sz' form, ditto for 'type=other_member_name' field, that defaults to 'type'.
+\&'sizeof=sz' form, ditto for 'type=other_member_name' field, that defaults to 'type'.
 
 .SH PRETTY PRINTING EXAMPLES
 
@@ -975,7 +1005,8 @@ .SH PRETTY PRINTING EXAMPLES
 .P
 This uses ~/bin/perf to get the type definitions, the defines 'struct perf_file_header' as the header,
 then seeks '$header.data.offset' bytes from the start of the file, and considers '$header.data.size' bytes
-worth of such records. The filter expression may omit a common prefix, in this case it could additionally be
+worth of such records.
+The filter expression may omit a common prefix, in this case it could additionally be
 equivalently written as both 'filter=type==CGROUP' or the 'filter=' can also be omitted, getting as compact
 as 'type==CGROUP':
 .P
@@ -1073,7 +1104,12 @@ .SH PRETTY PRINTING EXAMPLES
 $
 .fi
 .P
-Some of the records are not found in 'type_enum=perf_event_type' so some of the records don't get converted to a type that fully shows its contents. For perf we know that those are in another enumeration, 'enum perf_user_event_type', so, for these cases, we can create a 'virtual enum', i.e. the sum of two enums and then get all those entries decoded and properly casted, first few records with just 'enum perf_event_type':
+Some of the records are not found in 'type_enum=perf_event_type' so some of the
+records don't get converted to a type that fully shows its contents.
+For perf we know that those are in another enumeration,
+\&'enum perf_user_event_type', so, for these cases, we can create
+a 'virtual enum', i.e. the sum of two enums and then get all those entries
+decoded and properly casted, first few records with just 'enum perf_event_type':
 .PP
 .nf
 $ pahole ~/bin/perf --header=perf_file_header --seek_bytes '$header.data.offset' --size_bytes='$header.data.size' -C 'perf_event_header(sizeof,type,type_enum=perf_event_type)' --count 4 --prettify perf.data
@@ -1179,8 +1215,8 @@ .SH AUTHOR
 Thanks to Andrii Nakryiko and Martin KaFai Lau for providing the BTF encoder
 and improving the codebase while making sure the BTF encoder works as needed
 to be used in encoding the Linux kernel .BTF section from the DWARF info
-generated by gcc. For that Andrii wrote a BTF deduplicator in libbpf that is
-used by \fBpahole\fR.
+generated by gcc.
+For that Andrii wrote a BTF deduplicator in libbpf that is used by \fBpahole\fR.
 .P
 Also thanks to Conectiva, Mandriva and Red Hat for allowing me to work on these tools.
 .P

base-commit: b9fa3ae313589f017f6fad8aaac414f29ce879c5
-- 
2.55.0

