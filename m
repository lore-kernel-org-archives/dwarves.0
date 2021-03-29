Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48E1C433DB
	for <linux-dwarves@archiver.kernel.org>; Mon, 29 Mar 2021 23:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F2926188B
	for <linux-dwarves@archiver.kernel.org>; Mon, 29 Mar 2021 23:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhC2XOd (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Mon, 29 Mar 2021 19:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbhC2XOZ (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Mon, 29 Mar 2021 19:14:25 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE6FC061764
        for <dwarves@vger.kernel.org>; Mon, 29 Mar 2021 16:14:25 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id a9so8825053pfo.10
        for <dwarves@vger.kernel.org>; Mon, 29 Mar 2021 16:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=WbL6Dgfv19ESq2vhoguN8WYq0PGt7TcFwh49HZU1Vnk=;
        b=TOqTuyiHfp2Aqk7WL0/mNDmMzhSLqR57xlz0CAuGb59fOx4jh2t1vko3NDpvI1RLWJ
         zlDo/lCw91stJuMp9dwD+ilY8Cis/u/W42atyls7P9walbfMlZicdmKteVrDxC2ZRbhE
         knDOW+HGg9VqpXnaP6GrPrPPuDn88ECZhA1eLusbsRAcyMjFm58ryHcTaSYz0Ewe62PF
         TFjx/LVd8hBOrjQJqwirEwqSC0HfIqIkmOqJggh+RVM7P6cajq3GfSbPvBXTaHqWGtAi
         SFKk68Q5o7v4NBp8jKRG4OamYYdOvZ0lkNOwlvvL5zcza4uo7wFlm2pjN+rqL+jkRDTZ
         CO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WbL6Dgfv19ESq2vhoguN8WYq0PGt7TcFwh49HZU1Vnk=;
        b=FbQHJsZM50X/VXEYV/v+wVOUInJ9Yg4CptNrp/oIU259qEGU9cP/oH0AJzuHztSFpm
         mJbE2AhhcMvolP5E9TZZKhhWYdNW+eXqkNpcITNhgIC5Fm+4NZpqvCZhLdFqVAm27gz4
         wbI48QwlW7Ltig6wJ838uzEXXI9MSaDiezjM9tEUzA4BJ3ak0Pa2V/uJYBWqbs0mo6k7
         oxXtMWDPDB7s1m52C1hRSVGVDxEVArGFlc6fWzvRbb0fbtmiJW2BQy5LhEKTE+SDw2yK
         98LBC3HkWzNZwDy8ti/9oWf7AsNAz6RXiPYWlBORNjC9f3hYlsmBnOwUtF4Nec/++DaY
         ug+Q==
X-Gm-Message-State: AOAM533kwrGlWLVlzPbEJ10dVMMoJ1QPNysRYaoAcXEs7rt3VFolmKFh
        eXIjk/0O+B7NLy3ZYqEuJ1uKfEO7ZucMc33bv/Q=
X-Google-Smtp-Source: ABdhPJwHfu5lvMjTOoU4epMJ9aoCz9WkzjdHbVwDMn+v7xRX0vlVTbYjEFG1KbexjwV+Wz4CcRMJLBV7xYUgntayCtk=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:c959:2751:3fb4:47b1])
 (user=ndesaulniers job=sendgmr) by 2002:a17:90a:4d81:: with SMTP id
 m1mr1356657pjh.143.1617059664444; Mon, 29 Mar 2021 16:14:24 -0700 (PDT)
Date:   Mon, 29 Mar 2021 16:14:13 -0700
In-Reply-To: <20210328201400.1426437-1-yhs@fb.com>
Message-Id: <20210329231413.1971368-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20210328201400.1426437-1-yhs@fb.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: Re: [PATCH dwarves v3 0/3] permit merging all dwarf cu's for clang
 lto built binary
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     yhs@fb.com
Cc:     andrii@kernel.org, arnaldo.melo@gmail.com, ast@kernel.org,
        bpf@vger.kernel.org, dwarves@vger.kernel.org, kernel-team@fb.com,
        morbo@google.com, clang-built-linux@googlegroups.com,
        sedat.dilek@gmail.com, Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

(replying manually to https://lore.kernel.org/dwarves/20210328201400.1426437-1-yhs@fb.com/)

I didn't validate or try to use the produced data, but with this and the
kernel patch
https://lore.kernel.org/bpf/20210328064121.2062927-1-yhs@fb.com/

I was able to build a x86_64 defconfig + CONFIG_LTO_CLANG_THIN +
CONFIG_DEBUG_INFO_BTF without further errors.  Thank you for the series! FWIW:

Tested-by: Nick Desaulniers <ndesaulniers@google.com>
