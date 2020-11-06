Return-Path: <SRS0=X0E1=EM=vger.kernel.org=dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A828DC388F2
	for <linux-dwarves@archiver.kernel.org>; Fri,  6 Nov 2020 05:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CFE020A8B
	for <linux-dwarves@archiver.kernel.org>; Fri,  6 Nov 2020 05:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604640369;
	bh=YuNxCAhU5igq8xtKY8dIWLWTO3xu3TgDcdvZWSExVVs=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cx57NCWiNN+BRQhOc5yO7KIlNXrUQ89ffqwNp7+2HnTxKQp2yxDIdJF85Qf+ARiw+
	 O4+oZr3MJ0FpwdQ9DF+zNZd8X11dnl3FMU5T1HAj4YZzZ3g3JykgPIWbto9YYcSRqv
	 HUL4BfVsf34fgVpR7YNbPy9BmDVqP1hKvhnTsorg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbgKFF0I convert rfc822-to-8bit (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Fri, 6 Nov 2020 00:26:08 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:35942 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726128AbgKFF0I (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Fri, 6 Nov 2020 00:26:08 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A65Q6LX008311
        for <dwarves@vger.kernel.org>; Thu, 5 Nov 2020 21:26:08 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 34m81m75au-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <dwarves@vger.kernel.org>; Thu, 05 Nov 2020 21:26:07 -0800
Received: from intmgw001.03.ash8.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 5 Nov 2020 21:26:05 -0800
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id D3EEE2EC8EF6; Thu,  5 Nov 2020 21:25:57 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <dwarves@vger.kernel.org>, <acme@kernel.org>, <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH dwarves 3/4] libbpf: update libbpf submodlue reference to latest master
Date:   Thu, 5 Nov 2020 21:25:48 -0800
Message-ID: <20201106052549.3782099-4-andrii@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201106052549.3782099-1-andrii@kernel.org>
References: <20201106052549.3782099-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-06_01:2020-11-05,2020-11-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 adultscore=0 mlxlogscore=778 lowpriorityscore=0 clxscore=1034 mlxscore=0
 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0 suspectscore=8
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011060037
X-FB-Internal: deliver
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Pull in latest libbpf changes, containing split BTF APIs.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 lib/bpf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bpf b/lib/bpf
index ff797cc905d9..5af3d86b5a2c 160000
--- a/lib/bpf
+++ b/lib/bpf
@@ -1 +1 @@
-Subproject commit ff797cc905d9c5fe9acab92d2da127342b20f80f
+Subproject commit 5af3d86b5a2c5fecdc3ab83822d083edd32b4396
-- 
2.24.1

