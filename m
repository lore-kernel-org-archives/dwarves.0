Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE30C433E0
	for <linux-dwarves@archiver.kernel.org>; Mon,  1 Feb 2021 17:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE1F764EB8
	for <linux-dwarves@archiver.kernel.org>; Mon,  1 Feb 2021 17:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbhBAR0s (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Mon, 1 Feb 2021 12:26:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbhBAR0j (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Mon, 1 Feb 2021 12:26:39 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13AEFC0613ED
        for <dwarves@vger.kernel.org>; Mon,  1 Feb 2021 09:26:00 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id z9so10761790wro.11
        for <dwarves@vger.kernel.org>; Mon, 01 Feb 2021 09:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=bySTPITy9sEnX+OFrzSlCOjPXE0Wa2TKXWqG2xvgd+c=;
        b=u8+A7I39tOd9zkrrMGHaFVw5BoE5GnWa2aSfeajcOa+GlpgI0FEG0aW67lmSZOUB12
         cQfH1YTKJzqjGIcB6hC72ZeZRHURRRlQdVYx7CgN5vIA34vrQtEt4MUuqygxK+HWxO5F
         aKNL18FIxU1nSgRZJ4qFhMZ+lEHXYvUI7LUvChyU2EFhrd62zN/dI1dX1h+sj/ZaJeip
         QsmxEw/QknfaGzPW7Sp+qxtLvhY3NUTjah4MRb+mGF4dDc5f5QvYPOowVw58vmHYAc6t
         fQUMt2gyKAQTAlbRQJ2L3QQDFwEyuo3Yy2YY960xF2SdaIWhm2OnJHxsRUOJP8/nmfaY
         EaEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bySTPITy9sEnX+OFrzSlCOjPXE0Wa2TKXWqG2xvgd+c=;
        b=mIPh5nfJiBvfFYzp97VAhv5eu/Tc03MuGnVGabcAwCSxFVSSVXGT9ile2TY9QPuZ96
         vdrwruOXY7oWpEJcFnFJYyqLB67mqGXmHqFJn75DmpPjGhHV+1lsD6eWJ86+A3e3a32P
         evr5CwU3VHEKtqJrTWzUC7SuK+U168VIRTrHBU/lJ9gUnZ/4q+GkaDt3zz1psdDyu30n
         AM/OoGoAEpfZJY9n7qJIfNNlzl9v3QZUykSm98ZRwNjEphhMqYm6sEZMcLW00kEOetsz
         Zsbk2uDde7bbzyVF9zWGhcG+csIsd6EslPTVnwTrW4ngV7HukRBSKhSUSQQKatwg8uiV
         7jvg==
X-Gm-Message-State: AOAM532Tmbj0F996/wbDYLG7Ovzp+zRsdxjpLG3Xf2N/tPcHNH4rQmY8
        ke4KV6sIJVjmboSvcbZ+KxM996kUYVaSrY/4O7qLY2e6Pw0Rar+HVF/23N554J6Q9DkvBobhO+D
        UDEHh+Oi1tebyB2WKoeGrIlkh1CzW0YMcbhBR81LNNJTJNZhVC1se+8zA26lcbnNKi/tc
X-Google-Smtp-Source: ABdhPJwJqVGtfXk95YE5FB941yz9MW9nsqyP8zx/EwScVXa+eMv7vjwup5OsI9K+ctRUuvac/eydimMW2Jbgqg==
Sender: "gprocida via sendgmr" <gprocida@tef.lon.corp.google.com>
X-Received: from tef.lon.corp.google.com ([2a00:79e0:d:210:6893:b158:d9db:277c])
 (user=gprocida job=sendgmr) by 2002:a7b:cb54:: with SMTP id
 v20mr16412653wmj.148.1612200358590; Mon, 01 Feb 2021 09:25:58 -0800 (PST)
Date:   Mon,  1 Feb 2021 17:25:26 +0000
In-Reply-To: <87a83353155506cc02141e6e4108d89aa4e7d284>
Message-Id: <20210201172530.1141087-1-gprocida@google.com>
Mime-Version: 1.0
References: <87a83353155506cc02141e6e4108d89aa4e7d284>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH dwarves v2 0/4] BTF ELF writing changes
From:   Giuliano Procida <gprocida@google.com>
To:     dwarves@vger.kernel.org
Cc:     acme@kernel.org, andrii@kernel.org, ast@kernel.org,
        gprocida@google.com, maennich@google.com, kernel-team@android.com,
        kernel-team@fb.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Note: The 4 patches in this series supersede patches 2-4 of the
previous version of this series (patch 1 was applied).

pahole -J currently uses llvm-objcopy to add .BTF as a section (and
segment) to an ELF object containing DWARF debug information. If a
.BTF section is already present it is rewritten but segment
information is not updated.

In terms of the current Linux linker script, all that's needed is
either a dump of the raw BTF or a file containing a .BTF section. This
is because the script dumps .BTF out to a file, creates a
single-section ELF file and then links this into a final vmlinux.

The first commit in this series removes the dependency on
llvm-objcopy.

The remaining commits attempt to roughly duplicate the desired end
result, namely adding a .BTF section which is also a loadable segment.
They may not be sufficient. In terms of non-kernel .BTF use, they are
probably not necessary.

Nevertheless, this was an interesting exercise and removing the
llvm-objcopy dependency is a worthwhile goal.

I'm not well-placed to test the viability of vmlinux with .BTF as
generated by these patches, so any feedback is very welcome.

Giuliano Procida (4):
  btf_encoder: Add .BTF section using libelf
  btf_encoder: Manually lay out updated ELF sections
  btf_encoder: Add .BTF as a loadable segment
  btf_encoder: Align .BTF section/segment to 8 bytes

 libbtf.c | 240 +++++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 197 insertions(+), 43 deletions(-)

-- 
2.30.0.365.g02bc693789-goog

