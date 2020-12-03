Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FCBEC4361B
	for <linux-dwarves@archiver.kernel.org>; Thu,  3 Dec 2020 22:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 800012220F
	for <linux-dwarves@archiver.kernel.org>; Thu,  3 Dec 2020 22:07:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbgLCWH0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 3 Dec 2020 17:07:26 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:26081 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725885AbgLCWH0 (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Thu, 3 Dec 2020 17:07:26 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-XDsYB1DZO82W0KTPJacDUg-1; Thu, 03 Dec 2020 17:06:29 -0500
X-MC-Unique: XDsYB1DZO82W0KTPJacDUg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5B3B21005D4E;
        Thu,  3 Dec 2020 22:06:28 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.195.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9CFD15D9CA;
        Thu,  3 Dec 2020 22:06:26 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>
Subject: [PATCHv2 0/3] btf_encoder: Detect kernel modules
Date:   Thu,  3 Dec 2020 23:06:22 +0100
Message-Id: <20201203220625.3704363-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

hi,
adding support to detect kernel module and use its
mcount_loc section data as function filter.

v2 changes:
  - initialize return arguments in get_vmlinux_addrs [Andrii]
  - use elf_getscn in elf_section_by_idx [Andrii]
  - use address size from ELF's class for both kmod and vmlinux

thanks,
jirka


---
Jiri Olsa (3):
      btf_encoder: Factor filter_functions function
      btf_encoder: Use address size based on ELF's class
      btf_encoder: Detect kernel module ftrace addresses

 btf_encoder.c | 179 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------
 dutil.c       |  10 ++++++++
 dutil.h       |   2 ++
 3 files changed, 164 insertions(+), 27 deletions(-)

