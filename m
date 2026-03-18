Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1A233C18B;
	Wed, 18 Mar 2026 13:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773840639; cv=none; b=UHVxQenR3JM9qUgVoniDGXRU0zNPU7BvuyWMxcHloefUIcfQVMe2bvE1yk2NdO6Lf66rWlEZhgi5JehP+Fo+kHn594HIHhaTc+wtHeBUWqefrMhwHJCFRMPaTU+urBTKU28bne1vrJo7v4wyEUoSd1A6M6YZ0raMNx+l+R1pTe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773840639; c=relaxed/simple;
	bh=gQn9OWw89KWgNzTFK65hQtKuUBhksmbnaiKm9kiyB9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gfit6DMYtDXesxX0/cvFakdxPFpKtohru0bFIXBiA6dDh2N8xwS0AfMjU40xfq4lINysQ3MzuS8m+7FaJk95SagrAGI7N/FUTqOv6Kte/323K+7NxjVBdrKPX2K3aAIPWWHIILzUZuM/rvu/pILHL8yh55N/iijAOCJYAXkxXYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=atKfnVmS; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="atKfnVmS"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62I2O6KU1712268;
	Wed, 18 Mar 2026 13:29:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=0fZWH
	0MWJkeM+sDXWWMrqrt0C8s5zfZZlQO160amoD4=; b=atKfnVmSJdMRcK5pZJtSE
	Sad6Rg044qFtBcw1tIv5L6MVv+1w1nPQ6Gz6CjgO3OB5DeM76txl7XsFqH6UZtd0
	JDd4Ox6QnnqiTuWRIE3u2OyR+GfcCE06I1fpPPTDIMacixsiJOcDK2C1Us+KMZu1
	2/3VJ8X1kgB2kziejgkgDVGJFKXBXVVgoOWmWIH57tjpBdR6eiBq+Z1oF4e8xlTV
	VydfBTbeLIFMr2NeOn21I5v2DEe1ItLIh9yF3B1djycjbqCoXG+UeYV0oIn90Nj6
	L3E9SeITP9k1BlX5YZxicDvDXJP4wsuDCQ9qTJR3tH+bYqRbZxGBvFaXJc1RgJvj
	Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvyj661gt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Mar 2026 13:29:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62ICG9AS030548;
	Wed, 18 Mar 2026 13:29:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx4bmt6v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Mar 2026 13:29:55 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62IDTVfK009174;
	Wed, 18 Mar 2026 13:29:55 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-52-75.vpn.oracle.com [10.154.52.75])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4cvx4bmsqg-7;
	Wed, 18 Mar 2026 13:29:54 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        mykyta.yatsenko5@gmail.com, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v14 bpf-next 06/10] libbpf: Support sanitization of BTF layout for older kernels
Date: Wed, 18 Mar 2026 13:29:23 +0000
Message-ID: <20260318132927.1142388-7-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260318132927.1142388-1-alan.maguire@oracle.com>
References: <20260318132927.1142388-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603180114
X-Authority-Analysis: v=2.4 cv=LKFrgZW9 c=1 sm=1 tr=0 ts=69baa8d4 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=yPCof4ZbAAAA:8 a=b5GEs-_ypN0-ckuM7n8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDExMyBTYWx0ZWRfX4Zd7mt4zv3nk
 EKy5RCFIK1wDSqFlDPpgFCTSBl05cwA7xF7Kx1mKMIlMaVD4zOwbO8mNJZfhCfpVsDTTLVqgAdw
 wNZmalIHOEdRO2jk1vnpMq4wLr5vOrFbhUU+WU4nh2hnL1SO27mQ5mA5SpciK5TwxvCr2/d0yvC
 pDrpfl9dRy4h2YTdK5dfrlLla4CdA+cN1ky5ZopjYatSwANR82/kGUeZruC5N5SbDt2ei8khZLT
 cZSLdKNa05C6cRgsdtdHQtcZ3KH2k0PNYZNO2RRJRXIcXowMgRBu5TGtp3jh5UyvhZ4MYLXwYJE
 HyqoqPEazRzdux8DRRJukwHDS0+LC/7LbG2QGGphEKf3eNmVXREVLpNjonS1vWbWHuIn+iChIeD
 m5gc8HaexaTuk1oi0ESCohzPXrgXtNpJ2HO6LaAgsqZgZXZAYdjdxwlPj+m+9loETg9jx85ebck
 qdOOZ5BEUtbys6nqPZg==
