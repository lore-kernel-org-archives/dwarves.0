Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02395C433E6
	for <linux-dwarves@archiver.kernel.org>; Wed, 17 Feb 2021 11:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD76D64DEC
	for <linux-dwarves@archiver.kernel.org>; Wed, 17 Feb 2021 11:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbhBQLJR (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Wed, 17 Feb 2021 06:09:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbhBQLIz (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Wed, 17 Feb 2021 06:08:55 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDF0C061756
        for <dwarves@vger.kernel.org>; Wed, 17 Feb 2021 03:08:15 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id v1so9707056qvb.2
        for <dwarves@vger.kernel.org>; Wed, 17 Feb 2021 03:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=1modw9BZNdPfxYUaaJFvkvekSj+kTyCztdooD0nRWUs=;
        b=LhHCcqPhzj/XJuJcrhRF46TXfvRJVjP3CfjE4hJ4cxSDnDGvAFLSs7y37tqEQwDbHK
         j6UfzwpDHbUxatHGykjkAHuABcIdyHk1uYIQ+0YzDz64oj6HW7c8lW2mCKhZ7FIInMHo
         o7uC/n6tZOSR26L9vuHw+/Ry29Tk1MnIa8KAY2yJRar4XplcATe7gD0sviZlXT5FkBkj
         EbaemgSDD/Jtq0WJISpDD0zEKVADZFgPigPw3gkrXfiAhXiVxt5ywYSD2lqqfJGxljqX
         TfRnBJMEagbt0L5S5R65A3pSFrsQ93/SriNqKacEzS8J4hn0aXsq+mzQnycy0FWn572R
         A1Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1modw9BZNdPfxYUaaJFvkvekSj+kTyCztdooD0nRWUs=;
        b=nGWwu+Q4FlsRTqKoQohRGJuXIqjL+LIy4Lp02ciN/eVqCpne7R3poq4v8hLlOcRYK/
         PFNB64id7s9Z2O0RC2eXga0TN3sUCW/ATPJH/BSEOYwFtb+r/9mJQCNoOWwqxjDiEc3b
         8YWnIBQhQ6onYgTj8VyjJHv6cilqdW/pS+WfdEfcD2vpbQUmj64ilhC/UxHcvgI67JUX
         sDNC+SkQihMcRVI6VXbNGCKPyd/e+F7DfVaxC1OcORnw+bFaUKP701bz1VhpIDgYNktI
         zCIWRXBFJZT9Z1RkZKQMbE4p0liWKPd4YFJhS99Se+84TRuMQo5LixB2wJor7v1MiAGe
         Pkaw==
X-Gm-Message-State: AOAM530bm03ToXZR1cRuoLOdgjdW/yJuwOSYo335l75MliNHUPnusMpO
        ki28vEzH//6QTdwAKXLnGtiOMUHkgmrazy14Y6b4L/XHIiFFcPFXCxPnVoZUMxhezEmGKM75Jl5
        4ZWNf0ircdpX0FBLxb7Rsw2nQdXIXmm5ETtnqWc39MWKO12QHddlAfwNaFPAxtVAIF+9y
X-Google-Smtp-Source: ABdhPJxA3OhdA1qH/n1P6vTxIlXqgmv6/w8dYFqzqt9OgedI/MaB2h1mUGi7CP5/HVnhywNSOYJcw+YNAUrUXg==
Sender: "gprocida via sendgmr" <gprocida@tef.lon.corp.google.com>
X-Received: from tef.lon.corp.google.com ([2a00:79e0:d:110:61b3:1cb2:c180:c3f])
 (user=gprocida job=sendgmr) by 2002:ad4:4ba7:: with SMTP id
 i7mr1958624qvw.34.1613560094469; Wed, 17 Feb 2021 03:08:14 -0800 (PST)
Date:   Wed, 17 Feb 2021 11:07:59 +0000
In-Reply-To: <20210205134221.2953163-1-gprocida@google.com>
Message-Id: <20210217110804.75923-1-gprocida@google.com>
Mime-Version: 1.0
References: <20210205134221.2953163-1-gprocida@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH dwarves v4 0/5] ELF writing changes
From:   Giuliano Procida <gprocida@google.com>
To:     dwarves@vger.kernel.org, acme@kernel.org
Cc:     andrii@kernel.org, ast@kernel.org, gprocida@google.com,
        maennich@google.com, kernel-team@android.com, kernel-team@fb.com,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Arnaldo.

Versus v3 I've addressed Andrii's review comments, but some there may
be some style consistency issues remaining.

The first three changes are intended to improve code maintenance.
The fourth remoevs the llvm-objcopy dependency.
THe fifth aligns the .BTF section.

Giuliano.

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

