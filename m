Return-Path: <SRS0=Yf7w=DH=vger.kernel.org=dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C936EC2D0A8
	for <linux-dwarves@archiver.kernel.org>; Wed, 30 Sep 2020 04:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 714092074B
	for <linux-dwarves@archiver.kernel.org>; Wed, 30 Sep 2020 04:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Y75dPVIG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725385AbgI3E2E (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Wed, 30 Sep 2020 00:28:04 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:57146 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725497AbgI3E2E (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Wed, 30 Sep 2020 00:28:04 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08U4PkFD025940
        for <dwarves@vger.kernel.org>; Tue, 29 Sep 2020 21:28:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=hRS3+a/CVH0BnJkwJbuzBtLdd7H9emNQ/rnCXLUNs2E=;
 b=Y75dPVIGjPtDlLxrEeJmqZNTqe6EMWRIiAnvwraa318l7Jgq54ChPmQDGLPM1QuhFcUb
 HWa2DYgchU8r9wMr/3mwza4UEm8tAi0HYv0scum4/TJx879UUgl1hYx570zhImSjWcwJ
 UKw9VCjUXgJZhGQ9FVVL3HZ0mpfpsBlBzlg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 33t35n91wf-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <dwarves@vger.kernel.org>; Tue, 29 Sep 2020 21:28:03 -0700
Received: from intmgw003.03.ash8.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 29 Sep 2020 21:28:02 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id EFBE62EC77F1; Tue, 29 Sep 2020 21:27:53 -0700 (PDT)
From:   Andrii Nakryiko <andriin@fb.com>
To:     <dwarves@vger.kernel.org>
CC:     <bpf@vger.kernel.org>, Andrii Nakryiko <andriin@fb.com>
Subject: [PATCH dwarves 01/11] libbpf: update to latest libbpf version
Date:   Tue, 29 Sep 2020 21:27:32 -0700
Message-ID: <20200930042742.2525310-2-andriin@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200930042742.2525310-1-andriin@fb.com>
References: <20200930042742.2525310-1-andriin@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-30_01:2020-09-29,2020-09-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=635
 mlxscore=0 lowpriorityscore=0 suspectscore=13 impostorscore=0
 malwarescore=0 phishscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009300032
X-FB-Internal: deliver
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Pull in BTF writer APIs.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 lib/bpf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bpf b/lib/bpf
index e5dbc1a96f13..ff797cc905d9 160000
--- a/lib/bpf
+++ b/lib/bpf
@@ -1 +1 @@
-Subproject commit e5dbc1a96f138e7c47324a65269adff0ca0f4f6e
+Subproject commit ff797cc905d9c5fe9acab92d2da127342b20f80f
--=20
2.24.1

