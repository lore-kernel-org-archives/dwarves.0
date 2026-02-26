Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F732F12A1;
	Thu, 26 Feb 2026 08:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772096018; cv=none; b=I3h7E2p4oK5FEexXyvRLGfzqRWKnpALtszyG8xGryvb0kK82CfE9NmhvhLgMIGq/B/mKKXEuUmxwpGwaOAyKf/C3IEHRdOIHGhCzRnFBXj7YHuZ/AS48KsAa/F6uZTp4XgOoBz7R3PSNdH1XLxUGgvnnLkPcUt58Ax+GWmUvPNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772096018; c=relaxed/simple;
	bh=yQ/tKOBbf2Pl5b75ZAnGW28pwUxmTnECfZGx6LogGfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l36P+YmXQ2LeBatJG1ClLX6AStLU+cYgoqtQWAh57Ap8irDbVHYp/+U9DHgfKRoQmGL4x2uf0ycxOg2hBJiuz/MaB7qPzaskJnRxpEbwf9Z6gCqYySfYiMwOVhNvqbyhmoG6opv3OXrsz6ZeBpmTO5KNllFRP2lQMyRmRn7Z/9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZoY4xFhf; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZoY4xFhf"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PNvCfu3709664;
	Thu, 26 Feb 2026 08:53:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=E4yld
	J5eryW4WSGBCpphTaa0CznTbuHZawXe3ZxVSZk=; b=ZoY4xFhfANxF7xSNQsSVS
	3tqlKGWgDGtMHr9ikpoiZ1OorHbdqGkdyJKNsaPXUiaumUhLWOjmpNvW2614gPQF
	wcNv/CaPgx3cM7w/kIK60pCx/Dl4NGeWMqeWC6/7pjxdDlTCfHWNZ1jf5Thyw81l
	d2cHRfkeZpQhEeyU53TKe2vbAqv1U2Ex2FyKt/6ognsQVGSHoveiXwztNs5iLZwl
	O07GOKyVJtaB3PwZW2vAkMRyi31CIgk7NadGqQUYG5zGabUXTmVX3JgTCvj+xlX/
	lDzZ8bnNPXBk6wlmjPkgDhX56J9WsqQtYYKGbImz48IX62EnOdEVroIiDafgLebB
	A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cf4arftts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Feb 2026 08:53:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61Q7Km9C012575;
	Thu, 26 Feb 2026 08:53:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cf35gfgfw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Feb 2026 08:53:13 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 61Q8r7gJ014003;
	Thu, 26 Feb 2026 08:53:13 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-58-146.vpn.oracle.com [10.154.58.146])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4cf35gfg6e-2;
	Thu, 26 Feb 2026 08:53:13 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        mykyta.yatsenko5@gmail.com, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 dwarves 1/2] pahole: Add "layout" BTF encoding feature
Date: Thu, 26 Feb 2026 08:52:39 +0000
Message-ID: <20260226085240.1908874-2-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260226085240.1908874-1-alan.maguire@oracle.com>
References: <20260226085240.1908874-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_04,2026-02-25_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2602130000 definitions=main-2602260079
X-Authority-Analysis: v=2.4 cv=La0xKzfi c=1 sm=1 tr=0 ts=69a009fa b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=yPCof4ZbAAAA:8 a=wiVDanay_bfISUmgNr8A:9 cc=ntf
 awl=host:13810
X-Proofpoint-ORIG-GUID: NY1XIUyvKPixSudRs7lvjraIh4CZJLAm
X-Proofpoint-GUID: NY1XIUyvKPixSudRs7lvjraIh4CZJLAm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDA3OSBTYWx0ZWRfX+co1Fx0d3gCj
 hfZytxTvbCTQZ4vLOiEIq21XBWMtblKdvhVhgb9ergi+sGjujxWCjWUl/ffYh5thhetbNrOBcAG
 2xoC60Lg+mqYgqEAIo0VFEZjarLNBIonppSBf1To78ZyD0GILZUB/kKZ+8h0lGwiXk/Mdj+v7lg
 dY/hlmT7vUIO9XDxpYNeCHpC7vSgG5DD10Gn0Cdbk0IyhZ1VIvf1oaEKv8hZ3wgiSDrxsyPwwk9
 B6CGVfaC/TvqXD+DA0quE+WsDqDzc3MzXmJQrN66GsnraI2lumv8otaVnBFyWFERn/T3+vJjMS+
 dfVZH7LstcRtkQ1yNF54aWrEv+8pf1HhPRShW26AiT3onUSpBmL3PtE5bJ7Ac56G6ITKJnJqTID
 CRkM29NtauxKzIWuLb4EqDYizSiIqm7n8eDGmkZD9cDcIsweA31lsKzlyinioNuCrsRzm/XZimi
 lrnEM7OA0njPc2t7bvgMyN+YxMhFuypU3TgbSF0k=

