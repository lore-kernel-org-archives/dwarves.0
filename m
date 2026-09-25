Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36F93E0081;
	Fri, 25 Sep 2026 18:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790362401; cv=none; b=To0hga6rqaW3QLqBMVOqTiMTDXMk3i9JDkI+pa0oJ+y9fz12pB4oYsg+bKA15j7qN2b8609BLM3wb20RZ9XBH2FGncanCZ1J2xehrE+WB25RliZ/ebly8pMHELqIJSC5vPVpEot1dBf6WUm2UdmOVc+KZZ/atHm+JubgJsU3hN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790362401; c=relaxed/simple;
	bh=eOFo7vkzrD0el5bOdTbjS55bPPwevg9xmQIZKgz2wgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PLLB1ePs7sQfzzeBGRiX76pahAMwt09hXit2XU9nEN1/bNhjQsYfEbfunA9TZaXtmi3pEqh6fmCD1h6s9LX5+7kq0hgLy2rwOm1L6KwJxsijcG9Ouvo+mHK9soOPfmtxsMx6kb0nkXK55dSJFNOj+WmV/SM5SoUIw6U2n7lGv4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FK022RXA; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FK022RXA"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68PECMw52933095;
	Fri, 25 Sep 2026 18:52:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=ZMqQW
	gT8dfPpw+gx/6DbP10TU5bM3esrGuk1nVRFX/o=; b=FK022RXAwzpX0ulzFz+dM
	bLH5QeyQKcE8/S9aQBrTheOWk91hI+2xuEPTeE0XugpQcJ1dear7GVhCPQeZY6tG
	R2tgX5s2SVayVJMgR2FiDWZK4PZR0xK9xIYWe28kEGHxxL1daBOPbXToIMZDmsMW
	fNR2sw1GJQFan0r1fgLE/Wg730T8DZ38EJZVFIQUzcwZae0hQKC84OLydTiQRfz6
	2A93RmUwbegI4mpInqqdOqUI5tbifNNVUin9rs2tClYFqgyj1TUQAoDHkFyU5DTN
	vEBZwzB5mu+mEOojlqNbfPbI7nPtUi+RnMtKAAGtn5/5eM6m1WZYWEVGa52djpSk
	g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gsk219vep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 18:52:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 68PIqCK7038628;
	Fri, 25 Sep 2026 18:52:54 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gtepthtgw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 18:52:54 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 68PIqQow040536;
	Fri, 25 Sep 2026 18:52:53 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-81-122.vpn.oracle.com [10.154.81.122])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4gtepthsyc-10;
	Fri, 25 Sep 2026 18:52:53 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org, ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com,
        qmo@kernel.org
Cc: dwarves@vger.kernel.org, jolsa@kernel.org, daniel@iogearbox.net,
        ihor.solodrai@linux.dev, yonghong.song@linux.dev, song@kernel.org,
        martin.lau@linux.dev, memxor@gmail.com, emil@etsalapatis.com,
        bpf@vger.kernel.org, nsc@kernel.org, puranjay@kernel.org,
        yatsenko@meta.com, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 dwarves 9/9] man-pages: Document --inline_sites option
Date: Fri, 25 Sep 2026 19:51:58 +0100
Message-ID: <20260925185200.1318067-10-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260925185200.1318067-1-alan.maguire@oracle.com>
References: <20260925185200.1318067-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2609040000 definitions=main-2609250075
X-Authority-Analysis: v=2.4 cv=APP6TA4N c=1 sm=1 tr=0 ts=6ab6c307 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yPCof4ZbAAAA:8 a=ol5OCCR9Ltgci0DkqhUA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13532
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA3NSBTYWx0ZWRfXzU+fPV9CB0oP
 CbzidJ7PPPofhGiRXr1m24reKFTcqtY8pxWvi61/1YQe6+J/6RKt7W2HBAn1iZqKeedVvJwaies
 C8nTNPiIleGuvLCFHsT0RfeV9kE1YLVQcAAelXU84cXkiW5cuv3E
X-Proofpoint-ORIG-GUID: 6y1tZGcaN_Gy2HHahwoiW3SXsQV5Z2fk
X-Proofpoint-GUID: 6y1tZGcaN_Gy2HHahwoiW3SXsQV5Z2fk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA3NSBTYWx0ZWRfX2TtHonRx7fTg
 k2nqAc8xgA3WWSVTSZe40bV7oFvm0+J64jALbatdvLxNln3/zXxac87yjL0bQGnDkLym3NhINhA
 79PdXzeWzJiEH2L8xK3l34sf4PrOCcagKpFGMVhbKC8388oGfwHhZh4w97vGlIBWXy2JfuuvpPx
 kcffhshC64BVT1vQZ/e7jTsUHM7GuwVIwPAQE8XASelX8Fa32aqljNl97GxXuGta6DvcmlTrQqV
 rtI3nGsENd2g6iIArTokAQN2KSSTZm2tJ5BEr9W2XetWquQA8LP5JJOkjteNLrhmTOUHNlkxd86
 RPtAH0kFEk56pSCUo7on3moZXHrbS6F7OEWo1AkUPJtpF1Rmbj2NkskCXfrPRwJjn03Cl1sMZ4O
 Fb6NevTOM+hEWXNIFCxNAK/TzGsgL0ENXvM56QU7L4aeVnoXMC/by5bgSjgJOg2JBGcI9w3tH8n
 AcyUI4ZFuQiF/gCIx9jIZQYPho55Ssghc4DerShc=

