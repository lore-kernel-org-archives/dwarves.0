Return-Path: <SRS0=AnL8=D7=vger.kernel.org=dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3E3C2D0A3
	for <linux-dwarves@archiver.kernel.org>; Sat, 24 Oct 2020 18:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20F262177B
	for <linux-dwarves@archiver.kernel.org>; Sat, 24 Oct 2020 18:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603564634;
	bh=kihC6BW8qyhWUIajITFMWYIKOUq6rFn/rkIWrVqSU7w=;
	h=From:To:CC:Subject:Date:List-ID:From;
	b=IGQnRW2jwmNbIz4tTZa5XMSj1CKuxFGzpFUqDSuOWGAqUbsWkIxDWY+w+T5N37REn
	 cv04ovvPYzhGzStzND0Ni3WVlbk49p2SNG5ZMtub3POLKizX77IuC4bXlkaSvMEbQu
	 +Dme7mtEr4Of4k4jKWJY+B994U4o+lwyOA2iPkC8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1763921AbgJXShN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Sat, 24 Oct 2020 14:37:13 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:4288 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1763920AbgJXShN (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Sat, 24 Oct 2020 14:37:13 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09OIO32Q001182
        for <dwarves@vger.kernel.org>; Sat, 24 Oct 2020 11:37:12 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 34cj3g1b50-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <dwarves@vger.kernel.org>; Sat, 24 Oct 2020 11:37:11 -0700
Received: from intmgw002.03.ash8.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sat, 24 Oct 2020 11:37:10 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 344FB2EC847E; Sat, 24 Oct 2020 11:37:01 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <dwarves@vger.kernel.org>, <acme@kernel.org>
CC:     <andrii@kernel.org>
Subject: [PATCH dwarves] cmake: make libbpf's Linux UAPI headers available to all binaries
Date:   Sat, 24 Oct 2020 11:36:53 -0700
Message-ID: <20201024183653.891042-1-andrii@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.737
 definitions=2020-10-24_13:2020-10-23,2020-10-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 lowpriorityscore=0 mlxscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 phishscore=0 mlxlogscore=444 malwarescore=0 priorityscore=1501
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2010240144
X-FB-Internal: deliver
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Now that libbpf is used to implement deduplicated strings container, all of
the binaries will need linux/btf.h header to compile properly. libbpf is
distributed with its own copies of Linux UAPI headers, so use them during
compilation.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 CMakeLists.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 8e9fe4710a0c..84693514e0c8 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -2,7 +2,9 @@ project(pahole C)
 cmake_minimum_required(VERSION 2.8.8)
 cmake_policy(SET CMP0005 NEW)
 
-INCLUDE_DIRECTORIES( ${CMAKE_CURRENT_BINARY_DIR} ${CMAKE_CURRENT_SOURCE_DIR} )
+INCLUDE_DIRECTORIES(${CMAKE_CURRENT_BINARY_DIR}
+		    ${CMAKE_CURRENT_SOURCE_DIR}
+		    ${CMAKE_CURRENT_SOURCE_DIR}/lib/bpf/include/uapi)
 
 # Try to parse this later, Helio just showed me a KDE4 example to support
 # x86-64 builds.
-- 
2.24.1

