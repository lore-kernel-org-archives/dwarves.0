Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 479D7C433EF
	for <linux-dwarves@archiver.kernel.org>; Thu, 12 May 2022 05:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349498AbiELFSt (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 12 May 2022 01:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347454AbiELFSs (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Thu, 12 May 2022 01:18:48 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92841195BE3
        for <dwarves@vger.kernel.org>; Wed, 11 May 2022 22:18:47 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24BMwgcZ003877
        for <dwarves@vger.kernel.org>; Wed, 11 May 2022 22:18:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=OqbokM0XZQXaK8PMlyrVgwJ4FoKHUwrR+8GqjPJei5o=;
 b=OvSs08CPxcLBqWQIb3TskoqBr35tXOvKJA5hlWTeub+o1k0LL2yZeRHh+xzYuJERmt73
 RoSeNqiXGwK4C113UoVUxuz8LJ7OzuQhZeGvfnt3t7Dc+Of3YTNVrKnFE5k3UFiEqokK
 bBNdLSwzWFGg2uP/USsulKQhlyLzUjoAGCw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g04pmr7nw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <dwarves@vger.kernel.org>; Wed, 11 May 2022 22:18:46 -0700
Received: from twshared4937.07.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 11 May 2022 22:18:08 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id C3FB2A2FE44B; Wed, 11 May 2022 22:18:04 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH dwarves v2 2/2] btf_encoder: Normalize array index type for parallel dwarf loading case
Date:   Wed, 11 May 2022 22:18:04 -0700
Message-ID: <20220512051804.2653507-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220512051759.2652236-1-yhs@fb.com>
References: <20220512051759.2652236-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: c4oh1DaXlS7VG322cbGQ7QjdlWH6cQnd
X-Proofpoint-GUID: c4oh1DaXlS7VG322cbGQ7QjdlWH6cQnd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-11_07,2022-05-11_01,2022-02-23_01
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

With latest llvm15 built kernel (make -j LLVM=3D1), I hit the following
error when build selftests (make -C tools/testing/selftests/bpf -j LLVM=3D=
1):
  In file included from skeleton/pid_iter.bpf.c:3:
  .../selftests/bpf/tools/build/bpftool/vmlinux.h:84050:9: error: unknown=
 type name
       '__builtin_va_list___2'; did you mean '__builtin_va_list'?
  typedef __builtin_va_list___2 va_list___2;
          ^~~~~~~~~~~~~~~~~~~~~
          __builtin_va_list
  note: '__builtin_va_list' declared here
  In file included from skeleton/profiler.bpf.c:3:
  .../selftests/bpf/tools/build/bpftool/vmlinux.h:84050:9: error: unknown=
 type name
       '__builtin_va_list__ _2'; did you mean '__builtin_va_list'?
  typedef __builtin_va_list___2 va_list___2;
          ^~~~~~~~~~~~~~~~~~~~~
          __builtin_va_list
  note: '__builtin_va_list' declared here

The error can be easily explained with after-dedup vmlinux btf:
  [21] INT 'int' size=3D4 bits_offset=3D0 nr_bits=3D32 encoding=3DSIGNED
  [2300] STRUCT '__va_list_tag' size=3D24 vlen=3D4
        'gp_offset' type_id=3D2 bits_offset=3D0
        'fp_offset' type_id=3D2 bits_offset=3D32
        'overflow_arg_area' type_id=3D32 bits_offset=3D64
        'reg_save_area' type_id=3D32 bits_offset=3D128
  [2308] TYPEDEF 'va_list' type_id=3D2309
  [2309] TYPEDEF '__builtin_va_list' type_id=3D2310
  [2310] ARRAY '(anon)' type_id=3D2300 index_type_id=3D21 nr_elems=3D1

  [5289] PTR '(anon)' type_id=3D2308
  [158520] STRUCT 'warn_args' size=3D32 vlen=3D2
        'fmt' type_id=3D14 bits_offset=3D0
        'args' type_id=3D2308 bits_offset=3D64
  [27299] INT '__ARRAY_SIZE_TYPE__' size=3D4 bits_offset=3D0 nr_bits=3D32=
 encoding=3D(none)
  [34590] TYPEDEF '__builtin_va_list' type_id=3D34591
  [34591] ARRAY '(anon)' type_id=3D2300 index_type_id=3D27299 nr_elems=3D=
1

Note that two array index_type_id's are different so the va_list and __bu=
iltin_va_list
will have two versions in the BTF. With this, vmlinux.h contains the foll=
owing code,
  typedef __builtin_va_list va_list;
  typedef __builtin_va_list___2 va_list___2;
Since __builtin_va_list is a builtin type for the compiler,
libbpf does not generate
  typedef <...> __builtin_va_list
and this caused __builtin_va_list___2 is not defined and hence compilatio=
n error.
This happened when pahole is running with more than one jobs when parsing=
 dwarf
and generating btfs.

Function btf_encoder__encode_cu() is used to do btf encoding for
each cu. The function will try to find an "int" type for the cu
if it is available, otherwise, it will create a special type
with name __ARRAY_SIZE_TYPE__. For example,
  file1: yes 'int' type
  file2: no 'int' type

In serial mode, file1 is processed first, followed by file2.
both will have 'int' type as the array index type since file2
will inherit the index type from file1.

In parallel mode though, arrays in file1 will have index type 'int',
and arrays in file2 wil have index type '__ARRAY_SIZE_TYPE__'.
This will prevent some legitimate dedup and may have generated
vmlinux.h having compilation error.

This patch fixed the issue by creating an 'int' type as the
array index type, so all array index type should be the same
for all cu's even in parallel mode.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 btf_encoder.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Changelog:
  v1 -> v2:
   - change creation of array index type to be 'int' type,
     the same as the type encoder tries to search in the current
     types.

diff --git a/btf_encoder.c b/btf_encoder.c
index 1a42094..9e708e4 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -1460,7 +1460,8 @@ int btf_encoder__encode_cu(struct btf_encoder *enco=
der, struct cu *cu)
=20
 		bt.name =3D 0;
 		bt.bit_size =3D 32;
-		btf_encoder__add_base_type(encoder, &bt, "__ARRAY_SIZE_TYPE__");
+		bt.is_signed =3D true;
+		btf_encoder__add_base_type(encoder, &bt, "int");
 		encoder->has_index_type =3D true;
 	}
=20
--=20
2.30.2

