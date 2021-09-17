Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8992C433F5
	for <linux-dwarves@archiver.kernel.org>; Fri, 17 Sep 2021 22:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0C4760F48
	for <linux-dwarves@archiver.kernel.org>; Fri, 17 Sep 2021 22:48:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344017AbhIQWts (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Fri, 17 Sep 2021 18:49:48 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:7276 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235369AbhIQWtr (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Fri, 17 Sep 2021 18:49:47 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18HHrR70026838
        for <dwarves@vger.kernel.org>; Fri, 17 Sep 2021 15:48:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=+YXihBOMhiSG+piFiJGD8LrHHDzlghSOhQNudXvTfQA=;
 b=mfSp63QvOV8DHKTM43D7BuMQIswZ9lkP6SM47iOMjoQdGFNV9ZpH9mq0IMWQ7o4TGhSF
 P+RmLlxH5O+pNRe9PZPkxPXNvu/GY+pt5hzS9+POxguZZtw1nlcYYRd+GHI2NZLdd2J1
 Oqi/gXGgX7wEnzNXLUFYYi8hdLGbVhUJ1BQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3b4yt7srp0-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <dwarves@vger.kernel.org>; Fri, 17 Sep 2021 15:48:25 -0700
Received: from intmgw001.06.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 17 Sep 2021 15:48:24 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id B823E75B5A17; Fri, 17 Sep 2021 15:48:18 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH dwarves] libbpf: Get latest libbpf
Date:   Fri, 17 Sep 2021 15:48:18 -0700
Message-ID: <20210917224818.733897-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: rXrCMsBe6Dp3ru_3GqoGTPKA8raz3CQS
X-Proofpoint-ORIG-GUID: rXrCMsBe6Dp3ru_3GqoGTPKA8raz3CQS
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-17_09,2021-09-17_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 mlxlogscore=905 mlxscore=0 lowpriorityscore=0 phishscore=0 clxscore=1011
 priorityscore=1501 spamscore=0 bulkscore=0 malwarescore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109170136
X-FB-Internal: deliver
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Latest upstream LLVM now supports to emit btf_tag to
dwarf ([1]) and the kernel support for btf_tag is also
landed ([2]). Sync with latest libbpf which has
btf_tag support. Next step will be to implement
dwarf -> btf conversion for btf_tag.

 [1] https://reviews.llvm.org/D106621
 [2] https://lore.kernel.org/bpf/20210914223015.245546-1-yhs@fb.com

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 lib/bpf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bpf b/lib/bpf
index 986962f..980777c 160000
--- a/lib/bpf
+++ b/lib/bpf
@@ -1 +1 @@
-Subproject commit 986962fade5dfa89c2890f3854eb040d2a64ab38
+Subproject commit 980777cc16db75d5628a537c892aefc2640bb242
--=20
2.30.2

