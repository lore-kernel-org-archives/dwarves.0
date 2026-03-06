Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C3F28505E;
	Fri,  6 Mar 2026 11:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772797236; cv=none; b=l8h79QctjPHfvlDa8bHsFcmqlpavlmqNLkR45/NXLEyYcoTSVCNIGJlqqCcIdGr32VpqOKTnJpftoV1h5/5ENw4BYs6d4WjXgkuZFL/EBgsV6cscvF4rLFySuprx8XLMOWO77HOTj7WISpKGBDlZc3CYrAcS7QRcaZLN9np9244=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772797236; c=relaxed/simple;
	bh=i500z2Bj3ObBlwJ2KefL6RMavoIXVvP+zpGFg+Gwg1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vD7oCWhG/xTMY0Xb9RtAqCsa/iSQQBNuZYQ6iEHVbl8V41luTWIvl4VVOEI4Z8pmGQaqHco4nL27DF9phNKm7vdMspyQJwfHcQC6aHwLDsRVFUPJpv/5pSbei9OhjX68yL1qHhtcosypKbntW5n66byMkbKxJk2JwQG5CP/VykE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=T2L5WGxA; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T2L5WGxA"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 626Bbr1h388057;
	Fri, 6 Mar 2026 11:40:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=OjNZh
	MieJM43MccA6oY3sp5DjyQ1/p5erty7X8DYWPI=; b=T2L5WGxAq1IfUTE6BC5Lj
	Dpc6A5nh5Q9S8bd5eVPKnp5izMfkLp/L4FydRBQguvm1o2uJ1E3YwQg4tY/burSj
	nvdwNG3K3qEXTG4QYkkg5de+2wwP1S+cKaiQoIPHbxbBn3vSud45PHPmlMX5dJs7
	FPvupRswDHbM264/uclFmx78oKbP61+De+ojW1IYlswJc3dqWSTJLz+jrGHbRn2q
	y6HHRinJ8BuZp0tdpGsBRcxqGKIO5cai/YOM1thL0uEqpcfAntmMcSO0zwSaU1zh
	jasJGa7nsdcK8sp5U1xOS1h7s/s6gDWio2zPx4K6C49/kcm0dVh3JMxkE/R4kniQ
	g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cqx7hr045-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Mar 2026 11:40:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 626AXnoA023120;
	Fri, 6 Mar 2026 11:36:53 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ckptjtmx0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Mar 2026 11:36:53 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 626BaXF5025727;
	Fri, 6 Mar 2026 11:36:52 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-62-192.vpn.oracle.com [10.154.62.192])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4ckptjtmhd-8;
	Fri, 06 Mar 2026 11:36:52 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        mykyta.yatsenko5@gmail.com, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v13 bpf-next 7/8] selftests/bpf: test kind encoding/decoding
Date: Fri,  6 Mar 2026 11:36:29 +0000
Message-ID: <20260306113630.1281527-8-alan.maguire@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=EMgLElZC c=1 sm=1 tr=0 ts=69aabd17 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=yPCof4ZbAAAA:8 a=P5AOqOs47VSxRN55gpgA:9 cc=ntf
 awl=host:12267
X-Proofpoint-ORIG-GUID: YhI2avNKTsyyKx0ti4yY9YKEyZzangjA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDExMCBTYWx0ZWRfX+0odYfpgpxkn
 afnX3R6fteUZdNiSugIuv8N43hhPe/8KgnBFv7Q3w0FADwWXvyGrsRiTaXBE7osYGbKIJSsVAX+
 oE6yPXgoHr17M9K59aFo675i6Bdk6OI7G2kP0Q6/E/zPV1szjxL7cpwJnMQVnsX8P5p4w4qhFy3
 Er0Ly1YjNb0eluULY7GgbJr4hJvYjPDNaQddRz7t8UKQ3UFSSnKkSVhdIV9SZhfBx/wCMVTYqBq
 MUp4CIFC7iHUL7d5vsuC4lCd+B4YlSMBQsrSdLQpHjayT4q/Cag1pnWJlNpE5OZENJJ7917HKw0
 w2v7jrF5kJ2aYHTAtrfZla3mFSRtFiVzzuiNaeAboXkkeqUj2fjL8lNq1TFVmdY5L39vtFxL3CZ
 Fo/zx4AczJJdQBGSMUE4ceHSqn3mQ9+Qky904KDi3PrIWD+V3M7nvHcfsVLUBNsV/W5PSAyAYz6
 +RvkvRDXtNhzBQp33aMgPGOEGVin16IZdqqGEd9A=
X-Proofpoint-GUID: YhI2avNKTsyyKx0ti4yY9YKEyZzangjA

verify btf__new_empty_opts() adds layouts for all kinds supported,
and after adding kind-related types for an unknown kind, ensure that
parsing uses this info when that kind is encountered rather than
giving up.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 .../selftests/bpf/prog_tests/btf_kind.c       | 224 ++++++++++++++++++
 1 file changed, 224 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_kind.c

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_kind.c b/tools/testing/selftests/bpf/prog_tests/btf_kind.c
new file mode 100644
index 000000000000..c9f5fd4a0783
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/btf_kind.c
@@ -0,0 +1,224 @@
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
+static int write_raw_btf(const char *btf_path, void *raw_btf, size_t raw_size)
+{
+	int fd = open(btf_path, O_WRONLY | O_CREAT | O_TRUNC | O_CLOEXEC, 0644);
+	ssize_t n;
+
+	if (!ASSERT_OK_FD(fd, "open_raw_btf"))
+		return -1;
+	n = write(fd, raw_btf, raw_size);
+	close(fd);
+	if (!ASSERT_EQ(n, (ssize_t)raw_size, "write_raw_btf"))
+		return -1;
+	return 0;
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
+	struct btf *btf = NULL, *new_btf = NULL;
+	__s32 int_id, unrec_id, id, id2;
+	LIBBPF_OPTS(btf_new_opts, opts);
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
+	if (write_raw_btf(btf_path, new_raw_btf, raw_size))
+		goto out;
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
+	new_btf = NULL;
+
+	/*
+	 * Next, change info_sz to equal sizeof(struct btf_type); this means the
+	 * "test_lookup" kind will be reinterpreted as a singular info element
+	 * following the unrecognized kind.
+	 */
+	l[NR_BTF_KINDS].info_sz = sizeof(struct btf_type);
+	if (write_raw_btf(btf_path, new_raw_btf, raw_size))
+		goto out;
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
+	new_btf = NULL;
+
+	/*
+	 * Change elem_sz to equal sizeof(struct btf_type)/2 and set vlen
+	 * associated with unrecognized type to 2; this allows us to verify
+	 * vlen-specified BTF can still be parsed.
+	 */
+	l[NR_BTF_KINDS].info_sz = 0;
+	l[NR_BTF_KINDS].elem_sz = sizeof(struct btf_type)/2;
+	t->info |= 2;
+	if (write_raw_btf(btf_path, new_raw_btf, raw_size))
+		goto out;
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
+out:
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

