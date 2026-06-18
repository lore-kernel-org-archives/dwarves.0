Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F361F3D75D7
	for <dwarves@vger.kernel.org>; Thu, 18 Jun 2026 18:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781808844; cv=none; b=Qt9mSpytaiMq4et48R2JN0N/zEwcyCVsTCn5vfvJBc7Rv607hdkbJ3afJcGKWoM2uBnVgU/8YTucZ5f+HO6MfsW5XRw2X/EsVlTSy4EilnjmgBDkIWWO83nWb+GqVEI3Xdv0R5bdH3tU6Y/K062/T+yUTODTwSZPpNSLGz/Xta8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781808844; c=relaxed/simple;
	bh=mYafzCWoZCiOquSU9iBNAFtDKKJVOxIUOc+5h8zh0/8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kLOCImvdTmBvBCpAQ/Uq4E/anAST4S3PEFExlcQqDjWaTsCTM5BcsYpL0WiMN6sKnXeS4o1y1Tyj4Dt2UVSejWTfpzBDbhqavFlRbJTg5m+Zp0YoXX0JiOkaQ8hzJT/3rcxc4WAu6BFwpzIdX9rXIAZ7mDL6VZPE/1OJRMjiTx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WQgtH1PX; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WQgtH1PX"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65IGCRVf820066;
	Thu, 18 Jun 2026 18:53:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=/5EmV822Yyo6Ih6UDgKxkmnLxfaj1
	R24fl4YUR0qR1o=; b=WQgtH1PXOxX+JtrpmkhrTEOjGtZRoQLnbL6camYROpJb0
	cAekQ9EUJQO8ROZRQowlbEk7wIqijzmERHGqQGYoK+g26V/P8w1y0+oPE/Wq+fxX
	IFeS1KSPNrfF+vW/kj5QQQ9FTR2XPvDz09sLYR3IPc6dNXGWEvLhj0q70PK7HrzY
	Au42aTW0X9U64aLRr8doB0m9rOgBXdUdtGKon3ofxE4uowIVWatefI7ce7b6kgaw
	eMr0RB9yBCVYq+qYUfzjo+lMuNzmxHUWHaGlTqJQa/45OCNbe6w4OLHscQpA0+3/
	rH23+fNCNcmgLc7a2xj7v+9pNZKBKFGSKcaGRRxug==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4euefy34ax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jun 2026 18:53:59 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 65IIrY6s014219;
	Thu, 18 Jun 2026 18:53:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ev14uh48d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jun 2026 18:53:59 +0000 (GMT)
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 65IIoKDV006711;
	Thu, 18 Jun 2026 18:53:58 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-57-173.vpn.oracle.com [10.154.57.173])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4ev14uh47w-1;
	Thu, 18 Jun 2026 18:53:58 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: dwarves@vger.kernel.org
Cc: vineet.gupta@linux.dev, yonghong.song@linux.dev, emil@etsalapatis.com,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves] github CI: build/install bpftool from kernel tree
Date: Thu, 18 Jun 2026 19:53:56 +0100
Message-ID: <20260618185356.1144526-1-alan.maguire@oracle.com>
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
 definitions=2026-06-18_03,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0 suspectscore=0 mlxscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2606180175
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDE3NSBTYWx0ZWRfX6IAjiuJAOSV1
 /L9zQhtB5BFzNrY6nm6q17p2Q6u7OBSbnyYZ2ZSAOcfc52Z+4e5ZdU+vHD/+VBvhRrnFL7VSnkC
 qY7dOVSuSaqDAcLeLL1Fdk8O7+VsoW374BTubFB0oSReUB0iKH7lTPo9xguCkS+J9NolAVU+NMe
 1PHY6y/Qt+5PcFlgAz4+9H4wJAF3KQxqzWOVf3GFowAD4D4PQHG+p2Miquy5JB+fy4aHxmPFCQp
 iTSiqesZhgCSLn1B9wD6fdj3VNmp00GjzDUQtiAVlyOAkSbHW6mdHBoCo/19vgkrwL6oV1fd7vN
 rp65mQzgmKF3H/7coh5d0Q1GxQer3/xMiZGuzXpB0BdecetW+napvVtq/E6KcRvmoV4z4XYAnpL
 mPgNOl3GPtShfFSjH9QzIhwo/PQDWDZa6TklRZMHhDwJk25AlIWQBawAVMacmWutB1ERHRtHc3B
 lUgXLdBliEXQipmUrjeP+WQlgX/yErohZNlfkMnE=
X-Authority-Analysis: v=2.4 cv=Xt7K/1F9 c=1 sm=1 tr=0 ts=6a343ec7 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=yPCof4ZbAAAA:8 a=iDnNZ1HYp5kgBz1Xu9IA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12313
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDE3NSBTYWx0ZWRfX7xmWtrUjGeh9
 MsaGjVl7FD8ysC7FzQpc9ejGaj40iAacGZKh7E3YeeMApmj3f4Rpnl6G7Tou7mtJAihi6FAkJNT
 KGGti/KIBx3W1qxgmP54VyJkF4j5I2IoTqcYzwF9gutZtBJ+mRW7
X-Proofpoint-GUID: Mkk8WjGgXlaaEFAzf9Cd9BBoG-bXAgm_
X-Proofpoint-ORIG-GUID: Mkk8WjGgXlaaEFAzf9Cd9BBoG-bXAgm_

It will be useful for selftests.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 .github/scripts/build-kernel.sh  | 3 +++
 .github/scripts/run-selftests.sh | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

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
index f9ba24e..2e73706 100755
--- a/.github/scripts/run-selftests.sh
+++ b/.github/scripts/run-selftests.sh
@@ -8,8 +8,9 @@ GITHUB_WORKSPACE=${GITHUB_WORKSPACE:-$(pwd)}
 VMLINUX=${GITHUB_WORKSPACE}/.kernel/vmlinux
 SELFTESTS=${GITHUB_WORKSPACE}/tests
 cd $SELFTESTS
-export PATH=${GITHUB_WORKSPACE}/install/usr/local/bin:${PATH}
+export PATH=${GITHUB_WORKSPACE}/install/usr/local/bin:${GITHUB_WORKSPACE}/install/usr/local/sbin:${PATH}
 which pahole
 pahole --version
+bpftool --version
 vmlinux=$VMLINUX ./tests
 
-- 
2.43.5

