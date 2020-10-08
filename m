Return-Path: <SRS0=vfrS=DP=vger.kernel.org=dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20441C433E7
	for <linux-dwarves@archiver.kernel.org>; Thu,  8 Oct 2020 23:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB25C2224E
	for <linux-dwarves@archiver.kernel.org>; Thu,  8 Oct 2020 23:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602200443;
	bh=MAXM1RbIMFR3cb/btDIfIew5vAc4KWKk+uYcErtWLs4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-ID:From;
	b=r4borC4t6pGsPHEcUUQwEqCFpbpCDPfb5CQD4kpSKqvFuM/Z2nyPucfhQ2Zq2P2U+
	 IUAe5Sn5bhl5uCypBrzsKtDuTdzMgi5nfwrP5DYg2gljERiM+FBvP3M/AyNeEmI0sR
	 sEFMh14cepFgdbcMaqhECpMM2Nd63FVA5C+Jgkfo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731081AbgJHXkn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 8 Oct 2020 19:40:43 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:59378 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731066AbgJHXkn (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Thu, 8 Oct 2020 19:40:43 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 098NVPDB030566
        for <dwarves@vger.kernel.org>; Thu, 8 Oct 2020 16:40:42 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3429gwrxd7-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <dwarves@vger.kernel.org>; Thu, 08 Oct 2020 16:40:42 -0700
Received: from intmgw004.08.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 8 Oct 2020 16:40:26 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id F3FE12EC7C76; Thu,  8 Oct 2020 16:40:20 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <dwarves@vger.kernel.org>
CC:     <bpf@vger.kernel.org>, <kernel-team@fb.com>, <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>
Subject: [PATCH v2 dwarves 8/8] btf_encoder: support cross-compiled ELF binaries with different endianness
Date:   Thu, 8 Oct 2020 16:40:00 -0700
Message-ID: <20201008234000.740660-9-andrii@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201008234000.740660-1-andrii@kernel.org>
References: <20201008234000.740660-1-andrii@kernel.org>
MIME-Version: 1.0
X-FB-Internal: Safe
Content-Type: text/plain
Content-Transfer-Encoding: 8BIT
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-08_15:2020-10-08,2020-10-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 adultscore=0
 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 malwarescore=0 spamscore=0 mlxscore=0 clxscore=1034 suspectscore=13
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010080166
X-FB-Internal: deliver
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

From: Andrii Nakryiko <andriin@fb.com>

Ensure that output BTF endianness corresponds to target ELF's endianness. This
makes it finally possible to use pahole to generate BTF for cross-compiled
kernels with different endianness.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 libbtf.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/libbtf.c b/libbtf.c
index 27aa3e5a986e..babf4fe8cd9e 100644
--- a/libbtf.c
+++ b/libbtf.c
@@ -87,6 +87,8 @@ struct btf_elf *btf_elf__new(const char *filename, Elf *elf)
 		btfe->raw_btf  = true;
 		btfe->wordsize = sizeof(long);
 		btfe->is_big_endian = BYTE_ORDER == BIG_ENDIAN;
+		btf__set_endianness(btfe->btf,
+				    btfe->is_big_endian ? BTF_BIG_ENDIAN : BTF_LITTLE_ENDIAN);
 		return btfe;
 	}
 
@@ -118,8 +120,14 @@ struct btf_elf *btf_elf__new(const char *filename, Elf *elf)
 	}
 
 	switch (btfe->ehdr.e_ident[EI_DATA]) {
-	case ELFDATA2LSB: btfe->is_big_endian = false; break;
-	case ELFDATA2MSB: btfe->is_big_endian = true;  break;
+	case ELFDATA2LSB:
+		btfe->is_big_endian = false;
+		btf__set_endianness(btfe->btf, BTF_LITTLE_ENDIAN);
+		break;
+	case ELFDATA2MSB:
+		btfe->is_big_endian = true;
+		btf__set_endianness(btfe->btf, BTF_BIG_ENDIAN);
+		break;
 	default:
 		fprintf(stderr, "%s: unknown elf endianness.\n", __func__);
 		goto errout;
@@ -704,6 +712,18 @@ static int btf_elf__write(const char *filename, struct btf *btf)
 		goto out;
 	}
 
+	switch (ehdr_mem.e_ident[EI_DATA]) {
+	case ELFDATA2LSB:
+		btf__set_endianness(btf, BTF_LITTLE_ENDIAN);
+		break;
+	case ELFDATA2MSB:
+		btf__set_endianness(btf, BTF_BIG_ENDIAN);
+		break;
+	default:
+		fprintf(stderr, "%s: unknown elf endianness.\n", __func__);
+		goto out;
+	}
+
 	/*
 	 * First we look if there was already a .BTF section to overwrite.
 	 */
-- 
2.24.1

