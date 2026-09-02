Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407B5476045;
	Wed,  2 Sep 2026 11:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788349149; cv=none; b=f6CVe7fT/ZqqCGpKKaCcnnI+sUTe9LxEcSjPjurG/El4JU9/liWvmXzAm80zpoZbph+vSmeRkCapidlDg0wWZRt5Nu6liFbknLJD8lgsWaIpR75grIy6TmcjNuEFiDJCe246LSwWVtEE/oOKEXA5m6QEv/+HNUlMKT0boE54TbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788349149; c=relaxed/simple;
	bh=8Sox4q7Mnn+b3GAOFJeDtGRiiyDTvo2M+v8Clq/IOdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NmcsNXfoAk8FHkvi0RvvGdZqcwRyy5nXN3J8zyYUyKO71QTNqQfKvs8eNgyUFxpW2orhec7djjMGrNdOjm4MNNJyb62Wu5L4WEsYRL+dhgrpgAUdDJiy+CCIjxDdG/uwOpKCFKJolRapSHzd+Jec05PFMRBS7CYKo9nqxFLZG3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Qsp1AsIc; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Qsp1AsIc"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681Kbbds396266;
	Wed, 2 Sep 2026 11:38:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=wEV3y
	wVxcqoLoza2+DDjsf3YFKZNTvV7WQLswLY4r8A=; b=Qsp1AsIcTWq5H4RInodW+
	feiy9d75Wd0bGd7FG2Q+BV/FSuEWe18uOYpFl7rxRAW3C1CxzuOtoqsCM8HOwm+H
	K2kds3whJPK2cQ3j0LQjkcDCNgMy9MN+XIvLGHiKSbzhaVBlDS77C70P3mSuuGT/
	4KauO9eHic+wZx1SZeZf4F5Gw+ZQSAXx1yiqYVSUxYVguIQrh22zG4CWUuvJpYDP
	ZP2e9ZWU8AQo6U9GpU65VGmCECMueyoDZs5bNKY/GByR0LpUFPhyBToECDnilz6M
	VK1PYzmY+y+Dno2Y7H1FgMJJa1SPLc73dV+pZPNnpO8wmSwwF254lEeuzi22GZpj
	w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gbpbaxpju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Sep 2026 11:38:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 682BaVNn029293;
	Wed, 2 Sep 2026 11:38:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gbnvrnt5w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Sep 2026 11:38:39 +0000 (GMT)
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 682BcYmc038508;
	Wed, 2 Sep 2026 11:38:38 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-52-253.vpn.oracle.com [10.154.52.253])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4gbnvrnt37-3;
	Wed, 02 Sep 2026 11:38:38 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org, ast@kernel.org, andrii@kernel.org
Cc: daniel@iogearbox.net, eddyz87@gmail.com, jolsa@kernel.org,
        ihor.solodrai@linux.dev, yonghong.song@linux.dev, song@kernel.org,
        qmo@kernel.org, martin.lau@linux.dev, memxor@gmail.com,
        emil@etsalapatis.com, bpf@vger.kernel.org, dwarves@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 dwarves 2/6] dwarf_loader: Resolve inline expansion names during recoding
Date: Wed,  2 Sep 2026 12:38:22 +0100
Message-ID: <20260902113829.1285407-3-alan.maguire@oracle.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDEwMyBTYWx0ZWRfXztyjpEP4Rdpa
 zBm+UN0M1ACCRjnsjIC80oDtLFl/sRU44WkfLEDDEVYxi68T+5MW5n6NePsjiVLbP134q94ZPBq
 xWDnrC0hj7sAmHXUYJlUD/aA9YLd/P4NVWddRQoEv8H4yHDrlENU
X-Proofpoint-ORIG-GUID: DgkYJHemWLns54MUcfHeM1gn36Wffzd5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDEwMyBTYWx0ZWRfX9mw4sVUSZxl4
 4raQ7+x0iTTHveGX6byDZcuEMRPjfWxV5Q294UNu5gWBuHAEbN5elnze1Z2kejs8flGh3GgZegT
 QoAjbdb+kkj3TgKpkNel5Jo5KI7z3f4S2NyGLp9luwwU548o4ZjzxuIuzYinc9dpoe9PyJ8Gil1
 l9pGRlcAMHa0E3iTkOMy2bvxN25hfjShQOSEekuOFlWkld2HXOaA9jEs7jp4NpDzrAbuQsC4WTf
 NP0vUcZDYFQ2QlaPHOrlBzBe1/XGKo8B1SIZt5mD2zEhrA7gsHJi5IUa+KDAht1cyT5cys2INNW
 tM4zVoZZLrNILyFU2r9BcHjZVMmrrSuS5OwoQ3H0cSM4DsJrfF4OxagR3XJpeR4OhMpAgsoNRdU
 FvDtZZYXWYgHp2xwPcD0rJNGLOmMR7/WFtVf4A7b4QVSNspa55cILegz6a8JKS2+BUSiNAQo3JG
 2JZTtHvw40nPPcoyf5jA+QDtO0bYqHhKmaIwaZXs=
X-Authority-Analysis: v=2.4 cv=DMi/JSNb c=1 sm=1 tr=0 ts=6a980ac0 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=VabnemYjAAAA:8 a=yPCof4ZbAAAA:8
 a=8NPk0I0YJxjnKrMsTPwA:9 a=O8hF6Hzn-FEA:10 a=gKebqoRLp9LExxC7YDUY:22
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12102
X-Proofpoint-GUID: DgkYJHemWLns54MUcfHeM1gn36Wffzd5

