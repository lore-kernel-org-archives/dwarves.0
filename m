Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087D2C433EF
	for <linux-dwarves@archiver.kernel.org>; Wed, 17 Nov 2021 20:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6F8B61AEC
	for <linux-dwarves@archiver.kernel.org>; Wed, 17 Nov 2021 20:22:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239806AbhKQUZo (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Wed, 17 Nov 2021 15:25:44 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:46424 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238577AbhKQUZn (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Wed, 17 Nov 2021 15:25:43 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AHJtuYX030348
        for <dwarves@vger.kernel.org>; Wed, 17 Nov 2021 12:22:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=odDHSc5u7mPeJUGZBEqXhlLUCYerDkSzOy5Wc0oaYJA=;
 b=g8Phjc6Fgz6jYIs8Yf+IhLffhHn7O+n5NEs2DD8lKAWdOqs1QN0LzTrIcD3b/Ruw5JXA
 TNOvKDn+6f6tp0ZBfMbDT5OUqdtlwVfLDIsSkHCYCRKG+gVFJMCXJMBVq3Zb8hekrQVV
 5VsKXWO7XL3iYhT1uBAVmnObREAuH7nafhc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3ccx48cpne-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <dwarves@vger.kernel.org>; Wed, 17 Nov 2021 12:22:44 -0800
Received: from intmgw001.06.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 17 Nov 2021 12:22:43 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 6295228FBAF5; Wed, 17 Nov 2021 12:22:35 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH dwarves 4/4] btf_encoder: support btf_type_tag attribute
Date:   Wed, 17 Nov 2021 12:22:35 -0800
Message-ID: <20211117202235.3271057-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211117202214.3268824-1-yhs@fb.com>
References: <20211117202214.3268824-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: plO4kvsc8wTMOHCE-NGsS6vXahe2RccP
X-Proofpoint-GUID: plO4kvsc8wTMOHCE-NGsS6vXahe2RccP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-17_07,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 adultscore=0 impostorscore=0 bulkscore=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111170091
X-FB-Internal: deliver
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

The following is an example.
  [$ ~] cat t.c
  #define __tag1 __attribute__((btf_type_tag("tag1")))
  #define __tag2 __attribute__((btf_type_tag("tag2")))
  int __tag1 * __tag1 __tag2 *g __attribute__((section(".data..percpu")))=
;
  [$ ~] clang -O2 -g -c t.c
  [$ ~] pahole -JV t.o
  Found per-CPU symbol 'g' at address 0x0
  Found 1 per-CPU variables!
  File t.o:
  [1] TYPE_TAG tag1 type_id=3D5
  [2] TYPE_TAG tag2 type_id=3D1
  [3] PTR (anon) type_id=3D2
  [4] TYPE_TAG tag1 type_id=3D6
  [5] PTR (anon) type_id=3D4
  [6] INT int size=3D4 nr_bits=3D32 encoding=3DSIGNED
  search cu 't.c' for percpu global variables.
  Variable 'g' from CU 't.c' at address 0x0 encoded
  [7] VAR g type=3D3 linkage=3D1
  [8] DATASEC .data..percpu size=3D8 vlen=3D1
          type=3D7 offset=3D0 size=3D8
  [$ ~]

You can see for the source
  int __tag1 * __tag1 __tag2 *g __attribute__((section(".data..percpu")))=
;
the following type chain is generated:
  var -> ptr -> tag2 -> tag1 -> ptr -> tag1 -> int

The following shows pahole option "--skip_encoding_btf_type_tag"
can prevent BTF_KIND_TYPE_TAG generation.
  [$ ~] pahole -JV t.o --skip_encoding_btf_type_tag
  Found per-CPU symbol 'g' at address 0x0
  Found 1 per-CPU variables!
  File t.o:
  [1] PTR (anon) type_id=3D2
  [2] PTR (anon) type_id=3D3
  [3] INT int size=3D4 nr_bits=3D32 encoding=3DSIGNED
  search cu 't.c' for percpu global variables.
  Variable 'g' from CU 't.c' at address 0x0 encoded
  [4] VAR g type=3D1 linkage=3D1
  [5] DATASEC .data..percpu size=3D8 vlen=3D1
          type=3D4 offset=3D0 size=3D8
  [$ ~]

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 btf_encoder.c | 7 +++++++
 dwarves.h     | 5 +++++
 2 files changed, 12 insertions(+)

diff --git a/btf_encoder.c b/btf_encoder.c
index 117656e..9d015f3 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -143,6 +143,7 @@ static const char * const btf_kind_str[NR_BTF_KINDS] =
=3D {
 	[BTF_KIND_DATASEC]      =3D "DATASEC",
 	[BTF_KIND_FLOAT]        =3D "FLOAT",
 	[BTF_KIND_DECL_TAG]     =3D "DECL_TAG",
+	[BTF_KIND_TYPE_TAG]     =3D "TYPE_TAG",
 };
=20
 static const char *btf__printable_name(const struct btf *btf, uint32_t o=
ffset)
@@ -393,6 +394,9 @@ static int32_t btf_encoder__add_ref_type(struct btf_e=
ncoder *encoder, uint16_t k
 	case BTF_KIND_TYPEDEF:
 		id =3D btf__add_typedef(btf, name, type);
 		break;
+	case BTF_KIND_TYPE_TAG:
+		id =3D btf__add_type_tag(btf, name, type);
+		break;
 	case BTF_KIND_FWD:
 		id =3D btf__add_fwd(btf, name, kind_flag);
 		break;
@@ -862,6 +866,9 @@ static int btf_encoder__encode_tag(struct btf_encoder=
 *encoder, struct tag *tag,
 	case DW_TAG_typedef:
 		name =3D namespace__name(tag__namespace(tag));
 		return btf_encoder__add_ref_type(encoder, BTF_KIND_TYPEDEF, ref_type_i=
d, name, false);
+	case DW_TAG_LLVM_annotation:
+		name =3D tag__btf_type_tag(tag)->value;
+		return btf_encoder__add_ref_type(encoder, BTF_KIND_TYPE_TAG, ref_type_=
id, name, false);
 	case DW_TAG_structure_type:
 	case DW_TAG_union_type:
 	case DW_TAG_class_type:
diff --git a/dwarves.h b/dwarves.h
index 4425d3c..52d162d 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -637,6 +637,11 @@ static inline struct btf_type_tag_ptr_type *tag__btf=
_type_tag_ptr(struct tag *ta
 	return (struct btf_type_tag_ptr_type *)tag;
 }
=20
+static inline struct btf_type_tag_type *tag__btf_type_tag(struct tag *ta=
g)
+{
+	return (struct btf_type_tag_type *)tag;
+}
+
 /** struct namespace - base class for enums, structs, unions, typedefs, =
etc
  *
  * @tags - class_member, enumerators, etc
--=20
2.30.2

