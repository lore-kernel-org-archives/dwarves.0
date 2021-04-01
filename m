Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0E9C43470
	for <linux-dwarves@archiver.kernel.org>; Thu,  1 Apr 2021 02:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D2B561059
	for <linux-dwarves@archiver.kernel.org>; Thu,  1 Apr 2021 02:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233305AbhDAC6x (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Wed, 31 Mar 2021 22:58:53 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:39122 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233318AbhDAC61 (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Wed, 31 Mar 2021 22:58:27 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1312nRA0014372
        for <dwarves@vger.kernel.org>; Wed, 31 Mar 2021 19:58:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=QqPajUbwdg6hoJiPtv9xVNjscfEufpQOiNX8ELfngSg=;
 b=QgY6Y9x6Aq1rX/t0knh5PtHdSIOETPvPL7MsqMkEEnmNE+n3hVoh6Uu7ve8DFifqTH41
 XVSTnBDjDWyvK8MwC2qQR6U+/1d2Bp/cryeWIEnXBQ0Vz1T6Rnmor17tJOGJ8s/zJ7Yc
 jYK311nRWs55XIcfJ2I0VOXb7TJ+zh9cVO8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37n2810vud-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <dwarves@vger.kernel.org>; Wed, 31 Mar 2021 19:58:24 -0700
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 31 Mar 2021 19:58:22 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 4ABB3EB9B57; Wed, 31 Mar 2021 19:58:20 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Bill Wendling <morbo@google.com>, <bpf@vger.kernel.org>,
        David Blaikie <dblaikie@gmail.com>,
        =?UTF-8?q?F=C4=81ng-ru=C3=AC=20S=C3=B2ng?= <maskray@google.com>,
        <kernel-team@fb.com>, Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH dwarves 1/2] dwarf_loader: check .debug_abbrev for cross-cu references
Date:   Wed, 31 Mar 2021 19:58:20 -0700
Message-ID: <20210401025820.2254482-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210401025815.2254256-1-yhs@fb.com>
References: <20210401025815.2254256-1-yhs@fb.com>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: cPr7vtCPKzecsF8pRy_Klwy3U1JXGTOb
X-Proofpoint-ORIG-GUID: cPr7vtCPKzecsF8pRy_Klwy3U1JXGTOb
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-31_11:2021-03-31,2021-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015 bulkscore=0
 impostorscore=0 spamscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104010019
X-FB-Internal: deliver
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Commit 39227909db3c checked compilation flags to see
whether the binary is built with lto or not (-flto).
Currently, for clang lto build, default setting
won't put compilation flags in dwarf due to size
concern.

David Blaikie suggested in [1] to scan through .debug_abbrev
for DW_FORM_ref_addr which should be most faster than
scanning through cu's. This patch implemented this
suggestion and replaced the previous compilation flag
matching approach. Indeed, it seems that the overhead
for this approach is indeed managable.

I did some change to measure the overhead of cus_merging_cu():
  @@ -2650,7 +2652,15 @@ static int cus__load_module(struct cus *cus, struc=
t conf_load *conf,
                  }
          }

  -       if (cus__merging_cu(dw)) {
  +       bool do_merging;
  +       struct timeval start, end;
  +       gettimeofday(&start, NULL);
  +       do_merging =3D cus__merging_cu(dw);
  +       gettimeofday(&end, NULL);
  +       fprintf(stderr, "%ld %ld -> %ld %ld\n", start.tv_sec, start.tv_us=
ec,
  +                       end.tv_sec, end.tv_usec);
  +
  +       if (do_merging) {
                  res =3D cus__merge_and_process_cu(cus, conf, mod, dw, elf=
, filename,
                                                  build_id, build_id_len,
                                                  type_cu ? &type_dcu : NUL=
L);

For lto vmlinux, the cus__merging_cu() checking takes
130us over total "pahole -J vmlinux" time 65sec as the function bail out
earlier due to detecting a merging cu condition.
For non-lto vmlinux, the cus__merging_cu() checking takes
~171368us over total pahole time 36sec, roughly 0.5% overhead.

 [1] https://lore.kernel.org/bpf/20210328064121.2062927-1-yhs@fb.com/

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 dwarf_loader.c | 43 ++++++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index c1ca1a3..bd23751 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -2503,35 +2503,40 @@ static int cus__load_debug_types(struct cus *cus, s=
truct conf_load *conf,
=20
 static bool cus__merging_cu(Dwarf *dw)
 {
-	uint8_t pointer_size, offset_size;
 	Dwarf_Off off =3D 0, noff;
 	size_t cuhl;
-	int cnt =3D 0;
=20
-	/*
-	 * Just checking the first cu is not enough.
-	 * In linux, some C files may have LTO is disabled, e.g.,
-	 *   e242db40be27  x86, vdso: disable LTO only for vDSO
-	 *   d2dcd3e37475  x86, cpu: disable LTO for cpu.c
-	 * Fortunately, disabling LTO for a particular file in a LTO build
-	 * is rather an exception. Iterating 5 cu's to check whether
-	 * LTO is used or not should be enough.
-	 */
-	while (dwarf_nextcu(dw, off, &noff, &cuhl, NULL, &pointer_size,
-			    &offset_size) =3D=3D 0) {
+	while (dwarf_nextcu (dw, off, &noff, &cuhl, NULL, NULL, NULL) =3D=3D 0) {
 		Dwarf_Die die_mem;
 		Dwarf_Die *cu_die =3D dwarf_offdie(dw, off + cuhl, &die_mem);
=20
 		if (cu_die =3D=3D NULL)
 			break;
=20
-		if (++cnt > 5)
-			break;
+		Dwarf_Off offset =3D 0;
+		while (true) {
+			size_t length;
+			Dwarf_Abbrev *abbrev =3D dwarf_getabbrev (cu_die, offset, &length);
+			if (abbrev =3D=3D NULL || abbrev =3D=3D DWARF_END_ABBREV)
+				break;
=20
-		const char *producer =3D attr_string(cu_die, DW_AT_producer);
-		if (strstr(producer, "clang version") !=3D NULL &&
-		    strstr(producer, "-flto") !=3D NULL)
-			return true;
+			size_t attrcnt;
+			if (dwarf_getattrcnt (abbrev, &attrcnt) !=3D 0)
+				return false;
+
+			unsigned int attr_num, attr_form;
+			Dwarf_Off aboffset;
+			size_t j;
+			for (j =3D 0; j < attrcnt; ++j) {
+				if (dwarf_getabbrevattr (abbrev, j, &attr_num, &attr_form,
+							 &aboffset))
+					return false;
+				if (attr_form =3D=3D DW_FORM_ref_addr)
+					return true;
+			}
+
+			offset +=3D length;
+		}
=20
 		off =3D noff;
 	}
--=20
2.30.2

