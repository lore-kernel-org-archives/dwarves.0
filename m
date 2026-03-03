Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80AF3CA484;
	Tue,  3 Mar 2026 18:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772562110; cv=none; b=gRCgnLKWxXLZKkwr3litYTZqbcR5a6uhuc1Ry9v7yoRwu92JpEZDoH35wxCaRJzWRZz5s4AILfq/N3QzxYhU8ZTfpHy2ArlyS6nVdNEnldNjpRaUZ+GlNOOAomsLuh3qI6ROnpZljiYULiyClk84XflYMnE2zXrEQekGIPYe+hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772562110; c=relaxed/simple;
	bh=bZ7u6stjooz7LjcGTlYrI9t1AsrH1YmqSnR1OrpQcxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XpEhyg5TVBRIiFifjYq5m6PRJ3IPNlkvlAuI9to30EyoHRXZBKoeMEUO/qDUwCA/F8dcnL1H5H1zsb5zLz5NjsSl/Ru6qjyPwPup6b3SF60o+FJKbptpsRDbtCPt1sHTWrxhIPZaS7OIOrP+eZuBtloYvrtYUi/R5SGqSZBYjZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XAC3w3X3; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XAC3w3X3"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 623HmFA8929436;
	Tue, 3 Mar 2026 18:20:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=72tnr
	q95ArychlanWJ+hJeBZGbwnglPduvYv9Ld9PPs=; b=XAC3w3X36MOw4DpcJMozI
	0Jr4Ha2lSClzwYvYPbVX0qniT/BwLKhcc8Qp3KYKGCEAC0+5MsBE/WXr65q+KWYp
	jb3UQd0slWOVA6f0Asb0YWlYfbeZ8ZZVZsD2VN73T7s/Mm7BEP2F5tJ9nEjhDJDb
	w4JIKh62jSGL5Bkc3ZGz9kISILxcjS/nRTbPTrSRgU/CHMXvXqzUqfOpBkcO5YrA
	4a0hUDA2BW3AguUSRkjJwvXC4LIpsoIpbogq13ILNqhCEA77Y84HkoD7f4Z8bXu9
	CahT5Xw5o3dDmBYK5bAVfr2RsHSOjFWVOWTqY+lm32qdwiVOy0rpy4GsF+iLnYqb
	g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cp4c381tu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Mar 2026 18:20:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 623HWZdT037723;
	Tue, 3 Mar 2026 18:20:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ckpteyykc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Mar 2026 18:20:27 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 623IK7oH029269;
	Tue, 3 Mar 2026 18:20:26 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-62-133.vpn.oracle.com [10.154.62.133])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4ckpteyxu6-8;
	Tue, 03 Mar 2026 18:20:26 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        mykyta.yatsenko5@gmail.com, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v12 bpf-next 7/8] selftests/bpf: test kind encoding/decoding
Date: Tue,  3 Mar 2026 18:20:02 +0000
Message-ID: <20260303182003.117483-8-alan.maguire@oracle.com>
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
X-Proofpoint-GUID: d_1UiYyixLWWuZUHNJTC-UgR3gnFrWn9
X-Authority-Analysis: v=2.4 cv=VZH6/Vp9 c=1 sm=1 tr=0 ts=69a7266b b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=yPCof4ZbAAAA:8 a=P5AOqOs47VSxRN55gpgA:9 cc=ntf
 awl=host:13812
X-Proofpoint-ORIG-GUID: d_1UiYyixLWWuZUHNJTC-UgR3gnFrWn9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDE0OCBTYWx0ZWRfX65vM90bx0pd8
 jGEJv5AajrqnKWHqyfz4k1pKwSliNwdm8TVVloeCaKQmLKav2DTJLJFVhO+to0XhZyELReU8W5M
 wAyhyFyGnbpLfla/qXk4jrhCu2VaLhsGhxzZrF3oKY9G1YtSO1mpLlAZaXUvs4OWOog893qEb0F
 Mmh66zyaAgGFqAPmLZc7nSUPqCbTiEC4BGVgtfpok0UkKIjVBUs5gZ5Xlnjp9IcT6+2tO9cD4Pf
 UyQvmPTsfSKlYIMTlYm0NEl6pN2ZzzhcPOyZWlMwG/JMD6nphoMAkpUhxJNLd6Tdl+mNyAspYBt
 uwLwpqAmZ5VIZuWYEP//QorrwJ224u/Tcd9PrE2i6FoeCP6C/5O6cqI2RY1nhchR1Gjrlm5fhk6
 0Q7cY0xM0r02VM+LpTumcHAU1TjrU4KmaSKE4E9U9Ptgd2GWOBrpiH0G6rRO2OfEyV7tr6F5IPX
 XBKJ01jipEg5+/0wKTzbJz1MHWLnIJey5mZPa/pg=

