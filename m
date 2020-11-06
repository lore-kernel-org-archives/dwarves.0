Return-Path: <SRS0=X0E1=EM=vger.kernel.org=dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D58C388F2
	for <linux-dwarves@archiver.kernel.org>; Fri,  6 Nov 2020 05:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 055902151B
	for <linux-dwarves@archiver.kernel.org>; Fri,  6 Nov 2020 05:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604640356;
	bh=v06R0TkAEEK1hQkJ7kUy0HWCcE7L4d6SdmsRAl9pKks=;
	h=From:To:CC:Subject:Date:List-ID:From;
	b=Z54BMbFADaj9Sxe+ONI7g2GE/6gcQkBaris5YxjSwLPHiU9wIbmedEcqluxi1CgWu
	 LYbzXhBtLBd0QGKbXLDDvNUVlogiFgQknIn9+WC/UcP8VkQGYK9rb53dmn4/Ae6eb4
	 p3TqaE575UbqmypO+p8+2e2IDYP+BcoU/rOmV/10=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725837AbgKFFZz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Fri, 6 Nov 2020 00:25:55 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:8556 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725835AbgKFFZz (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Fri, 6 Nov 2020 00:25:55 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A65OkQv024231
        for <dwarves@vger.kernel.org>; Thu, 5 Nov 2020 21:25:54 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 34m5r5qub5-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <dwarves@vger.kernel.org>; Thu, 05 Nov 2020 21:25:54 -0800
Received: from intmgw003.08.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 5 Nov 2020 21:25:53 -0800
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 5DC732EC8EF6; Thu,  5 Nov 2020 21:25:51 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <dwarves@vger.kernel.org>, <acme@kernel.org>, <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH dwarves 0/4] Add split BTF support to pahole
Date:   Thu, 5 Nov 2020 21:25:45 -0800
Message-ID: <20201106052549.3782099-1-andrii@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-06_01:2020-11-05,2020-11-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 adultscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=677 suspectscore=8 clxscore=1015
 spamscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011060037
X-FB-Internal: deliver
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Add ability to generate split BTF (for kernel modules), as well as load split
BTF. --btf_base argument is added to specify base BTF for split BTF. This
works for both btf_loader and btf_encoder.

Andrii Nakryiko (4):
  btf_encoder: fix array index type numbering
  libbtf: improve variable naming and error reporting when writing out
    BTF
  libbpf: update libbpf submodlue reference to latest master
  btf: add support for split BTF loading and encoding

 btf_encoder.c | 15 ++++++++-------
 btf_loader.c  |  2 +-
 lib/bpf       |  2 +-
 libbtf.c      | 43 +++++++++++++++++++++++++++----------------
 libbtf.h      |  4 +++-
 pahole.c      | 23 +++++++++++++++++++++++
 6 files changed, 63 insertions(+), 26 deletions(-)

-- 
2.24.1

