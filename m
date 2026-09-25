Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52983B47D2;
	Fri, 25 Sep 2026 18:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790362379; cv=none; b=my25MBY9McGvbef5JkwLxrrRD8mSJ2aJKtw7tY/6lQ6lM12rL6i0k9T2Tfq2pZbIogt7CzB1Ul6drvfqceoa8Xyb6MlQHGez6HO0MW1vFWV6GqQeMWlQQOwIqR8jXcSGGvCDc0a+fx+KbXloeZwBcA3mvcQZ8OnAXhVP/IzPgtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790362379; c=relaxed/simple;
	bh=dwePL0AqC7a5615Fbwgu4wiQ+Y21SDUtYhFlQ8AIgZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bSiFkIAv3U7by1ZmLey1SJp9PziR0GLeJCaTR15bFalDQFGoWYnH7ij6APJVpaB2iEuoxWKWaczIC27xxigDR7oVNnj7xbuoBco4NpntvoBI53omRVEDRC7PRq3hckLSg12C0c36hxfKx+HZy1ujYxzVSpkBHLnH+NkxINz9fmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DH4CepmC; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DH4CepmC"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68PECBD23838108;
	Fri, 25 Sep 2026 18:52:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=8L29X
	I5wKaBrL6Y5Ma6K5iEpLkP1C2mZmu/fsjXYxKk=; b=DH4CepmC4GqkgipouoqAJ
	+3gRV1QUq8RTur5r73zGZReLWCaDiL5tD8f/5kypAhPOWDAhR7/LZUyFk4RTdLmy
	k4g4BemOOi19iK15uGzfY3rIffMJ4sds+w0f/pK37dv8A0cvUvPPMwseC5AuU9P0
	eMJ0o9BGFq7hjqiV1Mmv0GXqu7NQChdY6YzHsPq4BjM/ZEM5WpkdnqomMrulqLFN
	EQJDXUrGnbK4NnGpQzbpyFE+55QZhYBKnFUYVxmImbtTmBaoACC7hcEwKEMH86d7
	bmRJ6falWHWpaszexfvlzolmYOycpmqqvIXdUdKO1yXUYKB/XuPIoW0ndlg2M8mE
	g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gsk1qhwyb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 18:52:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 68PIqEHs038673;
	Fri, 25 Sep 2026 18:52:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gtepthta1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 18:52:34 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 68PIqQoi040536;
	Fri, 25 Sep 2026 18:52:33 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-81-122.vpn.oracle.com [10.154.81.122])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4gtepthsyc-3;
	Fri, 25 Sep 2026 18:52:33 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org, ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com,
        qmo@kernel.org
Cc: dwarves@vger.kernel.org, jolsa@kernel.org, daniel@iogearbox.net,
        ihor.solodrai@linux.dev, yonghong.song@linux.dev, song@kernel.org,
        martin.lau@linux.dev, memxor@gmail.com, emil@etsalapatis.com,
        bpf@vger.kernel.org, nsc@kernel.org, puranjay@kernel.org,
        yatsenko@meta.com, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 dwarves 2/9] dwarf_loader: Resolve inline expansion names during recoding
Date: Fri, 25 Sep 2026 19:51:51 +0100
Message-ID: <20260925185200.1318067-3-alan.maguire@oracle.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA3NSBTYWx0ZWRfXywBKLRVCCMUi
 g2KjlwDgJgJ7WMKIZZq9bpDBPxwjFfDRdg60lbsziSods33RRFUes2s7SOPOU1E+iskw+gxMy6i
 bC5LnGiTzaND2vn8KQrY0QO3yq/AaGhB7lhQql1HGxdoDDoDSUEH
