Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F761C433EF
	for <linux-dwarves@archiver.kernel.org>; Sun, 10 Oct 2021 06:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6272360F55
	for <linux-dwarves@archiver.kernel.org>; Sun, 10 Oct 2021 06:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhJJGLM (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Sun, 10 Oct 2021 02:11:12 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:44810 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230256AbhJJGLK (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Sun, 10 Oct 2021 02:11:10 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=1;SR=0;TI=SMTPD_---0UrEEfj-_1633846150;
Received: from B-LB6YLVDL-0141.local(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0UrEEfj-_1633846150)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 10 Oct 2021 14:09:11 +0800
To:     dwarves@vger.kernel.org
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: pahole failed to get some struct info
Message-ID: <9a88283d-443c-3789-b120-b2c6c56ebe55@linux.alibaba.com>
Date:   Sun, 10 Oct 2021 14:09:10 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Hi,

Sorry to disturb you, when I use below command to get info about 'struct 
hvc_struct', it failed.

$ pahole -C hvc_struct vmlinux
die__process_function: tag not supported (INVALID)!
die__process_unit: DW_TAG_dwarf_procedure (0x36) @ <0x4ebf4c> not handled!

But when I try some common struct, it is OK.

$pahole -C task_struct vmlinux

Could you help me how to fix the issue?  thanks a lot.

