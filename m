Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F78509EFF;
	Fri,  2 Oct 2026 17:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790962907; cv=none; b=GtADadZo6hwrgHa2dmoIZO+BDBo+rUtVoUkb+u7vUMu3IwdSPOyg/8T41RlvSsG+7sgqZ8jh/RQCp2zOgHjnkH8n0BsAt/qn1xUf1dfSWQOUTEWVRvTURGWCU0LvPDMGMXeWCgj+AMQoIKUET/VjQ33hHE4PMn+6dmyi2M1QwkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790962907; c=relaxed/simple;
	bh=eOFo7vkzrD0el5bOdTbjS55bPPwevg9xmQIZKgz2wgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XA4pgHhdMUPt7Gb6Ja1DPWSiIzIcAvHgNUPTZjzBq21QvQ68y+Mm80qQhtsM0hA0bZuq6soa1Am3ccbAaGMkYG44JtaQEbwKgixqovwxdCTgb7HNohroAqXB7X1XfOQNcxtgQDM1OFgzwDgBYeD1V6QsCC7fZD7tX3MRpZyonYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BIIEtCc5; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BIIEtCc5"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 692EbdJf3156290;
	Fri, 2 Oct 2026 17:41:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=ZMqQW
	gT8dfPpw+gx/6DbP10TU5bM3esrGuk1nVRFX/o=; b=BIIEtCc5VmS8gIQOAV9c5
	Ue2M4O4N/ibhq51WnhQ4/5memT3uH6LNfR4e8qtl6yLNWiPDN5rowO5qkXnHA+jy
	rOzd8kgzBJEvCO2EkoDXUSGREZzCBm01nwzJbo+tddX26il9AkgCHvbZ0HyAzM3D
	z61kNYQwP0U3LY+12v3/nWkwCES2Ehua9m/bevQuVqr9M+RKVhvoN5qDKOlSpCUe
	vTN3MxKqtlLzs7vFeLfnUwvhqvTI8hjszHJTLHpZv3L5y9tlD5AY/nKuyjI/MMjT
	TRQJgb+E5RFHeS1RP9AVD22IRtGnr3rC/T38J8uvxs2S1sRfFknq0xmz+9QV7Lho
	A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx6kscgm6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Oct 2026 17:41:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 692HZUdn014531;
	Fri, 2 Oct 2026 17:41:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gtqua4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Oct 2026 17:41:15 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 692Hekeh030471;
	Fri, 2 Oct 2026 17:41:15 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-83-232.vpn.oracle.com [10.154.83.232])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4gx4gtqtes-11;
	Fri, 02 Oct 2026 17:41:14 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org, ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com,
        jolsa@kernel.org, qmo@kernel.org
Cc: dwarves@vger.kernel.org, daniel@iogearbox.net, ihor.solodrai@linux.dev,
        yonghong.song@linux.dev, song@kernel.org, martin.lau@linux.dev,
        memxor@gmail.com, emil@etsalapatis.com, bpf@vger.kernel.org,
        nsc@kernel.org, puranjay@kernel.org, yatsenko@meta.com,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v5 dwarves 10/10] man-pages: Document --inline_sites option
Date: Fri,  2 Oct 2026 18:40:38 +0100
Message-ID: <20261002174043.3823987-11-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20261002174043.3823987-1-alan.maguire@oracle.com>
References: <20261002174043.3823987-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_05,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 suspectscore=0 mlxscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2609040000 definitions=main-2610020070
X-Proofpoint-GUID: j3ztjcC9JK2ctquwk4XbeXCNR1Uc3mGI
X-Authority-Analysis: v=2.4 cv=U/gHnuru c=1 sm=1 tr=0 ts=6abfecbd b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yPCof4ZbAAAA:8 a=ol5OCCR9Ltgci0DkqhUA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13537
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA3MCBTYWx0ZWRfXzxk8uCer5aub
 b0CK2Cl0ylSJbNMihwae6lI2dMSEx4vzutt9eFcke9Nkv2tZBo1mBHm3yqUAIeaTZTFaZpaH+4o
 ut5cTdWdh7Dafa5qYAS6HyjzxjL63ys/y7nXabUsJ/gUbYtmuYoE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA3MCBTYWx0ZWRfXwN/Hn4bqBkFi
 O6vI/hpSW4SHG/KHJL3WCjpaNPeE9IzwICu0OWlu0LP6NbbmeZcd6H2So9oWQBtSfN3I4G3IBRa
 MFXDbXfLFQ054rNGEt1xBDnsH/d95Bk4ediOiECc8Zi/rkd4m+hhEJqFRrUY6HgEkyZKItlb5NQ
 Ap31bRNUslNxm5Y1a3b6d50Bs/i3RSlKheZ7W/zvIyKFuzGXOVd54+oOgMLJZbT/KnSlrAj28Pu
 Y8CXzOl/mwpHjQBVwWQo4Mg5D9ax7UiAiRqGVtdaBYLW7R5Qm1NRZrwNuBjfMKABeoqNqUG8/ZN
 GDSStn6vjl2fIr8G8tAQf8QQKE001EznCZC5gu4qSwVY83WjLYGCQ5+5AH6zlpdL5mNdvXEADOm
 fb48MhpbUIqakCYJYD9JZT9pbYeimFWqpUq7jYhs/NsOiAJANdKmuB0N+qqhMZ2jC8uMC7SNqLC
 SUFEuLGcxkOofZhKtOcRR1aXMEZhaZ/tSyO8vHSU=
X-Proofpoint-ORIG-GUID: j3ztjcC9JK2ctquwk4XbeXCNR1Uc3mGI

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

