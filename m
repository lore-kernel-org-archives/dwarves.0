Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57EAEECAA25
	for <linux-dwarves@archiver.kernel.org>; Thu, 25 Aug 2022 16:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243236AbiHYQnA (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 25 Aug 2022 12:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243083AbiHYQmT (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Thu, 25 Aug 2022 12:42:19 -0400
X-Greylist: delayed 395 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 25 Aug 2022 09:42:16 PDT
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2D850BA175;
        Thu, 25 Aug 2022 09:42:15 -0700 (PDT)
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 23C1272C90B;
        Thu, 25 Aug 2022 19:35:39 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 0B1914A470D;
        Thu, 25 Aug 2022 19:35:39 +0300 (MSK)
Date:   Thu, 25 Aug 2022 19:35:38 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        dwarves@vger.kernel.org, bpf@vger.kernel.org
Subject: pahole v1.24: FAILED: load BTF from vmlinux: Invalid argument
Message-ID: <20220825163538.vajnsv3xcpbhl47v@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Hi,

I also noticed that after upgrading pahole to v1.24 kernel build (tested on
v5.18.19, v5.15.63, sorry for not testing on mainline) fails with:

    BTFIDS  vmlinux
  + ./tools/bpf/resolve_btfids/resolve_btfids vmlinux
  FAILED: load BTF from vmlinux: Invalid argument

Perhaps, .tmp_vmlinux.btf is generated incorrectly? Downgrading dwarves to
v1.23 resolves the issue.

Thanks,

