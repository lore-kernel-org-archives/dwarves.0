Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE47C4332E
	for <linux-dwarves@archiver.kernel.org>; Sat,  6 Feb 2021 03:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49D5564FBA
	for <linux-dwarves@archiver.kernel.org>; Sat,  6 Feb 2021 03:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbhBFDUm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Fri, 5 Feb 2021 22:20:42 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:63582 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232005AbhBFCt4 (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Fri, 5 Feb 2021 21:49:56 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 115NYDBM009511
        for <dwarves@vger.kernel.org>; Fri, 5 Feb 2021 15:35:15 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 36h2wb42gg-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <dwarves@vger.kernel.org>; Fri, 05 Feb 2021 15:35:15 -0800
Received: from intmgw001.06.ash9.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 5 Feb 2021 15:35:13 -0800
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 47C072ECF50A; Fri,  5 Feb 2021 15:35:10 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <dwarves@vger.kernel.org>, <acme@kernel.org>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH dwarves] spec: fix dates in RPM spec
Date:   Fri, 5 Feb 2021 15:35:05 -0800
Message-ID: <20210205233505.79604-1-andrii@kernel.org>
X-Mailer: git-send-email 2.24.1
X-FB-Internal: Safe
Content-Type: text/plain
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-05_15:2021-02-05,2021-02-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 spamscore=0 mlxscore=0 malwarescore=0 adultscore=0 clxscore=1011
 mlxlogscore=649 phishscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102050146
X-FB-Internal: deliver
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Two dates have invalid days of the week. Fix that.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 rpm/SPECS/dwarves.spec | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rpm/SPECS/dwarves.spec b/rpm/SPECS/dwarves.spec
index 98433e395b6c..178d7c1397ec 100644
--- a/rpm/SPECS/dwarves.spec
+++ b/rpm/SPECS/dwarves.spec
@@ -295,7 +295,7 @@ rm -Rf %{buildroot}
 * Sat Nov 20 2010 Arnaldo Carvalho de Melo <acme@redhat.com> - 1.9-1
 - New release
 
-* Tue Feb 08 2010 Fedora Release Engineering <rel-eng@lists.fedoraproject.org> - 1.8-2
+* Mon Feb 08 2010 Fedora Release Engineering <rel-eng@lists.fedoraproject.org> - 1.8-2
 - Rebuilt for https://fedoraproject.org/wiki/Fedora_15_Mass_Rebuild
 
 * Fri Dec  4 2009 Arnaldo Carvalho de Melo <acme@redhat.com> - 1.8-1
@@ -446,7 +446,7 @@ rm -Rf %{buildroot}
 - Fix emission of arrays of structs, unions, etc
 - use sysconf for the default cacheline size
 
-* Wed Jan 18 2007 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
+* Thu Jan 18 2007 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
 - fab0db03ea9046893ca110bb2b7d71b764f61033
 - pdwtags added
 
-- 
2.24.1

