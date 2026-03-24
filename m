Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FF8408221;
	Tue, 24 Mar 2026 17:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774374317; cv=none; b=cOQF2mES3UBwWSvdWXQ3nXWKi4ErM2IIl+HYbRGXeSsBUrI8BjkBMuVxZY2FdCJA4X9VRp1xmfZZshJtg9fErEzgsj1IqHaS4skg3QdvdE8vyOaccmtlotyptNk+iGvgSrw9k/upV/4RUzmasGlfSo8z77+iL6jQ/Jp0xcp7WLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774374317; c=relaxed/simple;
	bh=7lx5RQgAu8tuCa5/y0LmMXgKvily/v6Qd02zsj0mNNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I080j7TBtLwwTgq55S9pP0x9jxyEK4HyjszTTgHZpTuQLWZkvxvCR45cxUGtuoUeTMj7NNld/rBTdosRdFdAeo3oqIFoiKIxP5vSXCfLXK3+V0WcXSfOifzTuEtbWV7egCwjfG/g8Zr5lSwEsScx0IWmQh8LsNqcAqS8LCVyRHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=i7CZXbjk; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i7CZXbjk"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62OCCIpq1022567;
	Tue, 24 Mar 2026 17:44:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=mlJGl
	TC/TiGAhOdLcvKPcmF12d02ePjIk6H4VEHMkrk=; b=i7CZXbjkovXRiqF5KU5Zv
	0JCorGllHsAIUgoJHJXZAUQBOM0t84lmv5B9eA+jWUCfJ4U6+ys2Kog6CwL84KfY
	i4ZiP/VK36smFzIV4XbbgbqVHIABBEP4wsa509SGHZZNjNcHZLGgOBHTuMozcdNm
	rSA+9o5vShznALwLApCaGrBYbN1g19zyk2hRsJJmHS1HJqgmG1YcXkBwNCTTrlFU
	ILS5cxfrdWbMFDe92g0zOicHWzH3+JeZLhBGX2450kBJ4Jsh1mPLWiJcFwfz+k7k
	EWD3F3KCyGax2fhF6hDVE3BA9TGfZa14FAMVYEVBPyXwMaZT7LxxGfutuwuwkW30
	Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d1kfpmr20-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 17:44:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62OG3MlY038879;
	Tue, 24 Mar 2026 17:44:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4d1hsac72m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 17:44:55 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62OHirgk035539;
	Tue, 24 Mar 2026 17:44:55 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-54-179.vpn.oracle.com [10.154.54.179])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4d1hsac706-2;
	Tue, 24 Mar 2026 17:44:55 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
        qmo@kernel.org, ihor.solodrai@linux.dev, mykyta.yatsenko5@gmail.com,
        dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v15 bpf-next 1/9] btf: Add BTF kind layout encoding to UAPI
Date: Tue, 24 Mar 2026 17:44:42 +0000
Message-ID: <20260324174450.1570809-2-alan.maguire@oracle.com>
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
X-Proofpoint-GUID: kDW_B0547O91isKIRY_1UNvyN0tmGn5o
X-Authority-Analysis: v=2.4 cv=VKnQXtPX c=1 sm=1 tr=0 ts=69c2cd98 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8
 a=juZ357eHEe9gvkRO8XoA:9 cc=ntf awl=host:13824
X-Proofpoint-ORIG-GUID: kDW_B0547O91isKIRY_1UNvyN0tmGn5o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDEzOCBTYWx0ZWRfX9oxUC2ge45Zx
 kVGmwhJjBbnTgQkavyC+4OAZwtlO/z752TksLXu4fHkx7jVsxMoWfyk32daLdfgt1iJwMY/Q//7
 V47DGifN0xak+6Oza0Cw1HvplJm6E4PQ1O4GOcpJYykTQvcZBqGBQxQ1euTJhRRoewO44qRBvbi
 C+RGpb4R8uXgYF/Ag7F+VXQmdR2WleDcEwXTEYKehTHe/ygk/7lQkLrwHzFCjgyE1WPfnWxis2x
 wCZ6U7dqluCKlE9mPOXNIlWI7mOY7QMjXsnVEOuixQwYQVDgeU86nJUABfefCaArPO9zf+JzRvz
 mieAScWTcOwXJOExXqN8kn1y7RsTM/30+BvkFydUg20ZVGx9fVI038jhWyaxVqs3HgNqvLoRnYG
 k/AfkOuV4MoJERx+8GukDfnPCgEzus5kYnxPgka7rOwmGOr763fn0jSNZ85aLwqIadtNKTVbcRI
 oy8GzRHlJTK9mWp1uP2K7AmRR2tNm481nsjaKUok=

