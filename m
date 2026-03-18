Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7123D8910;
	Wed, 18 Mar 2026 13:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773840622; cv=none; b=HMWpzWGjGDsFlQhECo5czUpv1zvUHtU+nd5dUMs0M3Nb4yp4bAw1bq3E5As+SpZXi7wcWbxc8Q67Ce1ArrttksEo6nrlmzoPbDCWmH/fWUrBvOatbgBWc+sCnLYXyhqIx6av+yJejGUQVBZfXSsv8bw4J6O5DUhLxcvBXmUj7To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773840622; c=relaxed/simple;
	bh=7lx5RQgAu8tuCa5/y0LmMXgKvily/v6Qd02zsj0mNNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VECk6aHifGEm4idTmo9nOx1BNKFt0xLI6KYP/CTsJxHwZrBtKHBvv3mqDNO2j4ncksJ85svrjOdX0TVpgdwk4BzRCwMvlCztm0tdXp0keGcYjffa0viuvz3j9J+KbWpfyKiUr4+vxAH0kAib7yy+jj4H+K1hwmtMCxi8TK45ips=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oHQ+6j9V; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oHQ+6j9V"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62I2N4qF2707496;
	Wed, 18 Mar 2026 13:29:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=mlJGl
	TC/TiGAhOdLcvKPcmF12d02ePjIk6H4VEHMkrk=; b=oHQ+6j9VZmavjPT9fFDjn
	g/ZhlMeFU99Hnp/y8DQOgNWhchBTPej/QaRJDWtIw6VgypzXjqVGb1wPsOe8UKbx
	Gn7RBVEvE6jA1za+rVy/SOERa/GW5TqyO8vR1kgTKn0CfWtAwvME39qQ0sJ35vMi
	u7BsWj57YH5auHE7RMmnVLUdgTCMOUu6GSNl3I03hjg+Q8qLk4gwDiFDMwwpb4im
	VU3MNha4U30gUGdgVef4eKs8yOrZ3O9wN+AxH7xvHEsIH3ti10m34hB1+euoQJ9P
	ugI59p3eJkVDGHwxODhgmweBdcJKOp0pM5BN9lLwhE7duhBGYK0tZkRIAt+gfZ/N
	A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvxf45yv7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Mar 2026 13:29:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62IBTYMM030497;
	Wed, 18 Mar 2026 13:29:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx4bmsw3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Mar 2026 13:29:36 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62IDTVfA009174;
	Wed, 18 Mar 2026 13:29:35 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-52-75.vpn.oracle.com [10.154.52.75])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4cvx4bmsqg-2;
	Wed, 18 Mar 2026 13:29:35 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        mykyta.yatsenko5@gmail.com, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v14 bpf-next 01/10] btf: Add BTF kind layout encoding to UAPI
Date: Wed, 18 Mar 2026 13:29:18 +0000
Message-ID: <20260318132927.1142388-2-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260318132927.1142388-1-alan.maguire@oracle.com>
References: <20260318132927.1142388-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603180114
X-Authority-Analysis: v=2.4 cv=ftrRpV4f c=1 sm=1 tr=0 ts=69baa8c1 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8
 a=juZ357eHEe9gvkRO8XoA:9
X-Proofpoint-GUID: LG1yxhaC-36LI2Xfxgt8N0RO56WWHvNS
X-Proofpoint-ORIG-GUID: LG1yxhaC-36LI2Xfxgt8N0RO56WWHvNS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDExNCBTYWx0ZWRfX3AX1IHLP4QhT
 7qDqM30c9beiu6ojm+IWFBwkUeZiFgWexzCqit9iHxwEhHe3XBbaTHpDZltnPVNEL9hI8Y5K1tX
 v2/7kULnNa211VzR0Reg/hfxrakMiVaeYLRciVfIz8VS9Ta8Zuwd6kmQ8oNoIzMLmfRxvAGITQR
 ttha4NbUHxJ0dlfZ9tXGf6JRbAOyN7RB3jlfaBeAvF3vETUjAg4KYldLyYejNnHp1ZHb19sVGDe
 dY8YKoZ1aiV1yb74O27LTSWQu4ikeF5TIf3KGItgD+JsdHFgbpbmj8CQI2j6YGJ0dryrWBhy3+R
 1HzW6TIeNyNrIgbNYJMQP+BY63VRkV2j31NStION0YjvP1zLiZFyr/iMaKUhuIm/AlIlaX3oYzf
 NAp3K4I8EMFicGPNN9TPrUIJ49tgXZcwXrVs8AdoZ9lr9SvfBTndUAK/6eHMJaqEIFDRuhiqJ6d
 k+CaeR5vxTf2xXwTXDw==

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

