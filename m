Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC799C433F5
	for <linux-dwarves@archiver.kernel.org>; Mon,  3 Oct 2022 12:07:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiJCMHW (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Mon, 3 Oct 2022 08:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbiJCMHV (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Mon, 3 Oct 2022 08:07:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD53550049
        for <dwarves@vger.kernel.org>; Mon,  3 Oct 2022 05:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664798839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yFStSiIeMtJhdVZxUGMMNFt/OzCepMDnoL3kmeexiIg=;
        b=Lgk8pMnNFkxIsx2W7/VfxRRU6mlR8baYevtgk1QGxDu0Mn/UO/OyJhCA9Ve3omuBv4Nqpk
        zbdsrUo3Rlz0rgyXy5r6oKHCgXuFHo598HC++Ku5PK40S2vQ5HhaJChN88Ss1K7JgwZ/F+
        zLXe5HJlKIxlZKtYW9HGKNQQgu7WE4U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-348-k5CXs9h9OBCNObwGCfRo1g-1; Mon, 03 Oct 2022 08:07:17 -0400
X-MC-Unique: k5CXs9h9OBCNObwGCfRo1g-1
Received: by mail-wm1-f72.google.com with SMTP id 84-20020a1c0257000000b003b4be28d7e3so9105852wmc.0
        for <dwarves@vger.kernel.org>; Mon, 03 Oct 2022 05:07:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=yFStSiIeMtJhdVZxUGMMNFt/OzCepMDnoL3kmeexiIg=;
        b=423XQGxtyVvhN4eWAKax/zadJGNHG49CjsCMblpOUr0xdA0IuBom0nEbACUHfaUHU9
         gQKXqPjsDSf61fb423sXkc9Qejq7XjuAhInXu+UcN+NZxvSNgN6OCQtZDGniWMkz8ADj
         EE826Jnn1s2r6Fr73LQsTH8me8zN1KlZcmKqVqbwqbZW95SvdGRtUru5SiE8vxkACJb1
         dEXpUoAmQM5+nKlio7tO3MpgOUR0tstzF1EVNdqxYNsGfV9dcrCNTjtnEMVxXbK7CWNB
         rud+/3J57cLr+BLDGW2VgLjt4ccgfE1qqGIo3vI+yVlLFQ5HrMrnij9BHsOsBzovfXlT
         xpRA==
X-Gm-Message-State: ACrzQf16ohI0mUPcxTIdWIgMb0H1C1XCpAsehICaVHflyN8ecPlJIuTl
        EeZvsDhN9CBlE/GX/EDPuGaG4337QC+Rt+TMW65dWgkbhTKhUovACylThIxfg0RcvtLEgK4YWk2
        KRL9XcVFEdkxn/B7ilg==
X-Received: by 2002:a05:6000:18a1:b0:22a:f4c2:c9e6 with SMTP id b1-20020a05600018a100b0022af4c2c9e6mr13554208wri.71.1664798836518;
        Mon, 03 Oct 2022 05:07:16 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4yG47lYnDoU0L1aLxAPFOS2iRlmgHO0100md786Xt8FUYiDA7wbguMbus0h6SrSBD27WahvA==
X-Received: by 2002:a05:6000:18a1:b0:22a:f4c2:c9e6 with SMTP id b1-20020a05600018a100b0022af4c2c9e6mr13554193wri.71.1664798836342;
        Mon, 03 Oct 2022 05:07:16 -0700 (PDT)
Received: from [192.168.1.18] ([79.123.82.157])
        by smtp.gmail.com with ESMTPSA id m24-20020adfa3d8000000b0022ae401e9e0sm9415295wrb.78.2022.10.03.05.07.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Oct 2022 05:07:15 -0700 (PDT)
Message-ID: <a8e2a00b-0a9b-1433-7698-364b36af73a7@redhat.com>
Date:   Mon, 3 Oct 2022 13:07:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: Encountered error while encoding BTF due to Unsupported
 DW_TAG_unspecified_type(0x3b)
Content-Language: en-GB
To:     =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>,
        dwarves@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>
References: <878d0959-7f80-471e-69d5-5228822b4365@suse.cz>
From:   Nick Clifton <nickc@redhat.com>
In-Reply-To: <878d0959-7f80-471e-69d5-5228822b4365@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Hi Martin,

> I noticed one can't build 5.19 with latest binutils master.
> 
> One see the following error:
> [ 1413s]   BTF     .btf.vmlinux.bin.o
> [ 1413s] Unsupported DW_TAG_unspecified_type(0x3b)

>   <0><c>: Abbrev Number: 3 (DW_TAG_unspecified_type) <--- the problematic TAG

> Is it something pahole should handle?

Yes, I believe so.  The tag is a valid DWARF tag, and GDB wants it, so
it would be good if pahole could support it.

Cheers
   Nick


