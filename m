Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C249150EBFC;
	Fri,  2 Oct 2026 17:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790962899; cv=none; b=mfFDhYrWM72BYWSv8ze5rP/CfxnNgS54v8p1HS9BIeFS0aHJux5T5VzgSbx1xKqMaRlPb6O0Ll8TWpuGxdCrSClJNtdrWP+3zJcpP01uFW/m7ciVx0wZ6/0XMl3PXpYm04l0+0fYubi+I3dkxJKdXG2vo/IndO/6V8VT5di8jik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790962899; c=relaxed/simple;
	bh=I3366xUS5g5aM+dYhIzXHiZtgxZFK6/WDDY/KCcV2Y8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Amlsgb0ac1aSz+x/fl2oKox7vuFtGfiU0Vh6RBuW5bgsBjgjKTyoK3l/cDiwa6rp3L92aVKoPuSZaKCosCRs9Jszi71umyDXW5hfPPhKVv6MULb7TNszCi+dmWifuiaV+mE7lGSe/6imJwbysmQ51cKLyIb7rXtUcHtQUCdho1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DAyz3gvJ; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DAyz3gvJ"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 692EcSZW3205604;
	Fri, 2 Oct 2026 17:40:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=mAHD/Yg7irXXTtXgdozGMe2zFUF2rKk4nNUaE770mBM=; b=
	DAyz3gvJ1MbFrnacbsZ6EQYxSm/qZis98hhviI5RqDgM2+4AcUZnXmSwG0Gig7Q/
	NuTwEZOxUQ6AhoXNPM2JLTjs8qAFG8LMl3oDYTZU+6UQmooil7Z+FqReLMGI5STR
	rgNh5E0tCh5Fg6PHGO8W49FuROA1zQR2/umHQm4WETj16lIt2tHKV4qCDroeO1RQ
	NGkmg5ywspYP5Y/CZHuKtvfqXVaJzT9kOV9LMDR5eNEECV0B6CeTWdH7mgABvP59
	Un+V/XY8xX5NBTU8Ve8Vs3jcZ86J/wujL5gwKU+sRQHT2Ofs2LaDPhy70crA7Lj7
	qI8JSFKKaRe8TFzQuqE3ag==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx4fbmatb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Oct 2026 17:40:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 692HZT4P014459;
	Fri, 2 Oct 2026 17:40:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gtqtms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Oct 2026 17:40:50 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 692HekeP030471;
	Fri, 2 Oct 2026 17:40:49 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-83-232.vpn.oracle.com [10.154.83.232])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4gx4gtqtes-2;
	Fri, 02 Oct 2026 17:40:49 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org, ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com,
        jolsa@kernel.org, qmo@kernel.org
Cc: dwarves@vger.kernel.org, daniel@iogearbox.net, ihor.solodrai@linux.dev,
        yonghong.song@linux.dev, song@kernel.org, martin.lau@linux.dev,
        memxor@gmail.com, emil@etsalapatis.com, bpf@vger.kernel.org,
        nsc@kernel.org, puranjay@kernel.org, yatsenko@meta.com,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v5 dwarves 01/10] dwarf_loader: Add parameter list to inline expansions
Date: Fri,  2 Oct 2026 18:40:29 +0100
Message-ID: <20261002174043.3823987-2-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20261002174043.3823987-1-alan.maguire@oracle.com>
References: <20261002174043.3823987-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_05,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 suspectscore=0 mlxscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2609040000 definitions=main-2610020070
X-Proofpoint-ORIG-GUID: 6wqNnl_t0yf7knYi8GL9WwPWt6h6vqHQ
X-Proofpoint-GUID: 6wqNnl_t0yf7knYi8GL9WwPWt6h6vqHQ
X-Authority-Analysis: v=2.4 cv=eJCGH3p1 c=1 sm=1 tr=0 ts=6abfeca2 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x4eqshVgHu-cdnggieHk:22 a=VabnemYjAAAA:8
 a=yPCof4ZbAAAA:8 a=2a_4i9DPlpY3F9QRGEMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=gKebqoRLp9LExxC7YDUY:22 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13537
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA3MCBTYWx0ZWRfXw/5nl6g7v4vu
 ScO06TvI1yl0iz5S4hQL6F0Nkd7NAWy9llYm68aUo/Y7fJApGTsGmiPumOqrDHLrNXgIzG8O1Ts
 vKTusE2jnTv7wZ47Saq86ae72K16/SEG0fg1EYRHxPGeJJltzoyH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA3MCBTYWx0ZWRfX2C3BqdGh5vzi
 y8SlQjryc1v6RD38HgTvGAQDdqA+KPnQf1kKHmtSgMKTPWEbiw0Mw2zXo/fQHL08f9BmLrW0D01
 74nuGivBX3OWf/a39Uu3aD0JiWaqX0BaO4rGg9gJr47BWV9DgsB3R1Xr8oA0SVnZCSqNytrYjW0
 edYcFyyL4zu7Gmm4/iy5aQsZdjYNMci/Qc4ssep23wMK86xjisXz3hG1tUBRPG4wqoQBkH+R1aW
 Bj3bt6nieyBMYEsnisPbKHBomi3LA6K4SzC6yDlodf9QHC1OaF4KgUycOZiOBU/pBe5vArKdQVF
 IpkEy32n5xDp4D9XxbGc+2hZFZ3mNOLiomUafd7YKCocUJ8ZCnRGUARjsVB7vpybeWuAskaGHPo
 7B4eBPUPuDrD6Y91sy2Ufccavior7kDSxFHVQI7N++biqnxBcrgrYlDrlLsXmMxqaQo8HHG3MGp
 cvXmVdCati15eHc81iLG+BhIbDUEk5JSYNw/UnwM=

