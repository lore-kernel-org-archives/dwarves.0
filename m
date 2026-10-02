Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400024FDE62;
	Fri,  2 Oct 2026 17:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790962897; cv=none; b=W0u7fSqT3nhkSm2U4i9RSwfsEgeQN9LBfrtIsU1XGu/JxdM7CqVijFK9fETDUT0jmmZJL1Xhpv9jVugDyseULherSc/VdrezcKCvGdFMMLm5PGxZ+4pBzZgN9ksM0NQ8mSu78VCCEYFqHSRjw6vn15bMNHtW/EXmX/b6s+YpN8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790962897; c=relaxed/simple;
	bh=nXprZKdPxr+kU+8S4vxgez+OLM/h53qIPAy9CWYKoM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AHYxqvp/QdKLoMaGw8vXAn4W8CYC3R4zPlMVhNFsm/zdKB2EJalglDw55QOhulPvJhd3uJfyjWqQbz3WcEDP4Mbo7aS5wWKCMe8z0JqKkC2hTTgVebzr1hEmO/mGAeA+SgI/+YANa1fk8I0rsGCTARwIwcmdPhLKZh8knDmtmkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jLKoO664; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jLKoO664"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 692EbxT43204655;
	Fri, 2 Oct 2026 17:41:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=OW1cM
	NpBaXSe0s+AXgpTBqTwMXXd2uHXkK+TRtfBXZQ=; b=jLKoO664OYZBLwvb0tOMH
	rsmS3u8owQaNZtCnWHs7LLA9SLFs6RHf4f8XGYuA0Tti3UopYFdbf96492VROGDm
	WwuomOFKBDdD6g7uS2OE5iZ5r5v//RYCiARhiGbYEYnd6z45NvGD3wuH4nKU4GbI
	UrtgfGWvfPZGPw/lqR4A61hgxKBC1vZrO3W/x0GOhn4YcCY3T8Gvyc/Zg3i75SRA
	lRvfK+sukum4b4CRp/cER881VtgAxtRw+wjA7S8g1yI/iKQVGRsz+Gkhgn9pUHhV
	6mctaGxMOA//sDvAv+Bw/eIYgZFhpjPRJyqFg67RRsxSnVhj+RhXC7IkDUNllO6D
	g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx4fbmatu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Oct 2026 17:41:04 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 692HZTmY014420;
	Fri, 2 Oct 2026 17:41:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gtqu05-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Oct 2026 17:41:04 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 692HekeZ030471;
	Fri, 2 Oct 2026 17:41:03 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-83-232.vpn.oracle.com [10.154.83.232])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4gx4gtqtes-7;
	Fri, 02 Oct 2026 17:41:03 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org, ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com,
        jolsa@kernel.org, qmo@kernel.org
Cc: dwarves@vger.kernel.org, daniel@iogearbox.net, ihor.solodrai@linux.dev,
        yonghong.song@linux.dev, song@kernel.org, martin.lau@linux.dev,
        memxor@gmail.com, emil@etsalapatis.com, bpf@vger.kernel.org,
        nsc@kernel.org, puranjay@kernel.org, yatsenko@meta.com,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v5 dwarves 06/10] btf_loader: Add "inline" annotation for inlined functions
Date: Fri,  2 Oct 2026 18:40:34 +0100
Message-ID: <20261002174043.3823987-7-alan.maguire@oracle.com>
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
X-Proofpoint-ORIG-GUID: obqEUIg65JaMqwAohkwElscH5vAIQ0Dr
X-Proofpoint-GUID: obqEUIg65JaMqwAohkwElscH5vAIQ0Dr
X-Authority-Analysis: v=2.4 cv=eJCGH3p1 c=1 sm=1 tr=0 ts=6abfecb0 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=yPCof4ZbAAAA:8 a=Yshe4ZZT8TUiTL5K-4gA:9
 a=O8hF6Hzn-FEA:10 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf
 awl=host:13537
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA3MCBTYWx0ZWRfX2NTQfKglcxFJ
 nWblIgxHUUfjrJCWUPt+7+DRc6Dk7teVLwjfa63yv31Y5rn/ABmDKyTl6i+L9Brv4RFvHHChorT
 8lawctw3oxG9AKqoG+JoGpS8u8jjaw7+DNMtVkE4p4OHHw2oWCAw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA3MCBTYWx0ZWRfXxFtZipAAFI9j
 ZbB9dFdLaxrcTFAJ7U7n0hP5P1NFgAsWdt9xIVVJAljkyemSFRJ/ykdgEpy5BI1/KfAmDHoLui+
 SCBJZVbYN/tvvY1Y6g5vb3W8/ZLmQ+ROOVhFCOMWeaN1NAlB7wL8/QNBA9YfNoOc/2tqI2ucige
 ic1uYnj08U1Dmw2MUOhQAszITojW3eFwrREKkwhQo3Krie+MHQiUEQk8gh8tCRK7o3Ta1cCwzny
 Be8SsJBE2YaBdL4a9+A2zqy7P0U6orBFVQ4TSGeRIIAaAtBRbnxrQdsfi9c9GdELPiLGa+bf0xT
 lqWewqEnBKV5F97xpvvwE2k0aGjhtIkoNqun9X4gW4Ln5ER8IBfphgD0Q9FzX1gLLzXSrEd31ET
 KfYHO5J1lqP0CHolMrspVHKe/tZAPIjo2oxlV/PWqXHElJoon09OmQl3xDe9Ftal2Xu8zRzeD3v
 3kM00L2i/g7w4UBjkY2antU7/KIVDYcYcdUyuOT4=

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

