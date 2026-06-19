Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33A33B19AC
	for <dwarves@vger.kernel.org>; Fri, 19 Jun 2026 15:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781882473; cv=none; b=lFzyHiylUerJkhSc3PtlOsI+1CxqJK8bN0eyYE+Z+1QQimk3jLAVCq2zbmWrpwpi0BZrEfTctWO6rKqr75jmFWMf2EwZ+UbTxBE1wg7/CKKIpxlgtskux7yerl2E9QiCHE3IzY3wliOZtlluPZMvV0MDyTPy+pUTk4o7J8TMBjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781882473; c=relaxed/simple;
	bh=IYSRHWdYRz7CMXDI166l+QddMimDsd8iK3xW1ioXWAY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V5u8uxjla0bnvKbFTRM+SWhKYF2IF/fVV1huz2HDO2QnREZpDt/vR2vDd9mGJNidi8h5MDC4gv6jy7Z9nZZaXW5hJOfr4HpLyuY5beEftdHFtfUWoMuFsNoca/URWUaH5HoUtBlf5ja+GoUDSagZ4Aw6CizqOGUsMLHWs8DpNxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Rrci4Wcm; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Rrci4Wcm"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65J3pvCq2014503;
	Fri, 19 Jun 2026 15:21:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=EZscl8saoEGl0fvL/ra8R2EO6T9vl
	cvhsobpKK3jBW0=; b=Rrci4WcmLKJGnlLC6s88aGmKIFqOMk7S2Zj7D5g4MUQaD
	UVuu1BxYiVMahUHXcorY7pwgfVlWlDkXieTouz6Gw5lg9bPG/lJirUKEVyIgrTPw
	FD3SWJqLtsRuxe/spI4wjEhpl5/RuQnmiETNBPL3HGn3C8rkQWBELTTPUELCVKm8
	wP2ZfkRmpvUiSUuDH6cGMwaP7pziTev/RLp5+9eCrm497wBg2U2kdXI29xmSkegM
	NmOOIW1AcQdmw2ieoH/8DBnIWGIaoi++sckSgP0QdvKx9p/zXn38/xqoOEpWwB54
	g6Y9UkY1h5Zd6ryNl5fbCMIBr683MZzdmUpGc8H/Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4euefy47q6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jun 2026 15:21:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 65JF37Ni038847;
	Fri, 19 Jun 2026 15:21:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ev14g7y36-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jun 2026 15:21:07 +0000 (GMT)
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 65JFL6VQ012172;
	Fri, 19 Jun 2026 15:21:06 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-57-173.vpn.oracle.com [10.154.57.173])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4ev14g7y1b-1;
	Fri, 19 Jun 2026 15:21:06 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: dwarves@vger.kernel.org
Cc: vineet.gupta@linux.dev, yonghong.song@linux.dev, emil@etsalapatis.com,
        jose.marchesi@oracle.com, david.faust@oracle.com,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves 1/2] btf_loader: Attach decl tags to struct and union members
Date: Fri, 19 Jun 2026 16:21:02 +0100
Message-ID: <20260619152103.1956732-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_03,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2606190143
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDE0NSBTYWx0ZWRfXxevjbRHvdZfT
 mwM04NbBgSmLDJJTeKYHEeKLTBW1POwfeqJzikFS4fR0ktTSml1VQ+N38huUxs1OtrWz5HU03ic
 RDUyKb4CvbifOk0SZFxaNs/mKHrVuNOD5Fd7vK8LwxUir1Ar/xuyF0RyPbJeF0rHuYLLuUq9X01
 LKKTdxf0TL1Pj0dCPKjtyNwSIGErW1mRwCp/U0gTylQksRQLF54lucVrKhBPCKbPdRvNYqLN3Em
 pluHvXiZUuA8eywoCogrkAP0dE/yWwkK3pvqkm/e4mTzdXF4/f7zYSvCKZVz0dL/ghbH3+dpc/Q
 MeNbhpga7MtaPx6kR2Lh500qxAlK/qywtUQPy7Ebf72IxyMBwa4ICkN6md7kDwAVtEK+RD3mdqj
 pqS4a8c5pE6yNO/IF8gmDsjWCAuwqhUphKP0r8nY9vm/jHDJupfngc5jA0orBUETyFWewpIONAp
 Bd2Lc89SjnNynNNbSmQ==
