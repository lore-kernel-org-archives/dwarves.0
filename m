Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795381621;
	b=Ygf7fsz7qy3Fkp/8BXQ+7r4DvLyBMhWl+8duKkancOCk3Ut0HCO6qV9nNzVDZOv4X2UC
	 rjcf0rysMnt2yqWB6cgo/lHMvtm1c1Kv2/bm+9aQXe6/e4z6o44W3OASPa1fsDaCD8+v2
	 xXHCYh3QqxEKr8CCCrUIiQDszcqzbFTpEwuW2eFLXM+EXGUnlg/U0dHKkIYtSLf5Oih4q
	 5Li/l7/PbKeWDjLRPqu3TxdKPusxMXMmbSRdqy9YrdtAdiBIeu5E6WxkllrKBcFYeay76
	 bC5c656zaAvsAIWZ/QkguClEILuFpsSH2EhbKtF2U/APOqIMdAKw2UdEdI7Kpve/D9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795381621;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=AWSCdKMiTxnFdt6qynxMon0yHgRe4HTGIt0dVhiBkvM=;
	b=Wz9gxpd/b/C8P6GDj1Dk7X+tB3SaJPwqu+4TXu/iX5rGPq1j4dAC10GBxwu7ffeZ//wd
	 wgrpsk916pOt7PGJ9m3zvtEljeOuhBQ+CLdVH4DAZNtPMACbbg7nj7lvCRo+twNHhIl5o
	 +K3xh7huj6zIMgk6FojZA5aNeJvlHMX3b28q+mZvjfNYwBdNGZOIFyT1cwuEhA4cd+1Sv
	 2PP7eMvFrelJacqpey2axb+jBHpKE+gfOFcoug+FzmzNkBTIWhLwch5TM81YBuIPvXdpD
	 LoUWtZLt6v0DayCbPsH2AqlNjT1hnrDIIWgLKIKzhutN1LzJn903jyAatXOZjLdxh3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RYTQCH2p;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6F0606A31A;
	Sun, 22 Nov 2026 21:07:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA6F0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RYTQCH2p
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AMKYS3E1705378;
	Sun, 22 Nov 2026 21:06:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=AWSCdKMiTxnFdt6qy
	nxMon0yHgRe4HTGIt0dVhiBkvM=; b=RYTQCH2p7fJH/fLCs14hdiRVLAkjWhK+V
	WT3R/i6wKdMlXs/DkgYm3zPLj2rt7nWZOqjDkinsiNOrn8s2+9fCQWVw5sAHNS34
	Q/+TkoQ/h5xMOw2Pg1M+IGLjBj9X9JVYTIv9ET1PKmASyN0npFa92roUg3RyhTWA
	GWLADPCXvfXIw4fs0NWniuBDmuDh8Xa1tRJ81mqrHdhVqmH3iXaPF1c7NituS82f
	YSvzPBETOTAfLvrOEitLwYMF4DC43H3uvjqPnvE1PQN7suSU3oTgRmf96eQe970U
	5T8C8do4gD3hTEmKoFvP3loW3FSxwJ5Yqf0sLWL02/gL1eIhCguPA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34fa0c9x-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 22 Nov 2026 21:06:41 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AMKK2p93890151;
	Sun, 22 Nov 2026 21:06:41 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j3qufkwtf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 22 Nov 2026 21:06:41 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AML6eqR30409298
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 22 Nov 2026 21:06:40 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AFD6458052;
	Sun, 22 Nov 2026 21:06:40 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6AE3A58056;
	Sun, 22 Nov 2026 21:06:39 +0000 (GMT)
