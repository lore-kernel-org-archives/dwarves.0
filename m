Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC2F368D6E
	for <dwarves@vger.kernel.org>; Fri, 19 Jun 2026 15:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781882475; cv=none; b=vFj79vHcH2weXCLDsVrNfVajDI4OkPHAyXITBYNzYD5UNkZ/SEM4l1TEgYSJys6Egcd5v03ftciyw9DGFeEpe7R43htDmlcC8wMoLhsloFdTrhbhsqDaPvJQKgqs9TPF9O7wE12MX7211DIb5f8aAPDsSwqlKlDkEz2mafhcDIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781882475; c=relaxed/simple;
	bh=3MkeRRkq1PELQVJPF/V7xFvhWbt7nMgBfzVLkl/d1+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ooUhD/uCAZf32+RVu6dPtGyH1YXGN/zTqRK+ODe1zi+a4otQulYaAMl9ebDD3Tr2CSMOezG6ef/2wsQl64Nv59dWi+abfPWmTFrDHzqu1kES7Jol0q4/JKQhVehY+qo4hDkb2lyYDbFA28teAdid6EadnjEdm2wP01Lmse+Wh2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LSzXy6nJ; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LSzXy6nJ"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65ILV6041335242;
	Fri, 19 Jun 2026 15:21:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=iPDcL
	tp0svxMqnxvYWQx6+TlTyviPrYmumt0S4DXbW8=; b=LSzXy6nJ+Ks/HLNY9bUbz
	/vlxN3pKj9zEOqNPylUGuS2u5+oViPgZFWuZCvPwrV1PWTspFqmfFPtAa9yMD14h
	8QTnjkHLid7Q7xxdhsC6NPfv1BrGL66Rhk9hFBZYXFU9SBRGqyvBciiQv/bUDY1h
	WMrgemghS8HGzJE9dXyQZBLxv1wWLJagIA0Kl04LGIt+dkrmRbzVTCv+UdWv4OGy
	XskTxkSqTzGggn83j+v8BIGjpH2yEpUiCQXiB0jLF35fwnyySMITMt5/pqrv5qkM
	kHi0v0Dp6s87W4MQBgx0IEM9u8n/ADoQPrSKXLXeSWKmxNPLweWGCk6vlwgg09VD
	w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4euefum7u8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jun 2026 15:21:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 65JF36jx038814;
	Fri, 19 Jun 2026 15:21:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ev14g7y4k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jun 2026 15:21:09 +0000 (GMT)
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 65JFL6VS012172;
	Fri, 19 Jun 2026 15:21:09 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-57-173.vpn.oracle.com [10.154.57.173])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4ev14g7y1b-2;
	Fri, 19 Jun 2026 15:21:09 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: dwarves@vger.kernel.org
Cc: vineet.gupta@linux.dev, yonghong.song@linux.dev, emil@etsalapatis.com,
        jose.marchesi@oracle.com, david.faust@oracle.com,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves 2/2] tests: add decl tag struct member test
Date: Fri, 19 Jun 2026 16:21:03 +0100
Message-ID: <20260619152103.1956732-2-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260619152103.1956732-1-alan.maguire@oracle.com>
References: <20260619152103.1956732-1-alan.maguire@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=S4XpBosP c=1 sm=1 tr=0 ts=6a355e66 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=yPCof4ZbAAAA:8 a=vkzzdnK_i78tParV0psA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDE0NSBTYWx0ZWRfXweGq5zqor1wY
 q0RXOWZcVwwo/77AcujrZXZi975h64SrCOjY1ppdv2JwnwZtgT9z4L1ReD/eHkOYqgi3Rq/EStj
 aD3Nci9QFUPh85NXxwMxWRpHeSjulVqKyr1CaZpNZaFb6Dnkp2H1
X-Proofpoint-ORIG-GUID: Vt-nEjZ5Qceq0J0QHXw9uXXgr12Fcnku
X-Proofpoint-GUID: Vt-nEjZ5Qceq0J0QHXw9uXXgr12Fcnku
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDE0NSBTYWx0ZWRfXyYsKncRij0XV
 biK0yKP/RfSX+XMrjkxbYVdSuBzOFD+aCc7KSzZqn2WFcS6M0/R9YKjYrtus3nS37u5XP0lWX6K
 sa48GTBkaqgpwOSYrj8Qrdit4b+IqfEp2kjxMq1Iiq7rWWnM0vsY+TdhiUISNqUwkRy8M1k8TQo
 Jb5Jd8T7wRj3b8X9cw4phq58Ro4HZFiR5d3+lmQarLj5G3FKvtGOL9Be2GgfNhTQeIydyKqJ90V
 +EO63xnUjd/FJ23XzHJ5sw8O5zJ+FH8Z5/K289hQGm8BkK0qoe/3J6UIT6sbrPMXW2WVDGxFUyN
 Gp7tCB4C11AKbk+4PKTXlQdvyIzRKkMHdUCK222E68nZfJvkPj4t0bp3Ciy+On+V1caw4psBASf
 REnDKL+jh48vRwS4tmDvYTDB0B3x6smIwqlG6J9mS8S4cDIuEMJ6HoH9857xNjvj1fJI45Cxd9f
 thszrCESvagGDT+vzIg==

Extend the decl-tag selftest with a tagged member and verify
it is displayed.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tests/pfunct-btf-decl-tags.sh | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/tests/pfunct-btf-decl-tags.sh b/tests/pfunct-btf-decl-tags.sh
index 520148b..89050d1 100755
--- a/tests/pfunct-btf-decl-tags.sh
+++ b/tests/pfunct-btf-decl-tags.sh
@@ -43,6 +43,12 @@ __tag(a) __tag(b)          void bar(void) {}
 __tag(a)                   void buz(void) {}
 void qux(int __tag(param_a) arg) {}
 
+struct tagged {
+	int __tag(member_tag) member;
+};
+
+struct tagged tagged_global;
+
 EOF
 )
 
@@ -72,18 +78,18 @@ void qux(param_a int arg);
 EOF
 )
 
+expected_member="member_tag int member;"
+
 run_test() {
 	local compiler=$1
 	local tmpobj=$2
+	local member_out
 
 	info_log "Testing with $compiler"
 	out=$(pfunct -P -F btf $tmpobj | awk "$sort_tags" | sort)
 	d=$(diff -u <(echo "$expected") <(echo "$out"))
 
-	if [[ "$d" == "" ]]; then
-		info_log "  passed"
-		return 0
-	else
+	if [[ "$d" != "" ]]; then
 		error_log "pfunct output does not match expected ($compiler):"
 		info_log "$d"
 		info_log
@@ -91,6 +97,23 @@ run_test() {
 		info_log "$out"
 		return 1
 	fi
+
+	member_out=$(pahole -F btf $tmpobj | awk '
+		/member_tag/ {
+			sub(/;.*/, ";");
+			gsub(/[[:space:]]+/, " ");
+			sub(/^ /, "");
+			print;
+		}')
+	if [[ "$member_out" != "$expected_member" ]]; then
+		error_log "pahole member decl tag output does not match expected ($compiler):"
+		info_log "expected: $expected_member"
+		info_log "got:      $member_out"
+		return 1
+	fi
+
+	info_log "  passed"
+	return 0
 }
 
 failed=0
-- 
2.43.5

