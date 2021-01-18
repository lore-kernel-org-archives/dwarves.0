Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8813C433E6
	for <linux-dwarves@archiver.kernel.org>; Mon, 18 Jan 2021 16:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84608222F9
	for <linux-dwarves@archiver.kernel.org>; Mon, 18 Jan 2021 16:12:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406076AbhARQMn (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Mon, 18 Jan 2021 11:12:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406081AbhARQC1 (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Mon, 18 Jan 2021 11:02:27 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED94C061757
        for <dwarves@vger.kernel.org>; Mon, 18 Jan 2021 08:01:46 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id i20so16969778qvk.18
        for <dwarves@vger.kernel.org>; Mon, 18 Jan 2021 08:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=6AJvxUC3f3ekjGpx4m23PwJ8eHqdXCq0waSkIBAPiPQ=;
        b=KWWIFsI9l/jL3bzBh7CupqwdsM1/X+KzBf5mSfkx+eRTjQV8lMGyl+7xIxvuPzq38Q
         aP2nHdXI9MCZkU8iVj1l3iF+oYfgs5OKkD7mpz5xyV9qOkBFDqTM7hlSYt9M+kMuj6Ag
         USmpKNEqmTeoVgpfZmNRfcBSanBEeNKSWviNpnIjFO5WgkP6zsMcllgrdOvDZOp4+Whc
         oRKVl0A1d9o1dFSuy8luz1Ku6ZR3GgNdkiVjMaBqriAQhq+EJSHdKeqMvY1kaCtwbdFc
         izE2yuPkuDi4+Vswn+yp8v2INA0WHvlHtVv84dCpSPJG9fZs/K6frAzgg+A3/EHp3e/Q
         o4oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=6AJvxUC3f3ekjGpx4m23PwJ8eHqdXCq0waSkIBAPiPQ=;
        b=q1FxNBFxw8CkLM4EbEd2DzwbhKQ18D+v79k2G67CRdDIDMbCD8uJU7B9Xl+5n/UUzM
         Qmu1rAbT5GkwnaqUENTWkmVtM++/mSo/Ekx/JO6okhGetuGQK0hn4R0CoJ8IIrk2lRv1
         iV7hYR9mBE5NkryatgrQ54OIpC5RRwCNQtLB9HIYgcFFz/R5srf5c1zakhljl8ifg6T/
         R+Yl7lRze+gLqDxvBcAF3bGL/uZrXb0CuunnmjAXHwzP8/WrMm+80SKVP/pw6V8+53xq
         Wfke9DGLuyvG2+J9du3UhY02oSgTAlV2uJMKc4oAr+yNTd5hjmPgzMhokU/rzfTiNcXN
         6hyw==
X-Gm-Message-State: AOAM5317SpY9IA6aCNfgtXYXgjQxe8mvQPWG/QiqrEUg1Iqa846ekq/M
        QufUOAol9JnQ8xAoICCTX9hwTD07Vam3RW9JENjxjmk5uIwEQeb3k2S9/akN3c7Rv4YCJ8ycFOP
        wAA0/8m/oJqbtq3W/eT6AROScmsKSQerROTwVcGVO14r4LBCDdqPQG6dGgzgpEjjB/yO3
X-Google-Smtp-Source: ABdhPJxffSUGa2Hbs60JFbgCvuZmykbNTsluerNpq7/eVhA5V+FJfBEImm6isKbCN/7v6pvNh5sOaEQzwy0udQ==
Sender: "gprocida via sendgmr" <gprocida@tef.lon.corp.google.com>
X-Received: from tef.lon.corp.google.com ([2a00:79e0:d:110:a6ae:11ff:fe11:4f04])
 (user=gprocida job=sendgmr) by 2002:a05:6214:504:: with SMTP id
 v4mr71159qvw.54.1610985705891; Mon, 18 Jan 2021 08:01:45 -0800 (PST)
Date:   Mon, 18 Jan 2021 16:01:36 +0000
Message-Id: <20210118160139.1971039-1-gprocida@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH 0/3] Small fixes and improvements
From:   Giuliano Procida <gprocida@google.com>
To:     dwarves@vger.kernel.org
Cc:     kernel-team@android.com, maennich@google.com, ast@kernel.org,
        andrii@kernel.org, bpf@vger.kernel.org, kernel-team@fb.com,
        Giuliano Procida <gprocida@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Hi.

1 is a bug fix affecting restrict qualifiers.
2 avoids leaving debris if objcopy fails.
3 aligns the BTF section to 16 bytes to avoid misaligned access.

Regards.

Giuliano Procida (3):
  btf_encoder: Fix handling of restrict qualifier
  btf_encoder: Improve error-handling around objcopy
  btf_encoder: Set .BTF section alignment to 16

 libbtf.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

-- 
2.30.0.284.gd98b1dd5eaa7-goog

