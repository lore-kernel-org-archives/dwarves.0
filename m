Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE079C433E6
	for <linux-dwarves@archiver.kernel.org>; Tue, 26 Jan 2021 19:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F8DB2311C
	for <linux-dwarves@archiver.kernel.org>; Tue, 26 Jan 2021 19:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729423AbhAZFmy (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 26 Jan 2021 00:42:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728590AbhAYNH6 (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Mon, 25 Jan 2021 08:07:58 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7590BC06174A
        for <dwarves@vger.kernel.org>; Mon, 25 Jan 2021 05:06:36 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id 5so3670567wmq.0
        for <dwarves@vger.kernel.org>; Mon, 25 Jan 2021 05:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=rvdd/QvafmjAw8kwJuM2WPMcObpLsH4hFPPapXqLuVw=;
        b=S7ZLKuJE2Nw0VX4gSdpTscLmFP0oSOsFalu+BDYlo+H04JU5zRMmwbpnfcya25COfc
         J9W8trwf/1gwvDti53XoNWqutktpB9FRu3Fvz4RWnLkn9NqSI0pd9C4Zcei7aottSJGp
         opmIYefCbdF+BfsI/U52Jc0BxkomJlWn5/rdp4jB7HoWvQhCF68RrQS7EFG2br3DHxZi
         fpGrlBIpmDDMJC6u+e/ze2HE+nCCPnI0CcwXgYsq5nsprOmCvS29uTGsUUa9wWIPrQee
         dJphcXYSkLtPKSp4XmzeG4oZW6T0MFK6FegzQnBo+oMPVD1IDKWfgLd63ccRs8BSe5j7
         enTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=rvdd/QvafmjAw8kwJuM2WPMcObpLsH4hFPPapXqLuVw=;
        b=l4r3IsJZXIgDZV6pBKKd/95Mm5StHhW5iCIJBXLKpI3Rv1TSmlrHTSDrmqtgEN6tBy
         r5M7plCN93t1Cx66+88ZvVFuLR0BN11+UVqcbl2V1tm3LrZxZZJl8D5BxFr8EzyIGLB9
         6SJi/FZkpiIBpwBxN2fzJ8vyu1kt67F9asypHuy7CvJchrxPWvZl3V+HD4YZ2ytZPU3h
         HtbOtzfj2ao5PliFTzzwRATe80RoRdIINeTOxCfBb292SVzVkGLzFI5Qfy3siVUxnuIG
         Wcjx/Otd6G3DG/b75qEcG25875dhELIYoC/gs3AJDSwJHje2u6QW/H0Cc9ijf/aJS2Hl
         uv9g==
X-Gm-Message-State: AOAM5307PP96zzK5m7Z3J6ZePxOs9xgeG741NNIZvswXC5v3Qr9R9HPr
        Ecaglq9SFJvOHa55vUdLnWJonBlhxmJFMLZ43kup4zihYoLR/PueAa1nCBKl+qO+4fcWeJJLPZ5
        NALqiQmD6rOTKtbrN6HuT0HQetgk0nU2RMawLRQSHy5P6nWHYLZ0Meeq4ZZ8e/Vm+7eHO
X-Google-Smtp-Source: ABdhPJzZ9wQdK3n/uMg8qE3gXor6Gv/nkJNGKknao7LqdRUWRx57fl9nXRn0QuDLbf0Po+yjPljRVYoKyVd6hQ==
Sender: "gprocida via sendgmr" <gprocida@tef.lon.corp.google.com>
X-Received: from tef.lon.corp.google.com ([2a00:79e0:d:110:a6ae:11ff:fe11:4f04])
 (user=gprocida job=sendgmr) by 2002:a1c:1f11:: with SMTP id
 f17mr32811wmf.67.1611579995009; Mon, 25 Jan 2021 05:06:35 -0800 (PST)
Date:   Mon, 25 Jan 2021 13:06:21 +0000
Message-Id: <20210125130625.2030186-1-gprocida@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH dwarves 0/4] BTF ELF writing changes
From:   Giuliano Procida <gprocida@google.com>
To:     dwarves@vger.kernel.org
Cc:     acme@kernel.org, andrii@kernel.org, ast@kernel.org,
        gprocida@google.com, maennich@google.com, kernel-team@android.com,
        kernel-team@fb.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Hi.

This follows on from my change to improve the error handling around
llvm-objcopy in libbtf.c.

Note on recipients: Please let me know if I should adjust To or CC.

Note on style: I've generally placed declarations as allowed by C99,
closest to point of use. Let me know if you'd prefer otherwise.

1. Improve ELF error reporting

2. Add .BTF section using libelf

This shows the minimal amount of code needed to drive libelf. However,
it leaves layout up to libelf, which is almost certainly not wanted.

As an unexpcted side-effect, vmlinux is larger than before. It seems
llvm-objcopy likes to trim down .strtab.

3. Manually lay out updated ELF sections

This does full layout of new and updated ELF sections. If the update
ELF sections were not the last ones in the file by offset, then it can
leave gaps between sections.

4. Align .BTF section to 8 bytes

This was my original aim.

Regards.

Giuliano Procida (4):
  btf_encoder: Improve ELF error reporting
  btf_encoder: Add .BTF section using libelf
  btf_encoder: Manually lay out updated ELF sections
  btf_encoder: Align .BTF section to 8 bytes

 libbtf.c | 222 +++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 175 insertions(+), 47 deletions(-)

-- 
2.30.0.280.ga3ce27912f-goog