Add support to pahole to add BTF kind layout info which describes the
BTF kinds supported at encoding time.  Since an older libbpf can be used
to build pahole add declaration for btf_new_opts and add a feature test
to check for the btf__new_empty_opts() function.

Also skip adding layout information for split BTF; it is redundant as
the base BTF will have the same information, and would just waste
space.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 btf_encoder.c | 21 ++++++++++++++++++++-
 dwarves.h     |  4 ++++
 pahole.c      |  6 ++++++
 3 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index aa7cd1c..99298e3 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -2679,6 +2679,16 @@ out:
 	return err;
 }
 
+/* Needed for older libbpf to support weak declaration of btf__new_empty_opts() */
+#ifndef btf_new_opts__last_field
+struct btf_new_opts {
+	size_t sz;
+	struct btf *base_btf;
+	bool add_layout;
+	size_t:0;
+};
+#endif
+
 struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filename, struct btf *base_btf, bool verbose, struct conf_load *conf_load)
 {
 	struct btf_encoder *encoder = zalloc(sizeof(*encoder));
@@ -2692,7 +2702,16 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
 		if (encoder->source_filename == NULL || encoder->filename == NULL)
 			goto out_delete;
 
-		encoder->btf = btf__new_empty_split(base_btf);
+		if (btf__new_empty_opts) {
+			LIBBPF_OPTS(btf_new_opts, opts);
+
+			/* only add layout to base BTF; no need to repeat for split. */
+			opts.add_layout = !base_btf && conf_load->btf_gen_layout;
+			opts.base_btf = base_btf;
+			encoder->btf = btf__new_empty_opts(&opts);
+		} else {
+			encoder->btf = btf__new_empty_split(base_btf);
+		}
 		if (encoder->btf == NULL)
 			goto out_delete;
 
diff --git a/dwarves.h b/dwarves.h
index d7c6474..5ec16e7 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -46,6 +46,8 @@ enum load_steal_kind {
 	LSK__ABORT,
 };
 
+struct btf_new_opts;
+
 /*
  * Weak declarations of libbpf APIs that are version-dependent
  */
@@ -55,6 +57,7 @@ __weak extern int btf__add_enum64(struct btf *btf, const char *name, __u32 byte_
 __weak extern int btf__add_enum64_value(struct btf *btf, const char *name, __u64 value);
 __weak extern int btf__add_type_attr(struct btf *btf, const char *value, int ref_type_id);
 __weak extern int btf__distill_base(const struct btf *src_btf, struct btf **new_base_btf, struct btf **new_split_btf);
+__weak extern struct btf *btf__new_empty_opts(struct btf_new_opts *opts);
 
 /*
  * BTF combines all the types into one big CU using btf_dedup(), so for something
@@ -95,6 +98,7 @@ struct conf_load {
 	bool			skip_encoding_btf_inconsistent_proto;
 	bool			skip_encoding_btf_vars;
 	bool			encode_btf_global_vars;
+	bool			btf_gen_layout;
 	bool			btf_gen_floats;
 	bool			btf_encode_force;
 	bool			reproducible_build;
diff --git a/pahole.c b/pahole.c
index 02a0d19..7eafc88 100644
--- a/pahole.c
+++ b/pahole.c
@@ -1209,6 +1209,11 @@ static bool attributes_check(void)
 	return btf__add_type_attr != NULL;
 }
 
+static bool layout_check(void)
+{
+	return btf__new_empty_opts != NULL;
+}
+
 struct btf_feature {
 	const char      *name;
 	const char      *option_alias;
@@ -1235,6 +1240,7 @@ struct btf_feature {
 	BTF_NON_DEFAULT_FEATURE_CHECK(attributes, btf_attributes, false,
 				      attributes_check),
 	BTF_NON_DEFAULT_FEATURE(true_signature, true_signature, false),
+	BTF_NON_DEFAULT_FEATURE_CHECK(layout, btf_gen_layout, false, layout_check)
 };
 
 #define BTF_MAX_FEATURE_STR	1024
-- 
2.39.3

