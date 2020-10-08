Return-Path: <SRS0=vfrS=DP=vger.kernel.org=dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82410C433E7
	for <linux-dwarves@archiver.kernel.org>; Thu,  8 Oct 2020 23:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19B1422242
	for <linux-dwarves@archiver.kernel.org>; Thu,  8 Oct 2020 23:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602200409;
	bh=v/lhga+VsSVgk0b4UaLrN2hZzAylPIvnPIyf1YISSXw=;
	h=From:To:CC:Subject:Date:List-ID:From;
	b=ooIb74sHpancy6TInT6qwH0hY7mgT42HOaRDqQDIux3h6SOYtFOmWWoLN1UwgwECo
	 uPKBQx+dzP0rflP0p2NoGOpfI7vOp1iatQwrDd1I/qHz+SCUq4YgBKKkhLJlhGej81
	 ATXpSI7ONTvCamYOv0f+mIM9r12rIjRhtd55YcfQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbgJHXkI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 8 Oct 2020 19:40:08 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:6676 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725909AbgJHXkI (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Thu, 8 Oct 2020 19:40:08 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 098NZ4UK017547
        for <dwarves@vger.kernel.org>; Thu, 8 Oct 2020 16:40:07 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3429gp8w62-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <dwarves@vger.kernel.org>; Thu, 08 Oct 2020 16:40:07 -0700
Received: from intmgw004.08.frc2.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 8 Oct 2020 16:40:05 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 6BB8C2EC7C76; Thu,  8 Oct 2020 16:40:03 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <dwarves@vger.kernel.org>
CC:     <bpf@vger.kernel.org>, <kernel-team@fb.com>, <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH v2 dwarves 0/8] Switch BTF loading and encoding to libbpf APIs
Date:   Thu, 8 Oct 2020 16:39:52 -0700
Message-ID: <20201008234000.740660-1-andrii@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-FB-Internal: Safe
Content-Type: text/plain
Content-Transfer-Encoding: 8BIT
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-08_15:2020-10-08,2020-10-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 spamscore=0 clxscore=1011 bulkscore=0 mlxscore=0 adultscore=0
 mlxlogscore=489 suspectscore=13 impostorscore=0 phishscore=0
 malwarescore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2010080166
X-FB-Internal: deliver
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

This patch set switches pahole to use libbpf-provided BTF loading and encoding
APIs. This reduces pahole's own BTF encoding code, speeds up the process,
reduces amount of RAM needed for DWARF-to-BTF conversion. Also, pahole finally
gets support to generating BTF for cross-compiled ELF binaries with different
endianness (patch #8).

Additionally, patch #3 fixes previously missed problem with invalid array
index type generation.

Patches #4-7 are speeding up DWARF-to-BTF convertion/dedup pretty
significantly, saving overall about 9 seconds out of current 27 or so.

Patch #5 revamps how per-CPU BTF variables are emitted, eliminating repeated
and expensive looping over ELF symbols table. The critical detail that took
few hours of investigation is that when DW_AT_variable has
DW_AT_specification, variable address (to correlate with symbol's address) has
to be taken before specification is followed.

More details could be found in respective patches.

v1->v2:
  - rebase on latest dwarves master and fix var->spec's address problem.

Cc: Arnaldo Carvalho de Melo <acme@kernel.org>

Andrii Nakryiko (8):
  btf_loader: use libbpf to load BTF
  btf_encoder: use libbpf APIs to encode BTF type info
  btf_encoder: fix emitting __ARRAY_SIZE_TYPE__ as index range type
  btf_encoder: discard CUs after BTF encoding
  btf_encoder: revamp how per-CPU variables are encoded
  dwarf_loader: increase the size of lookup hash map
  strings: use BTF's string APIs for strings management
  btf_encoder: support cross-compiled ELF binaries with different
    endianness

 btf_encoder.c  | 370 +++++++++++++++------------
 btf_loader.c   | 244 +++++++-----------
 ctf_encoder.c  |   2 +-
 dwarf_loader.c |   2 +-
 libbtf.c       | 661 +++++++++++++++++++++----------------------------
 libbtf.h       |  41 ++-
 libctf.c       |  14 +-
 libctf.h       |   4 +-
 pahole.c       |   2 +-
 strings.c      |  91 +++----
 strings.h      |  32 +--
 11 files changed, 645 insertions(+), 818 deletions(-)

-- 
2.24.1

