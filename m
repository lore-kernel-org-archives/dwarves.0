Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04891ECAA27
	for <linux-dwarves@archiver.kernel.org>; Thu, 25 Aug 2022 17:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235860AbiHYRQY (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 25 Aug 2022 13:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233066AbiHYRQX (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Thu, 25 Aug 2022 13:16:23 -0400
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F3A2A51A14;
        Thu, 25 Aug 2022 10:16:21 -0700 (PDT)
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id E2C7872C90B;
        Thu, 25 Aug 2022 20:16:20 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 599894A470D;
        Thu, 25 Aug 2022 20:16:20 +0300 (MSK)
Date:   Thu, 25 Aug 2022 20:16:20 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Martin Reboredo <yakoyoku@gmail.com>
Subject: Re: pahole v1.24: FAILED: load BTF from vmlinux: Invalid argument
Message-ID: <20220825171620.cioobudss6ovyrkc@altlinux.org>
References: <20220825163538.vajnsv3xcpbhl47v@altlinux.org>
 <CA+JHD904e2TPpz1ybsaaqD+qMTDcueXu4nVcmotEPhxNfGN+Gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <CA+JHD904e2TPpz1ybsaaqD+qMTDcueXu4nVcmotEPhxNfGN+Gw@mail.gmail.com>
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Arnaldo,

On Thu, Aug 25, 2022 at 01:47:59PM -0300, Arnaldo Carvalho de Melo wrote:
> On Thu, Aug 25, 2022, 1:35 PM Vitaly Chikunov <vt@altlinux.org> wrote:
> >
> > I also noticed that after upgrading pahole to v1.24 kernel build (tested on
> > v5.18.19, v5.15.63, sorry for not testing on mainline) fails with:
> >
> >     BTFIDS  vmlinux
> >   + ./tools/bpf/resolve_btfids/resolve_btfids vmlinux
> >   FAILED: load BTF from vmlinux: Invalid argument
> >
> > Perhaps, .tmp_vmlinux.btf is generated incorrectly? Downgrading dwarves to
> > v1.23 resolves the issue.
> >
> 
> Can you try this, from Martin Reboredo (Archlinux):
> 
> Can you try a build of the kernel or the by passing the
> --skip_encoding_btf_enum64 to scripts/pahole-flags.sh?
> 
> Here's a patch for either in tree scripts/pahole-flags.sh or
> /usr/lib/modules/5.19.3-arch1-1/build/scripts/pahole-flags.sh

This patch helped and kernel builds successfully after applying it.
(Didn't notice this suggestion in release discussion thread.)

Thanks!

> 
> diff --git a/scripts/pahole-flags.sh b/scripts/pahole-flags.sh
> index 0d99ef17e4a528..1f1f1d397c399a 100755
> --- a/scripts/pahole-flags.sh
> +++ b/scripts/pahole-flags.sh
> @@ -19,5 +19,9 @@ fi
>  if [ "${pahole_ver}" -ge "122" ]; then
>         extra_paholeopt="${extra_paholeopt} -j"
>  fi
> +if [ "${pahole_ver}" -ge "124" ]; then
> +       # see PAHOLE_HAS_LANG_EXCLUDE
> +       extra_paholeopt="${extra_paholeopt} --skip_encoding_btf_enum64"
> +fi
> 
>  echo ${extra_paholeopt}
> 
> >
> > Thanks,
> >
> >
