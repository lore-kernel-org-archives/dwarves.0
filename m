Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCF64D17A1;
	Fri, 25 Sep 2026 18:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790362389; cv=none; b=cIHliRiCiEYyRpeCOJjQiDWEmKqHSsA7lKMaTWm5fLxuqoHWe208lpNoAYW5ShpmkUQ68GZ10i6eFsRr21NYzJ0Tt+C+oi4G9yX21bj42KM1e2Wykeg11+l59l+k6O8HBKqhhB9zYCQ3F9HXvHY6LDOCDHupJLhJj0GuLuQBJJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790362389; c=relaxed/simple;
	bh=nXprZKdPxr+kU+8S4vxgez+OLM/h53qIPAy9CWYKoM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TRZP7gCE2yeanMmF+zQp0oldb9Q43RG6SO+b5MzJkv8p+rZE7Z8oXdY8q/Kj8//fQlPCRVktvIZnauwSvTZy3yq1qnYPuZ/8YK2tsLIHRvHkkXISTlPTk4RI7Dx+azbXRFfpx23onHyQmH0332s6UKODLL9C6yQre6CzGFpYNCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ht3mHqBj; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ht3mHqBj"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68PEBpXi3193010;
	Fri, 25 Sep 2026 18:52:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=OW1cM
	NpBaXSe0s+AXgpTBqTwMXXd2uHXkK+TRtfBXZQ=; b=ht3mHqBjNqNHvdGea3SF5
	/oP8OxtBrp7eRDYZyzix7YTxl2QulvWK84qyU1D9qVbIGAcYee7uev6VDoQxBceP
	85ndkzqotUXNBh3ccWjFb0zjyl1wO7vnKpztaA0OGF1Edmsvwe63gtGs3jOHUz8G
	hrYUc03AUNpzCYvYxh2UQRNsPSYt7exew+7DFuYPm2dEhO3KxutOyQL+T8h3AnBs
	ZcYoi4HJboZTwzXwCBEQP0YnTtbm24unzPpWgQoxq7b/TUlXpqiqRcie9ul8DFtZ
	OpcZvfYbqnC0laFCNn5kd7jZJBnJyclye3kz6znbmuhDJWxGpzEAGl/noHsPNqJM
	Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gsk2d9u6r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 18:52:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 68PIqEIr038662;
	Fri, 25 Sep 2026 18:52:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gtepthtcw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 18:52:43 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 68PIqQoo040536;
	Fri, 25 Sep 2026 18:52:42 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-81-122.vpn.oracle.com [10.154.81.122])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4gtepthsyc-6;
	Fri, 25 Sep 2026 18:52:42 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org, ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com,
        qmo@kernel.org
Cc: dwarves@vger.kernel.org, jolsa@kernel.org, daniel@iogearbox.net,
        ihor.solodrai@linux.dev, yonghong.song@linux.dev, song@kernel.org,
        martin.lau@linux.dev, memxor@gmail.com, emil@etsalapatis.com,
        bpf@vger.kernel.org, nsc@kernel.org, puranjay@kernel.org,
        yatsenko@meta.com, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 dwarves 5/9] btf_loader: Add "inline" annotation for inlined functions
Date: Fri, 25 Sep 2026 19:51:54 +0100
Message-ID: <20260925185200.1318067-6-alan.maguire@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA3NSBTYWx0ZWRfXwUiF2LNTfBMG
 26oPuVpwFzW3sAtzaFhw6EuB/36orfuv8RYZDjfGrQjRco+yaOjnJoc6IpxKJWFyKf/456r2+cB
 O1KEF/8T0Q6dbC6nzRfOiEvNDWCrrxfRfmWFFz+P5n0F074x8OD2+Ik6Z50EHhoXi9UcrYDX4Tf
 L6ZwuY7eu/VfUXCgI/fLN8iShmJ8faVqxS9Ah3xptsigCZX2DVIQXIzjFqtxaM+YFdxPl5tRaq0
 MF5Rq8M37MjxBSgPTMcQcRXRRqCgherpUId01VBLmCieIg6/8IGtfcp31r3pw+2MtPmH56UT5G4
 h3G98IlbGeWls3in7YDBaAi8GyeSTcx10GnRjSRrpA+waWHoeSr/ay6PINIb4qqska7c6Pc4xnt
 lc4mejeNph4EPg+iq1C6CfOwHtt6miFQni/s5VzUHM1LE8zz9B1hqTJchemUwoNBNXN5vYSQtH4
 OknYj4vc7wYH0H1qaWEwO8q4Wz4G72Xlft5Ie7I4=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA3NSBTYWx0ZWRfXzWISFGiyLH+q
 s26jxdqxlWS7UwqksUOhSr1Sv9b6xHRev+KZMmJA+mt3gEnL0q2W7gfw95he1fBu77NudWn3bVP
 CTF9CPbgrlVOdPvkyg9FCXpyonCCOlvcs3unydK9xEXGnkF9yTf7