Received: from thinkpad-p1.fritz.box (unknown [9.111.52.78])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 22 Nov 2026 21:06:39 +0000 (GMT)
From: Maxim Khmelevskii <max@linux.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: dwarves@vger.kernel.org, linux-debuggers@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH dwarves v1 1/2] dwarf_loader: Support in-memory return values for s390
Date: Sun, 22 Nov 2026 22:06:19 +0100
Message-ID: <20261122210636.2896891-5-max@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261122210636.2896891-4-max@linux.ibm.com>
References: <20261122210636.2896891-4-max@linux.ibm.com>
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Post: <mailto:dwarves@vger.kernel.org>
List-Help: <mailto:dwarves+help@vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
List-Owner: <mailto:dwarves+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIyMDA4NCBTYWx0ZWRfX+txkYzbOicKE
 /FBZCc5X8K376vRj1yEoPjCL7sLNmxSMmSAbGnkzzhsE+S6TVd5bKd1Dz1GPcC0lC9tOcVXN6VQ
 xtRfQTk4sY+l7t16WKpw/pKy52O5Y8WqCbIXVQzjNAM1OP5kSkNE3TGIuUICdGWt16mGbzhlSRk
 7oTcs8+h3mHkbvXQxhRTGzs2yxQP3TDoSoPDTz2XnhKfJBuMbyT3ScSTrf4SJOtzPLeU5NCpw77
 aKZFiwgYlP4YnwobyZAyds5CJfJTH5f+rNxMfB2cykWQHhz2VA7clBDcv8bHXATj6bJj49aiPTu
 1lkw8G4zAJRCJUTDksxRDvt1y4BTY0FiA9VCFS7H8lpOg0krsqijjKQelA10CEG0ytEuA4bfi/H
 zzewDbYEqR/WTck3t1ToBH5eLsBkEK8fV7RKC9KCUFveO1Woyq9UtVnn/lwnKLSUEblTjbmMNy6
 RufdS3sscFrtHin7CEg==
X-Proofpoint-ORIG-GUID: xwHs46zJeeTeY2Iw69jGb3NfLkFV409F
X-Authority-Analysis: v=2.4 cv=U6QHnuru c=1 sm=1 tr=0 ts=6b035961 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=I1klMSMIwWXoFng0-R0A:9
 a=O8hF6Hzn-FEA:10
X-Proofpoint-GUID: xwHs46zJeeTeY2Iw69jGb3NfLkFV409F
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIyMDA4NCBTYWx0ZWRfX4nYZYZJRxkKL
 xVyLyRZbQuEoyIWdOvqjT2lNS22po2z44W+oLZ/cqiw8fDMU4zIytlwtb0aKisQvTDwWPldj7C6
 LZWDeQkgt2qgAYxid86gSQWoanUMm20=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-22_05,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 impostorscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611220084

The s390 ABI returns any aggregate and scalars larger than 8 bytes, such
as __int128, in a return value buffer allocated by the caller.
This buffer's address is treated like a "hidden argument" and passed
by the caller in %r2. The function's first parameter is passed in %r3.

Without this change pahole skips such functions and with "--verbose"
prints a message like this:

<function> : skipping BTF encoding of function due to unexpected register usage for parameter

Set the first parameter register index (reg_idx) to the proper value.
Move function's return type resolution before parameters
are analyzed, because the analysis depends on the return type.

Although param_loc_supported is not set for s390, calculate
the reg_idx in function__match_clang_parameter_locations in case
the flag is enabled in the future.

The change affects only s390.

Signed-off-by: Maxim Khmelevskii <max@linux.ibm.com>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com> 
---
 dwarf_loader.c | 84 +++++++++++++++++++++++++++++++++++++++-----------
 dwarves.h      |  1 +
 2 files changed, 67 insertions(+), 18 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 01049e9..e6cc4e3 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -4044,6 +4044,51 @@ static bool parameter__apply_true_sig_member(struct parameter *parm, struct cu *
 	return true;
 }
 
