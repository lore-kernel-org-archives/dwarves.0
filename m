Return-Path: <SRS0=ASgQ=C6=vger.kernel.org=dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4872EC4363C
	for <linux-dwarves@archiver.kernel.org>; Mon, 21 Sep 2020 19:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D2322223E
	for <linux-dwarves@archiver.kernel.org>; Mon, 21 Sep 2020 19:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600718219;
	bh=KDVPHZRNRAofsnRLXnUHfWaXTMAgZ2R1MKwE1ZSwQto=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CNxlHQT8bXo4DY1b+u+N7QVY7D0KkiIthYxDKANOJ7HSa1LnqlX0L5q3wxPzv1UBU
	 KsKNnONBt7bZvF0XQQk2GkqXqSn1x2Zd9lrfghZq/RpHU9nCxvXV6Vgbs5FVYzsn+v
	 1jqZD66i89XHwo+BDnizMhebt0qvyVB1bnuQZrcw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbgIUT46 (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Mon, 21 Sep 2020 15:56:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:56348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728300AbgIUT44 (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Mon, 21 Sep 2020 15:56:56 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF7722193E;
        Mon, 21 Sep 2020 19:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600718216;
        bh=KDVPHZRNRAofsnRLXnUHfWaXTMAgZ2R1MKwE1ZSwQto=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JMtJ+6cbGWJZa+AwDNLdRthh4f4QrZUPEl+4YSDuE3c5G/wDRo2SFRmZ/YeGVisWO
         aOryKblsTZrQFpimIyzI50xCdQZ9y/OseAdonWShFj9FB9HOn0u6VOD5Hq7LetuGKs
         jJuxpMXznxQdm5JVVFxYH6eXGMNi4KDuFSOax8hs=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5EE72400E9; Mon, 21 Sep 2020 16:56:53 -0300 (-03)
Date:   Mon, 21 Sep 2020 16:56:53 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Hao Luo <haoluo@google.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        daniel@iogearbox.net, dwarves@vger.kernel.org, yhs@fb.com
Subject: Re: [PATCH v2 0/2] pahole: Make encoding percpu vars into BTF
 optional.
Message-ID: <20200921195653.GK1996959@kernel.org>
References: <20200921195310.3070085-1-haoluo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921195310.3070085-1-haoluo@google.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Mon, Sep 21, 2020 at 12:53:08PM -0700, Hao Luo escreveu:
> v1 -> v2:
>  - Use opt-out instead of opt-in. Rename the flag name to
>    '--skip_encoding_btf_vars'
> 
> Previous commit f3d9054ba8ff ("btf_encoder: Teach pahole to store
> percpu variables in vmlinux BTF.") introduced a feature in btf_encoder
> that encodes global symbols in BTF. However, this feature is not
> protected by any flag. In order to avoid surprises after Pahole v1.18
> rolls out, add a flag to toggle this feature off.
> 
> Also as a refactor, introduce '--btf_encode_force' to replace the
> old '--force' and '-j' option that is used to forcefully emit BTF.
> 
> Hao Luo (2):
>   btf_encoder: Allow disabling BTF var encoding.
>   btf_encoder: Introduce option '--btf_encode_force'
> 
>  btf_encoder.c |  5 ++++-
>  btf_encoder.h |  3 ++-
>  pahole.c      | 22 +++++++++++++++++-----
>  3 files changed, 23 insertions(+), 7 deletions(-)
> 
> -- 
> 2.28.0.681.g6f77f65b4e-goog

You forgot to update the man page, I'll do it this time,

Thanks

- Arnaldo
