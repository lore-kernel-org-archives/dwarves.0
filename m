Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71AD5C433ED
	for <linux-dwarves@archiver.kernel.org>; Tue,  6 Apr 2021 18:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 480B7613B3
	for <linux-dwarves@archiver.kernel.org>; Tue,  6 Apr 2021 18:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233700AbhDFSbk (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 6 Apr 2021 14:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbhDFSbk (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Tue, 6 Apr 2021 14:31:40 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF05C061756
        for <dwarves@vger.kernel.org>; Tue,  6 Apr 2021 11:31:31 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id b4so24292406lfi.6
        for <dwarves@vger.kernel.org>; Tue, 06 Apr 2021 11:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=euRo0fFZW1XQm6HPp79K+3LluoMpXlXxzV1+Kzw4l1U=;
        b=ap1mpGSaMnVKbk1wKPql8sMs4MA2LO03upICp5gY0NdhClfvjKjX3PvvrSL8yWYncn
         WuAZwKULDXFj7juBZdoZtSPZOFJLrCIKR4Bh+XvvYItum2e1k2TG4IlhiQKyhAbfsgam
         V7AQprdrzUTOf/NaGcjir9f8Y/1usIPs4Y1bKDRtQid2q7Iv+bk1GvAu5OlR3inTqeGj
         x6cVjDjD7U3cAXUSTyWFhuoBrfP3mhfYVOvoxG+Z4KGQnHIn2xcgf7POqF8nGFoqwxsC
         5OtLLAqfKKnaPfpRTCEQa6DlTH3qvQw7irO2O4fzGvA+f46JUtcIYVYqeWBUD2wwpyab
         XwTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=euRo0fFZW1XQm6HPp79K+3LluoMpXlXxzV1+Kzw4l1U=;
        b=MuhclWAxh/UfYv513BZzGvZqa7lloePvtqUY4dYzFe0ULb43G4s+X9d09+RfXRPuFa
         qS9a0/ESZ0PxHdZByax+IMHGIAp7aV3nZrOBFgpXRGpJgZIp0EOTucl5MNRoTo8k4jva
         y0wC3PRr7Yoky+LWfsb5fk+6gRwAyldLqUIkRgfk12dpBN9vSO9Fe1HL7p18WXBjfaBt
         99y2arWsxfSvh7Sh62SXjZpOJIqTs4fsgXJMgtbSM+MAMIFK967ehUQbloWbCcYrha0e
         p4iwkzKuYPu3CIhn+ZBm6WL8PpETK1YSP9Yh186+xO7eBzclK9xCpsxBLO4FctkLSVh9
         93nQ==
X-Gm-Message-State: AOAM533hJcVnZs6JWQ82KPPfo6QmWcs1jqd9ZpnaUPb8g09g+y36uL3k
        KFVMsdh0oPY6lG4W922jtqGgkAE5Ne9w4xlV25zidA==
X-Google-Smtp-Source: ABdhPJw+0wjMbthWQznQ4MeKcArGPuhj+Jm6HV9o3uq8zPVkkqJffJ3ehBxJ/t3F8LQFbULOKk4N1UPNp9bQv4j36wg=
X-Received: by 2002:a05:6512:94d:: with SMTP id u13mr20191207lft.368.1617733889510;
 Tue, 06 Apr 2021 11:31:29 -0700 (PDT)
MIME-Version: 1.0
References: <06ba2ed4-2730-9ce8-0665-3c720bc786a3@fb.com> <CAGG=3QXkvwrm_tnsYtJ-gvHw8Emv5xFWeckoPoD4PhEud7v8EA@mail.gmail.com>
 <YGxgnQyBPf5fxQxM@kernel.org> <YGyO9KzDoxu5zk33@kernel.org>
 <YGySmmmn4J43I0EG@kernel.org> <YGyTco9NvT8Bin8i@kernel.org>
 <YGyUbX/HRBdGjH3i@kernel.org> <3a6aa243-add9-88a5-b405-85fd8bfbe21d@fb.com>
 <4eda63d8-f9df-71ab-d625-dcc4df429a89@fb.com> <YGyicDTUkPNhab4K@kernel.org> <YGyis5/OlebLxYQQ@kernel.org>
In-Reply-To: <YGyis5/OlebLxYQQ@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 6 Apr 2021 11:31:18 -0700
Message-ID: <CAKwvOdmU3-hY=xJVAwTuJ+3A6MG=-3AbvukqXs1kYLEXANWhow@mail.gmail.com>
Subject: Re: [PATCH dwarves 0/2] dwarf_loader: improve cus__merging_cu()
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Yonghong Song <yhs@fb.com>, Bill Wendling <morbo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, dwarves@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        David Blaikie <dblaikie@gmail.com>,
        =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>,
        kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Tue, Apr 6, 2021 at 11:04 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Tue, Apr 06, 2021 at 03:03:29PM -0300, Arnaldo Carvalho de Melo escreveu:
> > /me goes back to building clang/llvm HEAD, reducing the number of linker
> > instances to 1 as I have just 32GB of ram in this Ryzen machine... ;-)
>
> And guess what takes a long time?
>
> [ 61%] Linking CXX executable ../../bin/llvm-lto

During configuration of LLVM (cmake):

$ cmake ... -DLLVM_ENABLE_LLD=ON

to link the binaries with LLD, which should be able to link using all cores.
https://llvm.org/docs/CMake.html

-- 
Thanks,
~Nick Desaulniers
