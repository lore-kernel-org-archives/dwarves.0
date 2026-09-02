Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998304A2E38
	for <dwarves@vger.kernel.org>; Wed,  2 Sep 2026 13:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788355707; cv=none; b=EyEeApFeq6QfmRTqSjdgqL+fNArFjiH+A6NnW9+mSdY2Y4Qf7H5fP8WTnv8XyKCYL4ekxvfAyWSy2EmLyx8eQ2oJqvkXIoKZ0uhp9TO/SSYOoqDKUQH+r8NKlIlNJUFWz0K0wSGG0VWr3dnsVRDLL8SZufXL4C2o7ISbUGRWtiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788355707; c=relaxed/simple;
	bh=0IpMk+3iKrxQlfytkHOEnz1RbiogZUofIkitSdk8aP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lleuOYYNVSmTyt3zsUpCSSkkIkOZMIQXPbO6kTONPcLx5K+kLJ/UuK5whBOLT9VPcCSYpYMcPzSg7ERYufnJ1TEGMAyv7wp/4D7kxIWyl5OBhJvbBEyhLzmdUfp46bToDy/IG72cqWywrrP7mUzcDTcLxJhERZ0FhYpHJ78hQG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=i9QSPkMs; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i9QSPkMs"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682BlbKk3963545;
	Wed, 2 Sep 2026 13:28:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=PRelN
	2SfWAq9NIfCO1arvIlHiizRrRz/9ujDG9mr8wc=; b=i9QSPkMsvI1B44fLn9JXJ
	MRtzsO9v4JyGDEKBYtvJoxoDBJ3nzswLML6FAtvTroJpNhCgMV442g2G4WfbhM1l
	L9y7/44qL9e3vzUryDhp5iaNjjQMGi3+wLLaC+XIYjYP0nnjuN0Ea7eKH5vTAM0K
	VRO2LrD+C0z4DROJU0Pti2vHE5z5hozrRr3xuTooHNV52ge2b10e8MQtnsN6shzs
	6L1i7yZW6j3+0xY9cCsk5GMET5Gra4CgE+wfMmxudLo43tpy6DO4vhg5UB2azISG
	3VtPF42tqj0pDpVKQxYiSBsKo1vh2rMjR+nG4I9SFahGC3FFfUs8y/4TWvXoJHC7
	Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gbqyrxvq3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Sep 2026 13:28:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 682DOtuW007259;
	Wed, 2 Sep 2026 13:28:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gbnvfsr26-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Sep 2026 13:28:22 +0000 (GMT)
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 682DPWZL010350;
	Wed, 2 Sep 2026 13:28:22 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-52-253.vpn.oracle.com [10.154.52.253])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4gbnvfsr0u-3;
	Wed, 02 Sep 2026 13:28:22 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org
Cc: dwarves@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves 3/3] pfunct: add man page
Date: Wed,  2 Sep 2026 14:28:18 +0100
Message-ID: <20260902132818.1361588-3-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260902132818.1361588-1-alan.maguire@oracle.com>
References: <20260902132818.1361588-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_03,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 bulkscore=0
 malwarescore=0 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2609020119
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDExOSBTYWx0ZWRfX/0E92eBqgXpD
 PpuzWD8ju1bm4RQEfsPmB4PsB5gok4GnfFBwVjFALCneNzrUFlqodYgRv0mJxfiR0Mr54ceGlCa
 DSeZyi6Lm1rC/vuZU3nMVoXUGC/aFS3z1eNlLimUv/BCQONTbqc2uPKuaFmk5HmfP5KYzRhf3gy
 Grtnyme7kL3J3b/6khuHxF/vwxwUDBBuHSBF7VekmVvXVMsBCRyqRgCFE0VBjx2oo2sEU17MVMh
 UIZ4c5+CMLXZ/nWJJFEuv9vt5vvzMA1ZwsOyULOhEo2CJlLZTAbLBIQlBGlxo1Zjn9CiS+B4pUn
 n6RJQF1A4w2hxv/wcwEWcA4aw3XHHEaJEufaRRkK55piRcFyKJxsJK6t9ZEql9JDFtttmLGOC3B
 luSlVS3uRCekgKY09QsKbSmwHA7sKyFA0sCAReKQr8EDkQ6DBS9yIouE/aNrdUaSyvsQoBw4zny
 jAI+8GD3/vQtdFPVFmQ==
X-Proofpoint-ORIG-GUID: xxd18hilOQ1d-OVE0TFdZRFoj9DZTxSL
X-Authority-Analysis: v=2.4 cv=fbCdDUQF c=1 sm=1 tr=0 ts=6a982477 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8
 a=ohspRcKTSTj5AJpvhiEA:9 a=O8hF6Hzn-FEA:10
