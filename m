Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886BB4B2045;
	Fri,  2 Oct 2026 17:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790962904; cv=none; b=DQF6VZXeM7mnM+D5Idih2vZUgXX0vLNtoMH97OfPCIEQfR+r3AtFeKa6idpiiVS0NYSDKWPwk5NHJRK25KtIem7c8anHuml5vMtP2hDP4Y5xFyXTAWklDDOvDoUgvCq+nGlbpHgvrwjABi/r8fCGDklTm1Sq5ix6+3p06xDTSmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790962904; c=relaxed/simple;
	bh=xVqt/rSU7GHiQjKEovU8o6c6mSOoAfa9lj7sduzQK0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BPjDecvLwjNkMgkujCdq0fHymvXVP3s6yO9q43KKSmFsQF0wigpq7e6aXyNoqqdMKFiIMa1E/ytTaOn/n3GKthlwPTimGFjREvKLKmw2WgmVj590z/c/KiX3zGsZJ3EjqMGC00K4b7IqQxXscORSgbo/nCNp0uzgfCPbhO4T9BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Z8ereAqA; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z8ereAqA"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 692EbdSw3156301;
	Fri, 2 Oct 2026 17:41:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=YLdeL
	C7SGZFz3Pkgph5usikI5apZG0RSfsoILi8oqR4=; b=Z8ereAqAPnSs5OmBP/Clf
	GO+JmVvMjfwhQsAh1eaav63owPwEVFDm07+LZCAt5HfyQlrdynG0TFYGZBHB5mqt
	aCho+eVB8h1ugfnYz7QrMUb58/YnAKwtyxXFXfJo63y5xCocRXAiAzTiYPVQRgW7
	a/CKNFozfG+ODE132Vvxi/IVd9AkhBp3O+iSGyQa3MubW8FzqtS5+aOjYYj12ZWs
	rKRdsH7yfnHbPE4RfAPAXORum9P1VUvhihjZsNehDKVeDX/JF9FcXPHU81LzTld0
	D6EEvc87UUoCMqczNpBxGpaTnG2/8H7ypVLIVCQ91DgM1zLWLvoe9ZmV0fDehizf
	A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx6kscgm0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Oct 2026 17:41:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 692HZT04014447;
	Fri, 2 Oct 2026 17:41:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gtqu2f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Oct 2026 17:41:07 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 692Hekeb030471;
	Fri, 2 Oct 2026 17:41:06 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-83-232.vpn.oracle.com [10.154.83.232])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4gx4gtqtes-8;
	Fri, 02 Oct 2026 17:41:06 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org, ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com,
        jolsa@kernel.org, qmo@kernel.org
Cc: dwarves@vger.kernel.org, daniel@iogearbox.net, ihor.solodrai@linux.dev,
        yonghong.song@linux.dev, song@kernel.org, martin.lau@linux.dev,
        memxor@gmail.com, emil@etsalapatis.com, bpf@vger.kernel.org,
        nsc@kernel.org, puranjay@kernel.org, yatsenko@meta.com,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v5 dwarves 07/10] btf_loader: Record inline sites in CU for BTF
Date: Fri,  2 Oct 2026 18:40:35 +0100
Message-ID: <20261002174043.3823987-8-alan.maguire@oracle.com>
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
X-Proofpoint-GUID: 8_141GfzNOxJFet6Eofe8WS2cUZVCFWW
X-Authority-Analysis: v=2.4 cv=U/gHnuru c=1 sm=1 tr=0 ts=6abfecb4 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yPCof4ZbAAAA:8 a=zBj7asqCIPECPjkPQzcA:9
 a=O8hF6Hzn-FEA:10 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf
 awl=host:13537
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA3MCBTYWx0ZWRfX1D6z/g+eg/eO
 uX7p/OVltsjv3C43HVIai96Oe2Su6JRvM8iQWbVAEUpT/qHk+7tzMwXVHyzcwxO9s2rrbR8bZf8
 V5DUYNwkuH7kSoXLkIfwop5p1h6bQY0g6zUA1dFo10NgRpNNi15v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA3MCBTYWx0ZWRfXym2zxdigUVVy
 TzSrjLcU2mlH2Q0obbqjDNd7LRiYYc1DPr7sGJ8RXfW8ekqlHDS5Fut36PiPoWI9KDdQ4PFS9XP
 9xeMvw7Sh6lff7msIhsLapBHxQSxYbDO+4LUDDxL8+DSS+Z1juGiLuP04J6DATAnxavNuCUmiQ2
 y4VcEpDfsjpKd3ZBOeE/GyjHMhw4SaweK8eWuZSxrZHntJbOhjyCB3tnkbER++c9xD7kuxjYNtV
 oEcXe0YvjkcRxaQKs6G/RRXMJJdnl51aXtIiMwUDpi5gBCU3jPQUUFt4tmcbII2+C8xqz/5mNFU
 O6KMWny0jIwIxsWWSSnhyEpBrwuJ4htCrfGGBphIFb5xdgaiAltG07qpTHGQLNbexMn7SpkB4A3
 rdiOWw5jw2yrzWTDWkxJY/3avNATExKPwOpe3+91KTa3enTqDeYamNaWyOYYxsOzoxYBj2xONxV
 l9MnOCMgenIx9LcjUqCk5DLqMvFMHa4XQAhmZePw=
X-Proofpoint-ORIG-GUID: 8_141GfzNOxJFet6Eofe8WS2cUZVCFWW

