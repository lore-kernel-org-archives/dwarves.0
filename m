Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B2DC433FE
	for <linux-dwarves@archiver.kernel.org>; Mon, 18 Oct 2021 13:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D4116103C
	for <linux-dwarves@archiver.kernel.org>; Mon, 18 Oct 2021 13:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbhJRNSa (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Mon, 18 Oct 2021 09:18:30 -0400
Received: from foss.arm.com ([217.140.110.172]:37234 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229833AbhJRNS3 (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Mon, 18 Oct 2021 09:18:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B0A20101E;
        Mon, 18 Oct 2021 06:16:18 -0700 (PDT)
Received: from e126130.arm.com (unknown [10.57.54.178])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E57D73F73D;
        Mon, 18 Oct 2021 06:16:17 -0700 (PDT)
From:   Douglas RAILLARD <douglas.raillard@arm.com>
To:     acme@redhat.com
Cc:     dwarves@vger.kernel.org, douglas.raillard@arm.com
Subject: [PATCH v2 0/3] Infer BTF alignment 
Date:   Mon, 18 Oct 2021 14:16:18 +0100
Message-Id: <20211018131621.212628-1-douglas.raillard@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

From: Douglas Raillard <douglas.raillard@arm.com>

Infer alignment of struct members when loading BTF, so that using the
header dumped by pahole results in the same offsets. This is useful for
debugging tools to be able to access pointers to structs of possibly
private types. One such example are kernel modules bolting traceevents
on existing upstream tracepoints, which typically expose "top-level"
struct pointers (e.g. struct cfs_rq) to allow maximum flexibility.

Changes since v1:
* Split alignment patch into refactor and new code.
* Test with fullcircle on vmlinux and .o of kernel tree:
    
  export PATH=pahole/build:$PATH
  for f in {kernel,drivers,arch,block,crypto,certs,fs,init,ipc,lib,mm,net,sound,virt}/**.o; do
     echo $f
     pahole/fullcircle $f
  done

  This did not produce any error but neither did it on pahole master
  branch, since I assume it reads DWARF by default.

  Trying with "pfunct -F btf" on object files seemed to yield empty
  sources:

    pfunct: file 'kernel/sched/fair.o' has no btf type information.

  Running pfunct on vmlinux worked, but fullcircle seems to have bailed
  out before getting to pfunct. When commenting out the bailouts, I
  managed to get pfunct to work, but the header generated with --compile
  contains one duplicate type, and lots of broken inlined functions
  (e.g. "return 0;" in a func returning a struct).
  

Douglas Raillard (3):
  fprintf: Fix nested struct printing
  btf_loader.c: Refactor class__fixup_btf_bitfields
  btf_loader.c: Infer alignment info

 btf_loader.c      | 65 ++++++++++++++++++++++++++++++++++++-----------
 dwarves.c         |  2 +-
 dwarves.h         |  2 ++
 dwarves_fprintf.c | 22 +++++++++++++---
 4 files changed, 71 insertions(+), 20 deletions(-)

-- 
2.25.1

