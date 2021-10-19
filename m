Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473DDC433F5
	for <linux-dwarves@archiver.kernel.org>; Tue, 19 Oct 2021 10:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EABD61027
	for <linux-dwarves@archiver.kernel.org>; Tue, 19 Oct 2021 10:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234955AbhJSKKG (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 19 Oct 2021 06:10:06 -0400
Received: from foss.arm.com ([217.140.110.172]:46968 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234794AbhJSKKG (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Tue, 19 Oct 2021 06:10:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 833CED6E;
        Tue, 19 Oct 2021 03:07:53 -0700 (PDT)
Received: from e126130.cambridge.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 84C1C3F70D;
        Tue, 19 Oct 2021 03:07:52 -0700 (PDT)
From:   Douglas RAILLARD <douglas.raillard@arm.com>
To:     acme@redhat.com
Cc:     dwarves@vger.kernel.org, douglas.raillard@arm.com
Subject: [PATCH v1 0/2] Anonymous inner struct
Date:   Tue, 19 Oct 2021 11:07:22 +0100
Message-Id: <20211019100724.325570-1-douglas.raillard@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

From: Douglas Raillard <douglas.raillard@arm.com>

Add an --inner_anonymous pahole CLI option to make inner
struct/enum/union anonymous. This allows turning this:

    struct foo { ... };
    struct bar {
        struct foo {
         ....
        } a;
    };
    
into this:

    struct foo { ... };
    struct bar {
        struct /* foo */ {
         ....
        } a;
    };

This avoids any conflict between the two definitions of struct foo. The
case arises when dumping multiple types at once with -E, all depending
on a same inner struct:

    struct bar {
        struct foo {
         ....
        } a;
    };
    struct bar2 {
        struct foo {
         ....
        } b;
    };


On top of that, struct foo could already be defined in a public header
already imported in the compilation unit, leading to a redefinition
error, while another nested struct is private and would still need -E
for the type to be usable.

Douglas Raillard (2):
  fprintf: Allow making struct/enum/union anonymous
  pahole.c: Add --inner_anonymous option

 dwarves.h         |  4 +++-
 dwarves_emit.c    |  2 +-
 dwarves_fprintf.c | 52 ++++++++++++++++++++++++++++++-----------------
 pahole.c          |  8 ++++++++
 4 files changed, 45 insertions(+), 21 deletions(-)

-- 
2.25.1

