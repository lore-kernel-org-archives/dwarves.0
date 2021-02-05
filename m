Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 674C7C433E0
	for <linux-dwarves@archiver.kernel.org>; Fri,  5 Feb 2021 22:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3124664FF8
	for <linux-dwarves@archiver.kernel.org>; Fri,  5 Feb 2021 22:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbhBEWn0 (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Fri, 5 Feb 2021 17:43:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbhBENnS (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Fri, 5 Feb 2021 08:43:18 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9880CC061793
        for <dwarves@vger.kernel.org>; Fri,  5 Feb 2021 05:42:37 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id m1so4977865qvp.0
        for <dwarves@vger.kernel.org>; Fri, 05 Feb 2021 05:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=IGpyT50ZsOIciQFmCAO819uoUHUYFH7dURB+H5TNyyo=;
        b=pGzIiS8uenAMefZwcV8gF0t6bCdBalkQ81lc00JAvU2AulD5fdy5sUr8R0VU/UZVmw
         IFXl2T/NFDgq10ByBMKuOgTnKaEXXRQdVbZi0LNFYQEkrTOFfN0yTM7X2pWvofXYIAFT
         emDSQt9ruT2GairKINejmb4r5En1+QGTry5mvlLXRnmBt3MHE686H2iZNPkDjXo3+oYV
         tQmaeeVlnk8LZjWqp7m5UqRH6IOGkXCrmJ3WD9TeX6Jsti/c8nmEjcqKMQ57m6Uxplxg
         CrItrPnCx0npjJUDSzj8Jt/TkOH84SNpZlJ4NRXDqjMLtaETKh60RzboyMiRteZvAbHx
         8GdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IGpyT50ZsOIciQFmCAO819uoUHUYFH7dURB+H5TNyyo=;
        b=NKdD9WyB+Ly0eNEichkASuZWRELtjEklG3x1x++Cr9BYL1QmeWDoD4OBINmcp9TYhh
         YdbkUBODtCW3JBnjzEkvDXr/fNQTpaVHM8amJ95WRZ9vgxo4xgqi/03kdvIcdd4bxVnD
         I+36/PMwObT2YLUKluFgtvvpFl1X+2x7wjEQNhADH5YWBh0rBLghISguRPnu3wbTqXXK
         Rg1TE3vK75hSwWP9A85kMrx+oUc6NcIEXN6pYXReFFyVMZM1k+kUgvHsWqcgYavnVkj/
         NzNtymafxn1yBVMrRF+dJhCMCmT0JLMYF1eau6Jnab6GmOpEQ3dMfR1KPT4bM2SSCYi8
         7pog==
X-Gm-Message-State: AOAM530YMt7kOG0oOpQhRb3VEUfuuGuylxE+aLQvBpTJ8NPOV2/0LUdv
        ygoH8L6d2IyvRtJuoeoSvElaMCfWBJf85LXTHF8UwiZZ3e+C7AwiAPDadHSxnxRKyBN2BNhDeCd
        zgE5d3c2yz0iJ9V4aS3AO+rLFgCncA0fDN+TsLS/JCRc7mrkjm9wTzePI1eRNrvYG8TCG
X-Google-Smtp-Source: ABdhPJzwa3on+DeHXWNowl5sLCJ519ChsSKMFvY0uqYRHnRWpKpD+sjjqxEOI6xvfwCcu7IrSpamvDlytHmgBw==
Sender: "gprocida via sendgmr" <gprocida@tef.lon.corp.google.com>
X-Received: from tef.lon.corp.google.com ([2a00:79e0:d:110:656b:9716:1ea:3de6])
 (user=gprocida job=sendgmr) by 2002:ad4:58b2:: with SMTP id
 ea18mr4480346qvb.52.1612532556716; Fri, 05 Feb 2021 05:42:36 -0800 (PST)
Date:   Fri,  5 Feb 2021 13:42:16 +0000
In-Reply-To: <20210201172530.1141087-1-gprocida@google.com>
Message-Id: <20210205134221.2953163-1-gprocida@google.com>
Mime-Version: 1.0
References: <20210201172530.1141087-1-gprocida@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH dwarves v3 0/5] ELF writing changes
From:   Giuliano Procida <gprocida@google.com>
To:     dwarves@vger.kernel.org
Cc:     acme@kernel.org, andrii@kernel.org, ast@kernel.org,
        gprocida@google.com, maennich@google.com, kernel-team@android.com,
        kernel-team@fb.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

These v3 patches address comments by Andrii and Arnaldo.

1. This uses a variadic macro and relies on a GNU extension. It can
probably be reworked to not use this, with some effort.

2. I was following the original code that had aliases structs and
pointers for the same data. I adjusted my code not to do this (later
commits) and changed the existing occurrences in the same function
(this commit). The net effect is clearer lifetime and ownership.

3. In a similar vein, the variable scn really only needed to be a
loop-local iterator.

4. This removes the dependency on llvm-objcopy.

5. And we set the alignment on the seciton.

I'm not posting the later patches that perform explicit ELF section
layout and which (attempt) to also do things with ELF segments.

Giuliano Procida (5):
  btf_encoder: Funnel ELF error reporting through a macro
  btf_encoder: Do not use both structs and pointers for the same data
  btf_encoder: Traverse sections using a for-loop
  btf_encoder: Add .BTF section using libelf
  btf_encoder: Align .BTF section to 8 bytes

 libbtf.c | 183 ++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 114 insertions(+), 69 deletions(-)

-- 
2.30.0.478.g8a0d178c01-goog

