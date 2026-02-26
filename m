Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C58D39282E;
	Thu, 26 Feb 2026 09:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772097035; cv=none; b=BHgY1waoq+q2jXTJgJk2TWjCpcXZuyG6I63wTnmaVmBn8ko0Ksv1EEuO42nAuUjqxeqX2vW0fR3+kdLpTrPEGnS623/2qg6NKMLv7osOPo0LN3r3zYkncI3Mu5Ytn3AdQnyPBzxDFnVO0OcehgeaAUA7mHp4Dtdvr7wVWUSEq/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772097035; c=relaxed/simple;
	bh=7lx5RQgAu8tuCa5/y0LmMXgKvily/v6Qd02zsj0mNNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dcxMwDIfIk+4M6FdKCgH4+oHjkz+4bCLUrs7kFG6Bs2v0wUkwAlPhrzo6wSGuzGR6xwE0B2Qwz4pWHpT48VF4nODzYNe9ryvYhQ5TXe0YbIPk0nkF3qBMSYX+azHhB8zeRQv8I3Z8vOLfsJGZcNyT/2ZV89m5oHYz344PUQz6t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YmbbjDgK; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YmbbjDgK"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61Q62hbr4032387;
	Thu, 26 Feb 2026 09:10:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=mlJGl
	TC/TiGAhOdLcvKPcmF12d02ePjIk6H4VEHMkrk=; b=YmbbjDgKL/Y162XJFxcvb
	86pF8eqAa2rYg4le3ylEqCMBfGD2duh5L5UoSr5O1gVsUMPRlGzHXUZfyPc9qY9F
	FIpVx2JgL0ZsmGAf73WxfynsKmTP61yuJDjjY0o9yTfXOwqgmZ5vD21Jo2g04uX9
	W0We6o4v0fdpRm8198TrCFEmHpHMVSYj2t6/+8xQQ9uZVLs9qT9GXoa8y55B47Mt
	Pg05A6FjTDjcpGJauQX/Js3h68gBealcxYM/DpiOmbwB9GIKQ35t41/mUbWH2VRl
	fR2SakDurkGkhg/M3MExVBZdgia4jLJ9mNaEDvBfM5cPvfRLrTBswBro0sYGP7bH
	g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cjgjfr6pf-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Feb 2026 09:10:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61Q7JjSi028500;
	Thu, 26 Feb 2026 08:56:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cf35c75ck-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Feb 2026 08:56:38 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 61Q8uYaS038952;
	Thu, 26 Feb 2026 08:56:37 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-58-146.vpn.oracle.com [10.154.58.146])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4cf35c759a-2;
	Thu, 26 Feb 2026 08:56:37 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        mykyta.yatsenko5@gmail.com, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v9 bpf-next 01/10] btf: add BTF kind layout encoding to UAPI
Date: Thu, 26 Feb 2026 08:56:15 +0000
Message-ID: <20260226085624.1909682-2-alan.maguire@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDA4MiBTYWx0ZWRfX6OhSbogCjh0x
 vMdbpe64tEjctESXnJu7N6nZOvYnfOgZpuwmD7OAl0HkhOW+ZWNKVlkMHo6V1uxPlV7nNJcpMus
 KcKqwQuGEFsjqd3VfguX7hBCF7lrqVTr+kFfuVBK8mfPa+N0XCXWwTCTIWzSI+QA1RnJTqACwN+
 VpX3ZFOpAumMTGK+XlXo4sjL/6QwglkB4OTpq0O6SrjcfSkfenzF2wEN7QYGajUhBMDNSTgL5Ta
 u//3DZZMzh6LuWcRi1pjJPovPVUKI2lApvFhUiuTE0uhvyBL/oxC2uelxHObNgyUl7PLHA0UkG1
 sCd3Z17KHJd4uoFOzX377sXuktFRx9EFpxc28aLxPxJrFHluZEhnx9aQfPJAGxBuCOErPIMC91D
 wnWH/vy81iD0TU+hxelExI7LkeDt9DXVDJ3TDtrV7tlZrSdgtKB4RoXcIM61yuawWOxgUaFckl5
 MQK+uaPlbgxG7+j1XzA==
X-Proofpoint-ORIG-GUID: Ujol1BYaXT1f5v-WvRRur0I5zqqmMwg8
X-Proofpoint-GUID: Ujol1BYaXT1f5v-WvRRur0I5zqqmMwg8
X-Authority-Analysis: v=2.4 cv=L/oQguT8 c=1 sm=1 tr=0 ts=69a00df3 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8
 a=juZ357eHEe9gvkRO8XoA:9

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

