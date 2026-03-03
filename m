Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363773A6F14;
	Tue,  3 Mar 2026 18:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772562065; cv=none; b=qG8cuYG5VwerE2UG8X+CvDRkYQ2DTAnTikrGhXjrbi6xjczODHlhefN78J99Y3I1X/nfkftCcsVYij+u/l6KcRitYtVW6dh2sK4NFqZ+onb5hFuWiZ5vusSvtCRofuYEZuSvnAHwqz0W8Z2h7t+Dnz/zZn48FgyJXZC63X9+XQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772562065; c=relaxed/simple;
	bh=Vl8d+1lloIOpJRAoS12Cp0A3vK8mnBKYu4DEwbR+X4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kag5HJsJ4zjOQneGRDn6Zzt/X0/qRp609bfBrniB66cW5ZWSRPool1ODX7kplj3vMI8Fkey8bF4Eo9E+6HsYmn8hli1+DyScdS5V4d7TQ/mm7NwdnlkGmcjLULnR4RAOsYlYxGmVZFbn9znkm+tgeI+ACVLCQfdBe6ZtgleS4yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RJmSxvh0; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RJmSxvh0"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 623HMNT43931149;
	Tue, 3 Mar 2026 18:20:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=xrbpE
	90Tswxkx7Bq0apvQT9aEigEF/KUczrfJPjSyfs=; b=RJmSxvh0VK+jwGjaMEzP7
	pTdfwVr76/D1mv39+W64RjCrn1fcUzwm50pyCggXqdyjNU/nEQd33i7z8xzCpDmX
	XKNhvqQbE4neHuogNJqXfuVd6y/6K2aYv9J6i3jCIYw2cJf2GLMGxcq11LDS5l/6
	AP8jWwlxqMeMnEsL1MnpxBFcwxlMKEUiaamNIbvpTQrBXi+UfP1wslHnLFiIYZ30
	Jea19Y2cS22CIdQg0kQy6q2YGP+5LvoAwbNwqwoaHRWrzALxCB3yIsfq1QpsL++H
	ShCr6920kOGT1sRMLetzqRq0MnHqYwUuj/iaxRz1EIFzOwyaKyzc2pN3UbZMmuy1
	g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cp401g3e4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Mar 2026 18:20:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 623HvjSG037789;
	Tue, 3 Mar 2026 18:20:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ckpteyyn4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Mar 2026 18:20:29 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 623IK7oJ029269;
	Tue, 3 Mar 2026 18:20:29 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-62-133.vpn.oracle.com [10.154.62.133])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4ckpteyxu6-9;
	Tue, 03 Mar 2026 18:20:29 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        mykyta.yatsenko5@gmail.com, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v12 bpf-next 8/8] kbuild, bpf: Specify "layout" optional feature
Date: Tue,  3 Mar 2026 18:20:03 +0000
Message-ID: <20260303182003.117483-9-alan.maguire@oracle.com>
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
X-Proofpoint-GUID: 7cNNnPgOllIGmTJPrnrSsgiy0tMnNtpH
X-Proofpoint-ORIG-GUID: 7cNNnPgOllIGmTJPrnrSsgiy0tMnNtpH
X-Authority-Analysis: v=2.4 cv=Mcdhep/f c=1 sm=1 tr=0 ts=69a7266f b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yPCof4ZbAAAA:8 a=J4qZCyyk7QvxA2XVlwcA:9 cc=ntf
 awl=host:13812
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDE0OCBTYWx0ZWRfX+7jXn083oL+k
 RAqof1kBa/6/RxCmFfnOIEIho2O+k3ltzSG/hn2gVR+SFOMi3Ds4YnJ9Fp4Y/HdDKuYdc2v8CCh
 aP5AGj7xNB3GkOlJQ5+IPE2LhvWtaidwe6uO/6DEMEetTrL5ztemdzgnglkLkfqI8XIduNK40fs
 W3pxQ65ck60XVevVN9dRbMB6pg5Jw2q4POU2QY6FAdNt3KzGCJZXdPOWOYdzwb5FlhqdwuBWDUV
 AHPtsJyC9m2XsHA+3WKf0QYL8FkyXqnLNVtmpUtodW5heKwoIaZXXhtHz7jjS+z7pQTPiMKSRAD
 x9/GgL8ClIeVHHkmxYXRUr9W4WehBmlZ7HsQFgCGViYPptzHMywEHPSjlgLfompxK7yGu7y0a1m
 LdgsnGFzKFQm0HoYibNUhk2rNfjSNPkTGk12osYMFgND/XdZZeRgoEwkchpNI56qRSe9pqOqFye
 r9E4e9OVDBZxAXR8MNdubjs8AY5tzFm8VKCLhxac=

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

