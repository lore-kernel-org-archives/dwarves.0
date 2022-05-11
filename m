Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84948C433F5
	for <linux-dwarves@archiver.kernel.org>; Wed, 11 May 2022 22:02:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237101AbiEKWC5 (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Wed, 11 May 2022 18:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231907AbiEKWC4 (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Wed, 11 May 2022 18:02:56 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA74BE3B
        for <dwarves@vger.kernel.org>; Wed, 11 May 2022 15:02:55 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 24BJg6ZU009576
        for <dwarves@vger.kernel.org>; Wed, 11 May 2022 15:02:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=BpSYOXyg6wnT7RS6o6SrXwZrXLpUQf9GZTa0R/0RJu4=;
 b=FpVDJBxjffDE1AKMe7I0CIntf6qDOAVSVC2PEWPQh3vJ6TGEA1Ty7Wrt4WTe07EAqlop
 7+si63cvXFCNU+h4fYrsTfrWc+clN8Blzo6yteK3OPRTzqwRqUsNlccs1yURUzSAbbKr
 YJbDN0/1mEUeaq8MAl1CEdlJz0425EhhCr0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net (PPS) with ESMTPS id 3fyx1h91jq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <dwarves@vger.kernel.org>; Wed, 11 May 2022 15:02:54 -0700
Received: from twshared8307.18.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 11 May 2022 15:02:53 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id C9078A2C7776; Wed, 11 May 2022 15:02:43 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH dwarves 1/2] libbpf: Sync with latest libbpf repo
Date:   Wed, 11 May 2022 15:02:43 -0700
Message-ID: <20220511220243.525215-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: -Z4yLEIysyjS4h5o9-nLRbLM1Z8ZBWFy
X-Proofpoint-ORIG-GUID: -Z4yLEIysyjS4h5o9-nLRbLM1Z8ZBWFy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-11_07,2022-05-11_01,2022-02-23_01
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Sync up to commit 87dff0a2c775 (vmtest: allow building foreign debian roo=
tfs).

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 lib/bpf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bpf b/lib/bpf
index 393a058..87dff0a 160000
--- a/lib/bpf
+++ b/lib/bpf
@@ -1 +1 @@
-Subproject commit 393a058d061d49d5c3055fa9eefafb4c0c31ccc3
+Subproject commit 87dff0a2c775c5943ca9233e69c81a25f2ed1a77
--=20
2.30.2

