Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B4DDC433EF
	for <linux-dwarves@archiver.kernel.org>; Wed,  4 May 2022 19:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377594AbiEDTqi (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Wed, 4 May 2022 15:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347480AbiEDTqg (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Wed, 4 May 2022 15:46:36 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA7119C10
        for <dwarves@vger.kernel.org>; Wed,  4 May 2022 12:42:59 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-ed8a3962f8so2249013fac.4
        for <dwarves@vger.kernel.org>; Wed, 04 May 2022 12:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QXq0FXkqxCaM/dCQ09BFAGCLDO3MEzAwUavtBOZoJNk=;
        b=OXXkru8RnDOhqGQkCSIiPJJFVhmo2TkJq68wKcfe+0dZh9kXxQpaB+1oVaQQvKiPHb
         q2T9cCT9EEMG4qfRk57CHEkv8q9uvPid9nNkU4/ABI3brlY9/7CIhDz83DeWYOajx1zr
         0kaXwP1BUAe8r2GEHUxwf33sJDAMYL+D+AUtG7wCKOj4P4KNdlKjHme1R6pZ1rWw04sV
         oD/GNK9Gnl8ebKG9DD0EqQ9nvkVTHm+0GngNarIGOxpKZCpqPeBVcndNbZIrAyBw8pY8
         rjtjnmbGwY3aFXQG+ERgaXz1dLMY1oMkd18R7ackUlHf0z7F/8NLMJ9QqO2aPEioDs6U
         RuZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QXq0FXkqxCaM/dCQ09BFAGCLDO3MEzAwUavtBOZoJNk=;
        b=4FCfNAMKcqQExZuRKZ8zk1LatlAvfoE2t+Ta1NixMYFYPn3djRAEd510c7BxLnpB15
         fuQ0ebTJS6OnHTQgoaRMDzND+0kvB3hDtvEcb+Kw6hb0Jd2zto1CinsWEnTYnvTGDSGL
         6KzOkUwH82uKbof2o7HLsAhbaAesG/PBH1diTFtzp1Zq92sJdRArfaNLUWsv75TbYKZn
         sqguruptb7mA6Vg9gDeHpnhWxvMbDFSZtnQVonT/6RY3jXVXqv1wga5yOiif1WMRYneY
         Pd/yZ+uGFv6xkz8AORkjkyN1xU0/Y1g+lnK28jPgL/XgqlAn+mp3qfQzvWdqjUACUcC8
         rqLw==
X-Gm-Message-State: AOAM533N5SXwVZubvqLoSIeF191gWpeYMrAb7VenIqp2YsmqSuNY56/u
        wLZVUS4YADX+R6rEP5DtK1M=
X-Google-Smtp-Source: ABdhPJxku6p5X8JpdYmb4J49AtoCF2Rm2WYLQx98UxwQDtgVXUI8SoYQ576BNygAwwTodOjwRY8BLA==
X-Received: by 2002:a05:6870:b527:b0:ed:9cbd:e04a with SMTP id v39-20020a056870b52700b000ed9cbde04amr582826oap.41.1651693379093;
        Wed, 04 May 2022 12:42:59 -0700 (PDT)
Received: from tx3000mach.io (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id q17-20020a9d6651000000b006060322127dsm5381446otm.77.2022.05.04.12.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 12:42:58 -0700 (PDT)
From:   Martin Reboredo <yakoyoku@gmail.com>
To:     arnaldo.melo@gmail.com, dwarves@vger.kernel.org
Cc:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net
Subject: Re: [PATCH] pahole: Implement cu_exclude_lang flag
Date:   Wed,  4 May 2022 16:42:50 -0300
Message-Id: <20220504194250.29344-1-yakoyoku@gmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <YnFDItzfx2JD7Gw7@kernel.org>
References: <YnFDItzfx2JD7Gw7@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

>Em Thu, Apr 21, 2022 at 11:47:15AM -0300, Martin Reboredo escreveu:
>> Exclude compilation units that have the language id equal to the one
>> from the --cu_exclude_lang=LANG flag.
>> 
>> Required by Rust Linux builds due to failing BTF checks product of
>> things like rustc's struct reordering.
>
>Sorry, when I saw this patch I already had committed a similar one, can
>you please take a look?
>
>Its in the "next" branch at:
>
>https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?h=next

I've saw said patches and performed local testing with a Rust-for-Linux
kernel, both in Qemu and bare metal, the kernel and it was working as
expected, bpftool could eject a proper header

$ bpftool btf dump file /sys/kernel/btf/vmlinux format c > vmlinux.h

and I could do BTF test from a guide by Aniket Bhattacharyea in
containiq.com (https://www.containiq.com/post/btf-bpf-type-format).

So yeah, I can say that this patch was effectively superseeded by the
patch series at next. Thanks for your attention though.
