Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A40C4332F
	for <linux-dwarves@archiver.kernel.org>; Mon, 24 Jan 2022 19:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345366AbiAXTWk (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Mon, 24 Jan 2022 14:22:40 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:23632 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1348641AbiAXTTW (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Mon, 24 Jan 2022 14:19:22 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 20OHVkoT020241
        for <dwarves@vger.kernel.org>; Mon, 24 Jan 2022 11:19:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=q2FfadR7zXuPDhV0DSMIvgVpo3Cs6cFsDqz81WQ/YT8=;
 b=TdiyvOqtIrRkiGmDBHoJyn1QQt92vtznnFJqg1CDnvxlgGN8iehBwDNu02Qv+6ZklPGu
 svLwx5ugGPaEnYcplr7VxqG7hRmBzLSYfbBBIBNqKJ7q40+umsrfZHqWYouFKz0uoH1R
 +DHDARg5TAJkSjqSXsu4zRzITbnG2Lzi7Wg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3dsk2q575j-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <dwarves@vger.kernel.org>; Mon, 24 Jan 2022 11:19:21 -0800
Received: from twshared3115.02.ash8.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 24 Jan 2022 11:19:19 -0800
Received: by devvm1744.ftw0.facebook.com (Postfix, from userid 460691)
        id 3F9132AE341A; Mon, 24 Jan 2022 11:19:10 -0800 (PST)
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     <dwarves@vger.kernel.org>, <arnaldo.melo@gmail.com>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        Kui-Feng Lee <kuifeng@fb.com>
Subject: [PATCH dwarves 0/3] Parallelize BTF type info generating of pahole
Date:   Mon, 24 Jan 2022 11:18:55 -0800
Message-ID: <20220124191858.1601255-1-kuifeng@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: dtpSZGFmszA90locDpCja8ioGkB0zzqg
X-Proofpoint-ORIG-GUID: dtpSZGFmszA90locDpCja8ioGkB0zzqg
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-24_09,2022-01-24_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 impostorscore=0
 spamscore=0 bulkscore=0 mlxscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 mlxlogscore=571
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2201240127
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

V2 fixes typo and syntax according the comments got from v1.
It also divides part 1 of v1 into part 1 & 2.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit=
/?id=3Dd81283d27266
[v1] https://lore.kernel.org/dwarves/20220120010817.2803482-1-kuifeng@fb.co=
m/

Kui-Feng Lee (3):
  dwarf_loader: Receive per-thread data on worker threads.
  dwarf_loader: Prepare and pass per-thread data to worker threads.
  pahole: Use per-thread btf instances to avoid mutex locking.

 btf_encoder.c  |   5 +++
 btf_encoder.h  |   2 +
 btf_loader.c   |   2 +-
 ctf_loader.c   |   2 +-
 dwarf_loader.c |  58 ++++++++++++++++++------
 dwarves.h      |   9 +++-
 pahole.c       | 117 ++++++++++++++++++++++++++++++++++++++++++++++---
 pdwtags.c      |   3 +-
 pfunct.c       |   4 +-
 9 files changed, 177 insertions(+), 25 deletions(-)

--=20
2.30.2