X-Proofpoint-GUID: 74w5D2jLp9khOa0_JF3Y6EvOXoOJjS-N
X-Proofpoint-ORIG-GUID: 74w5D2jLp9khOa0_JF3Y6EvOXoOJjS-N

Add a FEAT_BTF_LAYOUT feature check which checks if the
kernel supports BTF layout information.  Also sanitize
BTF if it contains layout data but the kernel does not
support it.  The sanitization requires rewriting raw
BTF data to update the header and eliminate the layout
section (since it lies between the types and strings),
so refactor sanitization to do the raw BTF retrieval
and creation of updated BTF, returning that new BTF
on success.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/features.c        | 29 +++++++++++++
 tools/lib/bpf/libbpf.c          | 74 ++++++++++++++++++++++++---------
 tools/lib/bpf/libbpf_internal.h |  6 +++
 tools/lib/bpf/libbpf_probes.c   | 40 +++++++++++-------
 4 files changed, 115 insertions(+), 34 deletions(-)

diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
index adcad221c601..4f19a0d79b0c 100644
--- a/tools/lib/bpf/features.c
+++ b/tools/lib/bpf/features.c
@@ -589,6 +589,32 @@ static int probe_uprobe_syscall(int token_fd)
 }
 #endif
 
+static int probe_kern_btf_layout(int token_fd)
+{
+	static const char strs[] = "\0int";
+	__u32 types[] = {
+		/* int */
+		BTF_TYPE_INT_ENC(1, BTF_INT_SIGNED, 0, 32, 4),
+	};
+	struct btf_layout layout[] = {
+		{ 0,			0,	0 },
+		{ sizeof(__u32),	0,	0 },
+	};
+	struct btf_header hdr = {
+		.magic = BTF_MAGIC,
+		.version = BTF_VERSION,
+		.hdr_len = sizeof(struct btf_header),
+		.type_len = sizeof(types),
+		.str_off = sizeof(types) + sizeof(layout),
+		.str_len = sizeof(strs),
+		.layout_off = sizeof(types),
+		.layout_len = sizeof(layout),
+	};
+
+	return probe_fd(libbpf__load_raw_btf_hdr(&hdr, (char *)types, strs,
+						 (char *)layout, token_fd));
+}
+
 typedef int (*feature_probe_fn)(int /* token_fd */);
 
 static struct kern_feature_cache feature_cache;
@@ -670,6 +696,9 @@ static struct kern_feature_desc {
 	[FEAT_UPROBE_SYSCALL] = {
 		"kernel supports uprobe syscall", probe_uprobe_syscall,
 	},
+	[FEAT_BTF_LAYOUT] = {
+		"kernel supports BTF layout", probe_kern_btf_layout,
+	},
 };
 
 bool feat_supported(struct kern_feature_cache *cache, enum kern_feature_id feat_id)
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 0662d72bad20..5d392fff76bd 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -3138,12 +3138,14 @@ static bool btf_needs_sanitization(struct bpf_object *obj)
 	bool has_type_tag = kernel_supports(obj, FEAT_BTF_TYPE_TAG);
 	bool has_enum64 = kernel_supports(obj, FEAT_BTF_ENUM64);
 	bool has_qmark_datasec = kernel_supports(obj, FEAT_BTF_QMARK_DATASEC);
+	bool has_layout = kernel_supports(obj, FEAT_BTF_LAYOUT);
 
 	return !has_func || !has_datasec || !has_func_global || !has_float ||
-	       !has_decl_tag || !has_type_tag || !has_enum64 || !has_qmark_datasec;
+	       !has_decl_tag || !has_type_tag || !has_enum64 || !has_qmark_datasec ||
+	       !has_layout;
 }
 
