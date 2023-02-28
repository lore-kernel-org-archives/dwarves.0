Return-Path: <dwarves-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDFAC64EC4
	for <linux-dwarves@archiver.kernel.org>; Tue, 28 Feb 2023 20:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjB1UZH (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 28 Feb 2023 15:25:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjB1UZH (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Tue, 28 Feb 2023 15:25:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B9832E55
        for <dwarves@vger.kernel.org>; Tue, 28 Feb 2023 12:25:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3DB31611AF
        for <dwarves@vger.kernel.org>; Tue, 28 Feb 2023 20:25:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74596C433EF;
        Tue, 28 Feb 2023 20:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677615901;
        bh=Nw96diikSl4K3psiSJ2u9AvGrLA1p+ChYsmGXNZOsIM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ajgx76+AFcufCe39fQXoLrHNePBv3HGuIyEwenofzHOowp182/MZ5363/s8OvjCq5
         9mSJX88OV08wTGS+MYm4cs1YKeJZAqxySC3PvYVM26+zWkUoHo2CgJpeM07jn1dlj1
         K2eQcPCk34heoNG7LarRWwXk5i0aLyVwJzQwlX0jrMdSS9ocGss2+ENrY65WjhjsiC
         UkBEuuYuO4evUBcotI4d1+5cXVexOtZnfS/TbR16IE+1h31ni/t7iIhr+2ESwBQYFk
         qsJxuyaM70viUvPZ51yp6RfF6DcicrfgTt9hA4dl5PGm8qX0K809rFMSopim+Cnx9O
         9YQVF5YKv5Fwg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8611D4049F; Tue, 28 Feb 2023 17:24:58 -0300 (-03)
Date:   Tue, 28 Feb 2023 17:24:58 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     dwarves@vger.kernel.org, arnaldo.melo@gmail.com
Subject: Re: [question] dwarves/pahole testing
Message-ID: <Y/5jGjgCdQpUe1Ak@kernel.org>
References: <92b71fbfc8d768103d533d3b0edded0bd6750b0f.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92b71fbfc8d768103d533d3b0edded0bd6750b0f.camel@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Thu, Feb 23, 2023 at 10:47:55PM +0200, Eduard Zingerman escreveu:
> Hello Dwarves community,
> 
> I have a set of changes that add support for "btf_type_tag" attached to the
> hosting type, as discussed in [1]. I'd like to test these changes before
> submitting via this mailing list. I have some local tests for the feature
> itself and I checked that kernel build / BPF selftests work as expected.
> Are there any additional tests I can run?
> Maybe some manual testing procedures?

You may want to test using 'btfdiff vmlinux' after encoding BTF from
DWARF.
 
> Thanks,
> Eduard
> 
> [1] https://github.com/eddyz87/dwarves
>     Dwarves update to support btf_type_tag:v2
> [2] https://lore.kernel.org/bpf/87r0w9jjoq.fsf@oracle.com/
>     Discussion about update for btf_type_tag encoding in DWARF
> 
