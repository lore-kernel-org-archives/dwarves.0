Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C793FE64C;
	Thu, 26 Mar 2026 14:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774536926; cv=none; b=MmzqYn+2egFUlHAjnPL6QLnZBsmU9V1g/7pXNowYyIwpeiUgLhiiUbBUfMIQAciPsrOfGrbQH2YjUORrLK0pbV3c+YnolhJtoHIGyErZhIWsC/eykeNiXuNwMIbCi9bOJ6qlnmGXmwh/8HDDZUsJJ5AZkQFH8eJjMAiA3dnzGko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774536926; c=relaxed/simple;
	bh=h+fgoRk9vR5FoOtdaS1FdwHKpBjoQ7i4aUxObdcRQV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gy1Eo7utw+CmaXuxW7xjf1z1MELaxbmbIrlEOy6S/nq5SgciJIGWWq3WHHnAhEvT/Lix1t8EbY3rx5AvOkXeDg4OKY9mna8zfO9BaGCTWP7HcjBuoptDRz7dwJpzdPa39ZL02D503w0HzUdj3UeGFRlvt72Tbec2vGhdGclr18k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pdcyCxCt; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pdcyCxCt"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62Q71t1o2664761;
	Thu, 26 Mar 2026 14:54:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=TbzxT
	2bAgm+jMxGmHitRkDxpL8FiifR+iJcF1ztrXqw=; b=pdcyCxCt5ngL5sScSD4ij
	DxpBydcfBpPPTA/nBPbLaA4r0b2f6AFo60XedZ4BVqB52HsEKJ4A/8XJdupLt817
	QFb+f0dbG4DAj0kdPszv+xov1f7delS2tUVsXspTi9oYs6pDB0/NGpy/0kCBrHhv
	wLO4ImYhc2ZtUSrvH3XKFArotHhODyXYXKI36ryHimBc127hZu89fsY5o9QvkEuD
	ugcED1MnPxwQO6nYg4N0R4iXLcby9fWUq2yzLVJir72jy54lcy/qukye0wQL7ICz
	tX5RQUoXBUxUE/jaUkWTrfhOMf1AMgwxZHCLEvzXdnISMsEhcanQXoi4Kf9t7JGi
	A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d1kj2gcg8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Mar 2026 14:54:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62QERLIo000741;
	Thu, 26 Mar 2026 14:54:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4d1hsd23b1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Mar 2026 14:54:55 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62QEslT7015958;
	Thu, 26 Mar 2026 14:54:54 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-54-22.vpn.oracle.com [10.154.54.22])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4d1hsd235q-3;
	Thu, 26 Mar 2026 14:54:54 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
        qmo@kernel.org, ihor.solodrai@linux.dev, mykyta.yatsenko5@gmail.com,
        dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v16 bpf-next 2/9] libbpf: Support layout section handling in BTF
Date: Thu, 26 Mar 2026 14:54:37 +0000
Message-ID: <20260326145444.2076244-3-alan.maguire@oracle.com>
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
X-Proofpoint-ORIG-GUID: sYzaoKVcrB-JJCatj7_I6zoNnI7jwiMn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDEwNSBTYWx0ZWRfX3P23BOiH8flJ
 vjRADmZv8tYX/uQLw1b5ZA23POJ5rY68YLO/BFMmRA9nn5f/SgnM27Xy0EWoW+VAbPRbhNIFSM4
 /3YmOxZnQQkIUhRfJPGYlvJy8jmRnX4f9EHnZ43wueU9vWvYdD0Gt5UIBGDgd9TsnuHZ9FXTvEw
 3vHUIQeUXsgo7RFVewbZDw3oUQ86Y1k7pCemXAaDKT7YaoE4C+fCHxFFjG1MBjABotomQnk7lCU
 YPBUQrydQ8udac1vldKDMJTChBtvgSgv1yhLvUuVkzyauniCU7YWO7xkXGIClLbTIXz2dHqgsNb
 Tyf/V9dGfe0opjIhW2MWQW9ezHrYFazDwmD/YyIBD2XczSwQ8D9IIoT2fnHT9D92Fo8Uc77NH6e
 bWqFcf5mmkCyCx3kt2PopMn3zIYP76fnxDvqOwGkn83QlDAbkeHhzSOirtFRfxtDAJGA0m48x0/
 bWOO+jE2ryjt1BFUKOw==
X-Proofpoint-GUID: sYzaoKVcrB-JJCatj7_I6zoNnI7jwiMn
X-Authority-Analysis: v=2.4 cv=KtJAGGWN c=1 sm=1 tr=0 ts=69c548c0 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=yPCof4ZbAAAA:8 a=y4pUIZtLJmWxnsyg3gMA:9

Support reading in layout fixing endian issues on reading;
also support writing layout section to raw BTF object.
There is not yet an API to populate the layout with meaningful
information.

As part of this, we need to consider multiple valid BTF header
sizes; the original or the layout-extended headers.
So to support this, the "struct btf" representation is modified
to contain a "struct btf_header" and we copy the valid
portion from the raw data to it; this means we can always safely
check fields like btf->hdr.layout_len .

Note if parsed-in BTF has extra header information beyond
sizeof(struct btf_header) - if so we make that BTF ineligible
for modification by setting btf->has_hdr_extra .