+static bool tag__is_aggregate(const struct tag *type)
+{
+	switch (type->tag) {
+	case DW_TAG_structure_type:
+	case DW_TAG_class_type:
+	case DW_TAG_union_type:
+	case DW_TAG_array_type:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool s390x__ret_in_memory(const struct tag *type, const struct cu *cu)
+{
+	if (tag__is_aggregate(type))
+		return true;
+
+	return tag__size(type, cu) > 8;
+}
+
+static bool ftype__ret_in_memory(const struct ftype *ftype, const struct cu *cu)
+{
+	switch (cu->e_machine) {
+	case EM_S390: {
+		struct tag *type;
+
+		if (ftype->tag.type == 0)
+			return false;
+
+		type = tag__strip_typedefs_and_modifiers(&ftype->tag, cu);
+		if (type == NULL)
+			return false;
+		return s390x__ret_in_memory(type, cu);
+	} break;
+	default:
+		return false;
+	}
+}
+
+static int ftype__first_param_reg_idx(const struct ftype *ftype, const struct cu *cu)
+{
+	return ftype__ret_in_memory(ftype, cu) ? 1 : 0;
+}
+
 static bool parameter__reg_in_expected_window(const struct parameter *parm, int reg_idx,
 					      int slots, const struct cu *cu)
 {
@@ -4060,8 +4105,8 @@ static bool parameter__reg_in_expected_window(const struct parameter *parm, int
 
 static void function__match_clang_parameter_locations(struct ftype *ftype, struct cu *cu)
 {
+	int reg_idx = ftype__first_param_reg_idx(ftype, cu);
 	struct parameter *pos;
-	int reg_idx = 0;
 
 	ftype__for_each_parameter(ftype, pos) {
 		int slots = parameter__abi_slots(pos, cu);
@@ -4089,7 +4134,7 @@ static void function__analyze_parameter_locations(struct function *fn, struct cu
 	bool true_sig_enabled = cu->param_loc_supported && conf->true_signature &&
 				ftype->signature_changed;
 	bool check_locations = !cu->producer_clang || ftype->signature_changed;
-	int reg_idx = 0;
+	int reg_idx = ftype__first_param_reg_idx(ftype, cu);
 
 	if (!check_locations) {
 		/* Producer is clang and the signature was not changed: match
@@ -4448,6 +4493,24 @@ static int cu__resolve_func_ret_types_optimized(struct cu *cu, struct conf_load
 			continue;
 
 		fn = tag__function(tag);
+
+		/* Set the function return type, it affects the register index associated
+		 * with the first parameter of the function. If the return value is passed
+		 * in memory the index is shifted.
+		 */
+		if (tag->type == 0 && fn->abstract_origin) {
+			struct dwarf_tag *dtag = tag__dwarf(tag);
+			struct dwarf_tag *dfunc;
+
+			dfunc = dwarf_cu__find_tag_by_ref(cu->priv, dtag, abstract_origin);
+			if (dfunc == NULL) {
+				tag__print_abstract_origin_not_found(tag);
+				return -1;
+			}
+
+			tag->type = dtag__tag(dfunc)->type;
+		}
+
 		/* Abstract inline subprograms describe source signatures; their
 		 * concrete locations belong to DW_TAG_inlined_subroutine children.
 		 */
@@ -4475,22 +4538,6 @@ static int cu__resolve_func_ret_types_optimized(struct cu *cu, struct conf_load
 					fn->proto.unexpected_reg = 1;
 			}
 		}
-
-		if (tag == NULL || tag->type != 0)
-			continue;
-
-		if (!fn->abstract_origin)
-			continue;
-
-		struct dwarf_tag *dtag = tag__dwarf(tag);
-		struct dwarf_tag *dfunc;
-		dfunc = dwarf_cu__find_tag_by_ref(cu->priv, dtag, abstract_origin);
-		if (dfunc == NULL) {
-			tag__print_abstract_origin_not_found(tag);
-			return -1;
-		}
-
-		tag->type = dtag__tag(dfunc)->type;
 	}
 	return 0;
 }
@@ -4805,6 +4852,7 @@ static int cu__set_common(struct cu *cu, struct conf_load *conf,
 	cu->agg_use_two_regs = arch__agg_use_two_regs(&ehdr);
 	cu->arg_align_two_regs = arch__arg_align_two_regs(&ehdr);
 	cu->param_loc_supported = arch__param_loc_supported(&ehdr);
+	cu->e_machine = ehdr.e_machine;
 	arch__set_register_params(&ehdr, cu);
 	return 0;
 }
diff --git a/dwarves.h b/dwarves.h
index 07d85e6..c7b254d 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -333,6 +333,7 @@ struct cu {
 	uint8_t		 arg_align_two_regs:1;	/* An over-aligned arg starts on an even register */
 	uint8_t		 param_loc_supported:1;	/* Parameter location analysis is validated for this arch */
 	uint8_t		 nr_register_params;
+	uint16_t	 e_machine;
 	int		 register_params[ARCH_MAX_REGISTER_PARAMS];
 	int		 functions_saved;
 	uint16_t	 language;
-- 
2.56.0

