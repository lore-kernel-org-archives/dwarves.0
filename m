Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1933B8BCE;
	Tue,  3 Mar 2026 18:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772562101; cv=none; b=rfJJRf6uvyZHAfR3hN3e4jCv7Pk+cPcCCi30ldgo1+ge1cvWjJEc2W7H2K06h8KHcHUygS6/ffLISUntss+4S7kQve3zG1/PUNz4LDuR9JH9NZMhEL1hva9YGqNGl5BBlj//Tv3tmHAnCdf8ecxFWSIbHSA2O79aJpKdYDJ4UsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772562101; c=relaxed/simple;
	bh=Df9OB5oe6ohlwZ85xlKDtKIBP1FN+uqlgAQMvF6PATc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tIFURt0Kz436o+6zYsBWlidD1eryr/Wi09avtNucQ2yVUJs4DMEQmofr1KpWF6PXS9oTrFgixAMeecM/GvJmKeRnhC2YxvKsnt0eQ8UzZZwIl+VoCN7R4ohSXIBRtCP8fFqkVGoXVZg7UR19J51sj5J8uhFT8wMNUGELUkdttC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TZlaTeMx; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TZlaTeMx"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 623HmGQE929602;
	Tue, 3 Mar 2026 18:20:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=sesYn
	5KWRNM8yaUhRzmvWhK4jtnxZ0x5aVj0JZgJB/g=; b=TZlaTeMx/AJ8vUcejrAPT
	Dt1dvT3lWllgMygXcnBq7n2S8MU4hcZ4Pv4o4K+fPij+5go88xbo/HEaNFBKJ7Mi
	LTiRqJI3s3HtizAoZMeO92Nm9KH+0bWJLVCgP4ghrEmhAgJrJaUKsUaXnTsJcuVC
	7un6YKfddjk0qjTVaa9u4yqy2uKCfebssD9Q9udCQBLBRFeMAmupk4rhlLBaieI3
	dU7d++jJqdx8ufPtd2AHfUkirYMOfdssv0bgoCTNFCnWrX5Zqj+IbzJji8YmOHGs
	ShnFsB77d+dj9EJrbd7Sgyfgw0Jp6PddMkVLM6/7UairB6kqpG1lM4gog+p1ZZio
	g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cp4c381th-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Mar 2026 18:20:19 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 623H0mgb037876;
	Tue, 3 Mar 2026 18:20:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ckpteyye1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Mar 2026 18:20:19 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 623IK7oB029269;
	Tue, 3 Mar 2026 18:20:18 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-62-133.vpn.oracle.com [10.154.62.133])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4ckpteyxu6-5;
	Tue, 03 Mar 2026 18:20:18 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        mykyta.yatsenko5@gmail.com, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v12 bpf-next 4/8] libbpf: Add layout encoding support
Date: Tue,  3 Mar 2026 18:19:59 +0000
Message-ID: <20260303182003.117483-5-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260303182003.117483-1-alan.maguire@oracle.com>
References: <20260303182003.117483-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-03_02,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603030148
X-Proofpoint-GUID: CickXJB5DG6HxPirAWPqa3e7J-Eum5cH
X-Authority-Analysis: v=2.4 cv=VZH6/Vp9 c=1 sm=1 tr=0 ts=69a72664 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=yPCof4ZbAAAA:8 a=lIN0CykIrsTzq82mcFQA:9 cc=ntf
 awl=host:13812