X-Proofpoint-GUID: xxd18hilOQ1d-OVE0TFdZRFoj9DZTxSL
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDExOSBTYWx0ZWRfX+k9a5vhBDsfG
 diawarAomHstiYxsKRLUZbYzrj5J9wuTNjQ0fB8NGG4h83h3/fEl1Qj/jWxAY9wWYl9nn66/2ks
 0SKoHjklVlnMXFTjDUeQA9rSihFOaPiWMSWCfv2zkaESSonlzTM+

Add a man page documenting pfunct options.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 CMakeLists.txt         |   1 +
 man-pages/pfunct.1     | 223 +++++++++++++++++++++++++++++++++++++++++
 rpm/SPECS/dwarves.spec |   1 +
 3 files changed, 225 insertions(+)
 create mode 100644 man-pages/pfunct.1

diff --git a/CMakeLists.txt b/CMakeLists.txt
index cbe5100..a0e3a85 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -226,6 +226,7 @@ install(FILES dwarves.h dwarves_emit.h dwarves_reorganize.h
 	      elfcreator.h elf_symtab.h hash.h libctf.h
 	DESTINATION ${CMAKE_INSTALL_PREFIX}/include/dwarves/)
 install(FILES man-pages/pahole.1 DESTINATION ${CMAKE_INSTALL_PREFIX}/share/man/man1/)
+install(FILES man-pages/pfunct.1 DESTINATION ${CMAKE_INSTALL_PREFIX}/share/man/man1/)
 if(Python3_FOUND)
 	install(PROGRAMS ostra/ostra-cg DESTINATION ${CMAKE_INSTALL_PREFIX}/bin)
 	install(FILES ostra/python/ostra.py DESTINATION ${CMAKE_INSTALL_PREFIX}/share/dwarves/runtime/python)