X-Proofpoint-ORIG-GUID: 9ZKrHBwRu-sv0P6qp0Q9Pz2oNaWXsy9p
X-Proofpoint-GUID: 9ZKrHBwRu-sv0P6qp0Q9Pz2oNaWXsy9p
X-Authority-Analysis: v=2.4 cv=LIzz05W9 c=1 sm=1 tr=0 ts=6ab6c2f3 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=VabnemYjAAAA:8 a=yPCof4ZbAAAA:8
 a=8NPk0I0YJxjnKrMsTPwA:9 a=O8hF6Hzn-FEA:10 a=gKebqoRLp9LExxC7YDUY:22
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13532
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA3NSBTYWx0ZWRfX59Dq0meiKNzM
 dbM1QJiccoYaON9Fw00ZWe6tCSZCjuBEa3Fz+vUt9bkdzt6CL+CFtsrjX0k8jGiq7o12OuF3mxJ
 i4ErLOEuMh/7v6cdM89Vo/7EKU4tKrro1Sy6Ct27haKvsHFWj8a/s2R4Tqe2Sa1v6stCbkR+vYt
 6BZUKvvEEHPs/WXbBykS3gu+5AnrROUnLrw8GRgqgCfy3/RdXHUaCjIbnDMf5lA6i30ft7Vq8Yj
 yd6TiQ57Jajvke8fs/McjtS/9kdUARtJhL4m+YzuVYpQYJ2VEw59Iidl+SERh173PBpGS94uLi6
 nrfoN6kO2BS07bjOobEXWa9mfpsKCi99ZPXvULjlYbLIDA2YHrbL3JvAH8BSTyHd4OcUFjZSNSA
 nu5Q+zimomSR6uh84t4aqiEuAfmnN/hge+szcWLrJvlbcB04mT8AKGd3o2ncgE87mVHXbWihvvk
 yuGRNXZA1oXppQ9cvq1ofCrCDczaVopkyMfH8e0Y=

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
 dwarf_loader.c | 57 +++++++++++++++++++++++++++++++++++++-------------
 dwarves.h      |  1 +
 2 files changed, 43 insertions(+), 15 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 2165621..13c6464 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -2015,11 +2015,19 @@ static struct inline_expansion *inline_expansion__new(Dwarf_Die *die, struct cu
 
 	if (exp != NULL) {
 		struct dwarf_tag *dtag = tag__dwarf(&exp->ip.tag);
+		Dwarf_Attribute attr_orig;
 
 		tag__init(&exp->ip.tag, cu, die);
 		dtag->decl_file = attr_string(die, DW_AT_call_file, conf);
 		dtag->decl_line = attr_numeric(die, DW_AT_call_line);
 		dwarf_tag__set_attr_type(dtag, DWARF_TAG__REF_TYPE, die, DW_AT_abstract_origin, cu);
+		if (dwarf_attr(die, DW_AT_abstract_origin, &attr_orig)) {
+			Dwarf_Die die_orig;
+
+			if (dwarf_formref_die(&attr_orig, &die_orig))
+				exp->name = attr_string(&die_orig, DW_AT_name, conf);
+		}
+
 		exp->ip.addr = 0;
 		exp->high_pc = 0;
 		exp->nr_parms = 0;
@@ -3571,6 +3579,32 @@ static void __tag__print_abstract_origin_not_found(struct tag *tag,
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
+			"%s: couldn't find name for function %#llx, abstract_origin=%#llx, specification=%#llx\n",
+			__func__,
+			(unsigned long long)dtag->id,
+			(unsigned long long)dtag->abstract_origin,
+			(unsigned long long)dtag->specification);
+	}
+}
+
 static void parameter__share_state_with_abstract_origin(struct parameter *parm,
 							struct parameter *oparm)
 {
@@ -3654,6 +3688,7 @@ static void inline_expansion__recode_dwarf_types(struct tag *tag, struct cu *cu)
 	struct dwarf_cu *dcu = cu->priv;
 	struct dwarf_tag *dtag = tag__dwarf(tag);
 	struct dwarf_tag *dtype;
+	struct tag *origin;
 	struct tag *pos;
 
 	/* The inline expansion's abstract origin is stored as its type ref. */
@@ -3664,7 +3699,12 @@ static void inline_expansion__recode_dwarf_types(struct tag *tag, struct cu *cu)
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
@@ -4056,20 +4096,7 @@ static int tag__recode_dwarf_type(struct tag *tag, struct cu *cu)
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
index f620db8..ddd4fd5 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -823,6 +823,7 @@ struct ip_tag {
 
 struct inline_expansion {
 	struct ip_tag	 ip;
+	const char	 *name;
 	size_t		 size;
 	uint64_t	 high_pc;
 	struct list_head parms;
-- 
2.43.5

