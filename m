Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5417BC388F7
	for <linux-dwarves@archiver.kernel.org>; Wed, 11 Nov 2020 00:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC3D120639
	for <linux-dwarves@archiver.kernel.org>; Wed, 11 Nov 2020 00:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PszDPvpD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731234AbgKKA2n (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 10 Nov 2020 19:28:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730894AbgKKA2n (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Tue, 10 Nov 2020 19:28:43 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB01C0613D1
        for <dwarves@vger.kernel.org>; Tue, 10 Nov 2020 16:28:41 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id n63so201526qte.4
        for <dwarves@vger.kernel.org>; Tue, 10 Nov 2020 16:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=vPqKR2PdoBbYJBAB0pEaaqICQ5DipdKjXLrgYSNC3EU=;
        b=PszDPvpDf9wwZ3wrshs0vaqCnkuhVPAX2Ek0EIBk2v/J7elSG0YvKSX9j+8ISa/Ch0
         Bjgb3ZJGRT5fKnduYhhdCXzCxiTWin3PzzOytHGrc5vLBns2tQ4aulrfQNI5ozX+OkoF
         JbHRPCBHdT61AIrbr5cuwVN2r6d9OCmd+NY7DuOk3LB/Cu7CsFyN0JNRXaL+g+noJvMh
         /ezT0PX5PFw8qo8yfqfAkfhRjcdspdKT76GaDSR/nWmv7tnJi2ElZwPqy6TqSAsGtdU/
         Uppxjfb9CCzxxt6/COPFnyREMedjZjhjVHdjcNBi9GS7oKZY+h3q+PK39SeHC3F4A5vW
         A1AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=vPqKR2PdoBbYJBAB0pEaaqICQ5DipdKjXLrgYSNC3EU=;
        b=TrrCD6PaKAIWRX8+JsBdj2jHQxoo4cTiN7hBHcewh2Qlnolx4PlO+4kKI/pJvgUiPe
         5JoOjMxMWUCyR8x4GpZf4Ycrc/ZzsmcNeh2Kuxc6KEt3yWDzOUJDKLX88dynOQ8OlHRR
         s58rOm5SHvAVxUEAJEQQwzck9LnpAcGOh21s++SlvV5Dw4s+VbvQ1zaHCoTBodm3H71N
         QmTeePGDDh9oukS1jMoTCzMQuAlTPK0I9tjD8lmMndMb4qpOnJN4Wj9G6Rex+LoifyKG
         cA9c4go0aa7pekqgULtKhg6IrXXyAyUeRvWel2BNIzKRXlRyWY7uSzKH2K8JyxAIQYzM
         eXjA==
X-Gm-Message-State: AOAM5324Y3IMCQMI/l6ctmWtG7aFREhomE9F5H7tnqKL9T0upgs+1gtR
        NH5MIRW0fVvqs8jNV6CNp9c=
X-Google-Smtp-Source: ABdhPJwNsI2MtpjIeFxItPt6qbW76PKiS2/1/g1M8rn0eYWcZO/4cmKOIjjaEedp1pGZaRKMWi8B+A==
X-Received: by 2002:ac8:67da:: with SMTP id r26mr21241482qtp.101.1605054520892;
        Tue, 10 Nov 2020 16:28:40 -0800 (PST)
Received: from [192.168.86.242] ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id y4sm536543qtd.24.2020.11.10.16.28.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2020 16:28:40 -0800 (PST)
Date:   Tue, 10 Nov 2020 21:28:15 -0300
User-Agent: K-9 Mail for Android
In-Reply-To: <CAEf4BzYc6sHzGW-mmHSaTgG4zOc8S9Dxegnufbc+myr7wTmRcw@mail.gmail.com>
References: <CAEf4BzYc6sHzGW-mmHSaTgG4zOc8S9Dxegnufbc+myr7wTmRcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: pahole and libdwarves linking/versioning issues
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        dwarves@vger.kernel.org
CC:     Alexei Starovoitov <ast@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Roman Gushchin <guro@fb.com>
From:   Arnaldo <arnaldo.melo@gmail.com>
Message-ID: <34B5347B-DCF8-479E-B638-204D90A2910A@gmail.com>
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org



On November 10, 2020 9:14:16 PM GMT-03:00, Andrii Nakryiko <andrii=2Enakry=
iko@gmail=2Ecom> wrote:
>Hey Arnaldo,
>
>We use pahole pretty extensively here at Facebook, as you might
>imagine, given it's a required tool to compile Linux kernel with BTF=2E
>
>There are a few problems we periodically run into, all of which seems
>to be related to the fact that pahole is just a thin wrapper binary on
>top of libdwarves shared library=2E
>
>One very common problem is when we upgrade the dwarves package from
>one minor version to another one=2E Typically people would do
>
>yum upgrade dwarves


I'll reply to this more thoroughly tomorrow morning=2E

But yes, the spec file um the pahole git repo has a explicit Requires: tag=
 to ask for the latest libdwarves=2E

- Arnaldo

>
>And that would succeed to update the dwarves package (say 1=2E13 to
>1=2E16)=2E But when you run
>
>pahole --version
>
>You'll still see 1=2E13 (and still have 1=2E13 functionality, of

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
