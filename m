Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C44C4167B
	for <linux-dwarves@archiver.kernel.org>; Fri, 11 Dec 2020 04:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 574FB23D56
	for <linux-dwarves@archiver.kernel.org>; Fri, 11 Dec 2020 04:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbgLKENA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 10 Dec 2020 23:13:00 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:14390 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2395284AbgLKEMc (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Thu, 10 Dec 2020 23:12:32 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BB4Akx6005322
        for <dwarves@vger.kernel.org>; Thu, 10 Dec 2020 20:11:49 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 35bpp2v38w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <dwarves@vger.kernel.org>; Thu, 10 Dec 2020 20:11:48 -0800
Received: from intmgw001.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 10 Dec 2020 20:11:47 -0800
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id DFF582ECB19F; Thu, 10 Dec 2020 20:11:43 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <dwarves@vger.kernel.org>, <acme@kernel.org>, <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@redhat.com>
Subject: [PATCH dwarves 0/2] Fix pahole to emit kernel module BTF variables
Date:   Thu, 10 Dec 2020 20:11:36 -0800
Message-ID: <20201211041139.589692-1-andrii@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-11_01:2020-12-09,2020-12-11 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=8
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 mlxlogscore=708 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012110023
X-FB-Internal: deliver
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Two bug fixes to make pahole emit correct kernel module BTF variable
information.

Cc: Hao Luo <haoluo@google.com>
Cc: Jiri Olsa <jolsa@redhat.com>

Andrii Nakryiko (2):
  btf_encoder: fix BTF variable generation for kernel modules
  btf_encoder: fix skipping per-CPU variables at offset 0

 btf_encoder.c | 61 +++++++++++++++++++++++++++++++++------------------
 libbtf.c      |  1 +
 libbtf.h      |  1 +
 3 files changed, 42 insertions(+), 21 deletions(-)

-- 
2.24.1

