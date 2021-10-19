Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C8FC433EF
	for <linux-dwarves@archiver.kernel.org>; Tue, 19 Oct 2021 15:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E762461074
	for <linux-dwarves@archiver.kernel.org>; Tue, 19 Oct 2021 15:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbhJSPZ6 (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 19 Oct 2021 11:25:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:44184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232316AbhJSPZ5 (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Tue, 19 Oct 2021 11:25:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8764160F25;
        Tue, 19 Oct 2021 15:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634657025;
        bh=tNRZ3IAH4InCFRa+LJXNMiMyhqk1pcGk5Sjb0G3qUXo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eNXfSPi5hgQ3KZt4l9YegVObUt1ucya9q/Zy/rtPcf1b19eXs/nSOv/5Gvasc/Fc0
         vocROxyddAtu5REk7LPyjdG/DxCWIzTMUsJlGurE1X8ss+sqijGIOyGg5oqscMlDVF
         +M41nzYcHhO9wnU9mbXfRyfj/FJznTaydJXhYVkwOG8LHalvm85k3H8qAXzA94aSFb
         93Y+3FJjlRjnqzDM80BGnrOz+lc/XSrjVQIapJQlkTPMoLWH+S26UNQzwYn/Iju132
         b6T8IoEP4vm9CDJxH2PHVjlmQ855v8Ymu/zd2L3wZask4xMKIkSwy0poLDUc8loJKE
         Ai6xKOhm5L9rA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5787B410A1; Tue, 19 Oct 2021 12:23:41 -0300 (-03)
Date:   Tue, 19 Oct 2021 12:23:41 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Douglas RAILLARD <douglas.raillard@arm.com>
Cc:     acme@redhat.com, dwarves@vger.kernel.org
Subject: Re: [PATCH v1] pahole: Add --skip_missing option
Message-ID: <YW7i/VgB9H15l+45@kernel.org>
References: <20211019104200.334089-1-douglas.raillard@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019104200.334089-1-douglas.raillard@arm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Tue, Oct 19, 2021 at 11:42:00AM +0100, Douglas RAILLARD escreveu:
> From: Douglas Raillard <douglas.raillard@arm.com>
> 
> Add a --skip_missing option that allows pahole to keep going in case one
> of the type passed to -C (e.g. via a file) does not exist.
> 
> This is useful for intropsection software such as debugging kernel
> modules that can handle various kernel configurations and versions for
> which some recently added types are missing. The consumer of the header
> becomes responsible of gating the uses of the type with #ifdef
> CONFIG_XXX, rather than pahole bailing out on the first unknown type.

Cherry picking this out of order, as its easy to review:

Committer testing:

Before:

  $ pahole tcp_splice_state,xxfrm_policy_queue,list_head tcp.o
  struct tcp_splice_state {
        struct pipe_inode_info *   pipe;                 /*     0     8 */
        size_t                     len;                  /*     8     8 */
        unsigned int               flags;                /*    16     4 */

        /* size: 24, cachelines: 1, members: 3 */
        /* padding: 4 */
        /* last cacheline: 24 bytes */
  };
  pahole: type 'xxfrm_policy_queue' not found
  $

After:

  $ pahole --help |& grep skip
        --skip=COUNT           Skip COUNT input records
        --skip_encoding_btf_tag   Do not encode TAGs in BTF.
        --skip_encoding_btf_vars   Do not encode VARs in BTF.
        --skip_missing         skip missing types passed to -C rather than stop
  $ pahole --skip_missing tcp_splice_state,xxfrm_policy_queue,list_head tcp.o
  struct tcp_splice_state {
        struct pipe_inode_info *   pipe;                 /*     0     8 */
        size_t                     len;                  /*     8     8 */
        unsigned int               flags;                /*    16     4 */

        /* size: 24, cachelines: 1, members: 3 */
        /* padding: 4 */
        /* last cacheline: 24 bytes */
  };
  struct list_head {
        struct list_head *         next;                 /*     0     8 */
        struct list_head *         prev;                 /*     8     8 */

        /* size: 16, cachelines: 1, members: 2 */
        /* last cacheline: 16 bytes */
  };
  pahole: type 'xxfrm_policy_queue' not found
  $

Signed-off-by: Douglas Raillard <douglas.raillard@arm.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
 
> Signed-off-by: Douglas Raillard <douglas.raillard@arm.com>
> ---
>  dwarves.h |  2 ++
>  pahole.c  | 17 +++++++++++++++--
>  2 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/dwarves.h b/dwarves.h
> index 30d33fa..6be6094 100644
> --- a/dwarves.h
> +++ b/dwarves.h
> @@ -43,6 +43,7 @@ struct conf_fprintf;
>   * @get_addr_info - wheter to load DW_AT_location and other addr info
>   * @nr_jobs - -j argument, number of threads to use
>   * @ptr_table_stats - print developer oriented ptr_table statistics.
> + * @skip_missing - skip missing types rather than bailing out.
>   */
>  struct conf_load {
>  	enum load_steal_kind	(*steal)(struct cu *cu,
> @@ -59,6 +60,7 @@ struct conf_load {
>  	bool			ignore_labels;
>  	bool			ptr_table_stats;
>  	bool			skip_encoding_btf_tag;
> +	bool			skip_missing;
>  	uint8_t			hashtable_bits;
>  	uint8_t			max_hashtable_bits;
>  	uint16_t		kabi_prefix_len;
> diff --git a/pahole.c b/pahole.c
> index 80271b5..68e3c8a 100644
> --- a/pahole.c
> +++ b/pahole.c
> @@ -1125,6 +1125,7 @@ ARGP_PROGRAM_VERSION_HOOK_DEF = dwarves_print_version;
>  #define ARGP_hashbits		   329
>  #define ARGP_devel_stats	   330
>  #define ARGP_skip_encoding_btf_tag 331
> +#define ARGP_skip_missing          332
>  
>  static const struct argp_option pahole__options[] = {
>  	{
> @@ -1500,6 +1501,11 @@ static const struct argp_option pahole__options[] = {
>  		.key  = ARGP_skip_encoding_btf_tag,
>  		.doc  = "Do not encode TAGs in BTF."
>  	},
> +	{
> +		.name = "skip_missing",
> +		.key  = ARGP_skip_missing,
> +		.doc = "skip missing types passed to -C rather than stop",
> +	},
>  	{
>  		.name = NULL,
>  	}
> @@ -1650,6 +1656,8 @@ static error_t pahole__options_parser(int key, char *arg,
>  		conf_load.ptr_table_stats = true;	break;
>  	case ARGP_skip_encoding_btf_tag:
>  		conf_load.skip_encoding_btf_tag = true;	break;
> +	case ARGP_skip_missing:
> +		conf_load.skip_missing = true;          break;
>  	default:
>  		return ARGP_ERR_UNKNOWN;
>  	}
> @@ -2879,8 +2887,13 @@ out_btf:
>  		static type_id_t class_id;
>  		struct tag *class = cu__find_type_by_name(cu, prototype->name, include_decls, &class_id);
>  
> -		if (class == NULL)
> -			return ret; // couldn't find that class name in this CU, continue to the next one.
> +		// couldn't find that class name in this CU, continue to the next one.
> +		if (class == NULL) {
> +			if (conf_load->skip_missing)
> +				continue;
> +			else
> +				return ret;
> +		}
>  
>  		if (prototype->nr_args != 0 && !tag__is_struct(class)) {
>  			fprintf(stderr, "pahole: attributes are only supported with 'class' and 'struct' types\n");
> -- 
> 2.25.1

-- 

- Arnaldo
