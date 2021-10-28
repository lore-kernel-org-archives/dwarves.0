Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D02C433F5
	for <linux-dwarves@archiver.kernel.org>; Thu, 28 Oct 2021 12:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D04160C40
	for <linux-dwarves@archiver.kernel.org>; Thu, 28 Oct 2021 12:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbhJ1M3w (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 28 Oct 2021 08:29:52 -0400
Received: from foss.arm.com ([217.140.110.172]:54302 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229578AbhJ1M3w (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Thu, 28 Oct 2021 08:29:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68D7C1063;
        Thu, 28 Oct 2021 05:27:25 -0700 (PDT)
Received: from e126130.arm.com (unknown [10.57.46.169])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 86F3A3F5A1;
        Thu, 28 Oct 2021 05:27:24 -0700 (PDT)
From:   Douglas RAILLARD <douglas.raillard@arm.com>
To:     acme@redhat.com
Cc:     dwarves@vger.kernel.org, douglas.raillard@arm.com
Subject: [PATCH v3 0/6] Infer BTF alignment
Date:   Thu, 28 Oct 2021 13:27:04 +0100
Message-Id: <20211028122710.881181-1-douglas.raillard@arm.com>
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

Changes since v2:

* Added 3 commits on top to use cacheline size when infering larger
  alignments

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
  


Douglas Raillard (6):
  fprintf: Fix nested struct printing
  btf_loader.c: Refactor class__fixup_btf_bitfields
  btf_loader.c: Infer alignment info
  dwarves_fprintf: Move cacheline_size into struct conf_fprintf
  btf_loader.c: Propagate struct conf_load
  btf_loader.c: Use cacheline size to infer alignment

 btf_loader.c      | 86 ++++++++++++++++++++++++++++++++++++-----------
 codiff.c          |  4 ++-
 ctracer.c         |  3 +-
 dtagnames.c       |  3 +-
 dwarves.c         |  8 ++---
 dwarves.h         |  8 +++--
 dwarves_fprintf.c | 52 +++++++++++++++++++---------
 pahole.c          |  8 +++--
 pdwtags.c         |  4 ++-
 pfunct.c          |  4 ++-
 pglobal.c         |  4 ++-
 prefcnt.c         |  4 ++-
 12 files changed, 135 insertions(+), 53 deletions(-)

-- 
2.25.1

