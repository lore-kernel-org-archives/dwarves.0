Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DA1396D2B;
	Thu, 26 Feb 2026 08:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772096252; cv=none; b=Di279iXdR1QLukYSzA73WTt0VVZyKYjI436opYTGiIvb2lHSzD+N3eRhSdxp2577nHvX81YCOBk8cvjf/cB2YFYI79MeQrC14dVaRiWjx22S5QfrM86XoPvtZshU1OgPoWyrH4/ywJbmP8peayNL28iHynnVX0+NUOn2e/8nQCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772096252; c=relaxed/simple;
	bh=6PUhMRtEzGekpMqdCKlA/B3WRIC4fAQ2CIv7S0OKoTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=deMD64y0I8Ig6KkgkUiOu0r2VUrJiyeO2oub1pwcCQEe5SAMQThrkdjFGiSOYEfvHMbDXrd9eptxZYN273OO4BR0TGRwC5TxERVY8A2J/lqiUdtQVoFgpgSHJmE2YciynWEWnXheb7Z9hJojA90sqWVUqboqsNpp77N6cNL8L04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ijjv+A/i; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ijjv+A/i"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PNwS7w3711138;
	Thu, 26 Feb 2026 08:57:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=qfYgd
	eT/JQE8r6NzsTtUyvD1tm2Bzu6imBK9XpGkhu4=; b=ijjv+A/iSQZWoEU537ndW
	tEUP4SesrRgOnDgXbUuzGWwdMUfi7dKqF1d2UC6yNoZfqElgKC+Exk9xeSIfQd5Y
	HH7I1lYkBnCYEfan+Qo9/mPH6m+KiWgWRkSYxFLsUdPmit4ZrSgrDEYN3ac2y924
	QWkgULxprRzvO/YvHf6StIvnhWkNh6qGPVFr0i//RFt4xtwhqTO7pIzX2p9afJdl
	PSiXSA4xxQAyYkYHPPTwucN1lmZOJOuDs4rvQFPDHuAp0xkEqhbGqDZzmNEWUZDk
	cJZNSUn72k0UhYTjQmIVXX/ROMwETJDZkGrB+1S0fnOr+v8XlhQ18FoaKVkp+Nbd
	Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cf4arftyp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Feb 2026 08:57:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61Q7G5Ah028662;
	Thu, 26 Feb 2026 08:57:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cf35c75ns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Feb 2026 08:57:08 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 61Q8uYai038952;
	Thu, 26 Feb 2026 08:57:08 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-58-146.vpn.oracle.com [10.154.58.146])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4cf35c759a-10;
	Thu, 26 Feb 2026 08:57:08 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        mykyta.yatsenko5@gmail.com, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v9 bpf-next 09/10] bpftool: Update doc to describe bpftool btf dump .. format metadata
Date: Thu, 26 Feb 2026 08:56:23 +0000
Message-ID: <20260226085624.1909682-10-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260226085624.1909682-1-alan.maguire@oracle.com>
References: <20260226085624.1909682-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_04,2026-02-25_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602260079
X-Authority-Analysis: v=2.4 cv=La0xKzfi c=1 sm=1 tr=0 ts=69a00ae6 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=yPCof4ZbAAAA:8 a=oGlH3XLwWBQq_BvjqjQA:9
X-Proofpoint-ORIG-GUID: Hzt32jbBMjxUVUF-jxFowht_p29ipVXP
X-Proofpoint-GUID: Hzt32jbBMjxUVUF-jxFowht_p29ipVXP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDA3OSBTYWx0ZWRfX7YfmL471JWoL
 aIb7eCjAu8esWK32T5t/xI7N2FQ3RmQIk0trP8U1PJPyu8NWJuRq0Hds1qkbiS+o8YAUE5FqW7Y
 YLNzTjvzD0hOogVti9FphdtRMnEGPpWi49uEy2FZwJ4jciaSuhNbJ3PK/vw2coG6OD9gYLZAJCP
 OJBBnB743CcHLneAhIqW3o2S6M40Pb9cZ8r5zv1JTflA4zDA5qjOLizEgVC41I3lK2bqWg+GTb0
 wXOKTHWABUUY01FYlEtU0/CRHA8RSPXaXioKc9IGYab1XDWBLdyKuE6N9Q2YQcUQ0kVCJEQCnbF
 HJbMvZgwUjYwjVeEZU93v5dT3f1hydbDjkdfJZ7u4DHSJ4ViL4d4ubc3BtlmOlsth3e+D+OasJo
 K8L19k3gZmtB8iG/cXp3GKFv7OwK6oVRoUNIMb3JdehdGpMJIOmtXQnj0Jd+RzBBzq38Yx6EXuR
 nFGFKgXT7WvpFko40tA==

...and provide an example of output.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 .../bpf/bpftool/Documentation/bpftool-btf.rst | 28 +++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-btf.rst b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
index d47dddc2b4ee..ea1b5cdecd0a 100644
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
+  kind 0    UNKNOWN    info_sz 0    elem_sz 0
+  kind 1    INT        info_sz 0    elem_sz 0
+  kind 2    PTR        info_sz 0    elem_sz 0
+  kind 3    ARRAY      info_sz 0    elem_sz 0
+  kind 4    STRUCT     info_sz 0    elem_sz 0
-- 
2.39.3

