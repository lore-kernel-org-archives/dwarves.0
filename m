Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EF2396B74;
	Thu, 26 Feb 2026 08:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772096238; cv=none; b=Rf3EZUdgkRF47ptDmVlBtuzC0W3qzFtvmbGFKkVguTIpWGJ+McHXPxTcp+2VVD55ekdT3WoBZxXA/OzuuIvKeLgbDAs8ykfUWOTUl4cLk/Cj4tQGJP26omUfeb5u/RZLbbviOL4hGPtaO03BgeClxbu0QbfnWY6s12JF4AyOiFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772096238; c=relaxed/simple;
	bh=ruIAhJcFOKsvJQlo8O9jSDbRF4/KQknOGZFNNZGfJh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bCLK/80cb7mw7uMU65dAPecMHHzcEAkkN7kta0Akymmnn0yepQVXLNBoh/4Azo1QedyXtoHbEgIVe5Le16VAQZq1VzQ5LHCKbTUbu62xv0KJMNENwxCdHMyqGgz/R44Y8wthaI/DXPIHkAi+eI0mRDTUy1ZZRfdx1AIOoF+U2Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lj9Fb3/k; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lj9Fb3/k"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PNwEBm3278372;
	Thu, 26 Feb 2026 08:56:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=grl5u
	oa0LlBdF+pPSZwVlmo7RUjDySv7GEs3d8Dock0=; b=lj9Fb3/kdpEH3D1OOPA3X
	m5DNCFrq9DH/iU2XZIXRrNmhkt2kOo0bN/ncrmrdg9J656aRUYTfenrh27KleTi+
	gFoC3rwXec46mS5SOGx7D0YLV0IrrGOklJgn3++ljEsWTcVaaTUEQytDwLZgzVtD
	iU8HABMuP5c48iCOY5si4pHybNbfmRf8LQ6hUk0Iw/X8YEI7m6oxT7l5IXW2KCpS
	zgG1BteBXDDL2caZaH2eHO00z2S51ZhIkFueJ3nSniXTcytzKgaE8RK1d4moo0Q2
	TzxcTF9MFiZmD6hPJ4EP5CWnrkicOeOt1YspLILbyXrEKIJh3zg2yZ1ewniny4b2
	g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cf4k5yten-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Feb 2026 08:56:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61Q75C34028534;
	Thu, 26 Feb 2026 08:56:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cf35c75f2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Feb 2026 08:56:50 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 61Q8uYaY038952;
	Thu, 26 Feb 2026 08:56:49 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-58-146.vpn.oracle.com [10.154.58.146])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4cf35c759a-5;
	Thu, 26 Feb 2026 08:56:49 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        mykyta.yatsenko5@gmail.com, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v9 bpf-next 04/10] libbpf: Add layout encoding support
Date: Thu, 26 Feb 2026 08:56:18 +0000
Message-ID: <20260226085624.1909682-5-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260226085624.1909682-1-alan.maguire@oracle.com>
References: <20260226085624.1909682-1-alan.maguire@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602260079
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDA3OSBTYWx0ZWRfX10J7gf7vB+uL
 oXTItfkotCgY+1WSCCoeN7Rlan71DGuq+iSOfcH1ynl9SbrQ10yCxQaDGbXOY19MxguAyweQuIB
 BFPnD+b1Mtqyj/8LBmFEQ7YYFpXUZpbJVIEK/fewpD2BB5NMUPrxH6mV3twhDgyTPHnE/gvQnbT
 OnjyoAsRa0hYMF0vk5JEQlFR3Auc8lBFDbp3oi0JBOnuiP0IuknD2uKOQ8bOzq9Ng2YlY4gcyC/
 EAKxlgMj4RSQpK3p8D4X9/3YGw1QHD3YGimnn6dsjqCPgdAnhvZrhvVuu6w6rn0QJkCcg58cYk7
 syaXb0CFPrnEJJhs4r+nii7+5Q3rMImWYZTTKLisM+Te7dzHB1KhVDvAcX3VQ/HnXoobUcHuV3d
 1LJmJvpIZhXlHJY91M2+Bd7pbHvHFETv+2z8PNqQwpCfdEvwKAxeLsGaAXIkMmlwEZVQStfDjiv
 h+d+PyCq24uLsXsI9+A==
X-Proofpoint-GUID: oJD0op3blciNZh__ni5fd3G1bxR7OsCi
X-Authority-Analysis: v=2.4 cv=b9C/I9Gx c=1 sm=1 tr=0 ts=69a00ad2 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=yPCof4ZbAAAA:8 a=lIN0CykIrsTzq82mcFQA:9
X-Proofpoint-ORIG-GUID: oJD0op3blciNZh__ni5fd3G1bxR7OsCi

Support encoding of BTF layout data via btf__new_empty_opts().

Current supported opts are base_btf and add_layout.

Layout information is maintained in btf.c in the layouts[] array;
when BTF is created with the add_layout option in represents the
current view of supported BTF kinds.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/btf.c      | 62 ++++++++++++++++++++++++++++++++++++++--
 tools/lib/bpf/btf.h      | 20 +++++++++++++
 tools/lib/bpf/libbpf.map |  1 +
 3 files changed, 80 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index c0603a8f8533..348dd5047556 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -29,6 +29,35 @@
 
 static struct btf_type btf_void;
 
+/* Describe how kinds are laid out; some have a singular element following the "struct btf_type",
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
@@ -1142,8 +1171,10 @@ void btf__free(struct btf *btf)
 	free(btf);
 }
 
-static struct btf *btf_new_empty(struct btf *base_btf)
+static struct btf *btf_new_empty(struct btf_new_opts *opts)
 {
+	bool add_layout = OPTS_GET(opts, add_layout, false);
+	struct btf *base_btf = OPTS_GET(opts, base_btf, NULL);
 	struct btf_header *hdr;
 	struct btf *btf;
 
@@ -1168,6 +1199,8 @@ static struct btf *btf_new_empty(struct btf *base_btf)
 
 	/* +1 for empty string at offset 0 */
 	btf->raw_size = sizeof(struct btf_header) + (base_btf ? 0 : 1);
+	if (add_layout)
+		btf->raw_size += sizeof(layouts);
 	btf->raw_data = calloc(1, btf->raw_size);
 	if (!btf->raw_data) {
 		free(btf);
@@ -1182,6 +1215,15 @@ static struct btf *btf_new_empty(struct btf *base_btf)
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
@@ -1189,12 +1231,26 @@ static struct btf *btf_new_empty(struct btf *base_btf)
 
 struct btf *btf__new_empty(void)
 {
-	return libbpf_ptr(btf_new_empty(NULL));
+	LIBBPF_OPTS(btf_new_opts, opts);
+
+	return libbpf_ptr(btf_new_empty(&opts));
 }
 
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