Add BTF inline sites to the CU representation.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 btf_loader.c | 47 +++++++++++++++++++++++++++++++++++++++++++----
 dwarves.c    |  1 +
 dwarves.h    | 11 +++++++++++
 3 files changed, 55 insertions(+), 4 deletions(-)

diff --git a/btf_loader.c b/btf_loader.c
index 4dea882..821a6d8 100644
--- a/btf_loader.c
+++ b/btf_loader.c
@@ -25,8 +25,6 @@
 #include <bpf/libbpf.h>
 #include <zlib.h>
 
-#include <gelf.h>
-
 #include "dutil.h"
 #include "dwarves.h"
 
@@ -36,6 +34,28 @@ struct btf_locsec_entry {
 	uint32_t offset;
 };
 
+static void btf__add_inline_site(struct cu *cu, const char *section_name,
+				 const struct btf_locsec_entry *entry)
+{
+	struct tag *tag = cu__function(cu, entry->func);
+	struct btf_inline_site *site;
+
+	if (!tag || !section_name)
+		return;
+	site = zalloc(sizeof(*site));
+	if (!site)
+		return;
+	site->section_name = strdup(section_name);
+	if (!site->section_name) {
+		free(site);
+		return;
+	}
+	site->function = tag__function(tag);
+	site->section_offset = entry->offset;
+	site->loc_proto = entry->loc_proto;
+	list_add_tail(&site->node, &cu->btf_inline_sites);
+}
+
 static const char *cu__btf_str(struct cu *cu, uint32_t offset)
 {
 	return offset ? btf__str_by_offset(cu->priv, offset) : NULL;
@@ -647,6 +667,12 @@ static int btf__load_types(struct btf *btf, struct cu *cu)
 			 * loaded.
 			 */
 			break;
+		case BTF_KIND_LOC_PARAM:
+		case BTF_KIND_LOC_PROTO:
+		case BTF_KIND_LOCSEC:
+			/* LOCSEC is decoded after the ordinary BTF types are loaded. */
+			err = 0;
+			break;
 		default:
 			fprintf(stderr, "BTF: idx: %d, Unknown kind %d\n", type_index, type);
 			fflush(stderr);
@@ -694,7 +720,7 @@ static void btf__mark_inline_functions(struct btf *btf, struct cu *cu)
 	for (type_index = 1; type_index < btf__type_cnt(btf); type_index++) {
 		const struct btf_locsec_entry *entries;
 		const char *name;
-		uint16_t i;
+		uint32_t i, nr_entries;
 
 		type_ptr = btf__type_by_id(btf, type_index);
 		type = btf_kind(type_ptr);
@@ -706,12 +732,18 @@ static void btf__mark_inline_functions(struct btf *btf, struct cu *cu)
 		if (!name || !strstarts(name, "inline"))
 			continue;
 
+		/* LOCSEC uses the extended 24-bit vlen introduced with the
+		 * location BTF kinds.  Older libbpf headers still expose the
+		 * original 16-bit btf_vlen() helper.
+		 */
+		nr_entries = type_ptr->info & 0x00ffffff;
 		entries = (const struct btf_locsec_entry *)(type_ptr + 1);
-		for (i = 0; i < btf_vlen(type_ptr); i++) {
+		for (i = 0; i < nr_entries; i++) {
 			struct tag *tag = cu__function(cu, entries[i].func);
 
 			if (tag)
 				tag__function(tag)->inlined = DW_INL_declared_inlined;
+			btf__add_inline_site(cu, name + strlen("inline"), &entries[i]);
 		}
 	}
 }
@@ -851,6 +883,13 @@ static int cu__fixup_btf_bitfields(const struct conf_load *conf, struct cu *cu)
 
 static void btf__cu_delete(struct cu *cu)
 {
+	struct btf_inline_site *site, *n;
+
+	list_for_each_entry_safe(site, n, &cu->btf_inline_sites, node) {
+		list_del(&site->node);
+		free(site->section_name);
+		free(site);
+	}
 	btf__free(cu->priv);
 	cu->priv = NULL;
 }
diff --git a/dwarves.c b/dwarves.c
index 2bb5c18..fe4f5e4 100644
--- a/dwarves.c
+++ b/dwarves.c
@@ -756,6 +756,7 @@ struct cu *cu__new(const char *name, uint8_t addr_size,
 		cu->dfops	= NULL;
 		INIT_LIST_HEAD(&cu->tags);
 		INIT_LIST_HEAD(&cu->tool_list);
+		INIT_LIST_HEAD(&cu->btf_inline_sites);
 		INIT_LIST_HEAD(&cu->node);
 
 		cu->addr_size = addr_size;
diff --git a/dwarves.h b/dwarves.h
index 746f94e..ba7dd77 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -292,12 +292,23 @@ struct debug_fmt_ops {
 	bool		   has_alignment_info;
 };
 
+/* A BTF LOCSEC record describing one inline expansion. */
+struct function;
+struct btf_inline_site {
+	struct list_head node;
+	struct function *function;
+	char		 *section_name;
+	uint32_t	 section_offset;
+	uint32_t	 loc_proto;
+};
+
 #define ARCH_MAX_REGISTER_PARAMS	8
 
 struct cu {
 	struct list_head node;
 	struct list_head tags;
 	struct list_head tool_list;	/* To be used by tools such as ctracer */
+	struct list_head btf_inline_sites;
 	struct ptr_table types_table;
 	struct ptr_table functions_table;
 	struct ptr_table tags_table;
-- 
2.43.5