-static int bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *btf)
+static struct btf *bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *orig_btf)
 {
 	bool has_func_global = kernel_supports(obj, FEAT_BTF_GLOBAL_FUNC);
 	bool has_datasec = kernel_supports(obj, FEAT_BTF_DATASEC);
@@ -3153,9 +3155,55 @@ static int bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *btf)
 	bool has_type_tag = kernel_supports(obj, FEAT_BTF_TYPE_TAG);
 	bool has_enum64 = kernel_supports(obj, FEAT_BTF_ENUM64);
 	bool has_qmark_datasec = kernel_supports(obj, FEAT_BTF_QMARK_DATASEC);
+	bool has_layout = kernel_supports(obj, FEAT_BTF_LAYOUT);
 	int enum64_placeholder_id = 0;
+	const struct btf_header *hdr;
+	struct btf *btf = NULL;
+	const void *raw_data;
 	struct btf_type *t;
 	int i, j, vlen;
+	__u32 sz;
+	int err;
+
+	/* clone BTF to sanitize a copy and leave the original intact */
+	raw_data = btf__raw_data(orig_btf, &sz);
+	hdr = raw_data;
+
+	if (!has_layout && hdr->hdr_len >= sizeof(struct btf_header) &&
+	    (hdr->layout_len != 0 || hdr->layout_off != 0)) {
+		struct btf_header *new_hdr;
+		void *new_raw_data;
+
+		/*
+		 * Need to rewrite BTF to exclude layout information and
+		 * move string section to immediately after types.
+		 */
+		new_raw_data = malloc(sz);
+		if (!new_raw_data)
+			return ERR_PTR(-ENOMEM);
+
+		memcpy(new_raw_data, raw_data, sz);
+		new_hdr = new_raw_data;
+		new_hdr->layout_off = 0;
+		new_hdr->layout_len = 0;
+		new_hdr->str_off = hdr->type_off + hdr->type_len;
+
+		memmove(new_raw_data + hdr->hdr_len + new_hdr->str_off,
+			new_raw_data + hdr->hdr_len + hdr->str_off,
+			hdr->str_len);
+		sz = hdr->hdr_len + hdr->type_len + hdr->str_len;
+
+		btf = btf__new(new_raw_data, sz);
+		free(new_raw_data);
+	} else {
+		btf = btf__new(raw_data, sz);
+	}
+	err = libbpf_get_error(btf);
+	if (err)
+		return ERR_PTR(err);
+
+	/* enforce 8-byte pointers for BPF-targeted BTFs */
+	btf__set_pointer_size(btf, 8);
 
 	for (i = 1; i < btf__type_cnt(btf); i++) {
 		t = (struct btf_type *)btf__type_by_id(btf, i);
@@ -3234,7 +3282,7 @@ static int bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *btf)
 			if (enum64_placeholder_id == 0) {
 				enum64_placeholder_id = btf__add_int(btf, "enum64_placeholder", 1, 0);
 				if (enum64_placeholder_id < 0)
-					return enum64_placeholder_id;
+					return ERR_PTR(enum64_placeholder_id);
 
 				t = (struct btf_type *)btf__type_by_id(btf, i);
 			}
@@ -3249,7 +3297,7 @@ static int bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *btf)
 		}
 	}
 
-	return 0;
+	return btf;
 }
 
 static bool libbpf_needs_btf(const struct bpf_object *obj)
