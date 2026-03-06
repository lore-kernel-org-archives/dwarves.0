Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D882264C0;
	Fri,  6 Mar 2026 11:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772797021; cv=none; b=V2Skwo4CCPUdZ9/JrGzoB92/bcNSGOZubKnhxyHgml3000xBjSYu5tEzRxH12Zi0c2sgZzQ5el9oEvSshAsVdMZnUMpe/5LyV9HBkuP5poHUdGN8xlfiqg9V28q8TRsALAGaWCBRB+rcsURfoG4GKr0tT1E3ZQgVPjF7qevHSI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772797021; c=relaxed/simple;
	bh=7lx5RQgAu8tuCa5/y0LmMXgKvily/v6Qd02zsj0mNNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dzOyBonAYb36YP6e7CC12EqsS8PWGjGkNay3pDLNioG6YrrRTtSmSIuvK/gma0knlDZU0wc1iLceCvRlZlY9I+2SMsGPZ2qaZCHjPHldBydrC4iE4Pq92rOGKaEhh1OT1x8L1OsFSftsDANcRL+1mTqzO+dXFQo/+LcWP61rHGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NNuUUGms; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NNuUUGms"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 626AtwgW2395656;
	Fri, 6 Mar 2026 11:36:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=mlJGl
	TC/TiGAhOdLcvKPcmF12d02ePjIk6H4VEHMkrk=; b=NNuUUGms4JLefzAlLgKU6
	m3ehWMqbS2rEFt+laWGLzkmfp2Wa1+uVTg1WqZKxKPR5Nq/zPJZZ0K0SKkYqCVBe
	M7fNAmDPNGF8DjUJx/9LZAKChWXsK9x3SFvNCRNCn7ctI0WfENClVaelovfUB8G5
	2wu4WXQzaMptz6S7FMYZtWQRlpSsf9NwSyPVxNKwAsDo55YxSgMxoZnpZaLa0HGb
	gqiTiTy7D3VWoUxd33n1WVpvimOlQbH7zPPOG5B/Cn5Qv0BUV8ytErRefYU+Jfjw
	oVHiUwUcEtfbM7uSzy+ZZNUMrk8RY32UwUl247aoGfWzQBDNzJxTD7wUPpONRvnp
	w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cqwkp01gq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Mar 2026 11:36:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62695Bkd023030;
	Fri, 6 Mar 2026 11:36:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ckptjtmqr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Mar 2026 11:36:37 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 626BaXEr025727;
	Fri, 6 Mar 2026 11:36:36 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-62-192.vpn.oracle.com [10.154.62.192])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4ckptjtmhd-2;
	Fri, 06 Mar 2026 11:36:36 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        mykyta.yatsenko5@gmail.com, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v13 bpf-next 1/8] btf: add BTF kind layout encoding to UAPI
Date: Fri,  6 Mar 2026 11:36:23 +0000
Message-ID: <20260306113630.1281527-2-alan.maguire@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDExMCBTYWx0ZWRfX8jAAncah7eI/
 bhvlpp0KOQuLZeTdlezRQz+kUADUFD5TefyTKqiCyGL7ssbUMiAGmNwsCXNRb6vlji4UwHPzkIQ
 KSe2+Mo+4pxceFTdm9byugI2i1XIcssAm2Y2S5x4GvhwQhr4kDCe86scuXY6CNGXJZdE5mpG8hW
 Iv+xzXWC2Ua6Jq9abmcyQrmrinG2j6Sy5/kkHLT29QsFJ68yQUlP7+WZq3Dido6xl/nLP2HmFli
 m3sUqCH51hzIxmIQECXV/sjBDo8lmZEJD+bNCYCeKiSJDkzPOTz0t57N6X+YRXiDNOUF9lyLxE8
 mEt0nTbF4pBEAuYkjheVLFia6zTu6p1BnYWGS6TMLiTehtyjB1pmpPTD8aV+OghddjdzXJJ7/7A
 PnIviJuhAtzPZi9AwtHhx5btTCIKAs/LS3ImLlFk5MUdxSZTbgmDr8Yw2wq+BlW0WoPF6bkzDaU
 Hd7Lea2ePrtXzmRzCbi0agrXLckPilGVkJv2ED0M=
X-Proofpoint-ORIG-GUID: MxNFOTQImZec0POzN_rD1svn_mlEgxjQ
X-Proofpoint-GUID: MxNFOTQImZec0POzN_rD1svn_mlEgxjQ
X-Authority-Analysis: v=2.4 cv=Rc2dyltv c=1 sm=1 tr=0 ts=69aabc46 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8
 a=juZ357eHEe9gvkRO8XoA:9 cc=ntf awl=host:12267

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