Add a name field to inline expansions and populate it from the resolved
origin function while recoding DWARF tags.

The origin DIE may not carry a direct DW_AT_name; normal function
recoding already handles names recovered through DW_AT_specification or
DW_AT_abstract_origin. Factor that lookup into a helper and use it for
inline expansions too, so expansion names stay consistent with the
resolved function name instead of remaining NULL in those cases.

Signed-off-by: Thierry Treyer <ttreyer@meta.com>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 dwarf_loader.c | 58 +++++++++++++++++++++++++++++++++++++-------------
 dwarves.h      |  1 +
 2 files changed, 44 insertions(+), 15 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 6805305..8bc5f64 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -2003,6 +2003,14 @@ static struct inline_expansion *inline_expansion__new(Dwarf_Die *die, struct cu
 		dtag->decl_file = attr_string(die, DW_AT_call_file, conf);
 		dtag->decl_line = attr_numeric(die, DW_AT_call_line);
 		dwarf_tag__set_attr_type(dtag, DWARF_TAG__REF_TYPE, die, DW_AT_abstract_origin, cu);
+
+		Dwarf_Attribute attr_orig;
+		if (dwarf_attr(die, DW_AT_abstract_origin, &attr_orig)) {
+			Dwarf_Die die_orig;
+			if (dwarf_formref_die(&attr_orig, &die_orig))
+				exp->name = attr_string(&die_orig, DW_AT_name, conf);
+		}
+
 		exp->ip.addr = 0;
 		exp->high_pc = 0;
 		exp->nr_parms = 0;
@@ -3553,6 +3561,33 @@ static void __tag__print_abstract_origin_not_found(struct tag *tag,
 #define tag__print_abstract_origin_not_found(tag) \
 	__tag__print_abstract_origin_not_found(tag, __func__, __LINE__)
 
+static void function__recode_dwarf_name(struct tag *tag, struct cu *cu)
+{
+	struct function *fn = tag__function(tag);
+	struct dwarf_tag *dtag = tag__dwarf(tag);
+	struct dwarf_tag *dtype;
+
+	if (fn->name != 0)
+		return;
+	if (dtag->abstract_origin == 0 && dtag->specification == 0)
+		return;
+
+	dtype = dwarf_cu__find_tag_by_ref(cu->priv, dtag, abstract_origin);
+	if (dtype == NULL)
+		dtype = dwarf_cu__find_tag_by_ref(cu->priv, dtag, specification);
+	if (dtype != NULL)
+		fn->name = tag__function(dtag__tag(dtype))->name;
+	else {
+		fprintf(stderr,
+			"%s: couldn't find name for "
+			"function %#llx, abstract_origin=%#llx,"
+			" specification=%#llx\n", __func__,
+			(unsigned long long)dtag->id,
+			(unsigned long long)dtag->abstract_origin,
+			(unsigned long long)dtag->specification);
+	}
+}
+
 static void parameter__share_state_with_abstract_origin(struct parameter *parm,
 							struct parameter *oparm)
 {
@@ -3636,6 +3671,7 @@ static void inline_expansion__recode_dwarf_types(struct tag *tag, struct cu *cu)
 	struct dwarf_cu *dcu = cu->priv;
 	struct dwarf_tag *dtag = tag__dwarf(tag);
 	struct dwarf_tag *dtype;
+	struct tag *origin;
 	struct tag *pos;
 
 	/* The inline expansion's abstract origin is stored as its type ref. */
@@ -3646,7 +3682,12 @@ static void inline_expansion__recode_dwarf_types(struct tag *tag, struct cu *cu)
 		return;
 	}
 
-	ftype__recode_dwarf_types(dtag__tag(dtype), cu);
+	origin = dtag__tag(dtype);
+	if (tag__is_function(origin)) {
+		function__recode_dwarf_name(origin, cu);
+		tag__inline_expansion(tag)->name = function__name(tag__function(origin));
+	}
+	ftype__recode_dwarf_types(origin, cu);
 	list_for_each_entry(pos, &tag__inline_expansion(tag)->parms, node)
 		parameter__recode_dwarf_type(tag__parameter(pos), cu, NULL);
 	tag->type = dtype->small_id;
@@ -3990,20 +4031,7 @@ static int tag__recode_dwarf_type(struct tag *tag, struct cu *cu)
 				 */
 				return 0;
 			}
-			dtype = dwarf_cu__find_tag_by_ref(cu->priv, dtag, abstract_origin);
-			if (dtype == NULL)
-				dtype = dwarf_cu__find_tag_by_ref(cu->priv, dtag, specification);
-			if (dtype != NULL)
-				fn->name = tag__function(dtag__tag(dtype))->name;
-			else {
-				fprintf(stderr,
-					"%s: couldn't find name for "
-					"function %#llx, abstract_origin=%#llx,"
-					" specification=%#llx\n", __func__,
-					(unsigned long long)dtag->id,
-					(unsigned long long)dtag->abstract_origin,
-					(unsigned long long)dtag->specification);
-			}
+			function__recode_dwarf_name(tag, cu);
 		}
 		lexblock__recode_dwarf_types(&fn->lexblock, cu);
 	}
diff --git a/dwarves.h b/dwarves.h
index b25ec76..781f9a0 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -822,6 +822,7 @@ struct ip_tag {
 
 struct inline_expansion {
 	struct ip_tag	 ip;
+	const char	 *name;
 	size_t		 size;
 	uint64_t	 high_pc;
 	struct list_head parms;
-- 
2.43.5

