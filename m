Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CFEDC433E0
	for <linux-dwarves@archiver.kernel.org>; Thu, 25 Mar 2021 06:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 651ED61A1D
	for <linux-dwarves@archiver.kernel.org>; Thu, 25 Mar 2021 06:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbhCYGxV (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 25 Mar 2021 02:53:21 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:16648 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229664AbhCYGxU (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Thu, 25 Mar 2021 02:53:20 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 12P6qBFD006917
        for <dwarves@vger.kernel.org>; Wed, 24 Mar 2021 23:53:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=uaz8yPiQ6eTiBgP3jSujiydY36CwYUz6K0MfYy/kn8o=;
 b=I2OFqdi0R+yVUhU9ldTqZOAtgAZy901JOS2XLvr/DRd/iTKg/BveUE9fw3KTG+Vg14g7
 atveJ8czEYy9bfhZn23ntNa4KjQkpj9JelaP2gPHprlGYcmFn251nPwx0u2U5L9tHdHS
 lwUFL8ltwpM38yipim/J7goKwW4YsXUum60= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 37g173pxey-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <dwarves@vger.kernel.org>; Wed, 24 Mar 2021 23:53:19 -0700
Received: from intmgw006.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 24 Mar 2021 23:53:18 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id E5CF3AE26A7; Wed, 24 Mar 2021 23:53:16 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Bill Wendling <morbo@google.com>, <bpf@vger.kernel.org>,
        <kernel-team@fb.com>
Subject: [PATCH dwarves 0/3] add option to merge more dwarf cu's into
Date:   Wed, 24 Mar 2021 23:53:16 -0700
Message-ID: <20210325065316.3121287-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-25_01:2021-03-24,2021-03-25 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 mlxscore=0 adultscore=0 mlxlogscore=999 clxscore=1015 phishscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103250050
X-FB-Internal: deliver
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

For vmlinux built with clang thin-lto or lto for latest bpf-next,
there exist cross cu debuginfo type references. For example,
      compile unit 1:
         tag 10:  type A
      compile unit 2:
         ...
           refer to type A (tag 10 in compile unit 1)
I only checked a few but have seen type A may be a simple type
like "unsigned char" or a complex type like an array of base types.
I am using latest llvm trunk and bpf-next. I suspect llvm12 or
linus tree >=3D 5.12 rc2 should be able to exhibit the issue as well.
Both thin-lto and lto have the same issues.

Current pahole cannot handle this. It will report types cannot
be found error. Bill Wendling has attempted to fix the issue
with [1] by permitting all tags/types are hashed to the same
hash table and then process cu's one by one. This does not
really work. The reason is that each cu resolves types locally
so for the above example we may have
  compile unit 1:
    type A : type_id =3D 10
  compile unit 2:
    refer to type A : type A will be resolved as type id =3D 10
But id 10 refers to compile unit 1, we will get either out
of bound type id or incorrect one.

This patch set is a continuation of Bill's work. We still
increase the hashtable size and traverse all cu's before
recoding and finalization. But instead of creating one-to-one
mapping between debuginfo cu and pahole cu, we just create
one pahole cu, which should solve the above incorrect type
id issue.

Patches #1 and #2 are refactoring the existing code
and Patch #3 added an option "merge_cus" to permit
merging all debuginfo cu's into one pahole cu.
For vmlinux built, it can be detected that if LTO or Thin-LTO
is enabled, "merge_cus" can be added into pahole
command line.

  [1] https://www.spinics.net/lists/dwarves/msg00999.html

Yonghong Song (3):
  dwarf_loader: permits flexible HASHTAGS__BITS
  dwarf_loader: factor out common code to initialize a cu
  dwarf_loader: add option to merge more dwarf cu's into one pahole cu

 dwarf_loader.c | 179 +++++++++++++++++++++++++++++++++++++++----------
 dwarves.h      |   2 +
 pahole.c       |   8 +++
 3 files changed, 155 insertions(+), 34 deletions(-)

--=20
2.30.2

