Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18803408252;
	Tue, 24 Mar 2026 17:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774374338; cv=none; b=dNK/67KgXu6jv3PbAdLl5ThDR52q0Nhy4vn9dbn/yVYec84fI8FD7yBr8ox0cj2lcwHF5n+Aw7zLo8m3beSoWGTxYzZt789lPVH6/wKbXMydap/z+GefcsfzDQu9IQCHnd4zqFGId1E6nQPcIW+DIgmN3NBfxxL1OM3ADhY189o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774374338; c=relaxed/simple;
	bh=KUwE6lZvF9pr+QEdxKilmS6LDteTS5lAJQPI8eB4FwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aZfcjHp6Opx1HEaO+8NUwHbLfu6o5ie5i8s7x+sSaJUjXdFQA9W8CbVs9WxnqQ/ztnqG+GODH8CMs8TeoqBW5bIqmSRha73Tq0cA8fzbQ/Vzx63wIBqcbwO5OA8QdpX73kgFz7aCu20lA3rb/QiDDYv+p+NRveO/3rVNAJVntig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QYjAqodX; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QYjAqodX"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62OCGNPL614488;
	Tue, 24 Mar 2026 17:45:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=YNz1X
	WCkuUJIXzerD6gqRhur9bYRi0YFePBtb4J4r4U=; b=QYjAqodX9WOraOY+gGda2
	Xh1AdPw9H9uNnGjv83dHJOrDAFCol9Ug88jTPe3xAQwOVELuvqIHKMz/LTbyVx9Z
	4w05G+lzdJ/dEnXrKTjodxxlHgqO8x1nYTtaU7rFL/CWBv/hk4eXXE5qWZN5KFsL
	A7N+7FOfqxXmCaQdwYu/KHuLtId0sU8beMEnS4A97SuTjk01IsgeZw3rNciB43Ez
	1EaFJoQ1PLg+R+XH5zD2ZZS/m/PypWjV4Z+/KdSYCyrVErowIR7EIBaMaROJbOcT
	Yn5KrbjDG/uZMjdCbs/ji1rVc+IUwPUNnRRi3kXn8c8/BfaeWjiprWf6x7kl8fwz
	A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d1khf4rdg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 17:45:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62OGT9CI039146;
	Tue, 24 Mar 2026 17:45:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4d1hsac7dp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 17:45:07 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62OHirgu035539;
	Tue, 24 Mar 2026 17:45:06 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-54-179.vpn.oracle.com [10.154.54.179])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4d1hsac706-7;
	Tue, 24 Mar 2026 17:45:06 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
        qmo@kernel.org, ihor.solodrai@linux.dev, mykyta.yatsenko5@gmail.com,
        dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v15 bpf-next 6/9] libbpf: Support sanitization of BTF layout for older kernels
Date: Tue, 24 Mar 2026 17:44:47 +0000
Message-ID: <20260324174450.1570809-7-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260324174450.1570809-1-alan.maguire@oracle.com>
References: <20260324174450.1570809-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603240137
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDEzOCBTYWx0ZWRfXy1oX7hwpB3Ql
 RZVrH+azvWq6Qai/v9xFEogs92XscvcKLwzlVIcM8K7ZlXD6qeb+TgtOs69qn0hLghqi/u1Y5D2
 ZYqyC7+fg1Et+8l8gOPHz/UxqbxsJ0Q9fIpqbdSsxhHdQY51n9vryCf88QxwV/PAruNey/dWYxT
 lQCSBGt8gX19NU6CxFT8xhTbozHRhRHIB9ws9YbmXP1wKKBDSb2IPCPOXGGL2PvUjEDAMWAVmZ/
 sTBGPzv+rfor0Snkmg8+WIeKHZg1OGokc/w1RQjbvn8iEaiPmkJzs5sm5IQbMJxtZWsL0qPCB8B
 tr+RWyhd2ZaL60EF0FFpa7xS5cx/G7Ch52U5ux8p1mYbCW7m5N5CYmhTZES9NAL3umrGoO5ez2f
 dbViEut2n7lW7N9FjrFPoqGIb/zxhLybJQGqx6Cv1m8e6/G+jLFoJySQ51kHY6IidJRXsTyOOBu
 JWnhs0DY8jxJk0w8+MtrpgjHsRiJocjQ9UHbDvLE=
