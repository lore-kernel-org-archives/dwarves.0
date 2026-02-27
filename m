Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53813D410C;
	Fri, 27 Feb 2026 10:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772186726; cv=none; b=f9YWyG+jXISzhV3+H1PxiycldYBU8dhKLF3g7dqSnOyxFAjTMLxM2RbbwnZ8dSXkaLl3yuKpsYiS5lF4v2HSyucI3W5tTHAGxa389yYkZ4uazYoKSSvtb3ji0fRTt37tnokWfPpkumvdHJ/aJ6Nds5LDcbo1uBzsFXDsKqvECZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772186726; c=relaxed/simple;
	bh=LvCbn+N7Wya2mHuD4QKmVKzr+7wH7X/vgFSmIjj0Gu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EradiI+3/e/KKp0SqV2sMnDBwgYY9TZLeCT6FxVKfCOx7yjj0f+5RV3CgIka/eMFBPHXZMCbnyugzVOsYn9iwQSnok9afWUP8f94etjxfvou4koS0MVTWLkPZkjXaWW0a1GczoYw7PJ543lBW3A0Qce0mbw4U2QR3SG1i+ZRZZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZaC+t1Qh; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZaC+t1Qh"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61R9uuJ82160530;
	Fri, 27 Feb 2026 10:05:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=W9+iB
	ABSKFrPrBXC34Ku4QTZTAmouwyRQY1qjMeBYjM=; b=ZaC+t1QhU/ThilruA9WN9
	I6lQP22UHPck9QwKqTWSOESeqhNsmOP4o3EpGS478qZnmwvBefF08JhFtlwzsamb
	5VYALazg5ymXIaupX2TJdcbb3JDMNXDWs3VcMCQvN9A/DFXVBp64Za+IFjOaKDkH
	A8UegUtNYikyVudHE9dWxFko7wkNlHu7c9zKFuCVXEp+S1D4pw93bpu9xd6nZDqo
	N5zd+O7IqTV+mS/F0R5iIWv3NuGYBS2zRhYXmLc5JbF0n6o9esaNEbRvbIrpAoqR
	2QRyiRSss+bdX+d3/ItQa/nco69LPrtx6BX3L/1FDjh4nQ2GUuwJu2LZyBvlQvdB
	A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cjh01a8sf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Feb 2026 10:04:59 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61R8iIWh028537;
	Fri, 27 Feb 2026 10:04:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cf35dmxh3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Feb 2026 10:04:59 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 61RA4Vxk036185;
	Fri, 27 Feb 2026 10:04:58 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-60-228.vpn.oracle.com [10.154.60.228])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4cf35dmx3p-8;
	Fri, 27 Feb 2026 10:04:58 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        mykyta.yatsenko5@gmail.com, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v10 bpf-next 07/10] selftests/bpf: test kind encoding/decoding
Date: Fri, 27 Feb 2026 10:04:23 +0000
Message-ID: <20260227100426.2585191-8-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260227100426.2585191-1-alan.maguire@oracle.com>
References: <20260227100426.2585191-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_01,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602270086
X-Proofpoint-ORIG-GUID: Jx6Zdft494RpkML4NJ-eouRBJwCRIXL1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDA4NiBTYWx0ZWRfX3dlabi7WXqdA
 /3HhQOHD0JnYn6C3e1bO3/ES6VU2ap5tEKztDqviEj2QiOzZ55RtkurwQfGId2TIcwryglh7ywr
 NBimKjFuDWOQkh01v4WAX0gJuM1t2unbs6XK95/tFxF8HNRJm1qr0gMWqGNeSywJGs21vTQOl8v
 bf3VfNxSoh7FA8T1Kyj9O23iG79NN2hXZNBGZM64f95tXm6qB30A4vJ9cMekgSURrnvozNBAiLY
 CGCvp/wJR5+T7E9Qs4YMjNUJcpjujApY/a3+XKBauCCDYPRyN0tU/DqwO09VI5MFM88mWcgxjpD
 YdES2lRUvosOz5dYPQJExaPkIcaokS4s+GBiyZx71IVJWGD2nxfK7SXTRVSx1aSLTXGcyNzTGUT
 bjjjjX9n64gLXumMESZhD/C4iO9xXSRcnMsc64JterraP1ODQJikBPsxC6LK+izIaRmf7/m5l0W
 AFdfQTYXErSe3PkFloQ==
X-Proofpoint-GUID: Jx6Zdft494RpkML4NJ-eouRBJwCRIXL1
X-Authority-Analysis: v=2.4 cv=D+xK6/Rj c=1 sm=1 tr=0 ts=69a16c4b cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=yPCof4ZbAAAA:8 a=P5AOqOs47VSxRN55gpgA:9

verify btf__new_empty_opts() adds layouts for all kinds supported,
and after adding kind-related types for an unknown kind, ensure that
parsing uses this info when that kind is encountered rather than
giving up.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 .../selftests/bpf/prog_tests/btf_kind.c       | 206 ++++++++++++++++++
 1 file changed, 206 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_kind.c

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_kind.c b/tools/testing/selftests/bpf/prog_tests/btf_kind.c
new file mode 100644
index 000000000000..09246dc61f5a
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/btf_kind.c
@@ -0,0 +1,206 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026, Oracle and/or its affiliates. */
+
+#include <test_progs.h>
+#include <bpf/btf.h>
+#include <bpf/libbpf.h>
+
+/* verify kind encoding exists for each kind */
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
+/* fabricate an unrecognized kind at BTF_KIND_MAX + 1, and after adding
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
+	/* now create our type with unrecognized kind by adding a typedef kind
+	 * we will overwrite it with our unrecognized kind value.
+	 */
+	unrec_id = btf__add_typedef(btf, "unrec_kind", int_id);
+	if (!ASSERT_GT(unrec_id, 0, "add_unrec_id"))
+		return;
+
+	/* add an id after it that we will look up to verify we can parse
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
+	/* move strings to make space for one new layout description */
+	raw_size += sizeof(*l);
+	str_data = new_raw_btf + hdr->hdr_len + hdr->str_off;
+	memmove(str_data + sizeof(*l), str_data, hdr->str_len);
+	hdr->str_off += sizeof(*l);
+
+	/* add new layout description */
+	hdr->layout_len += sizeof(*l);
+	l = new_raw_btf + hdr->hdr_len + hdr->layout_off;
+	l[NR_BTF_KINDS].info_sz = 0;
+	l[NR_BTF_KINDS].elem_sz = 0;
+	l[NR_BTF_KINDS].flags = 0;
+
+	/* now modify our typedef added above to be an unrecognized kind. */
+	t = (void *)hdr + hdr->hdr_len + hdr->type_off + sizeof(struct btf_type) +
+		sizeof(__u32);
+	t->info = (NR_BTF_KINDS << 24);
+
+	/* now write our BTF to a raw file, ready for parsing. */
+	snprintf(btf_path, sizeof(btf_path), "/tmp/btf_kind.%d", getpid());
+
+	write_raw_btf(btf_path, new_raw_btf, raw_size);
+
+	/* verify parsing succeeds, and that we can read type info past
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
+	/* next, change info_sz to equal sizeof(struct btf_type); this means the
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
+	/* next, change elem_sz to equal sizeof(struct btf_type)/2 and set
+	 * vlen associated with unrecognized type to 2; this allows us to verify
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

