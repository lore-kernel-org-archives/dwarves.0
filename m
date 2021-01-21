Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97854C4332B
	for <linux-dwarves@archiver.kernel.org>; Thu, 21 Jan 2021 13:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6533520691
	for <linux-dwarves@archiver.kernel.org>; Thu, 21 Jan 2021 13:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732256AbhAUN0W (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 21 Jan 2021 08:26:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:40384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731763AbhAUNYl (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Thu, 21 Jan 2021 08:24:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9D1BF22CBE;
        Thu, 21 Jan 2021 13:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611235440;
        bh=rwJXzhJMIhY1EDpt7GD6ssfobGNKXEQh5N/OFbzgjSI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HPrWRvjx+J8N4N4cImgTruqxZjR3uxg3/GcdWUDhiMYjyndzJEqmvmVwufbSOCzGn
         yLCbIDvwt2ptEMdKcGFq1R+teXGOuVuHyjN8DOjZMeFqiD/tlRXTOAagHyBMhgP+eH
         JOphNWq7kMaW/y+E/tzx12XTJb7MKnmi6gO7eDJYmSizEX0aVbR09gq79iuDvJoGT6
         Ap90DiQ9TqXuB41a471MI2q8Ilt76U+8WHwMHCdVYmV1vSLc/RfyZ4pV8m8EXiFYbz
         9j7gVqhCt0f7Db0trloxTjpVcE9QV1UcyqOo5Why0X8cr9ecUG378YhNSoFqTshhnP
         Rw5JgbhjnPPCQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7365440513; Thu, 21 Jan 2021 10:23:58 -0300 (-03)
Date:   Thu, 21 Jan 2021 10:23:58 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Giuliano Procida <gprocida@google.com>
Cc:     dwarves@vger.kernel.org, kernel-team@android.com,
        maennich@google.com, ast@kernel.org, andrii@kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH dwarves v2 3/3] btf_encoder: Set .BTF section alignment
 to 16
Message-ID: <20210121132358.GY12699@kernel.org>
References: <20210118160139.1971039-1-gprocida@google.com>
 <20210121113520.3603097-1-gprocida@google.com>
 <20210121113520.3603097-4-gprocida@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121113520.3603097-4-gprocida@google.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Thu, Jan 21, 2021 at 11:35:20AM +0000, Giuliano Procida escreveu:
> NOTE: Do not apply. I will try to eliminate the dependency on objcopy
> instead and achieve what's needed directly using libelf.

Ok, so I'll wait for the right fix.

Thanks for working on this!

- Arnaldo
 
> This is to avoid misaligned access when memory-mapping ELF sections.
> 
> Signed-off-by: Giuliano Procida <gprocida@google.com>
> ---
>  libbtf.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/libbtf.c b/libbtf.c
> index 7552d8e..2f12d53 100644
> --- a/libbtf.c
> +++ b/libbtf.c
> @@ -797,6 +797,14 @@ static int btf_elf__write(const char *filename, struct btf *btf)
>  			goto unlink;
>  		}
>  
> +		snprintf(cmd, sizeof(cmd), "%s --set-section-alignment .BTF=16 %s",
> +			 llvm_objcopy, filename);
> +		if (system(cmd)) {
> +			/* non-fatal, this is a nice-to-have and it's only supported from LLVM 10 */
> +			fprintf(stderr, "%s: warning: failed to align .BTF section in '%s': %d!\n",
> +				__func__, filename, errno);
> +		}
> +
>  		err = 0;
>  	unlink:
>  		unlink(tmp_fn);
> -- 
> 2.30.0.296.g2bfb1c46d8-goog
> 

-- 

- Arnaldo
