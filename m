Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBD02E3FE
	for <dwarves@vger.kernel.org>; Fri, 19 Jun 2026 07:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781854448; cv=none; b=VRltyM6Wa2QX/fAyUJ74/1ibC0DAVIyF3d3isAxT4Kt1FrisqjyMEswZ+dOLg/NdcpW+cMSunvSnPunIsaeZ6m3FYXhODakxpi/Ivfzf848mr0Hv0+TrcDALAyVVz1unL4brn1vw3KRmrOwMzAaxMq43DmC/F7xyRcsh+HGn1hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781854448; c=relaxed/simple;
	bh=RjnATTdpMBfhxcocnE43XvXR/nYfpqRo50wdDKEF1Gs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XSyZ3z+D5Hp1ktm2fcxdGIE4aLAmMBaHuw3Fi45NUHNisf8UXwIv4jXKF7Hhr56/wN9ZVA857y6XtZfcAR6DP4Ra+LTDW4zYx6c2IMNl+xyUDF5VQea56oatMJ4ztaARfWPd1Weo/jzdeCnBFDcQspRF9h/8otWGUAHmBUcOafY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iVLlxJHy; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iVLlxJHy"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65J3bhIe1966559;
	Fri, 19 Jun 2026 07:34:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=UzQ0t/B/kzHc/LyTqiPcQMDAt3e9j
	9qlkoGIo0md3O0=; b=iVLlxJHy6xVSuE3FXVTM7SPVLOd95Y2R23EKJqdVb7jpT
	b/Uhv3gFa3fhPL7Tfo7jSJniMlmsTebP/FckUniJ10x805y3Dm7SOsbdH/iXvYzT
	1wOgOrN/xdm8s5fMcbOqUxcH3xTLdsM7UGpcJagNMLaItUz1VUKmuq2luUcgPW0S
	UT08Ht3m1OeD4UeGIX5d7sd58cg8pJboU59fkz0F4w9NwI1A/6OgFktU+SUE7/ZC
	nIOgbQ2syR2zq11p9+Y/Xy1JSsFWadFSlmQcRjL03s+U1Ulu7+YusMn3n+cDCe0O
	9e4VU6fwofLxkZS2uq78OVkIXGtw+l2CjzjC70Kdg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4eueg33uru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jun 2026 07:34:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 65J7XY0a001422;
	Fri, 19 Jun 2026 07:34:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ev14v39uj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jun 2026 07:34:00 +0000 (GMT)
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 65J7Y0oi003847;
	Fri, 19 Jun 2026 07:34:00 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-57-173.vpn.oracle.com [10.154.57.173])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4ev14v39ts-1;
	Fri, 19 Jun 2026 07:34:00 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: dwarves@vger.kernel.org
Cc: vineet.gupta@linux.dev, yonghong.song@linux.dev, emil@etsalapatis.com,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 dwarves] github CI: build/install bpftool from kernel tree
Date: Fri, 19 Jun 2026 08:33:58 +0100
Message-ID: <20260619073358.1605594-1-alan.maguire@oracle.com>
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
 definitions=2026-06-19_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0 suspectscore=0 mlxscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2606190069
X-Authority-Analysis: v=2.4 cv=I8VVgtgg c=1 sm=1 tr=0 ts=6a34f0ea b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=NEAV23lmAAAA:8 a=yPCof4ZbAAAA:8
 a=0SH_j-x13pldxcHxuycA:9 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:12313
X-Proofpoint-GUID: zbA3Hhe4dRKRboFqt4KVRNr9LS-edRee
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDA2OCBTYWx0ZWRfXz2Wsw32FVGN/
 V/sL0XiZiM8euDSQtj5Z8mibr4DXhCqxj4mWGy/l1qX0lnpvAy//TeIovmFHXdpdXVMBrkdbiDy
 2B0P7GaAs002QotcEDb0I7hTwHzwXzGLPYuUHI5dNjvl2kkNqwFEs+4SRJZ3HBopWaf0oZspz9O
 Kpmw2+ixbyABmvYlpPjPkiEEkbn/ljgKd0f67u0zFPebdKXbtIg2Duv+DWyA/DmV9FoqwhTzzey
 f+TZxK0WeTk6iRHWxWgOzjWrvasJFOWkwaPa2gULSzBLttfoJSBzmvhBG2Y18oGJn+EW7bpbpJZ
 fozn1fE0EyM7IL/wGsIaI50pvOTcr6Nnxy6up7rDbc9sA2kaTNzPHv0sR1ilI5DkRNgbrbphc0Q
 De2hwNOdJjLYfVjslWoWTwBMFgc3EavIwMcsyTcdWiBk7r4Zxk02hqYaDI2WWGDYeNEKsgcfV1C
 M1WMxuCLrVo6uMVz3CaQznVuwNQXj8oqsCqIWPE4=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDA2OCBTYWx0ZWRfX9Jj43IIXcb1G
 7Jul/dxQiGloztSYNUtOaChv42VqOImehY946q/oRw1bsBE/mHTCtoFP5pEIzZx6jYG8Xx7Hx4a
 r2RcpKaDPrjz2Tl5zaU2MaakzN/vdhYS41lti+pLzShw7Eo+ZYCM
X-Proofpoint-ORIG-GUID: zbA3Hhe4dRKRboFqt4KVRNr9LS-edRee

It will be useful for selftests.  With this change on top
of the v5 gcc BTF tag series [1], CI runs succeed where
they previously failed due to absence of bpftool.

Changes since v1:

- need to specify LLVM_OBJCOPY env var for pahole invokations
in pfunct-btf-decl-tag.sh to succeed.

[1] https://github.com/alan-maguire/dwarves/actions/runs/27790591177/job/82238306741

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 .github/scripts/build-kernel.sh  | 3 +++
 .github/scripts/run-selftests.sh | 4 +++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/.github/scripts/build-kernel.sh b/.github/scripts/build-kernel.sh
index 0a1fd3f..9f11b22 100755
--- a/.github/scripts/build-kernel.sh
+++ b/.github/scripts/build-kernel.sh
@@ -40,3 +40,6 @@ make $buildopts olddefconfig && make prepare
 cat .config
 make -j $((4*$(nproc))) $buildopts all
 
+# Build, install bpftool
+cd tools/bpf/bpftool
+LLVM_STRIP=llvm-strip-${LLVM_VERSION} make && make DESTDIR=${GITHUB_WORKSPACE}/install/ install
diff --git a/.github/scripts/run-selftests.sh b/.github/scripts/run-selftests.sh
index f9ba24e..bb826bf 100755
--- a/.github/scripts/run-selftests.sh
+++ b/.github/scripts/run-selftests.sh
@@ -8,8 +8,10 @@ GITHUB_WORKSPACE=${GITHUB_WORKSPACE:-$(pwd)}
 VMLINUX=${GITHUB_WORKSPACE}/.kernel/vmlinux
 SELFTESTS=${GITHUB_WORKSPACE}/tests
 cd $SELFTESTS
-export PATH=${GITHUB_WORKSPACE}/install/usr/local/bin:${PATH}
+export PATH=${GITHUB_WORKSPACE}/install/usr/local/bin:${GITHUB_WORKSPACE}/install/usr/local/sbin:${PATH}
+export LLVM_OBJCOPY=objcopy
 which pahole
 pahole --version
+bpftool --version
 vmlinux=$VMLINUX ./tests
 
-- 
2.43.5

