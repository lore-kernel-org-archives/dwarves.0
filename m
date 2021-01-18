Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55526C433E6
	for <linux-dwarves@archiver.kernel.org>; Mon, 18 Jan 2021 16:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F67622C9C
	for <linux-dwarves@archiver.kernel.org>; Mon, 18 Jan 2021 16:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405872AbhARQCl (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Mon, 18 Jan 2021 11:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406291AbhARQCd (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Mon, 18 Jan 2021 11:02:33 -0500
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB84AC0613CF
        for <dwarves@vger.kernel.org>; Mon, 18 Jan 2021 08:01:51 -0800 (PST)
Received: by mail-ej1-x64a.google.com with SMTP id rl8so5061186ejb.8
        for <dwarves@vger.kernel.org>; Mon, 18 Jan 2021 08:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=cw3dvRGpX/nSIs+bFZRctQhooB6vy9IbCBqwEdoTFOc=;
        b=cFOm+rUnyAKi8JkpTd+HdgTPNG7OBrrUy9ionHXZamrgDP7xbIEWfp9EUbzohDY9y6
         8qNpc4Vzo/seVzuMT0dsBell02MySEo1pPEUdKXad3LF9pnA1+DTFHDS9m6D1LssnzpH
         4YmHa2u6fG0zS5rfw3rmIXNn/KkQWm5lsvDgm6aduXPuRo9RFfnZJ9TrbeFSVcT0mSkj
         i4Go/JwqFw6K/rVIAvgBUjnoYt0bcRS1ozHeRtl0rrDWbw21d+HMNHKL8Wbr3qt+PUzY
         QpGrw2t2FBEQNW/2jz73AjECpQVnOorM+I0m2JONBasQq4zXEaZo5yXqcIqUP09k5QNT
         U0mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cw3dvRGpX/nSIs+bFZRctQhooB6vy9IbCBqwEdoTFOc=;
        b=gC4EN6GV6sDe0c3o+gdHrqmyjauP+OnlXfjf6+Bpd/Y6ZnX3PpQi83Vo8AC4Xu6o0h
         uYClT4OlLVGROaZAdc3rEYmN/tA6vahs12auDe8aJquQjnnt/cRRD5uW5hqQ5Ic4YxKN
         H7J4sXE0CS1xud3iUqVa3gRYNHuG01Rori/Hdc8P1AfJpVp7yholFooEaUl0WJlqa6hy
         Z8oe32LyfHFVskQWNB937Om3f6fLA7keBYfJTK4Ri85l/xeztCLJKGuS3EdPuuCuvtJg
         e5cDgCgVr/BXCUCIFKwVQauaIrgyy4+x45EThMi45vQtTv7uc3opWWHCUAxg/zlFRpHV
         3b6g==
X-Gm-Message-State: AOAM533/Qsm98osvgqmtYG6mVDqMK8rzWIHHpHPB3ckJavQqg0M6KOq0
        fd8BmM/n7oNW8KY8Dm5JD2I+l68G0F0QM8OonIHTmGgedpiZdCBWAEdBzL13StOgOqZ9zHPfG3E
        Ux6gDb0GlkpX4EvVZRGjYxQEEGnJrXjEhbD/81Ez21GXpbKkC6KWA4ek0RGEflHBjZ1XI
X-Google-Smtp-Source: ABdhPJw+SvlnDKL5tE8q7bmDcvaaf08OQSqdIUpo3tCtpAC6m5QMFbp1u2chxyy6bFqmUFfKLlt+Tpu886Tm3Q==
Sender: "gprocida via sendgmr" <gprocida@tef.lon.corp.google.com>
X-Received: from tef.lon.corp.google.com ([2a00:79e0:d:110:a6ae:11ff:fe11:4f04])
 (user=gprocida job=sendgmr) by 2002:a17:906:15ca:: with SMTP id
 l10mr242893ejd.402.1610985710175; Mon, 18 Jan 2021 08:01:50 -0800 (PST)
Date:   Mon, 18 Jan 2021 16:01:37 +0000
In-Reply-To: <20210118160139.1971039-1-gprocida@google.com>
Message-Id: <20210118160139.1971039-2-gprocida@google.com>
Mime-Version: 1.0
References: <20210118160139.1971039-1-gprocida@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH 1/3] btf_encoder: Fix handling of restrict qualifier
From:   Giuliano Procida <gprocida@google.com>
To:     dwarves@vger.kernel.org
Cc:     kernel-team@android.com, maennich@google.com, ast@kernel.org,
        andrii@kernel.org, bpf@vger.kernel.org, kernel-team@fb.com,
        Giuliano Procida <gprocida@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Fixes: 48efa92933e8 ("btf_encoder: Use libbpf APIs to encode BTF type info")

Signed-off-by: Giuliano Procida <gprocida@google.com>
---
 libbtf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libbtf.c b/libbtf.c
index 16e1d45..3709087 100644
--- a/libbtf.c
+++ b/libbtf.c
@@ -417,7 +417,7 @@ int32_t btf_elf__add_ref_type(struct btf_elf *btfe, uint16_t kind, uint32_t type
 		id = btf__add_const(btf, type);
 		break;
 	case BTF_KIND_RESTRICT:
-		id = btf__add_const(btf, type);
+		id = btf__add_restrict(btf, type);
 		break;
 	case BTF_KIND_TYPEDEF:
 		id = btf__add_typedef(btf, name, type);
-- 
2.30.0.284.gd98b1dd5eaa7-goog

