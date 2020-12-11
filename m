Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32366C2BB9A
	for <linux-dwarves@archiver.kernel.org>; Fri, 11 Dec 2020 04:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3CBD23B85
	for <linux-dwarves@archiver.kernel.org>; Fri, 11 Dec 2020 04:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395313AbgLKENA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 10 Dec 2020 23:13:00 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:35068 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2395307AbgLKEMj (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Thu, 10 Dec 2020 23:12:39 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 0BB43AjE021086
        for <dwarves@vger.kernel.org>; Thu, 10 Dec 2020 20:11:54 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 35arhdpv3g-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <dwarves@vger.kernel.org>; Thu, 10 Dec 2020 20:11:54 -0800
Received: from intmgw003.03.ash8.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 10 Dec 2020 20:11:52 -0800
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 3A7092ECB19F; Thu, 10 Dec 2020 20:11:48 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <dwarves@vger.kernel.org>, <acme@kernel.org>, <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@redhat.com>
Subject: [PATCH dwarves 2/2] btf_encoder: fix skipping per-CPU variables at offset 0
Date:   Thu, 10 Dec 2020 20:11:38 -0800
Message-ID: <20201211041139.589692-3-andrii@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201211041139.589692-1-andrii@kernel.org>
References: <20201211041139.589692-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-11_01:2020-12-09,2020-12-11 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 adultscore=0 suspectscore=8 mlxscore=0 phishscore=0 mlxlogscore=954
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 bulkscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012110022
X-FB-Internal: deliver
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Adjust pahole logic of skipping any per-CPU symbol with offset 0, which is
especially bad for kernel modules, because it most certainly skips the very
first per-CPU variable.

Instead, do collect per-CPU ELF symbol with 0 offset, but do extra check for
non-kernel module case by verifying that ELF symbol name and DWARF variable
name match. Due to the bug of DWARF name of variable sometimes being NULL,
this is necessarily too pessimistic check (e.g., on my vmlinux image,
fixed_percpu_data variable is still not emitted due to missing DWARF variable
name), it allows to emit data for all module per-CPU variables.

Fixes: f3d9054ba8ff ("btf_encoder: Teach pahole to store percpu variables in vmlinux BTF.")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 btf_encoder.c | 40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index a7d484765ce2..1d7817078f89 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -412,21 +412,6 @@ static int collect_percpu_var(struct btf_elf *btfe, GElf_Sym *sym)
 		return 0;
 
 	addr = elf_sym__value(sym);
-	/*
-	 * Store only those symbols that have allocated space in the percpu section.
-	 * This excludes the following three types of symbols:
-	 *
-	 *  1. __ADDRESSABLE(sym), which are forcely emitted as symbols.
-	 *  2. __UNIQUE_ID(prefix), which are introduced to generate unique ids.
-	 *  3. __exitcall(fn), functions which are labeled as exit calls.
-	 *
-	 * In addition, the variables defined using DEFINE_PERCPU_FIRST are
-	 * also not included, which currently includes:
-	 *
-	 *  1. fixed_percpu_data
-	 */
-	if (!addr)
-		return 0;
 
 	size = elf_sym__size(sym);
 	if (!size)
@@ -652,7 +637,7 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
 
 	cu__for_each_variable(cu, core_id, pos) {
 		uint32_t size, type, linkage;
-		const char *name;
+		const char *name, *dwarf_name;
 		uint64_t addr;
 		int id;
 
@@ -680,6 +665,29 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
 		if (!percpu_var_exists(addr, &size, &name))
 			continue; /* not a per-CPU variable */
 
+		/* A lot of "special" DWARF variables (e.g, __UNIQUE_ID___xxx)
+		 * have addr == 0, which is the same as, say, valid
+		 * fixed_percpu_data per-CPU variable. To distinguish between
+		 * them, additionally compare DWARF and ELF symbol names. If
+		 * DWARF doesn't provide proper name, pessimistically assume
+		 * bad variable.
+		 *
+		 * Examples of such special variables are:
+		 *
+		 *  1. __ADDRESSABLE(sym), which are forcely emitted as symbols.
+		 *  2. __UNIQUE_ID(prefix), which are introduced to generate unique ids.
+		 *  3. __exitcall(fn), functions which are labeled as exit calls.
+		 *
+		 *  This is relevant only for vmlinux image, as for kernel
+		 *  modules per-CPU data section has non-zero offset so all
+		 *  per-CPU symbols have non-zero values.
+		 */
+		if (var->ip.addr == 0) {
+			dwarf_name = variable__name(var, cu);
+			if (!dwarf_name || strcmp(dwarf_name, name))
+				continue;
+		}
+
 		if (var->spec)
 			var = var->spec;
 
-- 
2.24.1