X-Proofpoint-ORIG-GUID: ltwlK0sEDX_1iLmIZDOxWqi6nPILH5Oe
X-Authority-Analysis: v=2.4 cv=f+Ddl+yM c=1 sm=1 tr=0 ts=6ab6c2fc b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=yPCof4ZbAAAA:8 a=Yshe4ZZT8TUiTL5K-4gA:9
 a=O8hF6Hzn-FEA:10 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf
 awl=host:13532
X-Proofpoint-GUID: ltwlK0sEDX_1iLmIZDOxWqi6nPILH5Oe

For a function that is inlined in BTF (signified by a LOCSEC entry
pointing at its FUNC) mark it "inline".  This is already done for
DWARF.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 btf_loader.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/btf_loader.c b/btf_loader.c
index 66ffd1a..4dea882 100644
--- a/btf_loader.c
+++ b/btf_loader.c
@@ -30,6 +30,12 @@
 #include "dutil.h"
 #include "dwarves.h"
 
+struct btf_locsec_entry {
+	uint32_t func;
+	uint32_t loc_proto;
+	uint32_t offset;
+};
+
 static const char *cu__btf_str(struct cu *cu, uint32_t offset)
 {
 	return offset ? btf__str_by_offset(cu->priv, offset) : NULL;
@@ -670,9 +676,54 @@ static int btf__load_types(struct btf *btf, struct cu *cu)
 	return 0;
 }
 
+static bool btf__has_location_support(void)
+{
+	return btf__add_loc_param && btf__add_loc_param_value &&
+		btf__add_loc_proto && btf__add_loc_proto_param &&
+		btf__add_locsec && btf__add_locsec_loc;
+}
+
+static void btf__mark_inline_functions(struct btf *btf, struct cu *cu)
+{
+	const struct btf_type *type_ptr;
+	uint32_t type_index, type;
+
+	if (!btf__has_location_support())
+		return;
+
+	for (type_index = 1; type_index < btf__type_cnt(btf); type_index++) {
+		const struct btf_locsec_entry *entries;
+		const char *name;
+		uint16_t i;
+
+		type_ptr = btf__type_by_id(btf, type_index);
+		type = btf_kind(type_ptr);
+		if (type != BTF_KIND_LOCSEC)
+			continue;
+
+		name = cu__btf_str(cu, type_ptr->name_off);
+		/* LOCSECs are named "inline<section>", e.g. "inline.text". */
+		if (!name || !strstarts(name, "inline"))
+			continue;
+
+		entries = (const struct btf_locsec_entry *)(type_ptr + 1);
+		for (i = 0; i < btf_vlen(type_ptr); i++) {
+			struct tag *tag = cu__function(cu, entries[i].func);
+
+			if (tag)
+				tag__function(tag)->inlined = DW_INL_declared_inlined;
+		}
+	}
+}
+
 static int btf__load_sections(struct btf *btf, struct cu *cu)
 {
-	return btf__load_types(btf, cu);
+	int err = btf__load_types(btf, cu);
+
+	if (!err)
+		btf__mark_inline_functions(btf, cu);
+
+	return err;
 }
 
 static uint32_t class__infer_alignment(const struct conf_load *conf,
-- 
2.43.5