@@ -3600,21 +3648,9 @@ static int bpf_object__sanitize_and_load_btf(struct bpf_object *obj)
 
 	sanitize = btf_needs_sanitization(obj);
 	if (sanitize) {
-		const void *raw_data;
-		__u32 sz;
-
-		/* clone BTF to sanitize a copy and leave the original intact */
-		raw_data = btf__raw_data(obj->btf, &sz);
-		kern_btf = btf__new(raw_data, sz);
-		err = libbpf_get_error(kern_btf);
-		if (err)
-			return err;
-
-		/* enforce 8-byte pointers for BPF-targeted BTFs */
-		btf__set_pointer_size(obj->btf, 8);
-		err = bpf_object__sanitize_btf(obj, kern_btf);
-		if (err)
-			return err;
+		kern_btf = bpf_object__sanitize_btf(obj, obj->btf);
+		if (IS_ERR(kern_btf))
+			return PTR_ERR(kern_btf);
 	}
 
 	if (obj->gen_loader) {
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 4bcb6ca69bb1..cabdaef79098 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -396,6 +396,8 @@ enum kern_feature_id {
 	FEAT_LDIMM64_FULL_RANGE_OFF,
 	/* Kernel supports uprobe syscall */
 	FEAT_UPROBE_SYSCALL,
+	/* Kernel supports BTF layout information */
+	FEAT_BTF_LAYOUT,
 	__FEAT_CNT,
 };
 
@@ -422,6 +424,10 @@ int parse_cpu_mask_file(const char *fcpu, bool **mask, int *mask_sz);
 int libbpf__load_raw_btf(const char *raw_types, size_t types_len,
 			 const char *str_sec, size_t str_len,
 			 int token_fd);
+int libbpf__load_raw_btf_hdr(const struct btf_header *hdr,
+			     const char *raw_types, const char *str_sec,
+			     const char *layout_sec, int token_fd);
+
 int btf_load_into_kernel(struct btf *btf,
 			 char *log_buf, size_t log_sz, __u32 log_level,
 			 int token_fd);
diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index bccf4bb747e1..bec25fe81402 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -218,18 +218,10 @@ int libbpf_probe_bpf_prog_type(enum bpf_prog_type prog_type, const void *opts)
 	return libbpf_err(ret);
 }
 
-int libbpf__load_raw_btf(const char *raw_types, size_t types_len,
-			 const char *str_sec, size_t str_len,
-			 int token_fd)
+int libbpf__load_raw_btf_hdr(const struct btf_header *hdr, const char *raw_types,
+			     const char *str_sec, const char *layout_sec,
+			     int token_fd)
 {
-	struct btf_header hdr = {
-		.magic = BTF_MAGIC,
-		.version = BTF_VERSION,
-		.hdr_len = sizeof(struct btf_header),
-		.type_len = types_len,
-		.str_off = types_len,
-		.str_len = str_len,
-	};
 	LIBBPF_OPTS(bpf_btf_load_opts, opts,
 		.token_fd = token_fd,
 		.btf_flags = token_fd ? BPF_F_TOKEN_FD : 0,
@@ -237,14 +229,16 @@ int libbpf__load_raw_btf(const char *raw_types, size_t types_len,
 	int btf_fd, btf_len;
 	__u8 *raw_btf;
 
-	btf_len = hdr.hdr_len + hdr.type_len + hdr.str_len;
+	btf_len = hdr->hdr_len + hdr->type_len + hdr->str_len + hdr->layout_len;
 	raw_btf = malloc(btf_len);
 	if (!raw_btf)
 		return -ENOMEM;
 
-	memcpy(raw_btf, &hdr, sizeof(hdr));
-	memcpy(raw_btf + hdr.hdr_len, raw_types, hdr.type_len);
-	memcpy(raw_btf + hdr.hdr_len + hdr.type_len, str_sec, hdr.str_len);
+	memcpy(raw_btf, hdr, sizeof(*hdr));
+	memcpy(raw_btf + hdr->hdr_len, raw_types, hdr->type_len);
+	memcpy(raw_btf + hdr->hdr_len + hdr->str_off, str_sec, hdr->str_len);
+	if (layout_sec)
+		memcpy(raw_btf + hdr->hdr_len + hdr->layout_off, layout_sec, hdr->layout_len);
 
 	btf_fd = bpf_btf_load(raw_btf, btf_len, &opts);
 
@@ -252,6 +246,22 @@ int libbpf__load_raw_btf(const char *raw_types, size_t types_len,
 	return btf_fd;
 }
 
+int libbpf__load_raw_btf(const char *raw_types, size_t types_len,
+			 const char *str_sec, size_t str_len,
+			 int token_fd)
+{
+	struct btf_header hdr = {
+		.magic = BTF_MAGIC,
+		.version = BTF_VERSION,
+		.hdr_len = sizeof(struct btf_header),
+		.type_len = types_len,
+		.str_off = types_len,
+		.str_len = str_len,
+	};
+
+	return libbpf__load_raw_btf_hdr(&hdr, raw_types, str_sec, NULL, token_fd);
+}
+
 static int load_local_storage_btf(void)
 {
 	const char strs[] = "\0bpf_spin_lock\0val\0cnt\0l";
-- 
2.39.3

