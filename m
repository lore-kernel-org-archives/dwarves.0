Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E64A471CF5;
	Wed,  2 Sep 2026 11:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788349149; cv=none; b=YTHntqOVoZYXyrHNHxprqVBH3BteLzw5++a6lGToHxPA6/EQfnS1txpfESAxPCBxyfpgsx8y8Dn5iwBjJVjm9u64fyxPYrhlyT2mfoGKFWA7/d1UvKPsrepqU3uNoFQkh4CHZ/xj/GNaF8EZlb07vRBNbftKQVZT05WlEjeGXkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788349149; c=relaxed/simple;
	bh=xzzsA9ik37JIEE7R4w4uuF7AY2RbYiJTZpzN9DNCQlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OcwJi5l9Kre0k3taaOUieqeD+GevzWtrmL07TgguHdtfLjIyGn+HXOvUSkxSa1KiZiM1rS7L++fX3+N5X4xe20oSAeyIebmYNoHaPOSRIPk7qQpuQuNj4T1KaMTpF3kIA+872iCK3rqZOo5kNS1tPvhovtiOsdqhfgYviDZnaUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GHeXLjPG; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GHeXLjPG"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681Kp5S44036410;
	Wed, 2 Sep 2026 11:38:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=ExQZ7
	aePJ5aL2TfgrdyurwGNMpOAOZIAmr6fQ6IDNHE=; b=GHeXLjPGDvYt0clx9jN5J
	kNbcVuYuwaBWHY55HHNzdF4cI2ga4tOvJTHXeWKkUhyNx8QTecnuH0zqfq2XiaAA
	bxNf8E2TR7P/lnEWAI9eObfviZ3NdMG7CxUP0kxnk3GX8L7Yf+E4dWb0pu6zdEb8
	I1YOtAdOmZzZcplPkYbdzb+sy2F0kUgYfIV8hx01CJb6COE40rxEpFkzuafjQ2SU
	N4+9tkGTH6Ddtc3tKmjMvfwoAoiXek/A6tkGQLQo7sNiwLiVkFcYftfqKV7IymNK
	cRj5kpL4trEFWpj7zPHjDCA7/XueY0UnDFLvZd/m1fZhOKi6En6b8D3wBIHW9vrF
	g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gbp0xxms0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Sep 2026 11:38:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 682BaVPB029286;
	Wed, 2 Sep 2026 11:38:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gbnvrnt84-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Sep 2026 11:38:46 +0000 (GMT)
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 682BcYmi038508;
	Wed, 2 Sep 2026 11:38:45 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-52-253.vpn.oracle.com [10.154.52.253])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4gbnvrnt37-6;
	Wed, 02 Sep 2026 11:38:45 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org, ast@kernel.org, andrii@kernel.org
Cc: daniel@iogearbox.net, eddyz87@gmail.com, jolsa@kernel.org,
        ihor.solodrai@linux.dev, yonghong.song@linux.dev, song@kernel.org,
        qmo@kernel.org, martin.lau@linux.dev, memxor@gmail.com,
        emil@etsalapatis.com, bpf@vger.kernel.org, dwarves@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 dwarves 5/6] btf_loader: Add "inline" annotation for inlined functions
Date: Wed,  2 Sep 2026 12:38:25 +0100
Message-ID: <20260902113829.1285407-6-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260902113829.1285407-1-alan.maguire@oracle.com>
References: <20260902113829.1285407-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_02,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2609020103
X-Proofpoint-ORIG-GUID: Fgaqk4kWLQeeZOqIuhdoKKIAqnI9FL3Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDEwMyBTYWx0ZWRfX1ruTFQZHZiys
 0zGzd45Pmy6Aedo//SKXn4XQgW/VijY7YIK0Pa6w/BF+HLgYjNx5oTo74jk2g907DOj25+7G9tY
 rfgbsjoauUpjS/LhtA/xfvJuIDhqHy9QTwVXw73HgBaj19ZiPGthhTYrjzxh6JwbXwDik8gK7pm
 OvV6IdhaXi/uUWJype23BoVE/tM98XZoU0hhFt+doFYni0vFtUKxEC1d4Te779lef4eMxc8H391
 rzsbKEQX3r0HQd8bwmlCEZ3Um/Jd7S6MxnASK9U2uKXU4uWETYpGJziX7mh9VPpcdHyMtdNGxeV
 ZWwc3aCyUE8zQ/RURi/4rBYDHZfxbmDdCgbiEDUBNHDzqQFM6ZLauaRgp30f1ei5Y3UgLxmZkch
 T+C50AFXfMXNGAocexHICHD8rfg6IIct/s/usqWL+TGXL98hcfJmCh0RuPhqUi9PRVflreViQno
 3Vr/QUBaHfVfse6ycOL3a0B82ah/pOlVCT1Wv6Ig=
X-Authority-Analysis: v=2.4 cv=Ebb4hvmC c=1 sm=1 tr=0 ts=6a980ac7 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=yPCof4ZbAAAA:8 a=cdKcfzRyvrmrIr9UkKgA:9
 a=O8hF6Hzn-FEA:10 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf
 awl=host:12102
X-Proofpoint-GUID: Fgaqk4kWLQeeZOqIuhdoKKIAqnI9FL3Z
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDEwMyBTYWx0ZWRfX6gPf9cAzBXei
 2MNYmxUgRL01CihLFFQ5zHmp6qRjiofgsX4X0OgHiOXJQp025DkT7fQMB8O51JX/sVd626kXFuC
 L2MYdW6umQko8CyQip38MxsQ7UiaGJq+FAHskV49O5nN7iQOpjTe

For a function that is inlined in BTF (signified by a LOCSEC entry
pointing at its FUNC) mark it "inline".  This is already done for
DWARF.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 btf_loader.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/btf_loader.c b/btf_loader.c
index 66ffd1a..d787202 100644
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
@@ -670,9 +676,53 @@ static int btf__load_types(struct btf *btf, struct cu *cu)
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
+		if (!name || strcmp(name, "inline") != 0)
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

