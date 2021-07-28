Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63445C4338F
	for <linux-dwarves@archiver.kernel.org>; Wed, 28 Jul 2021 11:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39C1B60FC4
	for <linux-dwarves@archiver.kernel.org>; Wed, 28 Jul 2021 11:21:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbhG1LVW (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Wed, 28 Jul 2021 07:21:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:35394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231876AbhG1LVV (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Wed, 28 Jul 2021 07:21:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DEDE7600D1;
        Wed, 28 Jul 2021 11:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627471279;
        bh=NB7MZNPgZ8YzeYPdlHUSWde7687aE7Lh3hk2Ak8jmQg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OB4vrUqComEEN1MVD77GlvIjZ2ciOe2yJS9TZ0pejVMc0LcKpJWQ/m2aBegSVtCsV
         Kg7PuHh8hTvyUzf+sbE+7jaRJzP/5BBwqYV6GVlEcCCoLE1VMFt89Nr1DZ1UoHHZ+n
         afTFBIfu1UUIAOmXH6LYgPwJmvuSXYAPaLTdPHww=
Date:   Wed, 28 Jul 2021 13:21:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Deepak Kumar Mishra <DeepakKumar.Mishra@arm.com>
Cc:     "dwarves@vger.kernel.org" <dwarves@vger.kernel.org>,
        "acme@kernel.org" <acme@kernel.org>
Subject: Re: Expected release date of v1.22
Message-ID: <YQE9rQ6I6lq11Lne@kroah.com>
References: <YK+41f972j25Z1QQ@kernel.org>
 <20210715213120.GJ24916@kitsune.suse.cz>
 <YPGIxJao9SrsiG9X@kernel.org>
 <d5b963695314f66240b96f5699a78f0d980a0b44.camel@debian.org>
 <YPXptNw0ssvLNWRQ@kernel.org>
 <DB8PR08MB543689EC29E9131A0576F4DD97EA9@DB8PR08MB5436.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB8PR08MB543689EC29E9131A0576F4DD97EA9@DB8PR08MB5436.eurprd08.prod.outlook.com>
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Wed, Jul 28, 2021 at 10:53:08AM +0000, Deepak Kumar Mishra wrote:
> IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.

Now deleted.

Also, not a good idea to send to public email lists...