X-Proofpoint-ORIG-GUID: CickXJB5DG6HxPirAWPqa3e7J-Eum5cH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDE0OCBTYWx0ZWRfX7uc9BgjX4FkI
 LBvLoJQvvF/oAbOcKQF6V32QMNL7U5r5YNWgTjmfqvJTypuhoQbEWbIb/p+hoGdlu4uKz2rUayJ
 rMOzh0S2ezJQzHDxLNpBc/FHOb0C33UmUy6Llg4EbONRTaY1KglgTbTLG+3cdocKSAH7/PkQx4G
 OMswFxDuwby15KarAZCnELCghEqFCnRQrIlfn/QfpS0nKkeetCYCMxc2Yza2dgDCj0OM6xVyDRY
 g0cjo7zRRyBvYUM9Oh2iimvdNzB4P0Q2y0z87sF6KrDGyJHn/d3ZM7WlkGTU/jmPNwE+Nj0ILiR
 U/TDjC278xy2z25WpPEyesNR4g4HDwINWIVnxEmiQMMpxTbwgNU/yBz86l9OLe04piTO4XW+vVB
 Wc4/cvSGVJrM/vf2/Yeu2NIKQMaLRlRLQ2Hs99kj+zoCORV6GlJVunQA7sZMzlXOfJh1w7K8YBJ
 nMFlTw1L0XZ+zAr8frnsojCtFgzs7aj/bf4d04Y8=

Support encoding of BTF layout data via btf__new_empty_opts().

Current supported opts are base_btf and add_layout.

Layout information is maintained in btf.c in the layouts[] array;
when BTF is created with the add_layout option it represents the
current view of supported BTF kinds.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/btf.c      | 59 ++++++++++++++++++++++++++++++++++++++--
 tools/lib/bpf/btf.h      | 20 ++++++++++++++
 tools/lib/bpf/libbpf.map |  1 +
 3 files changed, 78 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 9f4d1bd73b4d..eba0cae65bb4 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -29,6 +29,36 @@
 
 static struct btf_type btf_void;
 
+/*
+ * Describe how kinds are laid out; some have a singular element following the "struct btf_type",
+ * some have BTF_INFO_VLEN(t->info) elements.  Specify sizes for both.  Flags are currently unused.
+ * Kind layout can be optionally added to the BTF representation in a dedicated section to
+ * facilitate parsing.  New kinds must be added here.
+ */
+static struct btf_layout layouts[NR_BTF_KINDS] = {
+/*				singular element size		vlen element(s) size		flags */
+[BTF_KIND_UNKN] =	{	0,				0,				0 },
+[BTF_KIND_INT] =	{	sizeof(__u32),			0,				0 },
+[BTF_KIND_PTR] =	{	0,				0,				0 },
+[BTF_KIND_ARRAY] =	{	sizeof(struct btf_array),	0,				0 },
+[BTF_KIND_STRUCT] =	{	0,				sizeof(struct btf_member),	0 },
+[BTF_KIND_UNION] =	{	0,				sizeof(struct btf_member),	0 },
+[BTF_KIND_ENUM] =	{	0,				sizeof(struct btf_enum),	0 },
+[BTF_KIND_FWD] =	{	0,				0,				0 },
+[BTF_KIND_TYPEDEF] =	{	0,				0,				0 },
+[BTF_KIND_VOLATILE] =	{	0,				0,				0 },
+[BTF_KIND_CONST] =	{	0,				0,				0 },
+[BTF_KIND_RESTRICT] =	{	0,				0,				0 },
+[BTF_KIND_FUNC] =	{	0,				0,				0 },
+[BTF_KIND_FUNC_PROTO] =	{	0,				sizeof(struct btf_param),	0 },
+[BTF_KIND_VAR] =	{	sizeof(struct btf_var),		0,				0 },
+[BTF_KIND_DATASEC] =	{	0,				sizeof(struct btf_var_secinfo),	0 },
+[BTF_KIND_FLOAT] =	{	0,				0,				0 },
+[BTF_KIND_DECL_TAG] =	{	sizeof(struct btf_decl_tag),	0,				0 },
+[BTF_KIND_TYPE_TAG] =	{	0,				0,				0 },
+[BTF_KIND_ENUM64] =	{	0,				sizeof(struct btf_enum64),	0 },
+};
+
 struct btf {
 	/* raw BTF data in native endianness */
 	void *raw_data;
@@ -1139,8 +1169,10 @@ void btf__free(struct btf *btf)
 	free(btf);
 }
 
