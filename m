Return-Path: <SRS0=zo6D=C3=vger.kernel.org=dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DFEDC43465
	for <linux-dwarves@archiver.kernel.org>; Fri, 18 Sep 2020 20:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED69B235F8
	for <linux-dwarves@archiver.kernel.org>; Fri, 18 Sep 2020 20:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rSEjdtei"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbgIRUlC (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Fri, 18 Sep 2020 16:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbgIRUlC (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Fri, 18 Sep 2020 16:41:02 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C409C0613CE
        for <dwarves@vger.kernel.org>; Fri, 18 Sep 2020 13:41:02 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id b8so2330610yba.10
        for <dwarves@vger.kernel.org>; Fri, 18 Sep 2020 13:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=Tc4ZvUJNbpRKOK4RDnmv6KdaodgSaNEg+hTKyaO3PFk=;
        b=rSEjdteih9ECBuhm+jrrQ+X5Oq+MKMwH66ROM01he8ilxOsSsXWbznrWqDy4g+3YuL
         mB0pPXDZnrvRtLkU5VpwSmz2r+dglGI14BOnDeXjwD8O0DyaeubNBWes8Pr8ZLJ7DlrO
         uvS737T5/B5wVuK9Vk3SSROtOHQILfKLDeL2S4esxJbYY4kleanwH60x3aQZoOtvXAXs
         hjXNq6xlHQy+bBkNSlTM5R+qwTSJESHOEoGJAxmMnYf4wPm52jRbelPDZrzhTZdQ7nPS
         9Lo5xH3gUDvIqy+zJxjDIvdz5RFDrEAVEFO0yYvQ5fJgjflvCIGIHzR40eIAPc7Kp6qd
         dm/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=Tc4ZvUJNbpRKOK4RDnmv6KdaodgSaNEg+hTKyaO3PFk=;
        b=UUfaYKOWVLGUApkaLyLYMF45VoeYvM8esJEpCTZ0XrGlY7t3Mr9OC/KKNX3MMl3xng
         NnsSXeTUY2yzUqG1q31PfayFKBdOGgVRK8HWqyrFZxV2eSNwEt7ChwwtkiW+bytHRmKd
         ALao42A+VuKRsuOFoubIh+F2TWOARBOiwI1zMLkh7QVDHt/dHHLaS46hkKOzDygFSp7I
         31upwVjcsGI5pB80y8UWZUpV2sDAmOa8MrGPF+2wLPlRjYZCbtElZkdsSeY1Hi/VQI/b
         RtxJXNV2RMupapVTh95A8EuAIPbNWbv8u6xL87NMCiG/eHpOqGaWsSbOSk4UV6zKj7vv
         +URg==
X-Gm-Message-State: AOAM530NqPXJe+AjNg5twMqTBEwoBBLE4xyCP1+JOVnKdIqrk4ue5UZ2
        b5MZ2gK3ti++MZBrO17NAbFm1xfjunA=
X-Google-Smtp-Source: ABdhPJzf8vwLvRpVMJ05bf4AH3lCZmcawiqvaAnx5Mh0Z5yytQzU7AizC5DadSFH2H3JHITEAnR4SX6k5dU=
Sender: "haoluo via sendgmr" <haoluo@haoluo.svl.corp.google.com>
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:f693:9fff:fef4:e444])
 (user=haoluo job=sendgmr) by 2002:a25:1fd5:: with SMTP id f204mr48328208ybf.142.1600461661484;
 Fri, 18 Sep 2020 13:41:01 -0700 (PDT)
Date:   Fri, 18 Sep 2020 13:40:56 -0700
Message-Id: <20200918204058.1030519-1-haoluo@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH 0/2] pahole: Make encoding percpu vars into BTF optional.
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

Previous commit f3d9054ba8ff ("btf_encoder: Teach pahole to store
percpu variables in vmlinux BTF.") introduced a feature in btf_encoder
that encodes global symbols in BTF. However, this feature is not
protected by any flag. In order to avoid surprises after Pahole v1.18
rolls out, make this feature off by default and enable only upon
request. On the kernel side, we can add a Kconfig to enable this
new capability on an opt-in pattern.

Also as a refactor, introduce '--btf_encode_force' to replace the
old '--force' and '-j' option that is used to forcefully emit BTF.

Hao Luo (2):
  btf_encoder: Make encoding vars into BTF optional.
  btf_encoder: Introduce option '--btf_encode_force'

 btf_encoder.c |  5 ++++-
 btf_encoder.h |  2 +-
 pahole.c      | 22 +++++++++++++++++-----
 3 files changed, 22 insertions(+), 7 deletions(-)

-- 
2.28.0.681.g6f77f65b4e-goog