X-Authority-Analysis: v=2.4 cv=AIvfpCdw c=1 sm=1 tr=0 ts=69c2cda4 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=yPCof4ZbAAAA:8 a=Y2CjA1SVjdCJZ1e5LhoA:9 cc=ntf
 awl=host:13824
X-Proofpoint-ORIG-GUID: yHzP6C5evhK6F6HAO-VM_CCBWQrStKiw
X-Proofpoint-GUID: yHzP6C5evhK6F6HAO-VM_CCBWQrStKiw

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
 tools/lib/bpf/features.c        | 29 +++++++++++
 tools/lib/bpf/libbpf.c          | 88 +++++++++++++++++++++++++--------
 tools/lib/bpf/libbpf_internal.h |  6 +++
 tools/lib/bpf/libbpf_probes.c   | 40 +++++++++------
 4 files changed, 127 insertions(+), 36 deletions(-)

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
index 0662d72bad20..1877de0cff44 100644
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
@@ -3153,9 +3155,64 @@ static int bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *btf)
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
+	if (!raw_data)
+		return ERR_PTR(-ENOMEM);
+	/* btf_header() gives us endian-safe header info */
+	hdr = btf_header(orig_btf);
+
+	if (!has_layout && hdr->hdr_len >= sizeof(struct btf_header) &&
+	    (hdr->layout_len != 0 || hdr->layout_off != 0)) {
+		const struct btf_header *old_hdr = raw_data;
+		struct btf_header *new_hdr;
+		void *new_raw_data;
+		__u32 new_str_off;
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
+		new_str_off = hdr->type_off + hdr->type_len;
+		/* Handle swapped endian case */
+		if (old_hdr->str_off != hdr->str_off)
+			new_hdr->str_off = bswap_32(new_str_off);
+		else
+			new_hdr->str_off = new_str_off;
+
+		memmove(new_raw_data + hdr->hdr_len + new_hdr->str_off,
+			new_raw_data + hdr->hdr_len + hdr->str_off,
+			hdr->str_len);
+		sz = hdr->hdr_len + hdr->type_off + hdr->type_len + hdr->str_len;
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
@@ -3233,9 +3290,10 @@ static int bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *btf)
 
 			if (enum64_placeholder_id == 0) {
 				enum64_placeholder_id = btf__add_int(btf, "enum64_placeholder", 1, 0);
-				if (enum64_placeholder_id < 0)
-					return enum64_placeholder_id;
-
+				if (enum64_placeholder_id < 0) {
+					btf__free(btf);
+					return ERR_PTR(enum64_placeholder_id);
+				}
 				t = (struct btf_type *)btf__type_by_id(btf, i);
 			}
 
@@ -3249,7 +3307,7 @@ static int bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *btf)
 		}
 	}
 
-	return 0;
+	return btf;
 }
 
 static bool libbpf_needs_btf(const struct bpf_object *obj)
@@ -3600,21 +3658,9 @@ static int bpf_object__sanitize_and_load_btf(struct bpf_object *obj)
 
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
index bccf4bb747e1..b70d9637ecf5 100644
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
+	btf_len = hdr->hdr_len + hdr->type_off + hdr->type_len + hdr->str_len + hdr->layout_len;
 	raw_btf = malloc(btf_len);
 	if (!raw_btf)
 		return -ENOMEM;
 
-	memcpy(raw_btf, &hdr, sizeof(hdr));
-	memcpy(raw_btf + hdr.hdr_len, raw_types, hdr.type_len);
-	memcpy(raw_btf + hdr.hdr_len + hdr.type_len, str_sec, hdr.str_len);
+	memcpy(raw_btf, hdr, sizeof(*hdr));
+	memcpy(raw_btf + hdr->hdr_len + hdr->type_off, raw_types, hdr->type_len);
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