-static struct btf *btf_new_empty(struct btf *base_btf)
+static struct btf *btf_new_empty(struct btf_new_opts *opts)
 {
+	bool add_layout = OPTS_GET(opts, add_layout, false);
+	struct btf *base_btf = OPTS_GET(opts, base_btf, NULL);
 	struct btf_header *hdr;
 	struct btf *btf;
 
@@ -1165,6 +1197,8 @@ static struct btf *btf_new_empty(struct btf *base_btf)
 
 	/* +1 for empty string at offset 0 */
 	btf->raw_size = sizeof(struct btf_header) + (base_btf ? 0 : 1);
+	if (add_layout)
+		btf->raw_size += sizeof(layouts);
 	btf->raw_data = calloc(1, btf->raw_size);
 	if (!btf->raw_data) {
 		free(btf);
@@ -1179,6 +1213,15 @@ static struct btf *btf_new_empty(struct btf *base_btf)
 	btf->types_data = btf->raw_data + hdr->hdr_len;
 	btf->strs_data = btf->raw_data + hdr->hdr_len;
 	hdr->str_len = base_btf ? 0 : 1; /* empty string at offset 0 */
+
+	if (add_layout) {
+		hdr->layout_len = sizeof(layouts);
+		btf->layout = btf->raw_data + hdr->hdr_len;
+		memcpy(btf->layout, layouts, sizeof(layouts));
+		btf->strs_data += sizeof(layouts);
+		hdr->str_off += sizeof(layouts);
+	}
+
 	memcpy(&btf->hdr, hdr, sizeof(*hdr));
 
 	return btf;
@@ -1191,7 +1234,19 @@ struct btf *btf__new_empty(void)
 
 struct btf *btf__new_empty_split(struct btf *base_btf)
 {
-	return libbpf_ptr(btf_new_empty(base_btf));
+	LIBBPF_OPTS(btf_new_opts, opts);
+
+	opts.base_btf = base_btf;
+
+	return libbpf_ptr(btf_new_empty(&opts));
+}
+
+struct btf *btf__new_empty_opts(struct btf_new_opts *opts)
+{
+	if (!OPTS_VALID(opts, btf_new_opts))
+		return libbpf_err_ptr(-EINVAL);
+
+	return libbpf_ptr(btf_new_empty(opts));
 }
 
 static struct btf *btf_new(const void *data, __u32 size, struct btf *base_btf, bool is_mmap)
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index b30008c267c0..a1f8deca2603 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -109,6 +109,26 @@ LIBBPF_API struct btf *btf__new_empty(void);
  */
 LIBBPF_API struct btf *btf__new_empty_split(struct btf *base_btf);
 
+struct btf_new_opts {
+	size_t sz;
+	struct btf *base_btf;	/* optional base BTF */
+	bool add_layout;	/* add BTF layout information */
+	size_t:0;
+};
+#define btf_new_opts__last_field add_layout
+
+/**
+ * @brief **btf__new_empty_opts()** creates an unpopulated BTF object with
+ * optional *base_btf* and BTF kind layout description if *add_layout*
+ * is set
+ * @return new BTF object instance which has to be eventually freed with
+ * **btf__free()**
+ *
+ * On error, NULL is returned and the thread-local `errno` variable is
+ * set to the error code.
+ */
+LIBBPF_API struct btf *btf__new_empty_opts(struct btf_new_opts *opts);
+
 /**
  * @brief **btf__distill_base()** creates new versions of the split BTF
  * *src_btf* and its base BTF. The new base BTF will only contain the types
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index d18fbcea7578..0f740fb27a12 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -453,5 +453,6 @@ LIBBPF_1.7.0 {
 		bpf_map__exclusive_program;
 		bpf_prog_assoc_struct_ops;
 		bpf_program__assoc_struct_ops;
+		btf__new_empty_opts;
 		btf__permute;
 } LIBBPF_1.6.0;
-- 
2.39.3