verify btf__new_empty_opts() adds layouts for all kinds supported,
and after adding kind-related types for an unknown kind, ensure that
parsing uses this info when that kind is encountered rather than
giving up.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 .../selftests/bpf/prog_tests/btf_kind.c       | 212 ++++++++++++++++++
 1 file changed, 212 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_kind.c

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_kind.c b/tools/testing/selftests/bpf/prog_tests/btf_kind.c
new file mode 100644
index 000000000000..8cc55bbab7e9
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/btf_kind.c
@@ -0,0 +1,212 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026, Oracle and/or its affiliates. */
+
+#include <test_progs.h>
+#include <bpf/btf.h>
+#include <bpf/libbpf.h>
+
+/* Verify kind encoding exists for each kind */
+static void test_btf_kind_encoding(void)
+{
+	LIBBPF_OPTS(btf_new_opts, opts);
+	const struct btf_header *hdr;
+	const void *raw_btf;
+	struct btf *btf;
+	__u32 raw_size;
+
+	opts.add_layout = true;
+	btf = btf__new_empty_opts(&opts);
+	if (!ASSERT_OK_PTR(btf, "btf_new"))
+		return;
+
+	raw_btf = btf__raw_data(btf, &raw_size);
+	if (!ASSERT_OK_PTR(raw_btf, "btf__raw_data"))
+		return;
+
+	hdr = raw_btf;
+
+	ASSERT_EQ(hdr->layout_off % 4, 0, "layout_aligned");
+	ASSERT_EQ(hdr->layout_len, sizeof(struct btf_layout) * NR_BTF_KINDS,
+		  "layout_len");
+	ASSERT_EQ(hdr->str_off, hdr->layout_off + hdr->layout_len, "str_after_layout");
+	btf__free(btf);
+
+	opts.add_layout = false;
+	btf = btf__new_empty_opts(&opts);
+	if (!ASSERT_OK_PTR(btf, "btf_new"))
+		return;
+
+	raw_btf = btf__raw_data(btf, &raw_size);
+	if (!ASSERT_OK_PTR(raw_btf, "btf__raw_data"))
+		return;
+
+	hdr = raw_btf;
+
+	ASSERT_EQ(hdr->layout_off, 0, "no_layout_off");
+	ASSERT_EQ(hdr->layout_len, 0, "no_layout_len");
+	ASSERT_EQ(hdr->str_off, hdr->type_off + hdr->type_len, "strs_after_types");
+	btf__free(btf);
+}
+
+static void write_raw_btf(const char *btf_path, void *raw_btf, size_t raw_size)
+{
+	int fd = open(btf_path, O_WRONLY | O_CREAT);
+
+	write(fd, raw_btf, raw_size);
+	close(fd);
+}
+
+/*
+ * Fabricate an unrecognized kind at BTF_KIND_MAX + 1, and after adding
+ * the appropriate struct/typedefs to the BTF such that it recognizes
+ * this kind, ensure that parsing of BTF containing the unrecognized kind
+ * can succeed.
+ */
+void test_btf_kind_decoding(void)
+{
+	__s32 int_id, unrec_id, id, id2;
+	LIBBPF_OPTS(btf_new_opts, opts);
+	struct btf *btf, *new_btf;
+	struct btf_layout *l;
+	struct btf_header *hdr;
+	const void *raw_btf;
+	struct btf_type *t;
+	char btf_path[64];
+	void *new_raw_btf;
+	void *str_data;
+	__u32 raw_size;
+
+	opts.add_layout = true;
+	btf = btf__new_empty_opts(&opts);
+	if (!ASSERT_OK_PTR(btf, "btf_new"))
+		return;
+
+	int_id = btf__add_int(btf, "test_char", 1, BTF_INT_CHAR);
+	if (!ASSERT_GT(int_id, 0, "add_int_id"))
+		return;
+
+	/*
+	 * Create our type with unrecognized kind by adding a typedef kind
+	 * we will overwrite it with our unrecognized kind value.
+	 */
+	unrec_id = btf__add_typedef(btf, "unrec_kind", int_id);
+	if (!ASSERT_GT(unrec_id, 0, "add_unrec_id"))
+		return;
+
+	/*
+	 * Add an id after it that we will look up to verify we can parse
+	 * beyond unrecognized kinds.
+	 */
+	id = btf__add_typedef(btf, "test_lookup", int_id);
+	if (!ASSERT_GT(id, 0, "add_test_lookup_id"))
+		return;
+	id2 = btf__add_typedef(btf, "test_lookup2", int_id);
+	if (!ASSERT_GT(id2, 0, "add_test_lookup_id2"))
+		return;
+
+	raw_btf = (void *)btf__raw_data(btf, &raw_size);
+	if (!ASSERT_OK_PTR(raw_btf, "btf__raw_data"))
+		return;
+
+	new_raw_btf = calloc(1, raw_size + sizeof(*l));
+	if (!ASSERT_OK_PTR(new_raw_btf, "calloc_raw_btf"))
+		return;
+	memcpy(new_raw_btf, raw_btf, raw_size);
+
+	hdr = new_raw_btf;
+
+	/* Move strings to make space for one new layout description */
+	raw_size += sizeof(*l);
+	str_data = new_raw_btf + hdr->hdr_len + hdr->str_off;
+	memmove(str_data + sizeof(*l), str_data, hdr->str_len);
+	hdr->str_off += sizeof(*l);
+
+	/* Add new layout description */
+	hdr->layout_len += sizeof(*l);
+	l = new_raw_btf + hdr->hdr_len + hdr->layout_off;
+	l[NR_BTF_KINDS].info_sz = 0;
+	l[NR_BTF_KINDS].elem_sz = 0;
+	l[NR_BTF_KINDS].flags = 0;
+
+	/* Now modify typedef added above to be an unrecognized kind. */
+	t = (void *)hdr + hdr->hdr_len + hdr->type_off + sizeof(struct btf_type) +
+		sizeof(__u32);
+	t->info = (NR_BTF_KINDS << 24);
+
+	/* Write BTF to a raw file, ready for parsing. */
+	snprintf(btf_path, sizeof(btf_path), "/tmp/btf_kind.%d", getpid());
+
+	write_raw_btf(btf_path, new_raw_btf, raw_size);
+
+	/*
+	 * Verify parsing succeeds, and that we can read type info past
+	 * the unrecognized kind.
+	 */
+	new_btf = btf__parse_raw(btf_path);
+	if (ASSERT_OK_PTR(new_btf, "btf__parse_raw")) {
+		ASSERT_EQ(btf__find_by_name(new_btf, "unrec_kind"), unrec_id,
+			  "unrec_kind_found");
+		ASSERT_EQ(btf__find_by_name_kind(new_btf, "test_lookup",
+						 BTF_KIND_TYPEDEF), id,
+			  "verify_id_lookup");
+		ASSERT_EQ(btf__find_by_name_kind(new_btf, "test_lookup2",
+						 BTF_KIND_TYPEDEF), id2,
+			  "verify_id2_lookup");
+	}
+	btf__free(new_btf);
+
+	/*
+	 * Next, change info_sz to equal sizeof(struct btf_type); this means the
+	 * "test_lookup" kind will be reinterpreted as a singular info element
+	 * following the unrecognized kind.
+	 */
+	l[NR_BTF_KINDS].info_sz = sizeof(struct btf_type);
+	write_raw_btf(btf_path, new_raw_btf, raw_size);
+
+	new_btf = btf__parse_raw(btf_path);
+	if (ASSERT_OK_PTR(new_btf, "btf__parse_raw")) {
+		ASSERT_EQ(btf__find_by_name_kind(new_btf, "test_lookup",
+						 BTF_KIND_TYPEDEF), -ENOENT,
+			  "verify_id_not_found");
+		/* id of "test_lookup2" will be id2 -1 as we have removed one type */
+		ASSERT_EQ(btf__find_by_name_kind(new_btf, "test_lookup2",
+						 BTF_KIND_TYPEDEF), id2 - 1,
+			  "verify_id_lookup2");
+
+	}
+	btf__free(new_btf);
+
+	/*
+	 * Change elem_sz to equal sizeof(struct btf_type)/2 and set vlen
+	 * associated with unrecognized type to 2; this allows us to verify
+	 * vlen-specified BTF can still be parsed.
+	 */
+	l[NR_BTF_KINDS].info_sz = 0;
+	l[NR_BTF_KINDS].elem_sz = sizeof(struct btf_type)/2;
+	t->info |= 2;
+	write_raw_btf(btf_path, new_raw_btf, raw_size);
+
+	new_btf = btf__parse_raw(btf_path);
+	if (ASSERT_OK_PTR(new_btf, "btf__parse_raw")) {
+		ASSERT_EQ(btf__find_by_name_kind(new_btf, "test_lookup",
+						 BTF_KIND_TYPEDEF), -ENOENT,
+			  "verify_id_not_found");
+		/* id of "test_lookup2" will be id2 -1 as we have removed one type */
+		ASSERT_EQ(btf__find_by_name_kind(new_btf, "test_lookup2",
+						 BTF_KIND_TYPEDEF), id2 - 1,
+			  "verify_id_lookup2");
+
+	}
+	btf__free(new_btf);
+	free(new_raw_btf);
+	unlink(btf_path);
+	btf__free(btf);
+}
+
+void test_btf_kind(void)
+{
+	if (test__start_subtest("btf_kind_encoding"))
+		test_btf_kind_encoding();
+	if (test__start_subtest("btf_kind_decoding"))
+		test_btf_kind_decoding();
+}
-- 
2.39.3

