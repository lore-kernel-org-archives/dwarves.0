Return-Path: <SRS0=ASgQ=C6=vger.kernel.org=dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E06FC4363C
	for <linux-dwarves@archiver.kernel.org>; Mon, 21 Sep 2020 19:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 250762193E
	for <linux-dwarves@archiver.kernel.org>; Mon, 21 Sep 2020 19:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V3cX9kBm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbgIUTxy (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Mon, 21 Sep 2020 15:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727197AbgIUTxx (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Mon, 21 Sep 2020 15:53:53 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF67C061755
        for <dwarves@vger.kernel.org>; Mon, 21 Sep 2020 12:53:53 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id h191so11874663qke.1
        for <dwarves@vger.kernel.org>; Mon, 21 Sep 2020 12:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=QYDxpFkd6x3hO4KFD3r6MMj2VtZkn9zakZWkjUqeaPk=;
        b=V3cX9kBmIPV40AkjswH30h1iGFKC9m6QKKgsN1ByRO6AhpOJErPAx8yYNAtL2WWA3J
         7RxLnxAvinE9H3wbgRMxI9BB56GXC4srNA9dwsMmDojUoXRz7HuwNSPLNGsVFoAmR+Lb
         9o2IYtipOBUD4xdhmy8BwGp2DvLVzQ2RzV8roZHFq1IlFLYiyRd2caBHaQzDpgYGwNRE
         cK/nvK+QvWIHCvWFnfwtvYEj/M1ZbLpWyGmV/DCdFAtMQ4uQ2JNGp5uB1WqKKvgPNtEA
         kcQP/YMEyzG/E9zX0IFfKqLV5ZpkllPSnHcBHt3w4z1flLjoPkEQFpBVtqg3AOz89y+W
         EUzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=QYDxpFkd6x3hO4KFD3r6MMj2VtZkn9zakZWkjUqeaPk=;
        b=XhZrN4vpuqzI/AOsnZ3tglFANAFPcsBt1AaUUngYl5jj+lctxKQCoSrPAr2dmjGkbA
         IQZkevQoEUhgh9e0w6e/jTdpErryYhq8Q0c5vsP/zy6VhkiNDJAiY1clKfjIHm07SvLM
         aL8ayfydsEg/2zhKDEsCSitvFfqpi6lvZw8M+YZ288zkJp5A3oH5y7BEmVAU2lH+dOCF
         QIuw4NaKryfTm3DQ1o/wdT9Twp8QkRUBBjZ0+ws6Ez13OIF11yUqTflWRN+eLqHYcsFI
         8rNsd3GMKZ6N8h+gDalvskUlbOPZJ987KDT9PzAYl9a4Tbg3TbO1Mo/O7/8ol8yKYl81
         NYIw==
X-Gm-Message-State: AOAM533khDxiCEQkkTTVSHFCONx9xphgNXGojcNZtL+lgh5Q0RvQ01n2
        QnbL5ZYPqAtzFWk3mi403pOJQFMm4Hs=
X-Google-Smtp-Source: ABdhPJybmAqVngr22DJTIxBbeUfqxrIW7MhO+/LEraSnfLldS5+AGlQ8qIatzAtHqpfTLVP6vKlYpHaR9mk=
Sender: "haoluo via sendgmr" <haoluo@haoluo.svl.corp.google.com>
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:f693:9fff:fef4:e444])
 (user=haoluo job=sendgmr) by 2002:ad4:42b3:: with SMTP id e19mr1898822qvr.6.1600718032730;
 Mon, 21 Sep 2020 12:53:52 -0700 (PDT)
Date:   Mon, 21 Sep 2020 12:53:08 -0700
Message-Id: <20200921195310.3070085-1-haoluo@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH v2 0/2] pahole: Make encoding percpu vars into BTF optional.
From:   Hao Luo <haoluo@google.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        daniel@iogearbox.net, dwarves@vger.kernel.org, yhs@fb.com,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

v1 -> v2:
 - Use opt-out instead of opt-in. Rename the flag name to
   '--skip_encoding_btf_vars'

Previous commit f3d9054ba8ff ("btf_encoder: Teach pahole to store
percpu variables in vmlinux BTF.") introduced a feature in btf_encoder
that encodes global symbols in BTF. However, this feature is not
protected by any flag. In order to avoid surprises after Pahole v1.18
rolls out, add a flag to toggle this feature off.

Also as a refactor, introduce '--btf_encode_force' to replace the
old '--force' and '-j' option that is used to forcefully emit BTF.

Hao Luo (2):
  btf_encoder: Allow disabling BTF var encoding.
  btf_encoder: Introduce option '--btf_encode_force'

 btf_encoder.c |  5 ++++-
 btf_encoder.h |  3 ++-
 pahole.c      | 22 +++++++++++++++++-----
 3 files changed, 23 insertions(+), 7 deletions(-)

-- 
2.28.0.681.g6f77f65b4e-goog