Ensure that we handle endianness issues for BTF layout section,
though currently only field that needs this (flags) is unused.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/btf.c | 473 ++++++++++++++++++++++++++++++--------------
 1 file changed, 320 insertions(+), 153 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 40becc964368..2c6c524175c0 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -40,42 +40,53 @@ struct btf {
 
 	/*
 	 * When BTF is loaded from an ELF or raw memory it is stored
-	 * in a contiguous memory block. The hdr, type_data, and, strs_data
+	 * in a contiguous memory block. The type_data, layout and strs_data
 	 * point inside that memory region to their respective parts of BTF
 	 * representation:
 	 *
-	 * +--------------------------------+
-	 * |  Header  |  Types  |  Strings  |
-	 * +--------------------------------+
-	 * ^          ^         ^
-	 * |          |         |
-	 * hdr        |         |
-	 * types_data-+         |
-	 * strs_data------------+
+	 * +----------------------------------------+---------------+
+	 * |  Header  |  Types  |  Optional layout  |  Strings      |
+	 * +--------------------------------------------------------+
+	 * ^          ^         ^                   ^
+	 * |          |         |                   |
+	 * raw_data   |         |                   |
+	 * types_data-+         |                   |
+	 * layout---------------+                   |
+	 * strs_data--------------------------------+
+	 *
+	 * A separate struct btf_header is embedded as btf->hdr,
+	 * and header information is copied into it.  This allows us
+	 * to handle header data for various header formats; the original,
+	 * the extended header with layout info, etc.
 	 *
 	 * If BTF data is later modified, e.g., due to types added or
 	 * removed, BTF deduplication performed, etc, this contiguous
-	 * representation is broken up into three independently allocated
-	 * memory regions to be able to modify them independently.
+	 * representation is broken up into four independent memory
+	 * regions.
+	 *
 	 * raw_data is nulled out at that point, but can be later allocated
 	 * and cached again if user calls btf__raw_data(), at which point
-	 * raw_data will contain a contiguous copy of header, types, and
-	 * strings:
+	 * raw_data will contain a contiguous copy of header, types, optional
+	 * layout and strings.  layout optionally points to a
+	 * btf_layout array - this allows us to encode information about
+	 * the kinds known at encoding time.  If layout is NULL no
+	 * layout information is encoded.
 	 *
-	 * +----------+  +---------+  +-----------+
-	 * |  Header  |  |  Types  |  |  Strings  |
-	 * +----------+  +---------+  +-----------+
-	 * ^             ^            ^
-	 * |             |            |
-	 * hdr           |            |
-	 * types_data----+            |
-	 * strset__data(strs_set)-----+
+	 * +----------+  +---------+  +-----------+   +-----------+
+	 * |  Header  |  |  Types  |  |  Layout   |   |  Strings  |
+	 * +----------+  +---------+  +-----------+   +-----------+
+	 * ^             ^            ^               ^
+	 * |             |            |               |
+	 * hdr           |            |               |
+	 * types_data----+            |               |
+	 * layout---------------------+               |
+	 * strset__data(strs_set)---------------------+
 	 *
-	 *               +----------+---------+-----------+
-	 *               |  Header  |  Types  |  Strings  |
-	 * raw_data----->+----------+---------+-----------+
+	 *               +----------+---------+-------------------+-----------+
+	 *               |  Header  |  Types  |  Optional Layout  |  Strings  |
+	 * raw_data----->+----------+---------+-------------------+-----------+
 	 */
-	struct btf_header *hdr;
+	struct btf_header hdr;
 
 	void *types_data;
 	size_t types_data_cap; /* used size stored in hdr->type_len */
@@ -125,6 +136,17 @@ struct btf {
 	/* whether raw_data is a (read-only) mmap */
 	bool raw_data_is_mmap;
 
+	/* is BTF modifiable? i.e. is it split into separate sections as described above? */
+	bool modifiable;
+	/* does BTF have header information we do not support?  If so, disallow
+	 * modification.
+	 */
+	bool has_hdr_extra;
+	/* Points either at raw kind layout data in parsed BTF (if present), or
+	 * at an allocated kind layout array when BTF is modifiable.
+	 */
+	void *layout;
+
 	/* BTF object FD, if loaded into kernel */
 	int fd;
 
@@ -216,7 +238,7 @@ static int btf_add_type_idx_entry(struct btf *btf, __u32 type_off)
 	return 0;
 }
 
-static void btf_bswap_hdr(struct btf_header *h)
+static void btf_bswap_hdr(struct btf_header *h, __u32 hdr_len)
 {
 	h->magic = bswap_16(h->magic);
 	h->hdr_len = bswap_32(h->hdr_len);
@@ -224,66 +246,115 @@ static void btf_bswap_hdr(struct btf_header *h)
 	h->type_len = bswap_32(h->type_len);
 	h->str_off = bswap_32(h->str_off);
 	h->str_len = bswap_32(h->str_len);
+	/* May be operating on raw data with hdr_len that does not include below fields */
+	if (hdr_len >= sizeof(struct btf_header)) {
+		h->layout_off = bswap_32(h->layout_off);
+		h->layout_len = bswap_32(h->layout_len);
+	}
 }
 
 static int btf_parse_hdr(struct btf *btf)
 {
-	struct btf_header *hdr = btf->hdr;
-	__u32 meta_left;
+	struct btf_header *hdr = btf->raw_data;
+	__u32 hdr_len, meta_left;
 
-	if (btf->raw_size < sizeof(struct btf_header)) {
+	if (btf->raw_size < offsetofend(struct btf_header, str_len)) {
 		pr_debug("BTF header not found\n");
 		return -EINVAL;
 	}
 
+	hdr_len = hdr->hdr_len;
+
 	if (hdr->magic == bswap_16(BTF_MAGIC)) {
 		btf->swapped_endian = true;
-		if (bswap_32(hdr->hdr_len) != sizeof(struct btf_header)) {
+		hdr_len = bswap_32(hdr->hdr_len);
+		if (hdr_len < offsetofend(struct btf_header, str_len)) {
 			pr_warn("Can't load BTF with non-native endianness due to unsupported header length %u\n",
-				bswap_32(hdr->hdr_len));
+				hdr_len);
 			return -ENOTSUP;
 		}
-		btf_bswap_hdr(hdr);
 	} else if (hdr->magic != BTF_MAGIC) {
 		pr_debug("Invalid BTF magic: %x\n", hdr->magic);
 		return -EINVAL;
 	}
 
-	if (btf->raw_size < hdr->hdr_len) {
+	if (btf->raw_size < hdr_len) {
 		pr_debug("BTF header len %u larger than data size %u\n",
-			 hdr->hdr_len, btf->raw_size);
+			 hdr_len, btf->raw_size);
 		return -EINVAL;
 	}
 
-	meta_left = btf->raw_size - hdr->hdr_len;
-	if (meta_left < (long long)hdr->str_off + hdr->str_len) {
+	if (btf->swapped_endian)
+		btf_bswap_hdr(hdr, hdr_len);
+
+	memcpy(&btf->hdr, hdr, min((size_t)hdr_len, sizeof(struct btf_header)));
+
+	/* If unknown header data is found, modification is prohibited in
+	 * btf_ensure_modifiable().
+	 */
+	if (hdr_len > sizeof(struct btf_header)) {
+		__u8 *h = (__u8 *)hdr;
+		__u32 i;
+
+		for (i = sizeof(struct btf_header); i < hdr_len; i++) {
+			if (!h[i])
+				continue;
+			btf->has_hdr_extra = true;
+			pr_debug("Unknown BTF header data at offset %u; modification is disallowed\n",
+				 i);
+			break;
+		}
+	}
+
+	meta_left = btf->raw_size - hdr_len;
+	if (meta_left < (long long)btf->hdr.str_off + btf->hdr.str_len) {
 		pr_debug("Invalid BTF total size: %u\n", btf->raw_size);
 		return -EINVAL;
 	}
 
-	if ((long long)hdr->type_off + hdr->type_len > hdr->str_off) {
+	if ((long long)btf->hdr.type_off + btf->hdr.type_len > btf->hdr.str_off) {
 		pr_debug("Invalid BTF data sections layout: type data at %u + %u, strings data at %u + %u\n",
-			 hdr->type_off, hdr->type_len, hdr->str_off, hdr->str_len);
+			 btf->hdr.type_off, btf->hdr.type_len, btf->hdr.str_off,
+			 btf->hdr.str_len);
 		return -EINVAL;
 	}
 
-	if (hdr->type_off % 4) {
+	if (btf->hdr.type_off % 4) {
 		pr_debug("BTF type section is not aligned to 4 bytes\n");
 		return -EINVAL;
 	}
 
+	if (btf->hdr.layout_len == 0)
+		return 0;
+
+	/* optional layout section sits between types and strings */
+	if (btf->hdr.layout_off % 4) {
+		pr_debug("BTF layout section is not aligned to 4 bytes\n");
+		return -EINVAL;
+	}
+	if (btf->hdr.layout_off < (long long)btf->hdr.type_off + btf->hdr.type_len) {
+		pr_debug("Invalid BTF data sections layout: type data at %u + %u,  layout data at %u + %u\n",
+			 btf->hdr.type_off, btf->hdr.type_len,
+			 btf->hdr.layout_off, btf->hdr.layout_len);
+		return -EINVAL;
+	}
+	if ((long long)btf->hdr.layout_off + btf->hdr.layout_len > btf->hdr.str_off ||
+	    btf->hdr.layout_off > btf->hdr.str_off) {
+		pr_debug("Invalid BTF data sections layout: layout data at %u + %u, strings data at %u\n",
+			 btf->hdr.layout_off, btf->hdr.layout_len, btf->hdr.str_off);
+		return -EINVAL;
+	}
 	return 0;
 }
 
 static int btf_parse_str_sec(struct btf *btf)
 {
-	const struct btf_header *hdr = btf->hdr;
 	const char *start = btf->strs_data;
-	const char *end = start + btf->hdr->str_len;
+	const char *end = start + btf->hdr.str_len;
 
-	if (btf->base_btf && hdr->str_len == 0)
+	if (btf->base_btf && btf->hdr.str_len == 0)
 		return 0;
-	if (!hdr->str_len || hdr->str_len - 1 > BTF_MAX_STR_OFFSET || end[-1]) {
+	if (!btf->hdr.str_len || btf->hdr.str_len - 1 > BTF_MAX_STR_OFFSET || end[-1]) {
 		pr_debug("Invalid BTF string section\n");
 		return -EINVAL;
 	}
@@ -294,6 +365,27 @@ static int btf_parse_str_sec(struct btf *btf)
 	return 0;
 }
 
+static int btf_parse_layout_sec(struct btf *btf)
+{
+	if (!btf->hdr.layout_len)
+		return 0;
+
+	if (btf->hdr.layout_len % sizeof(struct btf_layout) != 0) {
+		pr_debug("Invalid BTF kind layout section\n");
+		return -EINVAL;
+	}
+	btf->layout = btf->raw_data + btf->hdr.hdr_len + btf->hdr.layout_off;
+
+	if (btf->swapped_endian) {
+		struct btf_layout *l, *end = btf->layout + btf->hdr.layout_len;
+
+		for (l = btf->layout; l < end; l++)
+			l->flags = bswap_16(l->flags);
+	}
+
+	return 0;
+}
+
 static int btf_type_size(const struct btf_type *t)
 {
 	const int base_size = sizeof(struct btf_type);
@@ -421,9 +513,8 @@ static int btf_bswap_type_rest(struct btf_type *t)
 
 static int btf_parse_type_sec(struct btf *btf)
 {
-	struct btf_header *hdr = btf->hdr;
 	void *next_type = btf->types_data;
-	void *end_type = next_type + hdr->type_len;
+	void *end_type = next_type + btf->hdr.type_len;
 	int err, type_size;
 
 	while (next_type + sizeof(struct btf_type) <= end_type) {
@@ -1012,7 +1103,8 @@ __s32 btf__find_by_name_kind(const struct btf *btf, const char *type_name,
 
 static bool btf_is_modifiable(const struct btf *btf)
 {
-	return (void *)btf->hdr != btf->raw_data;
+	/* BTF is modifiable if split into multiple sections */
+	return btf->modifiable;
 }
 
 static void btf_free_raw_data(struct btf *btf)
@@ -1036,14 +1128,14 @@ void btf__free(struct btf *btf)
 
 	if (btf_is_modifiable(btf)) {
 		/* if BTF was modified after loading, it will have a split
-		 * in-memory representation for header, types, and strings
+		 * in-memory representation for types, strings and layout
 		 * sections, so we need to free all of them individually. It
 		 * might still have a cached contiguous raw data present,
 		 * which will be unconditionally freed below.
 		 */
-		free(btf->hdr);
 		free(btf->types_data);
 		strset__free(btf->strs_set);
+		free(btf->layout);
 	}
 	btf_free_raw_data(btf);
 	free(btf->raw_data_swapped);
@@ -1055,6 +1147,7 @@ void btf__free(struct btf *btf)
 
 static struct btf *btf_new_empty(struct btf *base_btf)
 {
+	struct btf_header *hdr;
 	struct btf *btf;
 
 	btf = calloc(1, sizeof(*btf));
@@ -1072,7 +1165,7 @@ static struct btf *btf_new_empty(struct btf *base_btf)
 	if (base_btf) {
 		btf->base_btf = base_btf;
 		btf->start_id = btf__type_cnt(base_btf);
-		btf->start_str_off = base_btf->hdr->str_len + base_btf->start_str_off;
+		btf->start_str_off = base_btf->hdr.str_len + base_btf->start_str_off;
 		btf->swapped_endian = base_btf->swapped_endian;
 	}
 
@@ -1084,14 +1177,15 @@ static struct btf *btf_new_empty(struct btf *base_btf)
 		return ERR_PTR(-ENOMEM);
 	}
 
-	btf->hdr = btf->raw_data;
-	btf->hdr->hdr_len = sizeof(struct btf_header);
-	btf->hdr->magic = BTF_MAGIC;
-	btf->hdr->version = BTF_VERSION;
+	hdr = btf->raw_data;
+	hdr->hdr_len = sizeof(struct btf_header);
+	hdr->magic = BTF_MAGIC;
+	hdr->version = BTF_VERSION;
 
-	btf->types_data = btf->raw_data + btf->hdr->hdr_len;
-	btf->strs_data = btf->raw_data + btf->hdr->hdr_len;
-	btf->hdr->str_len = base_btf ? 0 : 1; /* empty string at offset 0 */
+	btf->types_data = btf->raw_data + hdr->hdr_len;
+	btf->strs_data = btf->raw_data + hdr->hdr_len;
+	hdr->str_len = base_btf ? 0 : 1; /* empty string at offset 0 */
+	memcpy(&btf->hdr, hdr, sizeof(*hdr));
 
 	return btf;
 }
@@ -1124,7 +1218,7 @@ static struct btf *btf_new(const void *data, __u32 size, struct btf *base_btf, b
 	if (base_btf) {
 		btf->base_btf = base_btf;
 		btf->start_id = btf__type_cnt(base_btf);
-		btf->start_str_off = base_btf->hdr->str_len + base_btf->start_str_off;
+		btf->start_str_off = base_btf->hdr.str_len + base_btf->start_str_off;
 	}
 
 	if (is_mmap) {
@@ -1141,15 +1235,15 @@ static struct btf *btf_new(const void *data, __u32 size, struct btf *base_btf, b
 
 	btf->raw_size = size;
 
-	btf->hdr = btf->raw_data;
 	err = btf_parse_hdr(btf);
 	if (err)
 		goto done;
 
-	btf->strs_data = btf->raw_data + btf->hdr->hdr_len + btf->hdr->str_off;
-	btf->types_data = btf->raw_data + btf->hdr->hdr_len + btf->hdr->type_off;
+	btf->strs_data = btf->raw_data + btf->hdr.hdr_len + btf->hdr.str_off;
+	btf->types_data = btf->raw_data + btf->hdr.hdr_len + btf->hdr.type_off;
 
 	err = btf_parse_str_sec(btf);
+	err = err ?: btf_parse_layout_sec(btf);
 	err = err ?: btf_parse_type_sec(btf);
 	err = err ?: btf_sanity_check(btf);
 	if (err)
@@ -1601,7 +1695,7 @@ static const void *btf_strs_data(const struct btf *btf)
 
 static void *btf_get_raw_data(const struct btf *btf, __u32 *size, bool swap_endian)
 {
-	struct btf_header *hdr = btf->hdr;
+	const struct btf_header *hdr = &btf->hdr;
 	struct btf_type *t;
 	void *data, *p;
 	__u32 data_sz;
@@ -1614,14 +1708,17 @@ static void *btf_get_raw_data(const struct btf *btf, __u32 *size, bool swap_endi
 	}
 
 	data_sz = hdr->hdr_len + hdr->type_len + hdr->str_len;
+	if (btf->layout)
+		data_sz += hdr->layout_len;
+
 	data = calloc(1, data_sz);
 	if (!data)
 		return NULL;
 	p = data;
 
-	memcpy(p, hdr, hdr->hdr_len);
+	memcpy(p, hdr, min((__u32)sizeof(struct btf_header), hdr->hdr_len));
 	if (swap_endian)
-		btf_bswap_hdr(p);
+		btf_bswap_hdr(p, hdr->hdr_len);
 	p += hdr->hdr_len;
 
 	memcpy(p, btf->types_data, hdr->type_len);
@@ -1639,8 +1736,18 @@ static void *btf_get_raw_data(const struct btf *btf, __u32 *size, bool swap_endi
 	}
 	p += hdr->type_len;
 
+	if (btf->layout) {
+		memcpy(p, btf->layout, hdr->layout_len);
+		if (swap_endian) {
+			struct btf_layout *l, *end = p + hdr->layout_len;
+
+			for (l = p; l < end ; l++)
+				l->flags = bswap_16(l->flags);
+		}
+		p += hdr->layout_len;
+	}
+
 	memcpy(p, btf_strs_data(btf), hdr->str_len);
-	p += hdr->str_len;
 
 	*size = data_sz;
 	return data;
@@ -1675,7 +1782,7 @@ const char *btf__str_by_offset(const struct btf *btf, __u32 offset)
 {
 	if (offset < btf->start_str_off)
 		return btf__str_by_offset(btf->base_btf, offset);
-	else if (offset - btf->start_str_off < btf->hdr->str_len)
+	else if (offset - btf->start_str_off < btf->hdr.str_len)
 		return btf_strs_data(btf) + (offset - btf->start_str_off);
 	else
 		return errno = EINVAL, NULL;
@@ -1783,12 +1890,12 @@ static void btf_invalidate_raw_data(struct btf *btf)
 }
 
 /* Ensure BTF is ready to be modified (by splitting into a three memory
- * regions for header, types, and strings). Also invalidate cached
+ * regions for types, strings and layout. Also invalidate cached
  * raw_data, if any.
  */
 static int btf_ensure_modifiable(struct btf *btf)
 {
-	void *hdr, *types;
+	void *types, *layout = NULL;
 	struct strset *set = NULL;
 	int err = -ENOMEM;
 
@@ -1798,45 +1905,58 @@ static int btf_ensure_modifiable(struct btf *btf)
 		return 0;
 	}
 
-	/* split raw data into three memory regions */
-	hdr = malloc(btf->hdr->hdr_len);
-	types = malloc(btf->hdr->type_len);
-	if (!hdr || !types)
+	if (btf->has_hdr_extra) {
+		/* Additional BTF header data was found; not safe to modify. */
+		return -EOPNOTSUPP;
+	}
+
+	/* split raw data into memory regions; btf->hdr is done already. */
+	types = malloc(btf->hdr.type_len);
+	if (!types)
 		goto err_out;
+	memcpy(types, btf->types_data, btf->hdr.type_len);
 
-	memcpy(hdr, btf->hdr, btf->hdr->hdr_len);
-	memcpy(types, btf->types_data, btf->hdr->type_len);
+	if (btf->hdr.layout_len) {
+		layout = malloc(btf->hdr.layout_len);
+		if (!layout)
+			goto err_out;
+		memcpy(layout, btf->raw_data + btf->hdr.hdr_len + btf->hdr.layout_off,
+		       btf->hdr.layout_len);
+	}
 
 	/* build lookup index for all strings */
-	set = strset__new(BTF_MAX_STR_OFFSET, btf->strs_data, btf->hdr->str_len);
+	set = strset__new(BTF_MAX_STR_OFFSET, btf->strs_data, btf->hdr.str_len);
 	if (IS_ERR(set)) {
 		err = PTR_ERR(set);
 		goto err_out;
 	}
 
 	/* only when everything was successful, update internal state */
-	btf->hdr = hdr;
 	btf->types_data = types;
-	btf->types_data_cap = btf->hdr->type_len;
+	btf->types_data_cap = btf->hdr.type_len;
 	btf->strs_data = NULL;
 	btf->strs_set = set;
+	if (layout)
+		btf->layout = layout;
 	/* if BTF was created from scratch, all strings are guaranteed to be
 	 * unique and deduplicated
 	 */
-	if (btf->hdr->str_len == 0)
+	if (btf->hdr.str_len == 0)
 		btf->strs_deduped = true;
-	if (!btf->base_btf && btf->hdr->str_len == 1)
+	if (!btf->base_btf && btf->hdr.str_len == 1)
 		btf->strs_deduped = true;
 
 	/* invalidate raw_data representation */
 	btf_invalidate_raw_data(btf);
 
+	btf->modifiable = true;
+
 	return 0;
 
 err_out:
 	strset__free(set);
-	free(hdr);
 	free(types);
+	free(layout);
 	return err;
 }
 
@@ -1849,6 +1969,7 @@ static int btf_ensure_modifiable(struct btf *btf)
 int btf__find_str(struct btf *btf, const char *s)
 {
 	int off;
+	int err;
 
 	if (btf->base_btf) {
 		off = btf__find_str(btf->base_btf, s);
@@ -1857,8 +1978,9 @@ int btf__find_str(struct btf *btf, const char *s)
 	}
 
 	/* BTF needs to be in a modifiable state to build string lookup index */
-	if (btf_ensure_modifiable(btf))
-		return libbpf_err(-ENOMEM);
+	err = btf_ensure_modifiable(btf);
+	if (err)
+		return libbpf_err(err);
 
 	off = strset__find_str(btf->strs_set, s);
 	if (off < 0)
@@ -1875,6 +1997,7 @@ int btf__find_str(struct btf *btf, const char *s)
 int btf__add_str(struct btf *btf, const char *s)
 {
 	int off;
+	int err;
 
 	if (btf->base_btf) {
 		off = btf__find_str(btf->base_btf, s);
@@ -1882,14 +2005,15 @@ int btf__add_str(struct btf *btf, const char *s)
 			return off;
 	}
 
-	if (btf_ensure_modifiable(btf))
-		return libbpf_err(-ENOMEM);
+	err = btf_ensure_modifiable(btf);
+	if (err)
+		return libbpf_err(err);
 
 	off = strset__add_str(btf->strs_set, s);
 	if (off < 0)
 		return libbpf_err(off);
 
-	btf->hdr->str_len = strset__data_size(btf->strs_set);
+	btf->hdr.str_len = strset__data_size(btf->strs_set);
 
 	return btf->start_str_off + off;
 }
@@ -1897,7 +2021,7 @@ int btf__add_str(struct btf *btf, const char *s)
 static void *btf_add_type_mem(struct btf *btf, size_t add_sz)
 {
 	return libbpf_add_mem(&btf->types_data, &btf->types_data_cap, 1,
-			      btf->hdr->type_len, UINT_MAX, add_sz);
+			      btf->hdr.type_len, UINT_MAX, add_sz);
 }
 
 static void btf_type_inc_vlen(struct btf_type *t)
@@ -1905,16 +2029,31 @@ static void btf_type_inc_vlen(struct btf_type *t)
 	t->info = btf_type_info(btf_kind(t), btf_vlen(t) + 1, btf_kflag(t));
 }
 
+static void btf_hdr_update_type_len(struct btf *btf, int new_len)
+{
+	btf->hdr.type_len = new_len;
+	if (btf->layout) {
+		btf->hdr.layout_off = btf->hdr.type_off + new_len;
+		btf->hdr.str_off = btf->hdr.layout_off + btf->hdr.layout_len;
+	} else {
+		btf->hdr.str_off = btf->hdr.type_off + new_len;
+	}
+}
+
+static void btf_hdr_update_str_len(struct btf *btf, int new_len)
+{
+	btf->hdr.str_len = new_len;
+}
+
 static int btf_commit_type(struct btf *btf, int data_sz)
 {
 	int err;
 
-	err = btf_add_type_idx_entry(btf, btf->hdr->type_len);
+	err = btf_add_type_idx_entry(btf, btf->hdr.type_len);
 	if (err)
 		return libbpf_err(err);
 
-	btf->hdr->type_len += data_sz;
-	btf->hdr->str_off += data_sz;
+	btf_hdr_update_type_len(btf, btf->hdr.type_len + data_sz);
 	btf->nr_types++;
 	return btf->start_id + btf->nr_types - 1;
 }
@@ -1968,8 +2107,9 @@ static int btf_add_type(struct btf_pipe *p, const struct btf_type *src_type)
 		return libbpf_err(sz);
 
 	/* deconstruct BTF, if necessary, and invalidate raw_data */
-	if (btf_ensure_modifiable(p->dst))
-		return libbpf_err(-ENOMEM);
+	err = btf_ensure_modifiable(p->dst);
+	if (err)
+		return libbpf_err(err);
 
 	t = btf_add_type_mem(p->dst, sz);
 	if (!t)
@@ -2018,15 +2158,16 @@ int btf__add_btf(struct btf *btf, const struct btf *src_btf)
 	src_start_id = src_btf->base_btf ? btf__type_cnt(src_btf->base_btf) : 1;
 
 	/* deconstruct BTF, if necessary, and invalidate raw_data */
-	if (btf_ensure_modifiable(btf))
-		return libbpf_err(-ENOMEM);
+	err = btf_ensure_modifiable(btf);
+	if (err)
+		return libbpf_err(err);
 
 	/* remember original strings section size if we have to roll back
 	 * partial strings section changes
 	 */
-	old_strs_len = btf->hdr->str_len;
+	old_strs_len = btf->hdr.str_len;
 
-	data_sz = src_btf->hdr->type_len;
+	data_sz = src_btf->hdr.type_len;
 	cnt = src_btf->nr_types;
 
 	/* pre-allocate enough memory for new types */
@@ -2103,8 +2244,7 @@ int btf__add_btf(struct btf *btf, const struct btf *src_btf)
 	 * update type count and various internal offsets and sizes to
 	 * "commit" the changes and made them visible to the outside world.
 	 */
-	btf->hdr->type_len += data_sz;
-	btf->hdr->str_off += data_sz;
+	btf_hdr_update_type_len(btf, btf->hdr.type_len + data_sz);
 	btf->nr_types += cnt;
 
 	hashmap__free(p.str_off_map);
@@ -2115,13 +2255,14 @@ int btf__add_btf(struct btf *btf, const struct btf *src_btf)
 	/* zero out preallocated memory as if it was just allocated with
 	 * libbpf_add_mem()
 	 */
-	memset(btf->types_data + btf->hdr->type_len, 0, data_sz);
-	memset(btf->strs_data + old_strs_len, 0, btf->hdr->str_len - old_strs_len);
+	memset(btf->types_data + btf->hdr.type_len, 0, data_sz);
+	if (btf->strs_data)
+		memset(btf->strs_data + old_strs_len, 0, btf->hdr.str_len - old_strs_len);
 
 	/* and now restore original strings section size; types data size
 	 * wasn't modified, so doesn't need restoring, see big comment above
 	 */
-	btf->hdr->str_len = old_strs_len;
+	btf_hdr_update_str_len(btf, old_strs_len);
 
 	hashmap__free(p.str_off_map);
 
@@ -2141,6 +2282,7 @@ int btf__add_int(struct btf *btf, const char *name, size_t byte_sz, int encoding
 {
 	struct btf_type *t;
 	int sz, name_off;
+	int err;
 
 	/* non-empty name */
 	if (str_is_empty(name))
@@ -2152,8 +2294,9 @@ int btf__add_int(struct btf *btf, const char *name, size_t byte_sz, int encoding
 		return libbpf_err(-EINVAL);
 
 	/* deconstruct BTF, if necessary, and invalidate raw_data */
-	if (btf_ensure_modifiable(btf))
-		return libbpf_err(-ENOMEM);
+	err = btf_ensure_modifiable(btf);
+	if (err)
+		return libbpf_err(err);
 
 	sz = sizeof(struct btf_type) + sizeof(int);
 	t = btf_add_type_mem(btf, sz);
@@ -2189,6 +2332,7 @@ int btf__add_float(struct btf *btf, const char *name, size_t byte_sz)
 {
 	struct btf_type *t;
 	int sz, name_off;
+	int err;
 
 	/* non-empty name */
 	if (str_is_empty(name))
@@ -2199,8 +2343,9 @@ int btf__add_float(struct btf *btf, const char *name, size_t byte_sz)
 	    byte_sz != 16)
 		return libbpf_err(-EINVAL);
 
-	if (btf_ensure_modifiable(btf))
-		return libbpf_err(-ENOMEM);
+	err = btf_ensure_modifiable(btf);
+	if (err)
+		return libbpf_err(err);
 
 	sz = sizeof(struct btf_type);
 	t = btf_add_type_mem(btf, sz);
@@ -2234,12 +2379,14 @@ static int btf_add_ref_kind(struct btf *btf, int kind, const char *name, int ref
 {
 	struct btf_type *t;
 	int sz, name_off = 0;
+	int err;
 
 	if (validate_type_id(ref_type_id))
 		return libbpf_err(-EINVAL);
 
-	if (btf_ensure_modifiable(btf))
-		return libbpf_err(-ENOMEM);
+	err = btf_ensure_modifiable(btf);
+	if (err)
+		return libbpf_err(err);
 
 	sz = sizeof(struct btf_type);
 	t = btf_add_type_mem(btf, sz);
@@ -2284,13 +2431,15 @@ int btf__add_array(struct btf *btf, int index_type_id, int elem_type_id, __u32 n
 {
 	struct btf_type *t;
 	struct btf_array *a;
+	int err;
 	int sz;
 
 	if (validate_type_id(index_type_id) || validate_type_id(elem_type_id))
 		return libbpf_err(-EINVAL);
 
-	if (btf_ensure_modifiable(btf))
-		return libbpf_err(-ENOMEM);
+	err = btf_ensure_modifiable(btf);
+	if (err)
+		return libbpf_err(err);
 
 	sz = sizeof(struct btf_type) + sizeof(struct btf_array);
 	t = btf_add_type_mem(btf, sz);
@@ -2314,9 +2463,11 @@ static int btf_add_composite(struct btf *btf, int kind, const char *name, __u32
 {
 	struct btf_type *t;
 	int sz, name_off = 0;
+	int err;
 
-	if (btf_ensure_modifiable(btf))
-		return libbpf_err(-ENOMEM);
+	err = btf_ensure_modifiable(btf);
+	if (err)
+		return libbpf_err(err);
 
 	sz = sizeof(struct btf_type);
 	t = btf_add_type_mem(btf, sz);
@@ -2396,6 +2547,7 @@ int btf__add_field(struct btf *btf, const char *name, int type_id,
 	struct btf_member *m;
 	bool is_bitfield;
 	int sz, name_off = 0;
+	int err;
 
 	/* last type should be union/struct */
 	if (btf->nr_types == 0)
@@ -2416,8 +2568,9 @@ int btf__add_field(struct btf *btf, const char *name, int type_id,
 		return libbpf_err(-EINVAL);
 
 	/* decompose and invalidate raw data */
-	if (btf_ensure_modifiable(btf))
-		return libbpf_err(-ENOMEM);
+	err = btf_ensure_modifiable(btf);
+	if (err)
+		return libbpf_err(err);
 
 	sz = sizeof(struct btf_member);
 	m = btf_add_type_mem(btf, sz);
@@ -2439,8 +2592,7 @@ int btf__add_field(struct btf *btf, const char *name, int type_id,
 	/* update parent type's vlen and kflag */
 	t->info = btf_type_info(btf_kind(t), btf_vlen(t) + 1, is_bitfield || btf_kflag(t));
 
-	btf->hdr->type_len += sz;
-	btf->hdr->str_off += sz;
+	btf_hdr_update_type_len(btf, btf->hdr.type_len + sz);
 	return 0;
 }
 
@@ -2449,13 +2601,15 @@ static int btf_add_enum_common(struct btf *btf, const char *name, __u32 byte_sz,
 {
 	struct btf_type *t;
 	int sz, name_off = 0;
+	int err;
 
 	/* byte_sz must be power of 2 */
 	if (!byte_sz || (byte_sz & (byte_sz - 1)) || byte_sz > 8)
 		return libbpf_err(-EINVAL);
 
-	if (btf_ensure_modifiable(btf))
-		return libbpf_err(-ENOMEM);
+	err = btf_ensure_modifiable(btf);
+	if (err)
+		return libbpf_err(err);
 
 	sz = sizeof(struct btf_type);
 	t = btf_add_type_mem(btf, sz);
@@ -2511,6 +2665,7 @@ int btf__add_enum_value(struct btf *btf, const char *name, __s64 value)
 	struct btf_type *t;
 	struct btf_enum *v;
 	int sz, name_off;
+	int err;
 
 	/* last type should be BTF_KIND_ENUM */
 	if (btf->nr_types == 0)
@@ -2526,8 +2681,9 @@ int btf__add_enum_value(struct btf *btf, const char *name, __s64 value)
 		return libbpf_err(-E2BIG);
 
 	/* decompose and invalidate raw data */
-	if (btf_ensure_modifiable(btf))
-		return libbpf_err(-ENOMEM);
+	err = btf_ensure_modifiable(btf);
+	if (err)
+		return libbpf_err(err);
 
 	sz = sizeof(struct btf_enum);
 	v = btf_add_type_mem(btf, sz);
@@ -2549,8 +2705,7 @@ int btf__add_enum_value(struct btf *btf, const char *name, __s64 value)
 	if (value < 0)
 		t->info = btf_type_info(btf_kind(t), btf_vlen(t), true);
 
-	btf->hdr->type_len += sz;
-	btf->hdr->str_off += sz;
+	btf_hdr_update_type_len(btf, btf->hdr.type_len + sz);
 	return 0;
 }
 
@@ -2588,6 +2743,7 @@ int btf__add_enum64_value(struct btf *btf, const char *name, __u64 value)
 	struct btf_enum64 *v;
 	struct btf_type *t;
 	int sz, name_off;
+	int err;
 
 	/* last type should be BTF_KIND_ENUM64 */
 	if (btf->nr_types == 0)
@@ -2601,8 +2757,9 @@ int btf__add_enum64_value(struct btf *btf, const char *name, __u64 value)
 		return libbpf_err(-EINVAL);
 
 	/* decompose and invalidate raw data */
-	if (btf_ensure_modifiable(btf))
-		return libbpf_err(-ENOMEM);
+	err = btf_ensure_modifiable(btf);
+	if (err)
+		return libbpf_err(err);
 
 	sz = sizeof(struct btf_enum64);
 	v = btf_add_type_mem(btf, sz);
@@ -2621,8 +2778,7 @@ int btf__add_enum64_value(struct btf *btf, const char *name, __u64 value)
 	t = btf_last_type(btf);
 	btf_type_inc_vlen(t);
 
-	btf->hdr->type_len += sz;
-	btf->hdr->str_off += sz;
+	btf_hdr_update_type_len(btf, btf->hdr.type_len + sz);
 	return 0;
 }
 
@@ -2791,13 +2947,15 @@ int btf__add_func(struct btf *btf, const char *name,
 int btf__add_func_proto(struct btf *btf, int ret_type_id)
 {
 	struct btf_type *t;
+	int err;
 	int sz;
 
 	if (validate_type_id(ret_type_id))
 		return libbpf_err(-EINVAL);
 
-	if (btf_ensure_modifiable(btf))
-		return libbpf_err(-ENOMEM);
+	err = btf_ensure_modifiable(btf);
+	if (err)
+		return libbpf_err(err);
 
 	sz = sizeof(struct btf_type);
 	t = btf_add_type_mem(btf, sz);
@@ -2827,6 +2985,7 @@ int btf__add_func_param(struct btf *btf, const char *name, int type_id)
 	struct btf_type *t;
 	struct btf_param *p;
 	int sz, name_off = 0;
+	int err;
 
 	if (validate_type_id(type_id))
 		return libbpf_err(-EINVAL);
@@ -2839,8 +2998,9 @@ int btf__add_func_param(struct btf *btf, const char *name, int type_id)
 		return libbpf_err(-EINVAL);
 
 	/* decompose and invalidate raw data */
-	if (btf_ensure_modifiable(btf))
-		return libbpf_err(-ENOMEM);
+	err = btf_ensure_modifiable(btf);
+	if (err)
+		return libbpf_err(err);
 
 	sz = sizeof(struct btf_param);
 	p = btf_add_type_mem(btf, sz);
@@ -2860,8 +3020,7 @@ int btf__add_func_param(struct btf *btf, const char *name, int type_id)
 	t = btf_last_type(btf);
 	btf_type_inc_vlen(t);
 
-	btf->hdr->type_len += sz;
-	btf->hdr->str_off += sz;
+	btf_hdr_update_type_len(btf, btf->hdr.type_len + sz);
 	return 0;
 }
 
@@ -2880,6 +3039,7 @@ int btf__add_var(struct btf *btf, const char *name, int linkage, int type_id)
 	struct btf_type *t;
 	struct btf_var *v;
 	int sz, name_off;
+	int err;
 
 	/* non-empty name */
 	if (str_is_empty(name))
@@ -2891,8 +3051,9 @@ int btf__add_var(struct btf *btf, const char *name, int linkage, int type_id)
 		return libbpf_err(-EINVAL);
 
 	/* deconstruct BTF, if necessary, and invalidate raw_data */
-	if (btf_ensure_modifiable(btf))
-		return libbpf_err(-ENOMEM);
+	err = btf_ensure_modifiable(btf);
+	if (err)
+		return libbpf_err(err);
 
 	sz = sizeof(struct btf_type) + sizeof(struct btf_var);
 	t = btf_add_type_mem(btf, sz);
@@ -2929,13 +3090,15 @@ int btf__add_datasec(struct btf *btf, const char *name, __u32 byte_sz)
 {
 	struct btf_type *t;
 	int sz, name_off;
+	int err;
 
 	/* non-empty name */
 	if (str_is_empty(name))
 		return libbpf_err(-EINVAL);
 
-	if (btf_ensure_modifiable(btf))
-		return libbpf_err(-ENOMEM);
+	err = btf_ensure_modifiable(btf);
+	if (err)
+		return libbpf_err(err);
 
 	sz = sizeof(struct btf_type);
 	t = btf_add_type_mem(btf, sz);
@@ -2968,6 +3131,7 @@ int btf__add_datasec_var_info(struct btf *btf, int var_type_id, __u32 offset, __
 {
 	struct btf_type *t;
 	struct btf_var_secinfo *v;
+	int err;
 	int sz;
 
 	/* last type should be BTF_KIND_DATASEC */
@@ -2981,8 +3145,9 @@ int btf__add_datasec_var_info(struct btf *btf, int var_type_id, __u32 offset, __
 		return libbpf_err(-EINVAL);
 
 	/* decompose and invalidate raw data */
-	if (btf_ensure_modifiable(btf))
-		return libbpf_err(-ENOMEM);
+	err = btf_ensure_modifiable(btf);
+	if (err)
+		return libbpf_err(err);
 
 	sz = sizeof(struct btf_var_secinfo);
 	v = btf_add_type_mem(btf, sz);
@@ -2997,8 +3162,7 @@ int btf__add_datasec_var_info(struct btf *btf, int var_type_id, __u32 offset, __
 	t = btf_last_type(btf);
 	btf_type_inc_vlen(t);
 
-	btf->hdr->type_len += sz;
-	btf->hdr->str_off += sz;
+	btf_hdr_update_type_len(btf, btf->hdr.type_len + sz);
 	return 0;
 }
 
@@ -3007,6 +3171,7 @@ static int btf_add_decl_tag(struct btf *btf, const char *value, int ref_type_id,
 {
 	struct btf_type *t;
 	int sz, value_off;
+	int err;
 
 	if (str_is_empty(value) || component_idx < -1)
 		return libbpf_err(-EINVAL);
@@ -3014,8 +3179,9 @@ static int btf_add_decl_tag(struct btf *btf, const char *value, int ref_type_id,
 	if (validate_type_id(ref_type_id))
 		return libbpf_err(-EINVAL);
 
-	if (btf_ensure_modifiable(btf))
-		return libbpf_err(-ENOMEM);
+	err = btf_ensure_modifiable(btf);
+	if (err)
+		return libbpf_err(err);
 
 	sz = sizeof(struct btf_type) + sizeof(struct btf_decl_tag);
 	t = btf_add_type_mem(btf, sz);
@@ -3639,10 +3805,9 @@ int btf__dedup(struct btf *btf, const struct btf_dedup_opts *opts)
 		return libbpf_err(-EINVAL);
 	}
 
-	if (btf_ensure_modifiable(btf)) {
-		err = -ENOMEM;
+	err = btf_ensure_modifiable(btf);
+	if (err)
 		goto done;
-	}
 
 	err = btf_dedup_prep(d);
 	if (err) {
@@ -3962,7 +4127,7 @@ static int btf_dedup_strings(struct btf_dedup *d)
 
 	/* replace BTF string data and hash with deduped ones */
 	strset__free(d->btf->strs_set);
-	d->btf->hdr->str_len = strset__data_size(d->strs_set);
+	btf_hdr_update_str_len(d->btf, strset__data_size(d->strs_set));
 	d->btf->strs_set = d->strs_set;
 	d->strs_set = NULL;
 	d->btf->strs_deduped = true;
@@ -5409,14 +5574,17 @@ static int btf_dedup_compact_types(struct btf_dedup *d)
 	/* shrink struct btf's internal types index and update btf_header */
 	d->btf->nr_types = next_type_id - d->btf->start_id;
 	d->btf->type_offs_cap = d->btf->nr_types;
-	d->btf->hdr->type_len = p - d->btf->types_data;
+	d->btf->hdr.type_len = p - d->btf->types_data;
 	new_offs = libbpf_reallocarray(d->btf->type_offs, d->btf->type_offs_cap,
 				       sizeof(*new_offs));
 	if (d->btf->type_offs_cap && !new_offs)
 		return -ENOMEM;
 	d->btf->type_offs = new_offs;
-	d->btf->hdr->str_off = d->btf->hdr->type_len;
-	d->btf->raw_size = d->btf->hdr->hdr_len + d->btf->hdr->type_len + d->btf->hdr->str_len;
+	if (d->btf->layout)
+		d->btf->hdr.layout_off = d->btf->hdr.type_off + d->btf->hdr.type_len;
+	d->btf->hdr.str_off = d->btf->hdr.type_off + d->btf->hdr.type_len + d->btf->hdr.layout_len;
+	d->btf->raw_size = d->btf->hdr.hdr_len + d->btf->hdr.type_off + d->btf->hdr.type_len +
+			   d->btf->hdr.layout_len + d->btf->hdr.str_len;
 	return 0;
 }
 
@@ -5874,7 +6042,7 @@ int btf__distill_base(const struct btf *src_btf, struct btf **new_base_btf,
 		goto done;
 	}
 	dist.split_start_id = btf__type_cnt(old_base);
-	dist.split_start_str = old_base->hdr->str_len;
+	dist.split_start_str = old_base->hdr.str_len;
 
 	/* Pass over src split BTF; generate the list of base BTF type ids it
 	 * references; these will constitute our distilled BTF set to be
@@ -5943,14 +6111,14 @@ int btf__distill_base(const struct btf *src_btf, struct btf **new_base_btf,
 
 const struct btf_header *btf_header(const struct btf *btf)
 {
-	return btf->hdr;
+	return &btf->hdr;
 }
 
 void btf_set_base_btf(struct btf *btf, const struct btf *base_btf)
 {
 	btf->base_btf = (struct btf *)base_btf;
 	btf->start_id = btf__type_cnt(base_btf);
-	btf->start_str_off = base_btf->hdr->str_len + base_btf->start_str_off;
+	btf->start_str_off = base_btf->hdr.str_len + base_btf->start_str_off;
 }
 
 int btf__relocate(struct btf *btf, const struct btf *base_btf)
@@ -6017,16 +6185,15 @@ int btf__permute(struct btf *btf, __u32 *id_map, __u32 id_map_cnt,
 		goto done;
 	}
 
-	new_types = calloc(btf->hdr->type_len, 1);
+	new_types = calloc(btf->hdr.type_len, 1);
 	if (!new_types) {
 		err = -ENOMEM;
 		goto done;
 	}
 
-	if (btf_ensure_modifiable(btf)) {
-		err = -ENOMEM;
+	err = btf_ensure_modifiable(btf);
+	if (err)
 		goto done;
-	}
 
 	for (i = start_offs; i < id_map_cnt; i++) {
 		id = id_map[i];
-- 
2.39.3

