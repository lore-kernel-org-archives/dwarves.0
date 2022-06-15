Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D8DBC43334
	for <linux-dwarves@archiver.kernel.org>; Wed, 15 Jun 2022 23:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242593AbiFOXDS (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Wed, 15 Jun 2022 19:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238630AbiFOXDS (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Wed, 15 Jun 2022 19:03:18 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE5322510
        for <dwarves@vger.kernel.org>; Wed, 15 Jun 2022 16:03:17 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 25FLpmK2003637
        for <dwarves@vger.kernel.org>; Wed, 15 Jun 2022 16:03:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=ryM3F2juoCXGltReAjJEPFW8MZMilEFT1PQOZTMcXQ8=;
 b=gATQsjJg3GTiofaz8VVM84vxCMWvCWeKH2LaTTukWTso0AGd+Z71yYqInYGNiRmdwsUf
 EXluEzpTTboIN6u9nrFQDfqJ82UqdDlECkt9MEmn/4WlKaaY/Mclei/E7eJMmEkdV4pc
 4VNGPhLCGqVbQVfNpF8/ELc3V+puf4FRG9s= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3gpr0ee10p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <dwarves@vger.kernel.org>; Wed, 15 Jun 2022 16:03:16 -0700
Received: from twshared22934.08.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 15 Jun 2022 16:03:15 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 51889BA4C51B; Wed, 15 Jun 2022 16:03:12 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH dwarves v2 1/2] libbpf: Sync with latest libbpf repo
Date:   Wed, 15 Jun 2022 16:03:12 -0700
Message-ID: <20220615230312.852007-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220615230306.851750-1-yhs@fb.com>
References: <20220615230306.851750-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: PtkiIurLqo66mY2N5oGoS1BvUR9VToTU
X-Proofpoint-GUID: PtkiIurLqo66mY2N5oGoS1BvUR9VToTU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-15_16,2022-06-15_01,2022-02-23_01
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Sync up to commit
  645500dd7d2d ci: blacklist mptcp test on s390x

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 lib/bpf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bpf b/lib/bpf
index 87dff0a..645500d 160000
--- a/lib/bpf
+++ b/lib/bpf
@@ -1 +1 @@
-Subproject commit 87dff0a2c775c5943ca9233e69c81a25f2ed1a77
+Subproject commit 645500dd7d2d6b5bb76e4c0375d597d4f0c4814e
--=20
2.30.2

