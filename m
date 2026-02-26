Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD01638F934
	for <dwarves@vger.kernel.org>; Thu, 26 Feb 2026 07:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772092692; cv=none; b=L9GUv/Rz0FhnIy1EmeH4bUaHS6L/EKSYMg/QlE/abwdg9d4DZsc8jFQFTZqmo+iNwvy3Rg8O6Ryap8z/dgMWYksuYuCNY0KGpzfIskSw+/lQkV0GciMtBs37aFN9kWm/KzRAgs+ZBRK12ILC0dKa7HRaWlSc8e4rzjNo8nGyS8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772092692; c=relaxed/simple;
	bh=Vf6jv8+1wr1rld2O/Fw1Fak1fIF87H3zTPWAMwPsrHg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WttX+Pv291KJMzV80vSmeGYwIAwCalIBQudWS3lN7WfvirJwSsDJ5FSt3wnH9lHAHb4skpmyidYhyG/+1Vs4iyIHpKmAQmR28/X+VXOFKQ8+qAdb4u6yQZb90gjjulyfoOi4PiG+IUoErmFQgj4xZCEgC0er0IppVx8tYztyi8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iaE1TYzV; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iaE1TYzV"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61Q6CRpP019854
	for <dwarves@vger.kernel.org>; Thu, 26 Feb 2026 07:58:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=NPB94EjfN4k5GT70STAS/RVgnN/1R
	RbX/+5fv6VxOIA=; b=iaE1TYzVkcIWUwrlWdgov9mewBFefkqWPGiK1z9i7HO3V
	nCfQ2+oCejHOdmcDuM0d8RIbMec4PSXFLZ+ksVDcrqk+ZSSxnXVxII5TmMJ3m9KW
	PGhEdwjSkkFJPpO3aUqChN/5l+URJbw2uwlRfCuV7yLAqdJE5B0+Mlw2+QgAqbHk
	wAfpNvFN2G1BYPqAoN2rMDuhMQp9iY9qhbt8nHmag0QV+FBkZFl5IiwjaBHFyDil
	XQWfRJX6NUpUVmy6CWX2DDiyvVfz5ZPA2gUrjd+me7xCeN7nOutFxvvUJnPv4BFx
	FRzI9HA+bTRI0cvIqEFOYPVaUtQnt5N2mQwMEQETA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cjgpp8392-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <dwarves@vger.kernel.org>; Thu, 26 Feb 2026 07:58:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61Q5uKkE028503
	for <dwarves@vger.kernel.org>; Thu, 26 Feb 2026 07:58:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cf35c5bxh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <dwarves@vger.kernel.org>; Thu, 26 Feb 2026 07:58:07 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 61Q7w6Oc001927
	for <dwarves@vger.kernel.org>; Thu, 26 Feb 2026 07:58:06 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-58-146.vpn.oracle.com [10.154.58.146])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4cf35c5bwv-1;
	Thu, 26 Feb 2026 07:58:06 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: dwarves@vger.kernel.org
Cc: Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves] btf_loader: Fix warnings due to type permutation
Date: Thu, 26 Feb 2026 07:58:05 +0000
Message-ID: <20260226075805.1901714-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
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
 definitions=main-2602260070
X-Authority-Analysis: v=2.4 cv=evPSD4pX c=1 sm=1 tr=0 ts=699ffd10 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=yPCof4ZbAAAA:8 a=DaV8g0g-6sENsMWtHYgA:9
X-Proofpoint-GUID: PzCkzNdBoaBiLtCn-dh58BcuWmLFVmR4
X-Proofpoint-ORIG-GUID: PzCkzNdBoaBiLtCn-dh58BcuWmLFVmR4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDA3MCBTYWx0ZWRfX/lU0Rg0hFx0+
 bh4MOscrYrQ54bPDP8wa9jSdC08SvwbYh08kh9Cvv/3YkNDrQ+2GouM1NOyrvZMa2zZQjw2MZmd
 ANij3NkInevaw5z3lEbe7qDrKawbfW9KXbqvjFC3IQrFq3DGUwt/co2CVGeKkeJ4VnHw6yQBTdh
 X+AKtpEW6EGbUzRKko+yz7P+1a21/FmrIy7T3drl4e7SoSiLI9vYYEvIYxrpWmXj4ZCD9KC36Mc
 Agd9KQk/qHFqY+kbVkFJW9jFithXjK5W4NJLrTGDTASWwLr3a80GTLgKu8xHvE9e6lCgITP3s3G
 64xm3LzJgTMYwuIbfdmfAdaohpmKWmalMCbUj5qiO6n1ADMEqNFB6kPnL7adhQkjs7w8OT0KTDc
 K7END1Ilhyfh0YACuXRNdKa8bDe69bWinQqENBcCA7H8iZ49VjbsVmn/5SK78a1nYMvdyxjrCeR
 T7tbFckplLAr2fZnTPA==

The BTF loader implicitly relied on the fact that decl tags appeared
after the types they refer to, since it looks those references up
and adds attributes to them.  As a result, when a decl tag appears
before the type it references, we get a warning of the form:

WARNING: BTF_KIND_DECL_TAG for unknown BTF id 61909

We see this since BTF permutation, but regardless BTF order should not
matter.  Other types do not rely on looking up their tag references,
so this needs to be fixed for decl tags specifically.

To solve this, simply create tags for all other types first,
then handle decl tags.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 btf_loader.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/btf_loader.c b/btf_loader.c
index 64ea680..b591219 100644
--- a/btf_loader.c
+++ b/btf_loader.c
@@ -505,12 +505,13 @@ static int process_decl_tag(struct cu *cu, const struct btf_type *tp)
 
 static int btf__load_types(struct btf *btf, struct cu *cu)
 {
-	uint32_t type_index;
+	const struct btf_type *type_ptr;
+	uint32_t type_index, type;
 	int err;
 
 	for (type_index = 1; type_index < btf__type_cnt(btf); type_index++) {
-		const struct btf_type *type_ptr = btf__type_by_id(btf, type_index);
-		uint32_t type = btf_kind(type_ptr);
+		type_ptr = btf__type_by_id(btf, type_index);
+		type = btf_kind(type_ptr);
 
 		switch (type) {
 		case BTF_KIND_INT:
@@ -572,7 +573,9 @@ static int btf__load_types(struct btf *btf, struct cu *cu)
 			err = create_new_float_type(cu, type_ptr, type_index);
 			break;
 		case BTF_KIND_DECL_TAG:
-			err = process_decl_tag(cu, type_ptr);
+			/* decl tags will be handled below when other types are
+			 * loaded.
+			 */
 			break;
 		default:
 			fprintf(stderr, "BTF: idx: %d, Unknown kind %d\n", type_index, type);
@@ -584,6 +587,22 @@ static int btf__load_types(struct btf *btf, struct cu *cu)
 		if (err < 0)
 			return err;
 	}
+	/*
+	 * For decl tags we add attributes to the tags associated with the types they
+	 * refer to.  Now that other types have been processed, we can do this.
+	 */
+	for (type_index = 1; type_index < btf__type_cnt(btf); type_index++) {
+		type_ptr = btf__type_by_id(btf, type_index);
+		type = btf_kind(type_ptr);
+
+		if (type != BTF_KIND_DECL_TAG)
+			continue;
+
+		err = process_decl_tag(cu, type_ptr);
+		if (err < 0)
+			return err;
+	}
+
 	return 0;
 }
 
-- 
2.43.5