BTF kind layouts provide information to parse BTF kinds. By separating
parsing BTF from using all the information it provides, we allow BTF
to encode new features even if they cannot be used by readers. This
will be helpful in particular for cases where older tools are used
to parse newer BTF with kinds the older tools do not recognize;
the BTF can still be parsed in such cases using kind layout.

The intent is to support encoding of kind layouts optionally so that
tools like pahole can add this information. For each kind, we record

- length of singular element following struct btf_type
- length of each of the btf_vlen() elements following
- a (currently unused) flags field

The ideas here were discussed at [1], [2]; hence

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

[1] https://lore.kernel.org/bpf/CAEf4BzYjWHRdNNw4B=eOXOs_ONrDwrgX4bn=Nuc1g8JPFC34MA@mail.gmail.com/
[2] https://lore.kernel.org/bpf/20230531201936.1992188-1-alan.maguire@oracle.com/
---
 include/uapi/linux/btf.h       | 12 ++++++++++++
 tools/include/uapi/linux/btf.h | 12 ++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/uapi/linux/btf.h b/include/uapi/linux/btf.h
index 266d4ffa6c07..638615ebddc2 100644
--- a/include/uapi/linux/btf.h
+++ b/include/uapi/linux/btf.h
@@ -8,6 +8,16 @@
 #define BTF_MAGIC	0xeB9F
 #define BTF_VERSION	1
 
+/*
+ * BTF layout section consists of a struct btf_layout for each known
+ * kind at BTF encoding time.
+ */
+struct btf_layout {
+	__u8 info_sz;		/* size of singular element after btf_type */
+	__u8 elem_sz;		/* size of each of btf_vlen(t) elements */
+	__u16 flags;		/* currently unused */
+};
+
 struct btf_header {
 	__u16	magic;
 	__u8	version;
@@ -19,6 +29,8 @@ struct btf_header {
 	__u32	type_len;	/* length of type section	*/
 	__u32	str_off;	/* offset of string section	*/
 	__u32	str_len;	/* length of string section	*/
+	__u32	layout_off;	/* offset of layout section	*/
+	__u32	layout_len;	/* length of layout section	*/
 };
 
 /* Max # of type identifier */
diff --git a/tools/include/uapi/linux/btf.h b/tools/include/uapi/linux/btf.h
index 266d4ffa6c07..638615ebddc2 100644
--- a/tools/include/uapi/linux/btf.h
+++ b/tools/include/uapi/linux/btf.h
@@ -8,6 +8,16 @@
 #define BTF_MAGIC	0xeB9F
 #define BTF_VERSION	1
 
+/*
+ * BTF layout section consists of a struct btf_layout for each known
+ * kind at BTF encoding time.
+ */
+struct btf_layout {
+	__u8 info_sz;		/* size of singular element after btf_type */
+	__u8 elem_sz;		/* size of each of btf_vlen(t) elements */
+	__u16 flags;		/* currently unused */
+};
+
 struct btf_header {
 	__u16	magic;
 	__u8	version;
@@ -19,6 +29,8 @@ struct btf_header {
 	__u32	type_len;	/* length of type section	*/
 	__u32	str_off;	/* offset of string section	*/
 	__u32	str_len;	/* length of string section	*/
+	__u32	layout_off;	/* offset of layout section	*/
+	__u32	layout_len;	/* length of layout section	*/
 };
 
 /* Max # of type identifier */
-- 
2.39.3

