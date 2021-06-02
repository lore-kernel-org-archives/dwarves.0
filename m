Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C28C4708F
	for <linux-dwarves@archiver.kernel.org>; Wed,  2 Jun 2021 05:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77B5C610E5
	for <linux-dwarves@archiver.kernel.org>; Wed,  2 Jun 2021 05:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbhFBF6t (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Wed, 2 Jun 2021 01:58:49 -0400
Received: from foss.arm.com ([217.140.110.172]:35164 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229779AbhFBF6t (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Wed, 2 Jun 2021 01:58:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 696E86D;
        Tue,  1 Jun 2021 22:57:06 -0700 (PDT)
Received: from a077198.arm.com (unknown [10.163.82.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE2323F774;
        Tue,  1 Jun 2021 22:57:04 -0700 (PDT)
From:   Deepak Kumar Mishra <deepakkumar.mishra@arm.com>
To:     dwarves@vger.kernel.org
Cc:     acme@kernel.org, qais.yousef@arm.com,
        Deepak Kumar Mishra <deepakkumar.mishra@arm.com>
Subject: [PATCH 0/2] dwarves: enable-SHARED-and-STATIC-lib-creation
Date:   Wed,  2 Jun 2021 11:26:22 +0530
Message-Id: <cover.1622612388.git.deepakkumar.mishra@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

CMakeLists.txt does not allow creation of static library and link applications
accordingly.

Creation of SHARED and STATIC should be allowed using -DBUILD_SHARED_LIBS

README file is also ammended to provide information regarding use of
-DBUILD_SHARED_LIBS while using cmake

Deepak Kumar Mishra (2):
  CMakeLists.txt: enable SHARED and STATIC lib creation
  README: add documentation for -DBUILD_SHARED_LIBS

 CMakeLists.txt | 10 +++++-----
 README         | 13 +++++++++++--
 2 files changed, 16 insertions(+), 7 deletions(-)

--
2.17.1