X-Authority-Analysis: v=2.4 cv=Xt7K/1F9 c=1 sm=1 tr=0 ts=6a355e64 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=yPCof4ZbAAAA:8 a=5Vtxk2qCIq0aV6RMEb8A:9
 a=O8hF6Hzn-FEA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDE0NSBTYWx0ZWRfX0TOcUcoZmmUa
 jvOU1ff+hI5NnaRFmr/fKdMu+AsQGuIaAfLpSrmlzTga+Jgg6rnRyFcXGZnMn5er+TAYXBmj6NH
 R4WR4YFuoJU5Xhif/cd9WC8ppPPC9gzJEAJyezCxIDyOjvZ657ln
X-Proofpoint-GUID: ls8jaBzCzs63Z4Fmgdf6YkRtBYNLZVCP
X-Proofpoint-ORIG-GUID: ls8jaBzCzs63Z4Fmgdf6YkRtBYNLZVCP

BTF_KIND_DECL_TAG with a non-negative component_idx can target either a
function parameter or a struct/union member. The BTF loader only resolved
the function-parameter case, so member decl tags were left attached to the
aggregate type and were not shown by pahole.

Add member lookup by component_idx for struct/union types and print stored
attributes from class_member__fprintf().

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 btf_loader.c      | 35 +++++++++++++++++++++++++++++++++--
 dwarves_fprintf.c |  3 +++
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/btf_loader.c b/btf_loader.c
index 92d4832..406ee28 100644
--- a/btf_loader.c
+++ b/btf_loader.c
@@ -506,10 +506,24 @@ static struct tag *function__parameter(const struct function *func, struct cu *c
 	return ftype__parameter(tag__ftype(tag), component_idx);
 }
 
+static struct tag *type__member(struct type *type, int component_idx)
+{
+	struct class_member *member;
+	int idx = 0;
+
+	type__for_each_data_member(type, member) {
+		if (idx == component_idx)
+			return &member->tag;
+		++idx;
+	}
+
+	return NULL;
+}
+
 static int process_decl_tag(struct cu *cu, const struct btf_type *tp)
 {
 	int component_idx = btf_decl_tag(tp)->component_idx;
-	struct tag *tag = cu__type(cu, tp->type);
+	struct tag *tag;
 	struct attributes *tmp;
 
 	tag = cu__function(cu, tp->type);
@@ -522,7 +536,24 @@ static int process_decl_tag(struct cu *cu, const struct btf_type *tp)
 		}
 	}
 
-	if (tag == NULL)
+	if (tag == NULL) {
+		tag = cu__type(cu, tp->type);
+
+		if (component_idx >= 0 && tag != NULL) {
+			if (tag != NULL && (tag__is_struct(tag) || tag__is_union(tag))) {
+				tag = type__member(tag__type(tag), component_idx);
+				if (tag == NULL) {
+					fprintf(stderr, "WARNING: BTF_KIND_DECL_TAG for unknown member %d in BTF id %d\n",
+						component_idx, tp->type);
+					return 0;
+				}
+			} else {
+				tag = NULL;
+			}
+		}
+	}
+
+	if (tag == NULL && component_idx < 0)
 		tag = cu__tag(cu, tp->type);
 
 	if (tag == NULL) {
diff --git a/dwarves_fprintf.c b/dwarves_fprintf.c
index ab1c381..04f6569 100644
--- a/dwarves_fprintf.c
+++ b/dwarves_fprintf.c
@@ -963,6 +963,7 @@ out_type_not_found:
 static size_t class__fprintf_cacheline_boundary(struct conf_fprintf *conf,
 						uint32_t offset,
 						FILE *fp);
+static size_t tag__attributes_fprintf(const struct tag *tag, FILE *fp);
 
 static size_t class_member__fprintf(struct class_member *member, bool union_member,
 				     struct tag *type, const struct cu *cu,
@@ -996,6 +997,8 @@ static size_t class_member__fprintf(struct class_member *member, bool union_memb
 	if (member->is_static)
 		printed += fprintf(fp, "static ");
 
+	printed += tag__attributes_fprintf(&member->tag, fp);
+
 	/* For struct-like constructs, the name of the member cannot be
 	 * conflated with the name of its type, otherwise __attribute__ are
 	 * printed in the wrong order.
-- 
2.43.5

