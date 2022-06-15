Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B6EC43334
	for <linux-dwarves@archiver.kernel.org>; Wed, 15 Jun 2022 23:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238604AbiFOXDP (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Wed, 15 Jun 2022 19:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234808AbiFOXDO (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Wed, 15 Jun 2022 19:03:14 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAFD522292
        for <dwarves@vger.kernel.org>; Wed, 15 Jun 2022 16:03:13 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25FLpmvZ005371
        for <dwarves@vger.kernel.org>; Wed, 15 Jun 2022 16:03:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=se6NoeIsESINTodtQFPkqZO3i09QPUHgq0junBWYOIs=;
 b=HWUByzlOGamMahxOvJBDQ/XtXxbXAdCrnph7YEi4z3P/ccg/BUCqBdmxq0FcD4GW4bZp
 1fNzVBf+sU0RLZ2wq2EjPu12HC6cDafnhw/whf8OwRdBzxnY4i8/5ImVlB/xjvEikWKE
 MKCkXziGP5tBFMt4Paf3HYecuUBZy6zomGo= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gpuwymfu6-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <dwarves@vger.kernel.org>; Wed, 15 Jun 2022 16:03:13 -0700
Received: from twshared22934.08.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 15 Jun 2022 16:03:12 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 13C36BA4C514; Wed, 15 Jun 2022 16:03:06 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH dwarves v2 0/2] btf: support BTF_KIND_ENUM64
Date:   Wed, 15 Jun 2022 16:03:06 -0700
Message-ID: <20220615230306.851750-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: nln_OmFXORQxh6bze1o0rKH9pJ7YItH8
X-Proofpoint-GUID: nln_OmFXORQxh6bze1o0rKH9pJ7YItH8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-15_16,2022-06-15_01,2022-02-23_01
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Add support for enum64. For 64-bit enumerator value,
previously, the value is truncated into 32bit, e.g.,
for the following enum in linux uapi bpf.h,
  enum {
        BPF_F_INDEX_MASK                =3D 0xffffffffULL,
        BPF_F_CURRENT_CPU               =3D BPF_F_INDEX_MASK,
  /* BPF_FUNC_perf_event_output for sk_buff input context. */
        BPF_F_CTXLEN_MASK               =3D (0xfffffULL << 32),
  };

BPF_F_CTXLEN_MASK will be encoded with 0 with BTF_KIND_ENUM
after pahole dwarf-to-btf conversion.
With this patch, the BPF_F_CTXLEN_MASK will be encoded properly
with BTF_KIND_ENUM64.

This patch is on top of tmp.master since tmp.master has not
been sync'ed with master branch yet.

Changelogs:
  v1 -> v2:
    - Add flag --skip_encoding_btf_enum64 to disable newly-added function=
ality.

Yonghong Song (2):
  libbpf: Sync with latest libbpf repo
  btf: Support BTF_KIND_ENUM64

 btf_encoder.c     | 65 +++++++++++++++++++++++++++++++++++------------
 btf_encoder.h     |  2 +-
 dwarf_loader.c    | 12 +++++++++
 dwarves.h         |  4 ++-
 dwarves_fprintf.c |  6 ++++-
 lib/bpf           |  2 +-
 pahole.c          | 10 +++++++-
 7 files changed, 80 insertions(+), 21 deletions(-)

--=20
2.30.2

