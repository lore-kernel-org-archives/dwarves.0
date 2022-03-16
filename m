Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65EEEC433FE
	for <linux-dwarves@archiver.kernel.org>; Wed, 16 Mar 2022 20:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236608AbiCPUwY (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Wed, 16 Mar 2022 16:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358089AbiCPUwX (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Wed, 16 Mar 2022 16:52:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC83F6E4EF;
        Wed, 16 Mar 2022 13:51:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9284AB81D65;
        Wed, 16 Mar 2022 20:51:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D5EC340E9;
        Wed, 16 Mar 2022 20:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647463866;
        bh=+HuG5Y6nJnoHSDgnSkgLUxN1bJmKug6pEGnJtApwr1A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JDpmBNqFUegg535TbNiHKQgjpfoDq1KgLrOH4ZfhxszXezKJRQsW0VztRlA4avp8c
         fDzG3BaUFhozIAHQ+DG8oNUFi1rTmmNnjmSZ3N8KwKzens25XPmdPYisYVpqsmjSuT
         eoSiEy62NnB0bnVoB+oR7tmF3VQG/6EC5h5+qjWHfNgkkDeTo59ZjHIoV9qhDoyeqR
         lfKr+WQOgE+RtlJuCCaHeDWcpdsvfSrrHiKbzVDg+zDHGVR+tF/Ea7gp+ebrBHNhBR
         qtm2ZKqFJm7RoGFlDsFgxyzW9XTlU0n9wLbcaAJdZ40JJpOtf5iyfREg1CUtOwjNub
         BhbWptanBn06Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5114D40407; Wed, 16 Mar 2022 17:51:03 -0300 (-03)
Date:   Wed, 16 Mar 2022 17:51:03 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     kkourt@kkourt.io
Cc:     dwarves@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kornilios Kourtis <kornilios@isovalent.com>
Subject: Re: [PATCH 2/2] dwarves: cus__load_files: set errno if load fails
Message-ID: <YjJNt0GpA5fAm8PQ@kernel.org>
References: <YjHjLkYBk/XfXSK0@tinh>
 <20220316132354.3226908-1-kkourt@kkourt.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316132354.3226908-1-kkourt@kkourt.io>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Wed, Mar 16, 2022 at 02:23:54PM +0100, kkourt@kkourt.io escreveu:
> From: Kornilios Kourtis <kornilios@isovalent.com>
> 
> This patch improves the error seen by the user by setting errno in
> cus__load_files(). Otherwise, we get a "No such file or directory" error
> which might be confusing.
> 
> Before the patch, using a bogus file:
> $ ./pahole -J ./vmlinux-5.3.18-24.102-default.debug
> pahole: ./vmlinux-5.3.18-24.102-default.debug: No such file or directory
> $ ls ./vmlinux-5.3.18-24.102-default.debug
> /home/kkourt/src/hubble-fgs/vmlinux-5.3.18-24.102-default.debug
> 
> After the patch:
> $ ./pahole -J ./vmlinux-5.3.18-24.102-default.debug
> pahole: ./vmlinux-5.3.18-24.102-default.debug: Unknown error -22
> 
> Which is not very helpful, but less confusing.

Humm, because you should've set errno to -err back in cus__load_files(),
with this on top of your two patches we should get the:

#define EINVAL          22      /* Invalid argument */


"Invalid argument" or so from getting.

diff --git a/dwarves.c b/dwarves.c
index 5d0b420f0110452e..89609e96c46747ce 100644
--- a/dwarves.c
+++ b/dwarves.c
@@ -2401,7 +2401,7 @@ int cus__load_files(struct cus *cus, struct conf_load *conf,
 	while (filenames[i] != NULL) {
 		int err = cus__load_file(cus, conf, filenames[i]);
 		if (err) {
-			errno = err;
+			errno = -err;
 			return -++i;
 		}
 		++i;



Agreed? I'll fix it up here and apply if so.

- Arnaldo
 
> Signed-off-by: Kornilios Kourtis <kornilios@isovalent.com>
> ---
>  dwarves.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/dwarves.c b/dwarves.c
> index 89b58ef..5d0b420 100644
> --- a/dwarves.c
> +++ b/dwarves.c
> @@ -2399,8 +2399,11 @@ int cus__load_files(struct cus *cus, struct conf_load *conf,
>  	int i = 0;
>  
>  	while (filenames[i] != NULL) {
> -		if (cus__load_file(cus, conf, filenames[i]))
> +		int err = cus__load_file(cus, conf, filenames[i]);
> +		if (err) {
> +			errno = err;
>  			return -++i;
> +		}
>  		++i;
>  	}
>  
> -- 
> 2.25.1

-- 

- Arnaldo
