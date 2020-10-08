Return-Path: <SRS0=vfrS=DP=vger.kernel.org=dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BFDC43457
	for <linux-dwarves@archiver.kernel.org>; Thu,  8 Oct 2020 23:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F76C2224E
	for <linux-dwarves@archiver.kernel.org>; Thu,  8 Oct 2020 23:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602200444;
	bh=dcH7jsOI9nC9ba8HtNCMIWG39/X0//Anft+FySEM+WA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YqOxE9p4wJ0pOV5ZwbKXer9fuDsKtvYjF/yTOhwNrPPoAq8QLW0PoTDDc/5uruHHN
	 nIMX4nRXRNThk1C/oeTs0xiz/01MHXAP3UJpaa8TAqzbUaCQ6Q+ICpeCuHNxLoZMqf
	 gryvfS6UYjCTTq9qeNB8g6RyaO/rcZAKVVK3gjHk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731087AbgJHXko convert rfc822-to-8bit (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 8 Oct 2020 19:40:44 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:22882 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731076AbgJHXkn (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Thu, 8 Oct 2020 19:40:43 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 098Nefwr027434
        for <dwarves@vger.kernel.org>; Thu, 8 Oct 2020 16:40:42 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3429ggrw6f-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <dwarves@vger.kernel.org>; Thu, 08 Oct 2020 16:40:42 -0700
Received: from intmgw001.08.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 8 Oct 2020 16:40:14 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 2936F2EC7C76; Thu,  8 Oct 2020 16:40:10 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <dwarves@vger.kernel.org>
CC:     <bpf@vger.kernel.org>, <kernel-team@fb.com>, <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>
Subject: [PATCH v2 dwarves 3/8] btf_encoder: fix emitting __ARRAY_SIZE_TYPE__ as index range type
Date:   Thu, 8 Oct 2020 16:39:55 -0700
Message-ID: <20201008234000.740660-4-andrii@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201008234000.740660-1-andrii@kernel.org>
References: <20201008234000.740660-1-andrii@kernel.org>
MIME-Version: 1.0
X-FB-Internal: Safe
Content-Type: text/plain
Content-Transfer-Encoding: 8BIT
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-08_15:2020-10-08,2020-10-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 mlxscore=0
 adultscore=0 suspectscore=15 lowpriorityscore=0 phishscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010080167
X-FB-Internal: deliver
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

From: Andrii Nakryiko <andriin@fb.com>

Fix the logic of determining if __ARRAY_SIZE_TYPE__ needs to be emitted.
Previously, such type could be emitted unnecessarily due to some particular CU
not having an int type in it. That would happen even if there was no array
type in that CU. Fix it by keeping track of 'int' type across CUs and only
emitting __ARRAY_SIZE_TYPE__ if a given CU has array type, but we still
haven't found 'int' type.

Testing against vmlinux shows that now there are no __ARRAY_SIZE_TYPE__
integers emitted.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 btf_encoder.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 6e6bce202438..2e5df03e040f 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -147,6 +147,8 @@ static int32_t enumeration_type__encode(struct btf_elf *btfe, struct cu *cu, str
 	return type_id;
 }
 
+static bool need_index_type;
+
 static int tag__encode_btf(struct cu *cu, struct tag *tag, uint32_t core_id, struct btf_elf *btfe,
 			   uint32_t array_index_id, uint32_t type_id_off)
 {
@@ -179,6 +181,7 @@ static int tag__encode_btf(struct cu *cu, struct tag *tag, uint32_t core_id, str
 			return structure_type__encode(btfe, cu, tag, type_id_off);
 	case DW_TAG_array_type:
 		/* TODO: Encode one dimension at a time. */
+		need_index_type = true;
 		return btf_elf__add_array(btfe, ref_type_id, array_index_id, array_type__nelems(tag));
 	case DW_TAG_enumeration_type:
 		return enumeration_type__encode(btfe, cu, tag);
@@ -193,6 +196,7 @@ static int tag__encode_btf(struct cu *cu, struct tag *tag, uint32_t core_id, str
 
 static struct btf_elf *btfe;
 static uint32_t array_index_id;
+static bool has_index_type;
 
 int btf_encoder__encode()
 {
@@ -228,7 +232,6 @@ static struct variable *hashaddr__find_variable(const struct hlist_head hashtabl
 int cu__encode_btf(struct cu *cu, int verbose, bool force,
 		   bool skip_encoding_vars)
 {
-	bool add_index_type = false;
 	uint32_t type_id_off;
 	uint32_t core_id;
 	struct function *fn;
@@ -254,18 +257,26 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
 		if (!btfe)
 			return -1;
 
-		/* cu__find_base_type_by_name() takes "type_id_t *id" */
-		type_id_t id;
-		if (!cu__find_base_type_by_name(cu, "int", &id)) {
-			add_index_type = true;
-			id = cu->types_table.nr_entries;
-		}
-		array_index_id = id;
+		has_index_type = false;
+		need_index_type = false;
+		array_index_id = 0;
 
 		if (verbose)
 			printf("File %s:\n", btfe->filename);
 	}
 
+	if (!has_index_type) {
+		/* cu__find_base_type_by_name() takes "type_id_t *id" */
+		type_id_t id;
+		if (cu__find_base_type_by_name(cu, "int", &id)) {
+			has_index_type = true;
+			array_index_id = id;
+		} else {
+			has_index_type = false;
+			array_index_id = cu->types_table.nr_entries;
+		}
+	}
+
 	btf_elf__verbose = verbose;
 	type_id_off = btf__get_nr_types(btfe->btf);
 
@@ -279,12 +290,13 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
 		}
 	}
 
-	if (add_index_type) {
+	if (need_index_type && !has_index_type) {
 		struct base_type bt = {};
 
 		bt.name = 0;
 		bt.bit_size = 32;
 		btf_elf__add_base_type(btfe, &bt, "__ARRAY_SIZE_TYPE__");
+		has_index_type = true;
 	}
 
 	cu__for_each_function(cu, core_id, fn) {
-- 
2.24.1

