Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82040273803;
	Fri,  6 Mar 2026 11:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772797033; cv=none; b=WnznXYkqZiFfN14pfehdRaYE1mFkoDGXwGxJAGcqslmmhKAVKrSdZZAVG4hZbIXnCUN8kw/qYAnB5GnhnpFJ02djlmu/OfgMUVeO2sL6EBo7X/1FSZo7fR80NSqb3Hrzsgj3l9ZTjHO+Acg2uINH/B3puMw7ERh6fzh7sxmb76g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772797033; c=relaxed/simple;
	bh=Df9OB5oe6ohlwZ85xlKDtKIBP1FN+uqlgAQMvF6PATc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ioBvsZB6dxiUrnCcp/In2cDsaFsFcsOoESdFr2sbZHlPKfHEvflUKjL6bP+58Rl6wdRrbAG3yYOYiA0aydjlnSpGzde4Px0McWsydv7sbBDmzlPHvwhKxpVyFyH68iZmFPwla/AOsmxE84apQVARSxjkzoMOgWl5UyEg4aod3cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jq60c3yu; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jq60c3yu"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 626ANJiL3160883;
	Fri, 6 Mar 2026 11:36:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=sesYn
	5KWRNM8yaUhRzmvWhK4jtnxZ0x5aVj0JZgJB/g=; b=jq60c3yutpUNZRq6s7tJy
	jT6pu0tlzdHtY6QC2XN3wKd4vKphniZPuT6BPOMrn+w1vSZgmmzgsdKn7IF8nJkC
	awZ1lhIYW2z9MsPnvhP2Le2aTDK7IZ7Z33e1Hab8LWo09+mLWqxHN0sG3R3TtFxw
	Mtw5FPdVoI0ptF+c8exfchWTXb+6TQZWnn3UPQJGDJEyz0YNbXs5I769WKNyfTTF
	Hy9CeMIjz+iV2Tww+7ybOJcFaOa2xdi/ZfJWlg3XKCc6Yx9oAX+YBH0fT/XonhVO
	1Dd0RunTD0gDn7SkOttJaUg5QE5q5zrdpkhb9QMZePaRfi5KLpJO0GG3fsjS5L9f
	w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cqw3xr27q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Mar 2026 11:36:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6269olQO023071;
	Fri, 6 Mar 2026 11:36:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ckptjtmtr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Mar 2026 11:36:45 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 626BaXEx025727;
	Fri, 6 Mar 2026 11:36:44 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-62-192.vpn.oracle.com [10.154.62.192])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4ckptjtmhd-5;
	Fri, 06 Mar 2026 11:36:44 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        mykyta.yatsenko5@gmail.com, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v13 bpf-next 4/8] libbpf: Add layout encoding support
Date: Fri,  6 Mar 2026 11:36:26 +0000
Message-ID: <20260306113630.1281527-5-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260306113630.1281527-1-alan.maguire@oracle.com>
References: <20260306113630.1281527-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_03,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 bulkscore=0 adultscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603060110
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDExMCBTYWx0ZWRfX/o2UtaMJHRu8
 uqg00vr2u70JjelSphb4UvV2he3/wpiSgFidWr9R1HFuhhDorpL0gg3kgGuZ42qQLWxfV7kyLXt
 voi/XjsWX/LKONoDmxVATsWDuv++xCVcQlaZbKWe+ZXvhnZ6G36U+BNIWa2OnSsa0SJoMgdhSjB
 2jtP2EuwpqysPObhEjNVJQqqCedpqmVOu4wDp1YvHD6sqb3TfjMG11CG6eFA+481olNvbm90fxE
 c9rpT4DReCO5LvprJ5rrBPDzouGCZH3xA39ro4U6FJ6iJaJrmZWZUZ3RKddOSpLuEGUSqgi6Fnj
 XLCsVNR5PNdfjWanqbK6IekDb0sbcmYKkRbpUj2jLtUa3yJYZfla4b/iaJOrfTkrrtYxuyPymtS
 2LGjAp52w2aFx/2vyxI7kEOxsRAzFGIZWzJSF65dSchZNTF/dyUDPmA2D316cMHj/15CzhzjFP6
 oExkbftl/06m9O/iRhJ9V/EpOHEoHJBcvVmWbSWQ=
X-Authority-Analysis: v=2.4 cv=d5T4CBjE c=1 sm=1 tr=0 ts=69aabc4d b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=yPCof4ZbAAAA:8 a=lIN0CykIrsTzq82mcFQA:9 cc=ntf
 awl=host:12267
X-Proofpoint-ORIG-GUID: DqtlhjrD1BN8ZGPC2LykTmx-4Sq4a2a_
X-Proofpoint-GUID: DqtlhjrD1BN8ZGPC2LykTmx-4Sq4a2a_

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

