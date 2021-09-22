Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0923EC43217
	for <linux-dwarves@archiver.kernel.org>; Wed, 22 Sep 2021 02:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDFF8610E8
	for <linux-dwarves@archiver.kernel.org>; Wed, 22 Sep 2021 02:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbhIVCPF (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 21 Sep 2021 22:15:05 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:38132 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229900AbhIVCPE (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Tue, 21 Sep 2021 22:15:04 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18LLEcgh019951
        for <dwarves@vger.kernel.org>; Tue, 21 Sep 2021 19:13:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=PeDNCnYFitH+YCnO9TBfSC89dObIlrQAqmBLoGkQ64M=;
 b=GOAFceJl8Xu9RL9Qe3KDVCjcduKbAFk3RkolnU40fzi6NjfCkCqR7m+iVAiTMEGHxoNp
 wECZgEsxQ4eD853nKgvUSFTuz1dOHRRtI/z/JN5zMS6ZnXrJbrN7eJpNTrEEqSL1fnjS
 4I+kEP82B4FVRLZ4Xp3irRAhMd7ECGfm+DE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3b7q4w1hm5-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <dwarves@vger.kernel.org>; Tue, 21 Sep 2021 19:13:35 -0700
Received: from intmgw001.05.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 21 Sep 2021 19:13:32 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id B2DDE24E20A; Tue, 21 Sep 2021 19:13:21 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH dwarves v2 0/2] generate BTF_KIND_TAG types from DW_TAG_LLVM_annotation dwarf tags
Date:   Tue, 21 Sep 2021 19:13:21 -0700
Message-ID: <20210922021321.2286360-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: ifFmZvYFBm9_QDUYqUN51ucLkFtArxD3
X-Proofpoint-ORIG-GUID: ifFmZvYFBm9_QDUYqUN51ucLkFtArxD3
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-21_07,2021-09-20_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 mlxlogscore=641
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109200000 definitions=main-2109220013
X-FB-Internal: deliver
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

LLVM has implemented btf_tag attribute ([1]) which intended
to provide a "string" tag for struct/union or its member, var,
a func or its parameter. Such a "string" tag will be encoded
in dwarf. For non-BPF target like x86_64, pahole needs to
convert those dwarf btf_tag annotations to BTF so kernel
can utilize these "string" tags for bpf program verification, etc.
=20=20=20=20=20=20=20=20
Patch 1 enhanced dwarf_loader to encode DW_TAG_LLVM_annotation
tags into internal data structure and Patch 2 will encode
such information to BTF with BTF_KIND_TAGs.

 [1] https://reviews.llvm.org/D106614

Changelog:
  v1 -> v2:
    - handle returning error cases for btf_encoder__add_tag().

Yonghong Song (2):
  dwarf_loader: parse dwarf tag DW_TAG_LLVM_annotation
  btf_encoder: generate BTF_KIND_TAG from llvm annotations

 btf_encoder.c  | 63 ++++++++++++++++++++++++++++++++++++-
 dwarf_loader.c | 85 ++++++++++++++++++++++++++++++++++++++++++++++----
 dwarves.h      | 10 ++++++
 pahole.c       |  8 +++++
 4 files changed, 159 insertions(+), 7 deletions(-)

--=20
2.30.2

