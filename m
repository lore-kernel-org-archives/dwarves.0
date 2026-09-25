Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB79E43F4B4;
	Fri, 25 Sep 2026 18:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790362391; cv=none; b=jDH1Q7B/owBuePq23ry+VzXDSXmlxKFyIeOr1dbCaYKNdevuZ8VpHD89xB1igsufiO+6jlK8rpLnTKFEuvc5+cNEm6Nxp+O8ZwUZu3Vv9D/Wx+lcsSgdyecU/gJZAZv5OPzQQGa72+70m6rpSNbvXhPB84uSNFZFcp8TP9c/5fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790362391; c=relaxed/simple;
	bh=xVqt/rSU7GHiQjKEovU8o6c6mSOoAfa9lj7sduzQK0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R4EsjByIWQBidlYGhZXCMQKp5aJt0bhXRfXx3gkmOIV25J5Knjm+Wh8UHDzb5Cgh/QCL3+jvcHaMuacKs02DMM0R53zEJXsvHH/VwF6GpmmlhexPscGqJqoFSHLLTxt1jffVSe4ABhCpHSGZZCByGwlYb+opS0uH9K4qkdyuXKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=f/v1OrUs; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="f/v1OrUs"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68PEC6WS1328725;
	Fri, 25 Sep 2026 18:52:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=YLdeL
	C7SGZFz3Pkgph5usikI5apZG0RSfsoILi8oqR4=; b=f/v1OrUsBYjKpgrkH3nxL
	NygxeQCbrdyVqlbHFDKuwUdanXdXIPj9tz60S+8i1Q8eISfMmwGDFIFEoTc2HaT5
	baHXiudIrms0rSEUEezLNQ5ox8Hwu7JredtIZMAWXccDoPnxTJ9jEOJ3QmNIjgxb
	ACNxzDn2NK8EDpJRczs0wJjg+2Whh3T9+kFbdNacJOBP/OIbP33l2eXYh3hzue2z
	Gvuba3L8UXY/XkSK8ZWkMeRPDtFxVMryFWPMoCE78VDdCn0ETEoQ3AF4u0rEPYgi
	axcnaYHD6liTDYMzs/OtKeA3f7D5bQjGbxYoxvlYFwaQKZOicoJDbsSgdrU6SVrC
	g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gsjxb9xqj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 18:52:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 68PIqFlg038761;
	Fri, 25 Sep 2026 18:52:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gtepthtdu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 18:52:45 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 68PIqQoq040536;
	Fri, 25 Sep 2026 18:52:45 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-81-122.vpn.oracle.com [10.154.81.122])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4gtepthsyc-7;
	Fri, 25 Sep 2026 18:52:44 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org, ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com,
        qmo@kernel.org
Cc: dwarves@vger.kernel.org, jolsa@kernel.org, daniel@iogearbox.net,
        ihor.solodrai@linux.dev, yonghong.song@linux.dev, song@kernel.org,
        martin.lau@linux.dev, memxor@gmail.com, emil@etsalapatis.com,
        bpf@vger.kernel.org, nsc@kernel.org, puranjay@kernel.org,
        yatsenko@meta.com, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 dwarves 6/9] btf_loader: Record inline sites in CU for BTF
Date: Fri, 25 Sep 2026 19:51:55 +0100
Message-ID: <20260925185200.1318067-7-alan.maguire@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA3NSBTYWx0ZWRfX/7ZcUKUnCyPu
 s2hVwRsT67Rz2xYAaLDT55oYUgEaI2IKFruJd4y9xt5/luangVUAqcUU7hUg0qMLfGVarEAxH/z
 AcjYbvaA+SsuKWAYj6JQMdwAACK1Xy1pEoKrL0hcC94E1f+hi/2tBvkWqF/2e5LG8V9QrP2v6vc
 WQnQdMidnwYgDkUNTPJRM8wij6ga94WOsB+QaECT1b5yy55PwGrHXkxdPzfEafWyHafq7grplk0
 8dEP2AvnFfXVOliLPSvsmHLIEbDUmOJfrCwLvODumNLQ+7syqMarjuBI4hXSxLGJDlKMZo1TPH8
 nTRr5eUY4kv4jDUfa81Ig7YVrice5NWIxIaTJ53I0M9zaF4D+Dlh2cs7sYUM/WhXpgmrxsJVCeG
 MJIUrxPJSkzDgURhzsVSap1tCYpli6mKsyGfI8dn+ONCFsCZUeyZPhDF2eZJiwjpaT3jmQ6Z0Oc
 aVnyxT/IxqNboZs477XkGZ6s2+32MAr5WRT3QLlA=
X-Proofpoint-ORIG-GUID: jGOdVkOZpvNZpH776L33KTSQgm5HQ8Jn
X-Authority-Analysis: v=2.4 cv=UINIjyfy c=1 sm=1 tr=0 ts=6ab6c2ff b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=yPCof4ZbAAAA:8 a=zBj7asqCIPECPjkPQzcA:9
 a=O8hF6Hzn-FEA:10 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf
 awl=host:13532
X-Proofpoint-GUID: jGOdVkOZpvNZpH776L33KTSQgm5HQ8Jn
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA3NSBTYWx0ZWRfX1uC/8sFgpt/l
 HaWvl6ZSIszM9Rzfh9fbGDQOlGwNLTi8DmdLtAQ5J0uqUMbw4WYU5AqnltW+voRyssORD696/pH
 MFxoljVpu28U8An0X4N35rRgld8ypDMgfir4kjxpzpZn+7OuLM+t

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

