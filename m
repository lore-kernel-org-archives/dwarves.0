Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9252C433F5
	for <linux-dwarves@archiver.kernel.org>; Tue,  4 Oct 2022 21:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiJDVKM (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 4 Oct 2022 17:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJDVKL (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Tue, 4 Oct 2022 17:10:11 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51503BC6F
        for <dwarves@vger.kernel.org>; Tue,  4 Oct 2022 14:10:10 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id x1so13726600plv.5
        for <dwarves@vger.kernel.org>; Tue, 04 Oct 2022 14:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cryptohaze-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=s2zAjAi2HylwnsEyEAQ1wIbqqftZndCmqy4yLvEtwF0=;
        b=rJ9eGLlJ9aj9+z9soNWdq5I4ILBxVLsOdQtVquoOXq0uSH17WI18cia4IJa5yCaqdf
         CNfOV1iD69Mj4mOCggNmKRaYRwKcADXCFjLUjo+UvbRVRXp5qyzXEir0NKzbF9con18e
         109/IkSwHgW2qNKm/nWpm1AOaoJfpkqDip1apCDyJbh86h4Rb80oPWw1MtLXeui6922C
         RYhMR9uUQdBfo8TExJoEys0E9IA9HMsKTXziOQQQhutd68zuZsG/A6H5PeT4pDoEhaxn
         DmmsrH+BCClBs7vpmeIgKs4nt4JxbdzGxtfx6gqx2e+ao/B8kQXxFcZHbZNcSkIRAKPd
         bvHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=s2zAjAi2HylwnsEyEAQ1wIbqqftZndCmqy4yLvEtwF0=;
        b=kmbcGbonTc2d94RS9cxuvNPO4oQfWeThV2dwV1EdZTZFN8vvvxyiWnR5i40OAi5A8u
         LJV6MghP3XD2JdEttNnwXva81dAqfwi1EU+rVkF6NUbWMSsyhlrbl2knoQGYneKUnEuf
         G6+phGBV4MreI+LUnkZMkXxBYodkfHF1EKYNfS2ZuyXLL+C7Lt871c1dIplHE1bHnzIc
         KjKbz6vKxC5Xo6rOpPCL7vrKdvgpdOHY7uZ0BE2uNkBjbUnNyVcQWu2P45w3k80s9P8V
         0OZnhUOhbQ4Nqau0d6BxxcoAqcT5f5E2nKzlxK49Hir6u7haiFPKm35CeZ1SMmxzuwl2
         DbWQ==
X-Gm-Message-State: ACrzQf1YZ0nPACgi5lvfH21kIcRf2e2Nu0ma8JSvurlvySglqyoN2h/7
        +qJCbgCel6d4O7Ts8dHYS8Q4tsygecZ1OSIXwSU=
X-Google-Smtp-Source: AMsMyM7D8ugUeqkzGyWT9qY4LV2gHT/qKHek4YM8Q92LocXVzmgzeJxYATxKmNc39woVslCjguyKwQ==
X-Received: by 2002:a17:902:e74c:b0:17f:7fdb:4c39 with SMTP id p12-20020a170902e74c00b0017f7fdb4c39mr73838plf.153.1664917809751;
        Tue, 04 Oct 2022 14:10:09 -0700 (PDT)
Received: from [10.137.0.11] ([66.195.179.45])
        by smtp.gmail.com with ESMTPSA id q39-20020a17090a1b2a00b00205f5ff3e3bsm7503pjq.10.2022.10.04.14.10.08
        for <dwarves@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 14:10:08 -0700 (PDT)
Message-ID: <17a34291-e28c-b08d-cfec-d455c72c4c54@cryptohaze.com>
Date:   Tue, 4 Oct 2022 15:10:06 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Content-Language: en-US
To:     dwarves@vger.kernel.org
From:   Bitweasil <bitweasil@cryptohaze.com>
Subject: Ubuntu kernels and die__process: DW_TAG ... got INVALID!
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

When trying to extract the layout of kernel structures that should exist 
on recent kernels from the Ubuntu debug kernel repo, I get the following 
error:

die__process: DW_TAG_compile_unit, DW_TAG_type_unit or 
DW_TAG_partial_unit expected got INVALID!
pahole: type 'mount' not found

As far as I can tell, 'struct mount' should still exist - and I can pull 
other structures out without trouble.  The issue starts appearing 
somewhere in the 5.15 kernel version - earlier kernels work exactly as 
expected and I can extract the full offsets.

https://elixir.bootlin.com/linux/v5.15.48/source/fs/mount.h indicates 
that 'struct mount' still exists in the source, and it remains present 
into the 6.0 kernel with no substantial changes. I can also produce the 
same response with some of the other structures in that file - 
mountpoint, mnt_namespace, and mnt_pcp all lead to the same error message.

I've tried building pahole from head (Oct 4, 2022, e819d737) without any 
changes to the behavior, and v1.21 and 1.24 both lead to the same results.

Steps to reproduce (warning, will take ~10GB - the unzipped kernel debug 
symbols are rather large):

cd /tmp
wget 
http://ddebs.ubuntu.com/pool/main/l/linux/linux-image-unsigned-5.15.0-48-generic-dbgsym_5.15.0-48.54_amd64.ddeb
ar x linux-image-unsigned-5.15.0-48-generic-dbgsym_5.15.0-48.54_amd64.ddeb
tar -xf data.tar.xz
cd usr/lib/debug/boot
pahole -C mount vmlinux-5.15.0-48-generic

die__process: DW_TAG_compile_unit, DW_TAG_type_unit or 
DW_TAG_partial_unit expected got INVALID!
pahole: type 'mount' not found

Any suggestions on how to resolve this?  I'm not familiar enough with 
the various debug formats to know how to troubleshoot beyond this point 
right now.

