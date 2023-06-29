Return-Path: <dwarves-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B5AEB64DC
	for <linux-dwarves@archiver.kernel.org>; Thu, 29 Jun 2023 15:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbjF2PPg (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 29 Jun 2023 11:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbjF2PPf (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Thu, 29 Jun 2023 11:15:35 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F3D1BD1;
        Thu, 29 Jun 2023 08:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
        bh=JyvFeXPxz6Be0T6oJyIK/ZexPeUDpqw2K2D+Uj5LllY=; b=adSAk2pGb6Y58ZgDJHKsT2CWo6
        T5sPGcWD4mS1Eo4v1PUR75FaTNp3KfqwZjlW0pGlwEKhEMwfhxnG8DTm2LGVHGkKxY6dLEIQ0jaDs
        KGleVj2s+DWJ5ObIU4okuZRatV99ybBntczEHuNeU9lrJwrQjfoeERFF5Y1r5xS/AZYDtDRs05FvQ
        fJRRuW3NwneBSwzEwvr8z8CkeqypzwyveZ5puc6oNtc0jW6fqda9O+BAtWRbb9s0haLIE2vlq/6G1
        dOkNIEvbsvDOF2qKtoz7JdF2E85QH10Zg0uVrANJYK+Tad7JpmGIpaCrKlEZHbqkw+uB+I7RQzUms
        NegOCIrQ==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1qEtMp-0004dN-DH; Thu, 29 Jun 2023 17:15:31 +0200
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1qEtMp-000Kbo-2g; Thu, 29 Jun 2023 17:15:31 +0200
Subject: Re: PSA: Ubuntu pahole creates buggy BTF
To:     Lorenz Bauer <lmb@isovalent.com>, bpf <bpf@vger.kernel.org>,
        dwarves@vger.kernel.org,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Dimitri John Ledkov <dimitri.ledkov@canonical.com>,
        Domenico Andreoli <cavok@debian.org>
References: <CAN+4W8junMrqMTQJ1cy-5fhd9FFsASWOndRPaprspKXMXShJYQ@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <aaf6220c-dddf-ee5f-37a2-e16bd580c0a7@iogearbox.net>
Date:   Thu, 29 Jun 2023 17:15:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAN+4W8junMrqMTQJ1cy-5fhd9FFsASWOndRPaprspKXMXShJYQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26954/Thu Jun 29 09:29:58 2023)
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

[ Also Cc'ing Dimitri / Domenico ]

On 6/29/23 4:41 PM, Lorenz Bauer wrote:
> Just a quick FYI for anyone else struggling with weird BTF on recent
> Ubuntu releases, it seems like their pahole is broken due to an
> incorrect backport.
> 
> The upstream issue is here:
> https://bugs.launchpad.net/ubuntu/+source/dwarves/+bug/2025370

(for ctx, original issue was here: https://github.com/cilium/ebpf/issues/1081)

Thanks,
Daniel
