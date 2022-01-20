Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56433C433EF
	for <linux-dwarves@archiver.kernel.org>; Thu, 20 Jan 2022 01:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237549AbiATBJ0 (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Wed, 19 Jan 2022 20:09:26 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:26024 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230333AbiATBIt (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Wed, 19 Jan 2022 20:08:49 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20K0eDUE021334
        for <dwarves@vger.kernel.org>; Wed, 19 Jan 2022 17:08:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=BcGjpflmXdsdW0dpjglKmqK+rYD+Gd8qklENRGkfbIc=;
 b=mz5iMfMBZDXyAYn/y6h9bc3cqTSg16B9Zxng81jaGDwi/TKLPvoCvKseSWgIW+4DBlfT
 xSNy+IMvxYyveR3UGTs3hrk/v/zghLY9HgwH7D75BPRBis+LJb+XM8O1lirrDsL+WOU5
 Ej2M6NO3Dm4GY42ZlppjIPlWnshU5wqxQf8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dp16qjqnr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <dwarves@vger.kernel.org>; Wed, 19 Jan 2022 17:08:47 -0800
Received: from twshared29821.14.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 19 Jan 2022 17:08:38 -0800
Received: by devvm1744.ftw0.facebook.com (Postfix, from userid 460691)
        id 5F161276FA1F; Wed, 19 Jan 2022 17:08:30 -0800 (PST)
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     <dwarves@vger.kernel.org>, <arnaldo.melo@gmail.com>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        Kui-Feng Lee <kuifeng@fb.com>
Subject: [PATCH dwarves 0/2] Parallelize BTF type info generating of pahole
Date:   Wed, 19 Jan 2022 17:08:15 -0800
Message-ID: <20220120010817.2803482-1-kuifeng@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: LKhd0rl60EdY3XE4QT5PTOVSqbSz5pw3
X-Proofpoint-GUID: LKhd0rl60EdY3XE4QT5PTOVSqbSz5pw3
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-19_12,2022-01-19_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 spamscore=0 mlxlogscore=490 suspectscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201200006
X-FB-Internal: deliver
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Creating an instance of btf for each worker thread allows
steal-function provided by pahole to add type info on multiple threads
without a lock.  The main thread merges the results of worker threads
to the primary instance.

Copying data from per-thread btf instances to the primary instance is
expensive now.  However, there is a patch landed at the bpf-next
repository. [1] With the patch for bpf-next and this patch, they drop
total runtime to 5.4s from 6.0s with "-j4" on my device to generate
BTF for Linux.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit=
/?id=3Dd81283d27266

Kui-Feng Lee (2):
  dwarf_loader: Prepare and pass per-thread data to worker threads.
  pahole: Use per-thread btf instances to avoid mutex locking.

 btf_encoder.c  |   5 +++
 btf_encoder.h  |   2 +
 btf_loader.c   |   2 +-
 ctf_loader.c   |   2 +-
 dwarf_loader.c |  58 ++++++++++++++++++------
 dwarves.h      |   9 +++-
 pahole.c       | 120 ++++++++++++++++++++++++++++++++++++++++++++++---
 pdwtags.c      |   3 +-
 pfunct.c       |   4 +-
 9 files changed, 180 insertions(+), 25 deletions(-)

--=20
2.30.2

