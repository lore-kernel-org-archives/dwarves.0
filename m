Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A61C433FE
	for <linux-dwarves@archiver.kernel.org>; Mon, 25 Oct 2021 17:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5531E60EE3
	for <linux-dwarves@archiver.kernel.org>; Mon, 25 Oct 2021 17:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234532AbhJYRHy (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Mon, 25 Oct 2021 13:07:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:58184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235004AbhJYRFj (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Mon, 25 Oct 2021 13:05:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D1DC96023B;
        Mon, 25 Oct 2021 17:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635181397;
        bh=bj9OxMqcAY6jcU/EhZ+9WGsVMdeWbMpMd+r78jE0g1Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CtVZPt9X1Ybk9hYW/KMfrdp05ZCMBqEHV9eLr0lNm8SgN2b01oDxpSOGnsWjA6hiV
         9riMRXcfUyrpfolQo25rAUSZEachEC0lcYnjBVZv1t/6k6kywpW7YXyYgYorMe+0IM
         oA3usvEaxRKGuSteTSfWWrkHlqjc5Ts8SSf7Mar7qaOR+1Mjl5cK2OV7ueNJdphd7h
         ORZEBJJbLRTH+kWNsqOwP4SLUnkavSsWRA9BW1kULME+DHMTUyQ8iYzEVAZgZLoP8Z
         LCwP+E+Fw5UNEtZZWGkOYzgVlILid/JFA2gNISFcFK6rwRkC6RV0ha7hRwuSU+dXfh
         FT+DBNYV2/M2g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 98B2D410A1; Mon, 25 Oct 2021 14:03:14 -0300 (-03)
Date:   Mon, 25 Oct 2021 14:03:14 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Domenico Andreoli <domenico.andreoli@linux.com>
Cc:     dwarves@vger.kernel.org
Subject: Re: [PATCH] Minor manpage fixes
Message-ID: <YXbjUtjhAlC4kZub@kernel.org>
References: <YXZwiaXX/jMKooQm@m4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXZwiaXX/jMKooQm@m4>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Mon, Oct 25, 2021 at 10:53:29AM +0200, Domenico Andreoli escreveu:
> Signed-off-by: Domenico Andreoli <domenico.andreoli@linux.com>
> ---
>  man-pages/pahole.1 |    7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Thanks, applied.

- Arnaldo

 
> Index: b/man-pages/pahole.1
> ===================================================================
> --- a/man-pages/pahole.1
> +++ b/man-pages/pahole.1
> @@ -100,7 +100,8 @@ or file URLs (e.g.: file://class_list.tx
>  .B \-c, \-\-cacheline_size=SIZE
>  Set cacheline size to SIZE bytes.
>  
> -.TP \-\-sort
> +.TP
> +.B \-\-sort
>  Sort the output by type name, maybe this will grow to allow sorting by other
>  criteria.
>  
> @@ -792,7 +793,7 @@ $ pahole ~/bin/perf --header=perf_file_h
>  		.size = 88,
>  	},
>  	.id = 13,
> -	.path = "/machine.slice/machine-qemu\x2d1\x2drhel6.sandy.scope",
> +	.path = "/machine.slice/machine-qemu\\x2d1\\x2drhel6.sandy.scope",
>  },
>  $ 
>  .fi
> @@ -805,7 +806,7 @@ $ pahole ~/bin/perf --header=perf_file_h
>  .P
>  This uses ~/bin/perf to get the type definitions, the defines 'struct perf_file_header' as the header,
>  then seeks '$header.data.offset' bytes from the start of the file, and considers '$header.data.size' bytes
> -worth of such records. The filter expression may omit a common prefix, in this case it could additonally be
> +worth of such records. The filter expression may omit a common prefix, in this case it could additionally be
>  equivalently written as both 'filter=type==CGROUP' or the 'filter=' can also be omitted, getting as compact
>  as 'type==CGROUP':
>  .P
> 
> -- 
> rsa4096: 3B10 0CA1 8674 ACBA B4FE  FCD2 CE5B CF17 9960 DE13
> ed25519: FFB4 0CC3 7F2E 091D F7DA  356E CC79 2832 ED38 CB05



-- 

- Arnaldo
