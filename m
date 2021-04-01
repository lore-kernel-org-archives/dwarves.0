Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190D4C433B4
	for <linux-dwarves@archiver.kernel.org>; Thu,  1 Apr 2021 02:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE27461077
	for <linux-dwarves@archiver.kernel.org>; Thu,  1 Apr 2021 02:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbhDAC6x (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Wed, 31 Mar 2021 22:58:53 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:49138 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233327AbhDAC61 (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Wed, 31 Mar 2021 22:58:27 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1312msjD021815
        for <dwarves@vger.kernel.org>; Wed, 31 Mar 2021 19:58:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=bRZwlD05rooxJMF2A/iIu55lvhEbiSIoVgbN8Ln/yu4=;
 b=FGgW31lxkGtk0wbQcGwL6zlL/xrqfRiem0EKjvwhnQ7JiycG58Cw7ChCsrDHpXBoTWay
 Kpniw93LIajOUpCC74JwiTC7l1nSAcv7OIKQq3EP5SZhD2vfwBSpBSYz/5HMrhb32XCd
 ntXjt40knuilAlP9GbGKQOfB8fomAD3XvdA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37n2ahrv18-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <dwarves@vger.kernel.org>; Wed, 31 Mar 2021 19:58:27 -0700
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 31 Mar 2021 19:58:26 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 83DE8EB9B62; Wed, 31 Mar 2021 19:58:25 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Bill Wendling <morbo@google.com>, <bpf@vger.kernel.org>,
        David Blaikie <dblaikie@gmail.com>,
        =?UTF-8?q?F=C4=81ng-ru=C3=AC=20S=C3=B2ng?= <maskray@google.com>,
        <kernel-team@fb.com>, Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH dwarves 2/2] dwarf_loader: check .notes section for lto build info
Date:   Wed, 31 Mar 2021 19:58:25 -0700
Message-ID: <20210401025825.2254746-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210401025815.2254256-1-yhs@fb.com>
References: <20210401025815.2254256-1-yhs@fb.com>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 63YbOU3ymXV9crfjAD2qu1bWJT2bBVmj
X-Proofpoint-ORIG-GUID: 63YbOU3ymXV9crfjAD2qu1bWJT2bBVmj
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-31_11:2021-03-31,2021-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 spamscore=0
 impostorscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=999 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103310000 definitions=main-2104010019
X-FB-Internal: deliver
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

In [1], linux introduced a note with type BUILD_COMPILER_LTO_INFO.
If this note type exist, there is no need to scan .debug_abbrev
section for cross-cu reference. With a kernel built with [1],
the cus__merging_cu() overhead is about 3us for either
lto or non-lto vmlinux.

 [1] https://lore.kernel.org/bpf/20210401012406.1800957-1-yhs@fb.com/

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 dwarf_loader.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index bd23751..026d137 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -2501,8 +2501,37 @@ static int cus__load_debug_types(struct cus *cus, st=
ruct conf_load *conf,
 	return 0;
 }
=20
-static bool cus__merging_cu(Dwarf *dw)
+/* Match the define in linux:include/linux/elfnote.h */
+#define LINUX_ELFNOTE_BUILD_LTO		0x101
+
+static bool cus__merging_cu(Dwarf *dw, Elf *elf)
 {
+	Elf_Scn *section =3D NULL;
+	while ((section =3D elf_nextscn(elf, section)) !=3D 0) {
+		GElf_Shdr header;
+		if (!gelf_getshdr(section, &header))
+			continue;
+
+		if (header.sh_type !=3D SHT_NOTE)
+			continue;
+
+		Elf_Data *data =3D NULL;
+		while ((data =3D elf_getdata(section, data)) !=3D 0) {
+			size_t name_off, desc_off, offset =3D 0;
+			GElf_Nhdr hdr;
+			while ((offset =3D gelf_getnote(data, offset, &hdr, &name_off, &desc_of=
f)) !=3D 0) {
+				if (hdr.n_type !=3D LINUX_ELFNOTE_BUILD_LTO)
+					continue;
+
+				/* owner is Linux */
+				if (strcmp((char *)data->d_buf + name_off, "Linux") !=3D 0)
+					continue;
+
+				return *(int *)(data->d_buf + desc_off) !=3D 0;
+			}
+		}
+	}
+
 	Dwarf_Off off =3D 0, noff;
 	size_t cuhl;
=20
@@ -2649,7 +2678,7 @@ static int cus__load_module(struct cus *cus, struct c=
onf_load *conf,
 		}
 	}
=20
-	if (cus__merging_cu(dw)) {
+	if (cus__merging_cu(dw, elf)) {
 		res =3D cus__merge_and_process_cu(cus, conf, mod, dw, elf, filename,
 						build_id, build_id_len,
 						type_cu ? &type_dcu : NULL);
--=20
2.30.2

