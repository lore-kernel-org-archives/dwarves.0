Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB82C433F5
	for <linux-dwarves@archiver.kernel.org>; Tue,  7 Dec 2021 17:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbhLGRfM (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 7 Dec 2021 12:35:12 -0500
Received: from foss.arm.com ([217.140.110.172]:37284 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229449AbhLGRfM (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Tue, 7 Dec 2021 12:35:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E939311D4;
        Tue,  7 Dec 2021 09:31:41 -0800 (PST)
Received: from e126130.cambridge.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DD7A43F73B;
        Tue,  7 Dec 2021 09:31:40 -0800 (PST)
From:   Douglas RAILLARD <douglas.raillard@arm.com>
To:     acme@redhat.com
Cc:     dwarves@vger.kernel.org, douglas.raillard@arm.com
Subject: [PATCH v2 0/6] improve expanded header
Date:   Tue,  7 Dec 2021 17:31:45 +0000
Message-Id: <20211207173151.2283946-1-douglas.raillard@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

From: Douglas Raillard <douglas.raillard@arm.com>

Improve headers generated with -E in a few ways:

  * Print each type only once, to avoid redefinitions

  * --forward_decl: Generate forward declaration for struct and union so
    that uses of pointers will work.

  * --expanded_prefix: Allow prefixing names of types added by -E (all
    the ones not explicitly requested with -C) so they can be namespaced
    manually. This is important in order to be able to mix
    pahole-generated headers with existing headers without clash or
    maintenance.


types.txt:

  t1
  t4

Original printed type with "-C types.txt -E":

  struct t1 {
    struct t2 *a;
    struct t3 {
      int a;
    } b;
  };

  struct t4 {
    struct t3 {
      int a;
    } a;
  };

After this series and with
"-C types.txt -E --expanded_prefix __pahole --forward_decl":

  struct t1
  struct t2;
  struct t3;

  struct t1 {
    struct t2 *a;
    struct __pahole_t3 {
      int a;
    } b;
  };

  struct t4 {
    struct __pahole_t3 a;
  };


This header can be freely mixed with any other header as long as they
don't define t1 or t4 (if there is a clash, then pahole is not necessary
and the user can just use the header in the first place).

TODOs:

  * Define types on their first use even when they are first used as
    pointers. Currently, if a type is only used as pointer it will never
    get defined, which will still compile thanks to --forward_decl but
    won't allow easy use of the values.

  * The prefix system allocates memory to rename types and never frees
    it. I don't think it's a big issue for now as it's done inside
    pahole.c and type names are likely necessary until the end of the
    process anyway, but it makes valgrind angry and could therefore mask
    other problems. There is another implementation of prefix that
    modifies dwarves_fprintf.c instead of changing the name but it was
    very invasive and impossible to check if prefixable spots were
    missed.


This series is to be applied on the "next" branch as it includes reverts
of the --inner_anonymous series, which is dropped since it could not
cope with recursive types.


Douglas Raillard (6):
  Revert "fprintf: Allow making struct/enum/union anonymous"
  Revert "pahole.c: Add --inner_anonymous option"
  fprintf: Print types only once
  pahole.c: Add prefix to expanded type names
  pahole.c: Add --expanded_prefix option
  pahole.c: Add --forward_decl option

 dwarves.h          | 12 ++++--
 dwarves_emit.c     |  2 +-
 dwarves_fprintf.c  | 77 +++++++++++++++++-------------------
 man-pages/pahole.1 |  8 ++--
 pahole.c           | 98 ++++++++++++++++++++++++++++++++++------------
 5 files changed, 121 insertions(+), 76 deletions(-)

-- 
2.25.1

