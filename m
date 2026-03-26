Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669E938759E;
	Thu, 26 Mar 2026 14:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774536924; cv=none; b=iShCugFDmikYKRnk64grDD4ngy8rn22egwJXI7vF1Vh01EVAhXWCKN+RwizGqVT16qw55EDhr0rCy0bzMn9SjyKS5UWhMBMr+rzaRkpGdrT8+f/JpkPeZs+TMRoJWjd8pxROwuyUETCeO2sySxYsejw9+8CF8lGtp7ZLq2d0z70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774536924; c=relaxed/simple;
	bh=KVyr8D1nFLppMQAYkSu9+jarxoetlaoelcBq9LoJfGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bx85px774iKhjajBhLwURW3VF3soWlrA2/b4wY2+0bP8YrusGTKilq56wSYtPjHo31BXmt+RPlmq2OUQA/it76HJDW4ICNwo2zvaafmeI7flDrF604sKC4jbS0Vbvmv0fzMjlf53Zh/ETnOKPEElDrPV7cVXdH1u6LH7CapZkxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=F/JYMhL5; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="F/JYMhL5"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62Q7KhUE3351927;
	Thu, 26 Mar 2026 14:55:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=Aw4jS
	llb1kmEckdhExLmXs7epYX05ronTsqNm02z4y4=; b=F/JYMhL5+ISSHLLSJZ86e
	yUoZsHkdUK9su36x2MXObYPCr+GyQQCtp7X+1FjCFfFEzNZ2PdFJyJnrQC6h2B+/
	zheY3RvXPZR4dsmcNZAWYWAuCCrakTNgyM+etj871YKnvARXvIPhWyFPjetnzK4P
	eH3NRMb/91CYcLa2RSL5xVw3JpABuNqaz9kRJdxFfRUn9FwxWIgXhtzpxTBdUfXU
	Y0MssJQM76CwRR8+hFS2UbnFXH5zFRIQmOrp7eGmgbIgRoDP4z1TG0FZz54ANmWc
	zWjCAhCZBSFFhYl0jfuoacVYsSzH8AXFC2uU5ouj9tzCrC2MM2qVdccxoIF2FCtb
	Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d1kejraa4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Mar 2026 14:55:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62QDVCaj000628;
	Thu, 26 Mar 2026 14:55:01 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4d1hsd23ex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Mar 2026 14:55:01 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62QEslTB015958;
	Thu, 26 Mar 2026 14:55:01 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-54-22.vpn.oracle.com [10.154.54.22])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4d1hsd235q-5;
	Thu, 26 Mar 2026 14:55:00 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
        qmo@kernel.org, ihor.solodrai@linux.dev, mykyta.yatsenko5@gmail.com,
        dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v16 bpf-next 4/9] libbpf: Add layout encoding support
Date: Thu, 26 Mar 2026 14:54:39 +0000
Message-ID: <20260326145444.2076244-5-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260326145444.2076244-1-alan.maguire@oracle.com>
References: <20260326145444.2076244-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603260105
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDEwNSBTYWx0ZWRfX5IG8zsVv+2Tp
 LGRqIzmh0IFKo5a7LJH7aaT+2eQz5oxWiZQrs6LNHL1dDS5ldycTJtD4ruy/w1wyhvFtjl+QrKK
 Ls3MjdZcNxxlCi6uIQf0RQXAzyxxW8o4V6qcPUTFdXpnqPrQOIVTVkPUN4hw9pGxTzk3ETWcI6y
 PnwINIgD9bd5+nVI5ZcPKPm9MUb+Hdl5AINuA4xs8ld3BiLVG4YiXLembw1edoEgsWmCq2cZCSg
 9xx3h9Q5+p1w04fQ3Q35YrxO3WBaDiheYjd4HDTp/tSry14CUHxFSjQJD/duqlJHVVsjtxhHW6Z
 iH/VdVcYgUtejnw3vLVgXezILjP3wubGCRVk3VMjeYv56NehOlkk2VTLjIuZ1O0j6YSXSjH5NBe
 BA+Ing8u8tPv2kEf0MHDSSpdhGvXBtN5OhHk0J7Ufh47cVmWQqSwJWHHRjQD4IOLQcRl6M/UCMX
 +4IIXhlP4oHri/LLeKA==
X-Authority-Analysis: v=2.4 cv=GZAaXAXL c=1 sm=1 tr=0 ts=69c548c6 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=yPCof4ZbAAAA:8 a=lIN0CykIrsTzq82mcFQA:9
X-Proofpoint-ORIG-GUID: huzhkejPXz1U58TsoUytrSjRSKwdvOeG
X-Proofpoint-GUID: huzhkejPXz1U58TsoUytrSjRSKwdvOeG

Support encoding of BTF layout data via btf__new_empty_opts().

Current supported opts are base_btf and add_layout.

Layout information is maintained in btf.c in the layouts[] array;
when BTF is created with the add_layout option it represents the
current view of supported BTF kinds.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/btf.c      | 63 ++++++++++++++++++++++++++++++++++++++--
 tools/lib/bpf/btf.h      | 20 +++++++++++++
 tools/lib/bpf/libbpf.map |  2 ++
 3 files changed, 83 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 291691171ca7..35b7fb85e1bb 100644
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
@@ -1179,8 +1209,10 @@ void btf__free(struct btf *btf)
 	free(btf);
 }
 
-static struct btf *btf_new_empty(struct btf *base_btf)
+static struct btf *btf_new_empty(struct btf_new_opts *opts)
 {
+	bool add_layout = OPTS_GET(opts, add_layout, false);
+	struct btf *base_btf = OPTS_GET(opts, base_btf, NULL);
 	struct btf_header *hdr;
 	struct btf *btf;
 
@@ -1205,6 +1237,8 @@ static struct btf *btf_new_empty(struct btf *base_btf)
 
 	/* +1 for empty string at offset 0 */
 	btf->raw_size = sizeof(struct btf_header) + (base_btf ? 0 : 1);
+	if (add_layout)
+		btf->raw_size += sizeof(layouts);
 	btf->raw_data = calloc(1, btf->raw_size);
 	if (!btf->raw_data) {
 		free(btf);
@@ -1219,6 +1253,19 @@ static struct btf *btf_new_empty(struct btf *base_btf)
 	btf->types_data = btf->raw_data + hdr->hdr_len;
 	btf->strs_data = btf->raw_data + hdr->hdr_len;
 	hdr->str_len = base_btf ? 0 : 1; /* empty string at offset 0 */
+
+	if (add_layout) {
+		hdr->layout_len = sizeof(layouts);
+		btf->layout = layouts;
+		/*
+		 * No need to swap endianness here as btf_get_raw_data()
+		 * will do this for us if btf->swapped_endian is true.
+		 */
+		memcpy(btf->raw_data + hdr->hdr_len, layouts, sizeof(layouts));
+		btf->strs_data += sizeof(layouts);
+		hdr->str_off += sizeof(layouts);
+	}
+
 	memcpy(&btf->hdr, hdr, sizeof(*hdr));
 
 	return btf;
@@ -1231,7 +1278,19 @@ struct btf *btf__new_empty(void)
 
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
index 5828040f178a..346fd346666b 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -458,4 +458,6 @@ LIBBPF_1.7.0 {
 } LIBBPF_1.6.0;
 
 LIBBPF_1.8.0 {
+	global:
+		btf__new_empty_opts;
 } LIBBPF_1.7.0;
-- 
2.39.3

