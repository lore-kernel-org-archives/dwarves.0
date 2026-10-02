Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC574BB282;
	Fri,  2 Oct 2026 17:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790962899; cv=none; b=Id0uqoTRoil7cWm5ZI8Z6XH3y+m5rdve3RfGcYDnnx5rGo3NyeUNZ1AoNV2RygX/LkjNGARGZHeEOyA3GVbZg2fxX/hP4WiFY1eOX/n14j2kDvx/vEYjftLfpWOG5+Vu3HUugvAHoMAz2FvvjyBDjOlJLFLZJQ+bNerXRNeStZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790962899; c=relaxed/simple;
	bh=OScoHv97GBoLB4xxSovY93Q542O4xSpeFsVQK4Z6FNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lYXkesknjV8XDhEeSKi6g3Aj+u+1VlsFxYzADQV86K7ZNwceLHRreI6npQfkW4AM/jUcVF4NbrVVcaNgB5Xxcmmp0x8O0Lxj9+SWh/DcD36kMmblmDfvc9X+UF1hUbb/nRKMJdHpjqOxSYCjyj7Xz1ekC+Ff+2zYte6+i6mCxe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mWr4vgyf; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mWr4vgyf"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 692Ebf0B3287852;
	Fri, 2 Oct 2026 17:40:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=Monae
	kfXG6OR4ME5IKM8eRAWr334sz1+3DvvkmerkYY=; b=mWr4vgyffK+FKwbdEWHXh
	3XXEHlQ5S9hhucHBb7YHJy1rDCp/AD/XluZM+rX5qNc4Dg6KBfzFJdZpV1z86qgv
	FHXl4XrqKVf/cM+4oQRV1BYWad1mf1PgYxL3YMBzNnsp5823uK32s9TdIWHxAwQ5
	GW5vG68kPh8DtJJGTLLAl+5JNRr3QAxlb8UWPui2f3NakS6odd+qhrKhrLDhoojG
	MNjwMwwhLRmhPGMEP2+Li/6rkY1YfFKUB6yQ64L+MVq3xaBY2lTIxyv1Fdsy1oT5
	zn3TCpzAUw2D7YX/TYTt9cjaimMFgkrBB1dVW5N7w1nTr69rrWiOG5CjRoDnVFSC
	w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx5ns4bxd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Oct 2026 17:40:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 692HZUGu014582;
	Fri, 2 Oct 2026 17:40:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gtqtsq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Oct 2026 17:40:55 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 692HekeT030471;
	Fri, 2 Oct 2026 17:40:55 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-83-232.vpn.oracle.com [10.154.83.232])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4gx4gtqtes-4;
	Fri, 02 Oct 2026 17:40:54 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org, ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com,
        jolsa@kernel.org, qmo@kernel.org
Cc: dwarves@vger.kernel.org, daniel@iogearbox.net, ihor.solodrai@linux.dev,
        yonghong.song@linux.dev, song@kernel.org, martin.lau@linux.dev,
        memxor@gmail.com, emil@etsalapatis.com, bpf@vger.kernel.org,
        nsc@kernel.org, puranjay@kernel.org, yatsenko@meta.com,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v5 dwarves 03/10] dwarf_loader: Resolve inline expansion names during recoding
Date: Fri,  2 Oct 2026 18:40:31 +0100
Message-ID: <20261002174043.3823987-4-alan.maguire@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA3MCBTYWx0ZWRfX8D85ftJg8UGS
 QJo9rRhKRcn4cdEYhq/4Ul3OGeY+d8G0hsFLI6WQ+1GW8EPkg4RDpqiYjIx4i2UoMt9RJYb9evX
 i1ZMhIn6o9aC4m9K39L0kiTSxjsTT2X+7tAjCtZ0pLiROt/GafRYMhkpYDMH+3qACDUgI0wU/G0
 OOGRB7WXIEZg8XFu9fKvq6B0rBt4BDLaTN6LMQml8S2yAW3qdCHMYPT23LOjiu5f6c7o3nOHBPH
 ivLf/gOIbGkTDSTGroOZdymyBtFv9GLrWINcgEmslNWtS2tK/zThSw7PV9kw/kaFX7EG85xcRW5
 fx3/ZVdt8nqWIBWS/JEHtPBvfTFCTtPUgqUFB73ZLxfxKwbIX2AcxDX/fikMF7tZQZ/lzn5rmaK
 wUt65cvll150DulT5n0HONjoWqZ0ugGLxcSNTzi0xpGMBrsTry4D3KN/elx8R8VeIjtqs/OcG6d
 euGlW5XXnllQkI1SnOy2OU2azvvgbC0XPInRD7K0=
X-Proofpoint-GUID: cz0_hgf5sGAUJSP-qR8yvkY6-chM5s50
X-Authority-Analysis: v=2.4 cv=T8QZ3PKQ c=1 sm=1 tr=0 ts=6abfeca8 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=VabnemYjAAAA:8 a=yPCof4ZbAAAA:8
 a=8NPk0I0YJxjnKrMsTPwA:9 a=O8hF6Hzn-FEA:10 a=gKebqoRLp9LExxC7YDUY:22
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13537
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA3MCBTYWx0ZWRfX6p41Df3/dxte
 EXNWl8Ukn6gcbztxSuoFqSEqCU0kiAJPZMjiQP+0oVs947KAUxeDJ3RZxblfU6QFm7V6p/ykfm1
 96Sczhv8efAQZYcUtimY7bJHS89xUSBOqXgMkd+fXR6DUFrdAijf
X-Proofpoint-ORIG-GUID: cz0_hgf5sGAUJSP-qR8yvkY6-chM5s50

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
index 0e74d2b..6883cf0 100644
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
@@ -3568,6 +3576,32 @@ static void __tag__print_abstract_origin_not_found(struct tag *tag,
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
@@ -3655,6 +3689,7 @@ static void inline_expansion__recode_dwarf_types(struct tag *tag, struct cu *cu)
 	struct dwarf_cu *dcu = cu->priv;
 	struct dwarf_tag *dtag = tag__dwarf(tag);
 	struct dwarf_tag *dtype;
+	struct tag *origin;
 	struct tag *pos;
 
 	/* The inline expansion's abstract origin is stored as its type ref. */
@@ -3665,7 +3700,12 @@ static void inline_expansion__recode_dwarf_types(struct tag *tag, struct cu *cu)
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
@@ -4057,20 +4097,7 @@ static int tag__recode_dwarf_type(struct tag *tag, struct cu *cu)
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

