Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFC63D7D79;
	Wed, 18 Mar 2026 13:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773840618; cv=none; b=l2XxVhiwokHFQtUbRU6R0MzuIODJ+8YWRUNUfRqT5roBKFR2xH+PRfGZlOCaEZmrwaOc8ShA6xQyfOp/k0GbPF7rtjd/HxbmRv4H/GqgMCTVmWIUFFAh0Esqo5YitkQV8+nbuxJycn+QglWO7T0+ivOJWu3WkKgRs6pDiueF5VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773840618; c=relaxed/simple;
	bh=U/qtKPC0ucXWGWIxxjbCxz7vv7tYsNk0eJoy+rLdfno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cR/DSthaknFB0qvWRkGkx+z1OEb6SWivvWf6Doi4eivLdlu51YYO8dpap1p10KNPE5WnhFywq7VlaM+drdvxuiykns4dTL20AjLnoy8cYPQWsFQJqzzL7cnm+kEwYTkx5o3COjM4+ED6vtDm4Yn0ZZ9tRdoXUtOsDLENlcCop3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BHy8nm2v; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BHy8nm2v"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62I2O4eH1777874;
	Wed, 18 Mar 2026 13:29:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=A6JA1
	FbnJ/EzUqbrlmiSkIUSD7tzK1e/8Ytwhlq5veQ=; b=BHy8nm2vDWWaTxMIRp2Wm
	1NACrDsfcnw9/GtaAYh4QMti09A9ystsnzz2EzfxZTauIi6kdxyZJg/oHiMi2cDb
	2HGb4ZVqrVot9scOl4c/vnsNL5aoMixk8His1ncZOkCwR/WWb+TJukQdyXaJd9bg
	FtDp9iRNQ9z6Z0UME78bFCJgrdJccNe74rUCFJPkHR/l2AgAMKDFrbpqusK0oVVP
	whiHvvLeyjgl9JLJZniW0gLyIHwr4QM1L3sjFgJ0kdG9dQYi3oi+V169RthE6NSx
	4Mxhn1JSXsZ5DROx6RnSTPL9V0+cdVbXcnk0HH+cDxkI4ZdJsBmCEyr4/NK0eE0+
	w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvxk8e41r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Mar 2026 13:29:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62ID9egu030485;
	Wed, 18 Mar 2026 13:29:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx4bmt3e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Mar 2026 13:29:48 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62IDTVfG009174;
	Wed, 18 Mar 2026 13:29:47 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-52-75.vpn.oracle.com [10.154.52.75])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4cvx4bmsqg-5;
	Wed, 18 Mar 2026 13:29:47 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        mykyta.yatsenko5@gmail.com, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v14 bpf-next 04/10] libbpf: Add layout encoding support
Date: Wed, 18 Mar 2026 13:29:21 +0000
Message-ID: <20260318132927.1142388-5-alan.maguire@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDExNCBTYWx0ZWRfX21ExONsuRP5h
 OYwv0V12IFsbBmiRNYA7Ahn++jcENkOg1c/iAn0E3uY3Fh1pyU5ZIMIjXbeH+zxE8kR/ituvw3J
 HOsAe6YI93vBjW53GLB8uM9+Rzy2pX0JZeyinXkPIDHGs7DggDNWeYx7xafKlUV7F5z4lNnLdHq
 OvzeGRM4qJ+/0B7ATBYp4BvhUtIsr2Hrd47iANpKDOLibTEAvzUG0uyIIGrW+sCAM6UOyL4+F9k
 x8HE+eaxueMWlKtLa1i9S4sbUoM6XC0QE+h+fsnrlSYicjdyeoFPMqU+bpruOmq8m6Ai3+fjy9/
 znLslVzJbCkVDI8rqZtaHtMxskUUEJmf6U0yCsT2eHgzenGvKoMtdywO6t+ehuJlRomXZNInlEf
 6TbOHm9sdUj66MgdN0ThND8/VCfxsWx6Wc90kjxGEzYoClUPoTG5tiGhfdPFM0rLVjCVYmITu1h
 0Nafd0UhPCEs4g7p1Mg==
X-Authority-Analysis: v=2.4 cv=AI0/m/Lt c=1 sm=1 tr=0 ts=69baa8cd b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=yPCof4ZbAAAA:8 a=lIN0CykIrsTzq82mcFQA:9
X-Proofpoint-GUID: rb42WPjQpWmUTP24cOnBA9tGpZgiqwY_
X-Proofpoint-ORIG-GUID: rb42WPjQpWmUTP24cOnBA9tGpZgiqwY_

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
index dcc3c4a54006..c033190f2ca4 100644
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
@@ -1160,8 +1190,10 @@ void btf__free(struct btf *btf)
 	free(btf);
 }
 
-static struct btf *btf_new_empty(struct btf *base_btf)
+static struct btf *btf_new_empty(struct btf_new_opts *opts)
 {
+	bool add_layout = OPTS_GET(opts, add_layout, false);
+	struct btf *base_btf = OPTS_GET(opts, base_btf, NULL);
 	struct btf_header *hdr;
 	struct btf *btf;
 
@@ -1186,6 +1218,8 @@ static struct btf *btf_new_empty(struct btf *base_btf)
 
 	/* +1 for empty string at offset 0 */
 	btf->raw_size = sizeof(struct btf_header) + (base_btf ? 0 : 1);
+	if (add_layout)
+		btf->raw_size += sizeof(layouts);
 	btf->raw_data = calloc(1, btf->raw_size);
 	if (!btf->raw_data) {
 		free(btf);
@@ -1200,6 +1234,15 @@ static struct btf *btf_new_empty(struct btf *base_btf)
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
@@ -1212,7 +1255,19 @@ struct btf *btf__new_empty(void)
 
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
index 3526c937bdbe..c4ef8c865a1d 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -457,4 +457,5 @@ LIBBPF_1.7.0 {
 } LIBBPF_1.6.0;
 
 LIBBPF_1.8.0 {
+		btf__new_empty_opts;
 } LIBBPF_1.7.0;
-- 
2.39.3