DW_TAG_formal_parameter children of DW_TAG_inlined_subroutine are
currently skipped, so callers cannot iterate parameters belonging to a
specific inline expansion.

Store these parameters on struct inline_expansion rather than in the
surrounding lexical block. Initialize and populate the list while
processing inline-subroutine children, include it in tag traversal, and
release it with its parent inline expansion.

Parameter type and location recoding is kept separate, to follow in a
subsequent change.

Signed-off-by: Thierry Treyer <ttreyer@meta.com>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 dwarf_loader.c | 32 +++++++++++++++++++-------------
 dwarves.c      | 34 ++++++++++++++++++++++++++++++++++
 dwarves.h      |  6 ++++++
 3 files changed, 59 insertions(+), 13 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 1e5363a..c08d2ab 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -2022,6 +2022,8 @@ static struct inline_expansion *inline_expansion__new(Dwarf_Die *die, struct cu
 		dwarf_tag__set_attr_type(dtag, DWARF_TAG__REF_TYPE, die, DW_AT_abstract_origin, cu);
 		exp->ip.addr = 0;
 		exp->high_pc = 0;
+		exp->nr_parms = 0;
+		INIT_LIST_HEAD(&exp->parms);
 
 		if (!cu->has_addr_info)
 			goto out;
@@ -2559,6 +2561,7 @@ static struct tag *die__create_new_string_type(Dwarf_Die *die, struct cu *cu)
 static struct tag *die__create_new_parameter(Dwarf_Die *die,
 					     struct ftype *ftype,
 					     struct lexblock *lexblock,
+					     struct inline_expansion *exp,
 					     struct cu *cu, struct conf_load *conf,
 					     int param_idx)
 {
@@ -2575,7 +2578,7 @@ static struct tag *die__create_new_parameter(Dwarf_Die *die,
 			if (add_gnu_annotation_chain(die, param_idx, conf, &(tag__function(&ftype->tag)->annots)))
 				return NULL;
 		}
-	} else {
+	} else if (exp == NULL) {
 		/*
 		 * DW_TAG_formal_parameters on a non DW_TAG_subprogram nor
 		 * DW_TAG_subroutine_type tag happens sometimes, likely due to
@@ -2656,7 +2659,7 @@ static struct tag *die__create_new_subroutine_type(Dwarf_Die *die,
 			tag__print_not_supported(die);
 			continue;
 		case DW_TAG_formal_parameter:
-			tag = die__create_new_parameter(die, ftype, NULL, cu, conf, -1);
+			tag = die__create_new_parameter(die, ftype, NULL, NULL, cu, conf, -1);
 			break;
 		case DW_TAG_unspecified_parameters:
 			ftype->unspec_parms = 1;
@@ -2946,10 +2949,14 @@ static struct tag *die__create_new_inline_expansion(Dwarf_Die *die,
 						    struct lexblock *lexblock,
 						    struct cu *cu, struct conf_load *conf);
 
-static int die__process_inline_expansion(Dwarf_Die *die, struct lexblock *lexblock, struct cu *cu, struct conf_load *conf)
+static int die__process_inline_expansion(Dwarf_Die *die,
+					 struct inline_expansion *exp,
+					 struct lexblock *lexblock,
+					 struct cu *cu, struct conf_load *conf)
 {
 	Dwarf_Die child;
 	struct tag *tag;
+	int parm_idx = 0;
 
 	if (!dwarf_haschildren(die) || dwarf_child(die, &child) != 0)
 		return 0;
@@ -2975,13 +2982,9 @@ static int die__process_inline_expansion(Dwarf_Die *die, struct lexblock *lexblo
 				goto out_enomem;
 			continue;
 		case DW_TAG_formal_parameter:
-			/*
-			 * Inline expansions can have their own formal
-			 * parameter children duplicating the abstract
-			 * origin's parameters.  These are not needed
-			 * for type reconstruction — skip them.
-			 */
-			continue;
+			tag = die__create_new_parameter(die, NULL, lexblock, exp,
+							cu, conf, parm_idx++);
+			break;
 		case DW_TAG_inlined_subroutine:
 			tag = die__create_new_inline_expansion(die, lexblock, cu, conf);
 			break;
@@ -3010,6 +3013,8 @@ static int die__process_inline_expansion(Dwarf_Die *die, struct lexblock *lexblo
 
 		if (cu__table_add_tag(cu, tag, &id) < 0)
 			goto out_delete_tag;
+		if (tag->tag == DW_TAG_formal_parameter)
+			inline_expansion__add_parameter(exp, tag__parameter(tag));
 hash:
 		cu__hash(cu, tag);
 		struct dwarf_tag *dtag = tag__dwarf(tag);
@@ -3032,8 +3037,8 @@ static struct tag *die__create_new_inline_expansion(Dwarf_Die *die,
 	if (exp == NULL)
 		return NULL;
 
-	if (die__process_inline_expansion(die, lexblock, cu, conf) != 0) {
-		tag__free(&exp->ip.tag, cu);
+	if (die__process_inline_expansion(die, exp, lexblock, cu, conf) != 0) {
+		tag__delete(&exp->ip.tag, cu);
 		return NULL;
 	}
 
@@ -3115,7 +3120,8 @@ static int die__process_function(Dwarf_Die *die, struct ftype *ftype,
 			continue;
 		}
 		case DW_TAG_formal_parameter:
-			tag = die__create_new_parameter(die, ftype, lexblock, cu, conf, param_idx++);
+			tag = die__create_new_parameter(die, ftype, lexblock, NULL,
+							cu, conf, param_idx++);
 			break;
 		case DW_TAG_variable:
 			tag = die__create_new_variable(die, cu, conf, 0);
diff --git a/dwarves.c b/dwarves.c
index 2164030..2bb5c18 100644
--- a/dwarves.c
+++ b/dwarves.c
@@ -203,6 +203,27 @@ void formal_parameter_pack__delete(struct formal_parameter_pack *pack, struct cu
 	cu__tag_free(cu, &pack->tag);
 }
 
+static void inline_expansion__delete_tags(struct inline_expansion *exp,
+					  struct cu *cu)
+{
+	struct tag *pos, *n;
+
+	list_for_each_entry_safe_reverse(pos, n, &exp->parms, node) {
+		list_del_init(&pos->node);
+		tag__delete(pos, cu);
+	}
+}
+
+static void inline_expansion__delete(struct inline_expansion *exp,
+				     struct cu *cu)
+{
+	if (exp == NULL)
+		return;
+
+	inline_expansion__delete_tags(exp, cu);
+	cu__tag_free(cu, &exp->ip.tag);
+}
+
 void tag__delete(struct tag *tag, struct cu *cu)
 {
 	if (tag == NULL)
@@ -225,6 +246,8 @@ void tag__delete(struct tag *tag, struct cu *cu)
 		ftype__delete(tag__ftype(tag), cu);		break;
 	case DW_TAG_subprogram:
 		function__delete(tag__function(tag), cu); break;
+	case DW_TAG_inlined_subroutine:
+		inline_expansion__delete(tag__inline_expansion(tag), cu); break;
 	case DW_TAG_lexical_block:
 		lexblock__delete(tag__lexblock(tag), cu); break;
 	case DW_TAG_GNU_template_parameter_pack:
@@ -1476,6 +1499,13 @@ void lexblock__add_tag(struct lexblock *block, struct tag *tag)
 	list_add_tail(&tag->node, &block->tags);
 }
 
+void inline_expansion__add_parameter(struct inline_expansion *exp,
+				     struct parameter *parm)
+{
+	++exp->nr_parms;
+	list_add_tail(&parm->tag.node, &exp->parms);
+}
+
 void lexblock__add_inline_expansion(struct lexblock *block,
 				    struct inline_expansion *exp)
 {
@@ -2059,6 +2089,10 @@ static int list__for_all_tags(struct list_head *list, struct cu *cu,
 			if (list__for_all_tags(&tag__lexblock(pos)->tags,
 					       cu, iterator, cookie))
 				return 1;
+		} else if (pos->tag == DW_TAG_inlined_subroutine) {
+			if (list__for_all_tags(&tag__inline_expansion(pos)->parms,
+					       cu, iterator, cookie))
+				return 1;
 		}
 
 		if (iterator(pos, cu, cookie))
diff --git a/dwarves.h b/dwarves.h
index f3453ed..f620db8 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -825,6 +825,8 @@ struct inline_expansion {
 	struct ip_tag	 ip;
 	size_t		 size;
 	uint64_t	 high_pc;
+	struct list_head parms;
+	uint16_t	 nr_parms;
 };
 
 static inline struct inline_expansion *
@@ -833,6 +835,10 @@ static inline struct inline_expansion *
 	return (struct inline_expansion *)tag;
 }
 
+struct parameter;
+void inline_expansion__add_parameter(struct inline_expansion *exp,
+				     struct parameter *parm);
+
 struct label {
 	struct ip_tag	 ip;
 	const char	 *name;
-- 
2.43.5

