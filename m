Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66105248F54;
	Fri, 27 Feb 2026 10:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772186733; cv=none; b=Vj0vbkxiHHee7ahlosrdum2ilW4KOam+xt8E7JAm4SpbAPJyUkkimiXej6dwQBcNMIqytuYGKIlX/vA7YQBfs1HcWsD7nd6HfEiSDG4k2NPHk0j8gBQTSBnZtsNhQe2nq4Sb51jefhOVolbY+DJRl/aFwsYhX6ZmVUnr7fJn9CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772186733; c=relaxed/simple;
	bh=RMHbTt8S59SfYaYRC+lqg2zr9mopJxKN5tDg1kP2oeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LrgojZh9B57ib/P+XLXUTueO26QZVHx4C0HzrM+EbXBs842NQhNDQl2dHnS12xz1Wb8oOXto9fXerapD3kNJYqx9OzCHads8k/rx8o5gp6DH9/+u+wHWMFZ9uZEc9+VPg6ddVLJcDo186hVwinPpph9jgt01NH6shIme7e24z8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HQNCpSYx; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HQNCpSYx"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61R9vPuj2821054;
	Fri, 27 Feb 2026 10:05:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=LcKjx
	DKdeq/XYAmo4PcfuxXz3FMAh3JOrx4tIRcRxLo=; b=HQNCpSYxORIiR2RyPTEFo
	IWaDfJCgK87dCZnuXnn29gPVWAT6+ovfXVjjme4m3W4rLdrkBTgWs9ECPfmHgtv3
	fYQfcjZTNVFOaNs+9ZAUfDgdWzW+Cf2+czLDmTRveBNLCVRHTQ3cvEscySe+/DRt
	P+4Yo1PFQBeu8SEQ5eRr2OSQzDIIME5zKP4npZCTsR7XX4Pa9f0gk55fvBgKn/0V
	iWYcj8EhriK2N6wmqmYzKld2vGbleCBtAPwdbw/YC/oFtmx4cAJxKi0TaETw4DPO
	VQCOrsr8mpIMHn5V2dxfxVFkqTcbN5tZrWqDua2Of5ewKK3tSnHnq3M9QOtOgmbi
	Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cf4k61vg0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Feb 2026 10:05:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61R9H3MV028533;
	Fri, 27 Feb 2026 10:05:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cf35dmxrr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Feb 2026 10:05:06 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 61RA4Vxo036185;
	Fri, 27 Feb 2026 10:05:06 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-60-228.vpn.oracle.com [10.154.60.228])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4cf35dmx3p-10;
	Fri, 27 Feb 2026 10:05:05 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        mykyta.yatsenko5@gmail.com, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v10 bpf-next 09/10] bpftool: Update doc to describe bpftool btf dump .. format metadata
Date: Fri, 27 Feb 2026 10:04:25 +0000
Message-ID: <20260227100426.2585191-10-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260227100426.2585191-1-alan.maguire@oracle.com>
References: <20260227100426.2585191-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_01,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602270086
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDA4NiBTYWx0ZWRfX7oJDAqKc2rjU
 F8+PrhLRqQRyF9loAWNiPEvvvtn/0N4G6+qhF3V3pQJ6AW25Bz9J/MuJjdrMlFeDERDEMwmOp3O
 C3qRmzH7dQqeWA/SzgwxzNie5slnOH7BoI5zNQ9CKyqno0+C6m7EGBcndA3NinEITGujAAq5tWG
 8w4YHyLK1OxUIS5QZ2tWZL5SPnxYZoQgoJz3JG4nKcYs2DzS0tQrNePZV8XsI1ppVDS2Ml80rch
 3xtXYd1MSoqaH76PQdIo/kHgNyZOaQrWC327azifQsQoiPLtUeXRgAoAPhYV5PBig88376XPYaC
 Z9Q6/rWaFc0zNWqX2p3YE7Uc4U6wek1SsuXuwB/KjZGd4kVzoCBwvbHBd2vlpENGSRa3Klg/3Lm
 m1P8tXxT7Tm2QkTc75E+jSnUpmvqI4/4WO1b8VJtG9NbvyGl6Ijqhu7YjatH7giyWCGW7OEv/On
 /dvG4RaOnpChOz/+66g==
X-Proofpoint-GUID: NdMuEITkHEySaXcYLX-6tHvFQxM5KXVw
X-Authority-Analysis: v=2.4 cv=b9C/I9Gx c=1 sm=1 tr=0 ts=69a16c53 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=yPCof4ZbAAAA:8 a=oGlH3XLwWBQq_BvjqjQA:9
X-Proofpoint-ORIG-GUID: NdMuEITkHEySaXcYLX-6tHvFQxM5KXVw

...and provide an example of output.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 .../bpf/bpftool/Documentation/bpftool-btf.rst | 28 +++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-btf.rst b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
index d47dddc2b4ee..1004f9bf0a43 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-btf.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
@@ -28,7 +28,7 @@ BTF COMMANDS
 | **bpftool** **btf help**
 |
 | *BTF_SRC* := { **id** *BTF_ID* | **prog** *PROG* | **map** *MAP* [{**key** | **value** | **kv** | **all**}] | **file** *FILE* }
-| *FORMAT* := { **raw** | **c** [**unsorted**] }
+| *FORMAT* := { **raw** | **c** [**unsorted**] | **meta** }
 | *MAP* := { **id** *MAP_ID* | **pinned** *FILE* }
 | *PROG* := { **id** *PROG_ID* | **pinned** *FILE* | **tag** *PROG_TAG* | **name** *PROG_NAME* }
 
@@ -65,7 +65,8 @@ bpftool btf dump *BTF_SRC* [format *FORMAT*] [root_id *ROOT_ID*]
     **format** option can be used to override default (raw) output format. Raw
     (**raw**) or C-syntax (**c**) output formats are supported. With C-style
     formatting, the output is sorted by default. Use the **unsorted** option
-    to avoid sorting the output.
+    to avoid sorting the output.  BTF metadata can be displayed with the
+    **meta** option.
 
     **root_id** option can be used to filter a dump to a single type and all
     its dependent types. It cannot be used with any other types of filtering
@@ -267,3 +268,26 @@ All the standard ways to specify map or program are supported:
   [104859] FUNC 'smbalert_work' type_id=9695 linkage=static
   [104860] FUNC 'smbus_alert' type_id=71367 linkage=static
   [104861] FUNC 'smbus_do_alert' type_id=84827 linkage=static
+
+Display BTF metadata from file vmlinux
+
+**# bpftool btf dump file vmlinux format meta**
+
+::
+
+  size 5161076
+  magic 0xeb9f
+  version 1
+  flags 0x1
+  hdr_len 40
+  type_len 3036368
+  type_off 0
+  str_len 2124588
+  str_off 3036368
+  layout_len 80
+  layout_off 5160956
+  kind 0    UNKNOWN    info_sz 0    elem_sz 0   flags 0
+  kind 1    INT        info_sz 0    elem_sz 0   flags 0
+  kind 2    PTR        info_sz 0    elem_sz 0   flags 0
+  kind 3    ARRAY      info_sz 0    elem_sz 0   flags 0
+  kind 4    STRUCT     info_sz 0    elem_sz 0   flags 0
-- 
2.39.3

