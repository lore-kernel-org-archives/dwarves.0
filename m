Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ADB9C43618
	for <linux-dwarves@archiver.kernel.org>; Mon, 17 May 2021 15:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E7B561108
	for <linux-dwarves@archiver.kernel.org>; Mon, 17 May 2021 15:46:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244923AbhEQPrV (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Mon, 17 May 2021 11:47:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:51390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243367AbhEQPnm (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Mon, 17 May 2021 11:43:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6D0CD61D1F;
        Mon, 17 May 2021 14:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621262574;
        bh=3z9OmQUb6j5Vj3qBOT7GkI09mz5Y0J5Fgfc/Ytm8dMA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ap9lGM3ThFYMWAezz5no18hV6Q+ZfRKUT9qhJBHdO13/3rhnMxMkY1e2DkMwPa0Bv
         68i6mZ12YkWVAp64C17ucc8WQy5jSWaI5eQA0+qLY+5AQ8gdF/PzlBJM47CKWwgTFk
         vsZA5f6XUBdzBuJR0/3liI220kVCoO/hCYYhpAdULMyoqFl88PBFkIDhAgTqtcDSkj
         gwvJxz+UJWlA/3ECK66MrtDQLvK0J3jJC5EGD0qC/b8pcUVYu1e3gbexW9zMyMruoQ
         5qIHgXul+lJHaKiyj2JtN1pNIEcAqwPW+lSdLs/3Xw4LKiA3pfIe6eJkf9V10J/2K5
         JYyGXZjZTZiKg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4C8D74034C; Mon, 17 May 2021 11:42:51 -0300 (-03)
Date:   Mon, 17 May 2021 11:42:51 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     =?utf-8?B?56iL5Lmm5oSP?= <chengshuyi@linux.alibaba.com>
Cc:     dwarves@vger.kernel.org, wenan.mao@linux.alibaba.com,
        Jiri Olsa <jolsa@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: Re: [PATCH] btf: Add --btf_prefix flag
Message-ID: <YKKA64WWqYN3P7YJ@kernel.org>
References: <a249699a-7c6c-4d4a-71b0-87981c8d229e@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a249699a-7c6c-4d4a-71b0-87981c8d229e@linux.alibaba.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Mon, May 17, 2021 at 08:06:30PM +0800, 程书意 escreveu:
> To solve problems similar to _RH_KABI_REPLACE, _RH_KABI_REPLACE makes many

Can you explain what is _RH_KABI_REPLACE, why it is needed so that
people unfamiliar with it can make sense of your patch?

Also why "btf_prefix" when this is related to this other feature? Can
you find a better name?

You also forgot to update the man page at man-pages/pahole.1.

- Arnaldo

> structures have different names, resulting in a
> particularly large vmlinux btf. For example, running ./pahole -J
> vmlinux-3.10.0-1160.el7.x86_64 without --btf_prefix flag,
> the running time is:
>                 real 8m28.912s
>                 user 8m27.271s
>                 sys 0m1.471s
> And the size of the generated btf segment is 30678240 bytes.
> 
> After adding the patch, running ./pahole
> --btf_prefix=__UNIQUE_ID_rh_kabi_hide -J vmlinux-3.10.0-1160.el7.x86_64. The
> running
> time of the command is:
>                 real 0m19.634s
>                 user 0m18.457s
>                 sys 0m1.169s
> The size of the generated btf segment is 3117719 bytes.
> 
> Thanks.
> 
> Signed-off-by: chengshuyi <chengshuyi@linux.alibaba.com>
> ---
>  pahole.c         | 10 ++++++++++
>  pahole_strings.h |  2 ++
>  strings.c        |  9 +++++++--
>  3 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/pahole.c b/pahole.c
> index dc40ccf..0b4f4ca 100644
> --- a/pahole.c
> +++ b/pahole.c
> @@ -24,6 +24,7 @@
>  #include "btf_encoder.h"
>  #include "libbtf.h"
>  #include "lib/bpf/src/libbpf.h"
> +#include "pahole_strings.h"
> 
>  static bool btf_encode;
>  static bool ctf_encode;
> @@ -855,6 +856,7 @@ ARGP_PROGRAM_VERSION_HOOK_DEF = dwarves_print_version;
>  #define ARGP_btf_gen_floats       322
>  #define ARGP_btf_gen_all       323
>  #define ARGP_with_flexible_array   324
> +#define ARGP_btf_prefix   325
> 
>  static const struct argp_option pahole__options[] = {
>      {
> @@ -1140,6 +1142,12 @@ static const struct argp_option pahole__options[] = {
>          .doc  = "Path to the base BTF file",
>      },
>      {
> +        .name = "btf_prefix",
> +        .key = ARGP_btf_prefix,
> +        .arg = "STRING",
> +        .doc = "Strings with the same prefix are considered the same.",
> +    },
> +    {
>          .name = "btf_encode",
>          .key  = 'J',
>          .doc  = "Encode as BTF",
> @@ -1297,6 +1305,8 @@ static error_t pahole__options_parser(int key, char
> *arg,
>          btf_encode_force = true;        break;
>      case ARGP_btf_base:
>          base_btf_file = arg;            break;
> +    case ARGP_btf_prefix:
> +        btf_prefix = arg;        break;
>      case ARGP_numeric_version:
>          print_numeric_version = true;        break;
>      case ARGP_btf_gen_floats:
> diff --git a/pahole_strings.h b/pahole_strings.h
> index 522fbf2..bf3dc7c 100644
> --- a/pahole_strings.h
> +++ b/pahole_strings.h
> @@ -14,6 +14,8 @@ struct strings {
>      struct btf *btf;
>  };
> 
> +extern const char *btf_prefix;
> +
>  struct strings *strings__new(void);
> 
>  void strings__delete(struct strings *strings);
> diff --git a/strings.c b/strings.c
> index d37f49d..911ce25 100644
> --- a/strings.c
> +++ b/strings.c
> @@ -16,6 +16,9 @@
> 
>  #include "dutil.h"
>  #include "lib/bpf/src/libbpf.h"
> +#include "libbtf.h"

Why do you need to add this new include? I guess you meant including
pahole_strings.h to get the forward declaration for 'btf_prefix'?

> +
> +const char *btf_prefix;
> 
>  struct strings *strings__new(void)
>  {
> @@ -47,8 +50,10 @@ strings_t strings__add(struct strings *strs, const char
> *str)
> 
>      if (str == NULL)
>          return 0;
> -
> -    index = btf__add_str(strs->btf, str);
> +    if(btf_prefix && strncmp(str,btf_prefix,strlen(btf_prefix))==0)

Please also follow the existing coding style, i.e. use a space after
'if' and also after the commas.

- Arnaldo

> +        index = btf__add_str(strs->btf, btf_prefix);
> +    else
> +        index = btf__add_str(strs->btf, str);
>      if (index < 0)
>          return 0;
> 
> -- 
> 1.8.3.1
> 
> 

-- 

- Arnaldo
