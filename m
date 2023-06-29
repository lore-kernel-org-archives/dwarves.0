Return-Path: <dwarves-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2CCEB64D9
	for <linux-dwarves@archiver.kernel.org>; Thu, 29 Jun 2023 14:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjF2OmA (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 29 Jun 2023 10:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjF2Ol7 (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Thu, 29 Jun 2023 10:41:59 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741731724
        for <dwarves@vger.kernel.org>; Thu, 29 Jun 2023 07:41:58 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-992b2249d82so76111766b.1
        for <dwarves@vger.kernel.org>; Thu, 29 Jun 2023 07:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1688049717; x=1690641717;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VFKUSHvydnmwLfHL2dvTDOlRV+qT8pyhLrBahYOSl0E=;
        b=SgFTV6dfVWVQuBYhOrP094wWv8xJDwdE3UUxtfTtwwDaCDgTRcQCAlW3js9W1PEQxM
         1BvhfjMQKZOtgBfvljjtbDEB99wHP/oB7cRcm0xBiivKEvpynv+hRTLHdB1lDaosFGSX
         HxsLtcJW/Ft8II9qLYkOAu0wXwajjFOcEhgg4+gR2FV2YF85OtrOpePi+tXFAJ8EKCtj
         A7MivJCB8C54r5k3Ag9hpSPg0a3BRYgfxe1q85pNklldPZeJ699UevsoHdBkjPKaAI8/
         MH7IUQj8WRBjgCiIC4WBHQ23JvstvkJ8ZfCYo10BknNLH9wWwcNFx6MLHq98KelyYNqG
         LRgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688049717; x=1690641717;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VFKUSHvydnmwLfHL2dvTDOlRV+qT8pyhLrBahYOSl0E=;
        b=kGgEbseksyjddUo/aS0J06mfyXl4kyjmB64J26BrOaR/YURnmLQRliITFEfWisVxPs
         Pz3+5FaRccm2gcP8wWGBp2giPBTxgzUs5agx1JUD/ged98amz1V0poG101sxjtzYEaz8
         Fq4Tp3k313+9byrbSQ5FD0mnSM4aVKrWs79BujMmRo7v3XeYE2wXNxbZGg+SGZ2bnwlv
         JCuPmZcxLlO0LbQy38iImW/uCRLHpXwh7nZ78h1xT+TkyKYMm0aq8ZzolHkcJ5tEb36W
         XbABiJvOlxTDjB6LVuMIQyRjFf1VU9KMNcXdeSNFJILdmEP7gUNUY0kcLAFKlQm17yMx
         UL1Q==
X-Gm-Message-State: AC+VfDyconsGwjJhxp64wTcDYnG7MJTy3LxwllzpbMdpxQe8joX47XpA
        mAqJEC7PujhUdrN0pYVoZnUO0dhNCDZe8KBuunsYTg==
X-Google-Smtp-Source: ACHHUZ5PpwlHihEBJKr/6GC1KVa4vlHk4QBMXqPo11p9tPg+6bn1TUW1aOxy520w5iR6PiV5HhJfJWj6cOCcGQqUbtY=
X-Received: by 2002:a17:907:318c:b0:987:e230:690 with SMTP id
 xe12-20020a170907318c00b00987e2300690mr33924666ejb.57.1688049716985; Thu, 29
 Jun 2023 07:41:56 -0700 (PDT)
MIME-Version: 1.0
From:   Lorenz Bauer <lmb@isovalent.com>
Date:   Thu, 29 Jun 2023 15:41:46 +0100
Message-ID: <CAN+4W8junMrqMTQJ1cy-5fhd9FFsASWOndRPaprspKXMXShJYQ@mail.gmail.com>
Subject: PSA: Ubuntu pahole creates buggy BTF
To:     bpf <bpf@vger.kernel.org>, dwarves@vger.kernel.org,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Just a quick FYI for anyone else struggling with weird BTF on recent
Ubuntu releases, it seems like their pahole is broken due to an
incorrect backport.

The upstream issue is here:
https://bugs.launchpad.net/ubuntu/+source/dwarves/+bug/2025370

Best
Lorenz