diff --git a/man-pages/pfunct.1 b/man-pages/pfunct.1
new file mode 100644
index 0000000..9482ac4
--- /dev/null
+++ b/man-pages/pfunct.1
@@ -0,0 +1,223 @@
+.\" Man page for pfunct
+.\" Licensed under version 2 of the GNU General Public License.
+.TH pfunct 1 "September 2, 2026" "dwarves" "dwarves"
+.\"
+.SH NAME
+pfunct \- Shows function information in debug information.
+.SH SYNOPSIS
+\fBpfunct\fR [\fIoptions\fR] \fIfiles\fR
+.SH DESCRIPTION
+.B pfunct
+shows functions, their parameters and associated statistics encoded in debugging information formats,
+DWARF and BTF being supported.
+
+The files must have associated debugging information.  This information may be
+inside the file itself, in ELF sections, or in another file.
+
+One way to have this information is to specify the \fB\-g\fR option to the
+compiler when building it. When this is done the information will be stored in
+an ELF section. For the DWARF debugging information format this, adds, among
+others, the \fB.debug_info\fR ELF section. For CTF it is found in just one ELF
+section, \fB.SUNW_ctf\fR. BTF comes in at least the \fB.BTF\fR ELF section, and
+may come also with the \fB.BTF.ext\fR ELF section.
+
+The \fBdebuginfo\fR packages available in most Linux distributions are also
+supported by \fBpfunct\fR, where the debugging information is available in a
+separate file.
+
+If no files are specified, then it will look if the /sys/kernel/btf/vmlinux
+is present, using the BTF information present in it about the running kernel,
+i.e. this works:
+.PP
+.nf
+$ pfunct ip_send_skb
+int ip_send_skb(struct net * net, struct sk_buff * skb);
+
+.fi
+
+Alternatively a file can be specified
+
+.PP
+.nf
+$ pfunct --format_path=dwarf ip_send_skb /path/2/vmlinux
+int ip_send_skb(struct net * net, struct sk_buff * skb);
+
+.fi
+
+Split BTF, such as the BTF for a kernel module, references types in a base
+BTF, normally the BTF for vmlinux. Use
+.B --btf_base
+to supply that base BTF when loading a detached split-BTF file. For files
+under /sys/kernel/btf/ other than vmlinux itself, pfunct automatically uses
+/sys/kernel/btf/vmlinux as the base BTF.
+
+.SH OPTIONS
+pfunct supports the following options.
+
+.TP
+.B \-C, \-\-class_name=CLASS_NAMES
+Show just these classes. This can be a comma separated list of class names
+or file URLs (e.g.: file://class_list.txt)
+
+.TP
+.B \-a, \-\-addr=ADDR
+Show just the function where ADDR is.
+
+.TP
+.B \-a,\-\-all
+Show all the functions that match the filter, or show all function prototypes
+if no filter is specified.
+
+.TP
+.B \-b,\-\-expand_types
+Expand types needed by the prototype.
+
+.TP
+.B \-c,\-\-class=CLASS
+Filter for functions that have CLASS pointer parameters.
+
+.TP
+.B \-E,\-\-externals
+Show just external functions (DWARF only).
+
+.TP
+.B \-f,\-\-function=FUNCTION
+Show just FUNCTION.
+
+.TP
+.B \-F, \-\-format_path
+Allows specifying a list of debugging formats to try, in order. Right now this
+includes "btf", "ctf" and "dwarf". The default format path used is equivalent to
+"-F dwarf,btf,ctf".
+
+.TP
+.B \-\-btf_base=PATH
+Use PATH as the base BTF when loading split BTF. If no format path is given,
+this selects BTF loading. This option is not needed for kernel module BTF read
+from /sys/kernel/btf/MODULE, where the vmlinux BTF is selected automatically.
+
+.TP
+.B \-g,\-\-goto_labels
+Show number of goto labels (DWARF only).
+
+.TP
+.B -G\-\-cc_unlinlined
+Declared inline, uninlined by the compiler (DWARF only).
+
+.TP
+.B \-H, \-\-cc_inlined
+Not declared inline, inlined by compiler (DWARF only).
+
+.TP
+.B \-i, \-\-inline_expansions
+Show inline expansion stats (DWARF only).
+
+.TP
+.B \-l, \-\-decl_info
+Show source code info.
+
+.TP
+.B \-t, \-\-total_inline_stats
+Show multi-CU total inline expansion stats (DWARF only).
+
+.TP
+.B \-s, \-\-sizes
+Show sizes of functions.
+
+.TP
+.B -N,\-\-function_name_len
+Show size of function names.
+
+.TP
+.B \-p, \-\-nr_parms
+Show number of parameters.
+
+.TP
+.B \-P, \-\-show_function_prototypes
+Show function prototypes.
+
+.TP
+.B \-S, \-\-nr_variables
+Show number of variables.
+
+.TP
+.B \-T, \-\-variables
+Show variables.
+
+.TP
+.B \-V, \-\-verbose
+Be verbose.
+
+.TP
+.B \-\-symtab=NAME
+Show symbol table NAME (default .symtab).
+
+.TP
+.B \-\-compile
+Generate compilable source code with types expanded (Default all functions).
+
+.TP
+.B \-\-no_parm_names
+Do not show parameter names.
+
+.SH NOTES
+
+To enable the generation of debugging information in the Linux kernel build
+process select CONFIG_DEBUG_INFO. This can be done using make menuconfig by
+this path: "Kernel Hacking" -> "Compile-time checks and compiler options" ->
+"Compile the kernel with debug info". Consider as well enabling
+CONFIG_DEBUG_INFO_BTF by going thru the aforementioned menuconfig path and then
+selecting "Generate BTF typeinfo". Most modern distributions with eBPF support
+should come with that in all its kernels, greatly facilitating the use of
+pahole.
+
+Many distributions also come with debuginfo packages, so just enable it in your
+package manager repository configuration and install the kernel-debuginfo, or
+any other userspace program written in a language that the compiler generates
+debuginfo (C, C++, for instance).
+
+.SH EXAMPLES
+
+.P
+Show a function (using /sys/kernel/btf/vmlinux):
+.PP
+.nf
+$ pfunct ip_send_skb
+int ip_send_skb(struct net * net, struct sk_buff * skb);
+$
+.fi
+
+.P
+Show a function in DWARF in file vmlinux
+
+.PP
+.nf
+$ pfunct --format_path=DWARF ip_send_skb vmlinux
+int ip_send_skb(struct net * net, struct sk_buff * skb);
+.fi
+
+.P
+Show all functions in detached split BTF using its vmlinux base:
+.PP
+.nf
+$ pfunct --btf_base=vmlinux.btf --all module.btf
+\&...
+.fi
+
+.P
+Show functions that were not declared with "inline" but were inlined:
+.PP
+.nf
+$ pfunct --cc_inlined ~/src/bpf-next/vmlinux
+clean_cache_range
+copy_from_user_nmi
+__insn_get_emulate_prefix
+...
+.fi
+
+.SH SEE ALSO
+\fIpahole\fR(1), \fIreadelf\fR(1), \fIobjdump\fR(1).
+.P
+Please send bug reports to <dwarves@vger.kernel.org>.
+.P
+No subscription is required.
diff --git a/rpm/SPECS/dwarves.spec b/rpm/SPECS/dwarves.spec
index d58285d..10cb2d0 100644
--- a/rpm/SPECS/dwarves.spec
+++ b/rpm/SPECS/dwarves.spec
@@ -99,6 +99,7 @@ rm -Rf %{buildroot}
 %dir %{_datadir}/dwarves/runtime/python/
 %defattr(0644,root,root,0755)
 %{_mandir}/man1/pahole.1*
+%{_mandir}/man1/pfunct.1*
 %{_datadir}/dwarves/runtime/Makefile
 %{_datadir}/dwarves/runtime/linux.blacklist.cu
 %{_datadir}/dwarves/runtime/ctracer_relay.c
-- 
2.43.5

