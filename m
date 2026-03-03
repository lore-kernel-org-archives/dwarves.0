Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57954348469;
	Tue,  3 Mar 2026 18:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772562047; cv=none; b=nveLxuONh1Dw7IW8aGWG9DIOtIp7Q62yBuze04/zXlGCZTB9vrtBKorwfCc3pVxkKmPvpkVd4/2RlHSETu5mV+2URbTTuJHQi6/kiX9NwlyLDzSfj3iMUP+rlp3ZJYqq6q75gv63c6PVsGNOl3KOkIWXFqL08y7xvD44c6rB7hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772562047; c=relaxed/simple;
	bh=7lx5RQgAu8tuCa5/y0LmMXgKvily/v6Qd02zsj0mNNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fwL+mIMOUwON66lY5hvKvTwheqnc1kSLmhrI4jmtTB8Bw25frOhugplcAMAKxerxf7NHoME//zN2NOvRDhOigA5qkwRnG8W8bOJ01K536hGu3BiwZgj4u36fucWhqUrycgmLzj8Sbzwe97Cr14I25ZnRJawMktmDCuCHEBOiatY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cUo6iNja; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cUo6iNja"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 623GXCt03927295;
	Tue, 3 Mar 2026 18:20:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=mlJGl
	TC/TiGAhOdLcvKPcmF12d02ePjIk6H4VEHMkrk=; b=cUo6iNja9BekheYh270xc
	DZK5giWmfkOLMAdiHrPYu68NfHpOWKHmEQcC90zROmy8Z8G5GNA+hyEsyYbfI9yj
	Ffn5mr+2fD6J4oU6A4NyGe55onxqYls1ghRDEsAamZ1x71yZ8M5UNclGzptav1ZJ
	SUh+/hkwlJQanBEqkKNEUcI+Km1xEiXdupFvWfEX+yXO2aZIotfac2ZJx3SdD+8N
	P5rh900s5Dci+jq7ELcA+4NBhQEykW4fsQJz+tHp39KYwShCQ6jwKAI48U6S7kCx
	oz0Sr8OuOIfVvBip3kLhXsoMCGFOHaw1iyK9AstwTSWRl+HvpvgVt5P/hwQ/wJp8
	Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cp38ug6u6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Mar 2026 18:20:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 623HJKJ9037803;
	Tue, 3 Mar 2026 18:20:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ckpteyy6b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Mar 2026 18:20:10 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 623IK7o5029269;
	Tue, 3 Mar 2026 18:20:10 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-62-133.vpn.oracle.com [10.154.62.133])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4ckpteyxu6-2;
	Tue, 03 Mar 2026 18:20:09 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        mykyta.yatsenko5@gmail.com, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v12 bpf-next 1/8] btf: add BTF kind layout encoding to UAPI
Date: Tue,  3 Mar 2026 18:19:56 +0000
Message-ID: <20260303182003.117483-2-alan.maguire@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDE0OCBTYWx0ZWRfX4D9QcpmlR2am
 l56r9psYusZw+Hunwh+enbWA0Xaxh3wT+CdYgoA+YGxd4mUrRO3TcNJySftfoHgnh6B7jXsIuWn
 oelOCBs30Zb79r6aDSx15B20ZO8yuscCgvJkGp3DtqM3shpJkpZnvvMfTAGuDAd0f3JLEaRbTfw
 +0CrmivU63LfAugqeseJM9W40QcWKdVt9NzUNyNOJMWwR0jvVcPsuw9DD+6KHZ7PQLvOBKYAcBd
 r30kNkkIhasPVvur8Ai3c20mNI2obUczDoLX0arvASzyXnswe49zvWsXoZTpSp6pDpr9hzEK1lH
 QKEjHLEdICJsmfuRMBYJVha55NSl8usAdTNW/qD7U5bF29+alrsyxsMBwVXVESc6I8qUxMKGdRb
 rsKYUnD3I0UEBPt+msJ3vq1ua/ber6Mdd2mYe8C3GrHpXEIRko9OKdGo57KPMN7UqwELzlg47Zk
 o4wv9OaH5rQZ1fFpEb+3YJcVx4TtDIEUeHnwwCgQ=
X-Authority-Analysis: v=2.4 cv=AIMSTgfK c=1 sm=1 tr=0 ts=69a7265c b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8
 a=juZ357eHEe9gvkRO8XoA:9 cc=ntf awl=host:13812
X-Proofpoint-GUID: XZ7cbYsCuYI80jgH6lEChFqE51CZwo9p
X-Proofpoint-ORIG-GUID: XZ7cbYsCuYI80jgH6lEChFqE51CZwo9p

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

