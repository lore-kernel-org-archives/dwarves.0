Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95ECE3FEB04;
	Thu, 26 Mar 2026 14:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774536943; cv=none; b=NixEAYazzVAJk69UDO6OT6oe+w/9kRUMMI+ZcQNV2kIKoHVY+zLm7TY86H2GVQZqrvAYWCGwQZKXoLfPATQP1LnjzfwN7xjeMeDAjNyRLtV5h/C8N3UhGUHukCfA4cciRZzHWGsiCi7fHr/ykYi8sWTMowgaAu2Kf0yKzYIvF20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774536943; c=relaxed/simple;
	bh=Vl8d+1lloIOpJRAoS12Cp0A3vK8mnBKYu4DEwbR+X4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=af6vz0wwp4aG31N+sNV6Dw8U2QS3Be1LsT/4kPephuDjvMLt7hNoRJd6Oht8iTK1nHkJu2X9+uL+yzwpsmGDhrdu8ro7KeKo+8JZMzk7zweXxhNapd9HPKVLBJIlxF+BL/GM+3Us3mx7XaebWq+cF96xNaBE+esMLbuMZMUkVNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=r53IyYZz; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="r53IyYZz"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62Q71t1u2664761;
	Thu, 26 Mar 2026 14:55:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=xrbpE
	90Tswxkx7Bq0apvQT9aEigEF/KUczrfJPjSyfs=; b=r53IyYZzwy1ZKNk1+XsiG
	cIDnc/Cv7pBv2XK/TMGJg0eOZOxufqZ0AJTaYTADuCr57UCChTEHnPRQi3vrai+C
	vIVyFvyoYHkw1eoC41sH5pmHXlsJ1uM/DoP2RSw8iU5bVhdnVnY+rnxhjk8JvB0R
	kqtb2cvuLM1qHjJLu0UB8J7AFNP2R9bOmqIZ+Sy/TG5pDW687GEYWnEdxmtMdc2i
	KwBbB4alIoZgBBbnRqANBXQyJEBixIfBRwk7DZO+jCbrS+gKqU5+b0513iNYjfJt
	TyFLDKyyVYjNr9FX0O5VERb4CX/B2IeLZNJr5H5Qxjb97wQHFbGq4Lnj5smQDi5u
	A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d1kj2gchh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Mar 2026 14:55:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62QEbQUU000648;
	Thu, 26 Mar 2026 14:55:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4d1hsd2434-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Mar 2026 14:55:17 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62QEslTL015958;
	Thu, 26 Mar 2026 14:55:17 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-54-22.vpn.oracle.com [10.154.54.22])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4d1hsd235q-10;
	Thu, 26 Mar 2026 14:55:16 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
        qmo@kernel.org, ihor.solodrai@linux.dev, mykyta.yatsenko5@gmail.com,
        dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v16 bpf-next 9/9] kbuild, bpf: Specify "layout" optional feature
Date: Thu, 26 Mar 2026 14:54:44 +0000
Message-ID: <20260326145444.2076244-10-alan.maguire@oracle.com>
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
X-Proofpoint-ORIG-GUID: 5jcI45qO6VHMgTknXCLMj4DIzl235WQ2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDEwNSBTYWx0ZWRfX1jzLCNYbbxji
 5prc+p5Tuz8F/X98KvhOTldRrGeCXj0f+fj7aAbDzylS32NEeXu50Sf1b8zfI2QuA7C+k2Xj99U
 6GSUOrrc8TOD4zo62JIrY+MXansRwpADshqgQropfL4fLoErJdlsOeltmRdh8USNUyk2jsqdGcv
 5R+X4PETUlLt2oH+cO+IJ1PlWn9wQ0n2rO9HGjQozir6hVRCSF4DwerIrkSySHcb3/LQGSggNNk
 5EzbzvCICbVnPK1dYl8nP/HmdLXXp5uA8/p7kOLF/dKHszZi4y1/wFkR0HtW4gO8yuq2P6laxaD
 3OBzyGdI6eT0FxSTjkFcObCUJ7ucKQc/04Z6QdZDiGuEEsFJfVbD6ftNyLQ5ZctNXA44iFWf5ya
 7EOCW6gTGN+afcNCUxYbpm2sxiGWytAaid9a1k5RwjwPik+LTZl4wIKR9ENbDqnf2wk+eFuFKvy
 7+H3oezWKa1bd8Pn4nQ==
X-Proofpoint-GUID: 5jcI45qO6VHMgTknXCLMj4DIzl235WQ2
X-Authority-Analysis: v=2.4 cv=KtJAGGWN c=1 sm=1 tr=0 ts=69c548d6 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=yPCof4ZbAAAA:8 a=J4qZCyyk7QvxA2XVlwcA:9

The "layout" feature will add metadata about BTF kinds to the
generated BTF; its absence in pahole will not trigger an error so it
is safe to add unconditionally as it will simply be ignored if pahole
does not support it.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 scripts/Makefile.btf | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
index 562a04b40e06..e66e13e79653 100644
--- a/scripts/Makefile.btf
+++ b/scripts/Makefile.btf
@@ -18,6 +18,8 @@ pahole-flags-$(call test-ge, $(pahole-ver), 126)  = -j$(JOBS) --btf_features=enc
 
 pahole-flags-$(call test-ge, $(pahole-ver), 130) += --btf_features=attributes
 
+pahole-flags-$(call test-ge, $(pahole-ver), 131) += --btf_features=layout
+
 endif
 
 pahole-flags-$(CONFIG_PAHOLE_HAS_LANG_EXCLUDE)		+= --lang_exclude=rust
-- 
2.39.3