Ensure it is documented along with -f file, --elf path2elf
and --running and include example.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 man-pages/pfunct.1 | 74 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 72 insertions(+), 2 deletions(-)

diff --git a/man-pages/pfunct.1 b/man-pages/pfunct.1
index 5ce203b..9935f9d 100644
--- a/man-pages/pfunct.1
+++ b/man-pages/pfunct.1
@@ -1,6 +1,6 @@
 .\" Man page for pfunct
 .\" Licensed under version 2 of the GNU General Public License.
-.TH pfunct 1 "September 2, 2026" "dwarves" "dwarves"
+.TH pfunct 1 "September 20, 2026" "dwarves" "dwarves"
 .\"
 .SH NAME
 pfunct \- Shows function information in debug information.
@@ -82,7 +82,9 @@ Show just external functions (DWARF only).
 
 .TP
 .B \-f,\-\-function=FUNCTION
-Show just FUNCTION.
+Show just FUNCTION. When used with
+.B \-j,\-\-inline_sites,
+show only sites for the specified inlined function.
 
 .TP
 .B \-F, \-\-format_path
@@ -96,6 +98,16 @@ Use PATH as the base BTF when loading split BTF. If no format path is given,
 this selects BTF loading. This option is not needed for kernel module BTF read
 from /sys/kernel/btf/MODULE, where the vmlinux BTF is selected automatically.
 
+.TP
+.B \-\-running[=OBJECT]
+Resolve BTF inline-site addresses against the running kernel instead of an ELF
+companion. OBJECT is vmlinux by default, or the name of a loaded module.
+For vmlinux, only .text inline sites are shown, using _stext from
+/proc/kallsyms. For a module, section bases are read from
+/sys/module/OBJECT/sections. Address visibility is subject to normal kernel
+permissions, including kptr_restrict. When symbol addresses are visible,
+pfunct also uses /proc/kallsyms to identify the containing function.
+
 .TP
 .B \-g,\-\-goto_labels
 Show number of goto labels (DWARF only).
@@ -112,6 +124,34 @@ Not declared inline, inlined by compiler (DWARF only).
 .B \-i, \-\-inline_expansions
 Show inline expansion stats (DWARF only).
 
+.TP
+.B \-j, \-\-inline_sites
+Show BTF inline sites encoded in LOCSEC records. If no
+.B \-\-format_path
+is specified, this option automatically selects BTF input.
+
+Each site includes its address, section-relative offset, inlined function
+prototype, and parameter locations. Parameter locations are shown as
+registers, dereferenced registers, constants, addresses, or
+.B unavailable
+when location information is absent. Without ELF information, registers use
+the generic
+.B regN
+notation and addresses are section-relative. When the input is an ELF file
+with embedded BTF, its ELF information is used automatically. For raw or
+detached BTF, use
+.B \-\-elf
+to resolve absolute addresses, enclosing ELF functions, and
+architecture-specific register names.
+
+.TP
+.B \-\-elf=PATH
+Use PATH as the ELF companion for
+.B \-j,\-\-inline_sites.
+Its section addresses, symbol table, and register names are used to resolve
+detached or raw BTF inline sites to absolute addresses, their containing
+functions, and architecture-specific register names.
+
 .TP
 .B \-l, \-\-decl_info
 Show source code info.
@@ -204,6 +244,36 @@ $ pfunct --btf_base=vmlinux.btf --all module.btf
 \&...
 .fi
 
+.P
+Show inline BTF sites from a detached BTF file, resolving each site to the
+containing function in its ELF companion:
+.PP
+.nf
+$ pfunct --inline_sites --elf ./program ./program.btf
+0x401120 [wrapper+0x0, .text +0x100] add_one(int value [%rdi])
+\&...
+.fi
+
+.P
+For an ELF file with embedded BTF, the ELF companion is inferred from the
+input, so no separate
+.B \-\-elf
+option is needed:
+.PP
+.nf
+$ pfunct --inline_sites ./program
+0x401120 [wrapper+0x0, .text +0x100] add_one(int value [%rdi])
+\&...
+.fi
+
+.P
+Limit inline-site output to the inlined function named add_one:
+.PP
+.nf
+$ pfunct --inline_sites --elf ./program -f add_one ./program.btf
+\&...
+.fi
+
 .P
 Show functions that were not declared with "inline" but were inlined:
 .PP
-- 
2.43.5

