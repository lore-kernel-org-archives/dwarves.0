Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCDF372B37;
	Thu, 26 Mar 2026 14:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774536960; cv=none; b=rcJHwAe2IdKM+B73mkLjdWpSgqjdAeCDM0OxVpA3gOQDDKgHxPbthPH8+8Qa93ZwTmbVFZX2tUcVBtN6hqCp/3g3QZxllMWRZS1n7/N16dVAdjMl1ZXv360kUzwT4clY6HUqR/KfuVCEUgcnRCPWYDRH/OqUdT0mMGhe4KrP1oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774536960; c=relaxed/simple;
	bh=ZknjIkjcjeSSl4daLOGY6RGHdJF54VhkmQZ8t15IDDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cny5lT+31ZByJjc9bcY9biwTsCLqjpaWn6fN7nqioteCNKE7HjRxfvMLmZVZLp1NMQMC1ZDGXDjwt/Ec4rV3loE8IPD547Q6n8svmQE6ObwNtcuyFsf5e3ZgYKDuqK3dWSuflJkTOMC5TcBIU55t1PBiVBjb3IcwfUGnTMBDY4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LtpW6sAr; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LtpW6sAr"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62Q7LHnZ2664765;
	Thu, 26 Mar 2026 14:55:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=II64k
	fkk8mqMd1unnxuaVJXGUrKY6yfoRTaLc/Ysmys=; b=LtpW6sAr+O2b16q5W//oo
	ZU4eDFa4XIPrGFmbycSV1yOAh/D/qvLg4GgKEi8k1XrJJa9KbZrIj5GZD9gFJCiy
	SXq0uHc/WpdVDHrb4YgQv7fbX9ZXiSHDr9Oqdh4CBKtRJiUnr46iuKBqlNBaB3N3
	7RUTc8NLapVEG7ZtwNKQdV6Gc6qRzX7I0PRQoqTWTsfI/UR6Dnhk2elosUl3gKIp
	IklHjR/3kBkNnmuyeRIiTLp5iIBiq+Ck6H0a6f8qAs8yXYtxHdmRrKsQi6HNqd4W
	kc96OWP5wIXGrrO1vmmrBAgCxOwMKr3U8fbwNs7khyR877mFHuaFkrRXXCNWOmXo
	g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d1kj2gchd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Mar 2026 14:55:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62QDVCat000628;
	Thu, 26 Mar 2026 14:55:14 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4d1hsd2412-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Mar 2026 14:55:14 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62QEslTJ015958;
	Thu, 26 Mar 2026 14:55:13 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-54-22.vpn.oracle.com [10.154.54.22])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4d1hsd235q-9;
	Thu, 26 Mar 2026 14:55:13 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
        qmo@kernel.org, ihor.solodrai@linux.dev, mykyta.yatsenko5@gmail.com,
        dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v16 bpf-next 8/9] selftests/bpf: Test kind encoding/decoding
Date: Thu, 26 Mar 2026 14:54:43 +0000
Message-ID: <20260326145444.2076244-9-alan.maguire@oracle.com>
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
X-Proofpoint-ORIG-GUID: 2KFJ0blNYJHj-mIgYeusg3uCz3qwvNru
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDEwNSBTYWx0ZWRfXz9ITs1IzXdGM
 KGifIiMnLzUdHkLbsFmaFSgmjm7+S92rfdfpxjyEvMaGXktyvALYeZHE221nuNWugxgZHOssd/6
 ATPXCE3MhHu7VOcNX8JW9ZZUJuP10KsxQkovQv1xyOU+jr2gYuuwZ29fobFnnAmQqQkU8uuJelG
 ig0Oy+Ew+bW3RiH3FbrkFbSX5K7OMnWth0Yu54WZ2l58x4hpF9Btped7147+ynwMJrCF4CcfunX
 4Nm3hIHYSjty4j+RaS8ihf4fUkQKJnMtM+DC1o5hw8WuD5R2jhSKcc2PzyvOns9hTJkYN9sq97S
 hc9ct2502N7u290+S3S+W/WDYBzkA9fR0sSJE8fzKHdROh8fgyPwv6lYh28e7szElWCtH0QYEo1
 L07Elp3syZwlG/jrE6qrzKcO5H0ebUhCu0SdyE4xt1/zPxyV504Ggm0MO3C2/s29v7l9Vr12YyF
 jqRRJ14B+8KA7p3vjMg==
X-Proofpoint-GUID: 2KFJ0blNYJHj-mIgYeusg3uCz3qwvNru
X-Authority-Analysis: v=2.4 cv=KtJAGGWN c=1 sm=1 tr=0 ts=69c548d3 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=yPCof4ZbAAAA:8 a=P5AOqOs47VSxRN55gpgA:9

verify btf__new_empty_opts() adds layouts for all kinds supported,
and after adding kind-related types for an unknown kind, ensure that
parsing uses this info when that kind is encountered rather than
giving up.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 .../selftests/bpf/prog_tests/btf_kind.c       | 226 ++++++++++++++++++
 1 file changed, 226 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_kind.c

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_kind.c b/tools/testing/selftests/bpf/prog_tests/btf_kind.c
new file mode 100644
index 000000000000..f61afe6a79a5
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/btf_kind.c
@@ -0,0 +1,226 @@
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
+static int write_raw_btf(void *raw_btf, size_t raw_size, char *file)
+{
+	int fd = mkstemp(file);
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
+	char btf_kind_file1[] = "/tmp/test_btf_kind.XXXXXX";
+	char btf_kind_file2[] = "/tmp/test_btf_kind.XXXXXX";
+	char btf_kind_file3[] = "/tmp/test_btf_kind.XXXXXX";
+	struct btf *btf = NULL, *new_btf = NULL;
+	__s32 int_id, unrec_id, id, id2;
+	LIBBPF_OPTS(btf_new_opts, opts);
+	struct btf_layout *l;
+	struct btf_header *hdr;
+	const void *raw_btf;
+	struct btf_type *t;
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
+	if (write_raw_btf(new_raw_btf, raw_size, btf_kind_file1))
+		goto out;
+
+	/*
+	 * Verify parsing succeeds, and that we can read type info past
+	 * the unrecognized kind.
+	 */
+	new_btf = btf__parse_raw(btf_kind_file1);
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
+	if (write_raw_btf(new_raw_btf, raw_size, btf_kind_file2))
+		goto out;
+
+	new_btf = btf__parse_raw(btf_kind_file2);
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
+	 * Change elem_sz to equal sizeof(struct btf_type) and set vlen
+	 * associated with unrecognized type to 1; this allows us to verify
+	 * vlen-specified BTF can still be parsed.
+	 */
+	l[NR_BTF_KINDS].info_sz = 0;
+	l[NR_BTF_KINDS].elem_sz = sizeof(struct btf_type);
+	t->info |= 1;
+	if (write_raw_btf(new_raw_btf, raw_size, btf_kind_file3))
+		goto out;
+
+	new_btf = btf__parse_raw(btf_kind_file3);
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
+	unlink(btf_kind_file1);
+	unlink(btf_kind_file2);
+	unlink(btf_kind_file3);
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

