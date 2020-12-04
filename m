Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D35AC4361A
	for <linux-dwarves@archiver.kernel.org>; Fri,  4 Dec 2020 21:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E44B122A83
	for <linux-dwarves@archiver.kernel.org>; Fri,  4 Dec 2020 21:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbgLDVVQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Fri, 4 Dec 2020 16:21:16 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:62682 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726021AbgLDVVQ (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Fri, 4 Dec 2020 16:21:16 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B4LKOmV015563
        for <dwarves@vger.kernel.org>; Fri, 4 Dec 2020 13:20:36 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 357tfmrx67-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <dwarves@vger.kernel.org>; Fri, 04 Dec 2020 13:20:36 -0800
Received: from intmgw002.08.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 4 Dec 2020 13:20:18 -0800
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 31E4B2ECAB55; Fri,  4 Dec 2020 13:20:16 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <dwarves@vger.kernel.org>, <acme@kernel.org>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH dwarves] rpm: fix changelog date
Date:   Fri, 4 Dec 2020 13:20:14 -0800
Message-ID: <20201204212014.2983374-1-andrii@kernel.org>
X-Mailer: git-send-email 2.24.1
X-FB-Internal: Safe
Content-Type: text/plain
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-04_12:2020-12-04,2020-12-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 spamscore=0 bulkscore=0 mlxlogscore=273
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2012040121
X-FB-Internal: deliver
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

It causes errors when trying to import 1.19 version.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 rpm/SPECS/dwarves.spec | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rpm/SPECS/dwarves.spec b/rpm/SPECS/dwarves.spec
index 9232002ccd28..693a9da19c82 100644
--- a/rpm/SPECS/dwarves.spec
+++ b/rpm/SPECS/dwarves.spec
@@ -275,7 +275,7 @@ rm -Rf %{buildroot}
 * Sat Nov 20 2010 Arnaldo Carvalho de Melo <acme@redhat.com> - 1.9-1
 - New release
 
-* Tue Feb 08 2011 Fedora Release Engineering <rel-eng@lists.fedoraproject.org> - 1.8-2
+* Tue Feb 08 2010 Fedora Release Engineering <rel-eng@lists.fedoraproject.org> - 1.8-2
 - Rebuilt for https://fedoraproject.org/wiki/Fedora_15_Mass_Rebuild
 
 * Fri Dec  4 2009 Arnaldo Carvalho de Melo <acme@redhat.com> - 1.8-1
-- 
2.24.1

