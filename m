Return-Path: <dwarves-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97809C61DA4
	for <linux-dwarves@archiver.kernel.org>; Mon, 30 Jan 2023 09:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbjA3JXG (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Mon, 30 Jan 2023 04:23:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbjA3JXF (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Mon, 30 Jan 2023 04:23:05 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F57A5D9
        for <dwarves@vger.kernel.org>; Mon, 30 Jan 2023 01:23:03 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9B65A1FE10;
        Mon, 30 Jan 2023 09:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1675070582; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6F3q5AAylFK5gkUAAz0rRMOstOI57HDI2j+gx0TzIt4=;
        b=vZinVz8mvjY/q8jSYsdp6Z3kVtmFYZpuzwnH82MNba84BEWsM6JFL0hqzeC00mp+ULgntj
        sMICWKwGnH0g8SUU02fUXJdod8XMAeYFiRi+GDiHDC6FeW7NQHNqkupu4anKJroqdJyfv3
        fpUAuaC37f609V1abBiXyAkaRtv/KqU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1675070582;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6F3q5AAylFK5gkUAAz0rRMOstOI57HDI2j+gx0TzIt4=;
        b=vc+Wb5gQLWYjDefsQEf4OACuz4SaCE7y0j5Bgd5luXW6PDSYnGTY+Q0pTG5/B0C0kdWSfV
        N9yKsN+ho37tY2Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7786B13A06;
        Mon, 30 Jan 2023 09:23:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id H40mHHaM12ORaAAAMHmgww
        (envelope-from <mliska@suse.cz>); Mon, 30 Jan 2023 09:23:02 +0000
Message-ID: <68e2ee74-e0b7-35a8-33bb-b957df65327b@suse.cz>
Date:   Mon, 30 Jan 2023 10:23:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Encountered error while encoding BTF due to Unsupported
 DW_TAG_unspecified_type(0x3b)
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Yonghong Song <yhs@meta.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Yonghong Song <yhs@fb.com>, dwarves@vger.kernel.org,
        Nick Clifton <nickc@redhat.com>
References: <CAEf4BzaonLxP77zj9ReaEWdZ-Whh4JUts3S5YO8v9vVuCfMdiQ@mail.gmail.com>
 <Yz8PBLflC2VDm9qw@kernel.org> <Y0CKQHhcTSWYqNpj@kernel.org>
 <166780df-a8ca-6dfb-88e9-9e489efc6bf7@meta.com> <Y0QK1nmVjqr95od1@kernel.org>
 <Y0R7uu3s/imnvPzM@kernel.org> <Y0R+U8i8mDPkOAw7@kernel.org>
 <002daef3-ce5e-e6f1-ec12-fe5f64ae2632@meta.com> <Y0VzbkffTg2TJ5i3@kernel.org>
 <ee52054a-bd76-2817-33c4-ffae00e72fb9@meta.com> <Y0Wk5i0Zz2saSKK3@kernel.org>
From:   =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>
In-Reply-To: <Y0Wk5i0Zz2saSKK3@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Hi Arnaldo.

Now as the binutils 2.40 release is out, can you please consider doing a new
dwarvers (pahole) release that will include the changes we discussed in this thread?

Thank you,
Martin
