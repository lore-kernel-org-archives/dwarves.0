Return-Path: <SRS0=a5OZ=EB=vger.kernel.org=dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948DCC4363A
	for <linux-dwarves@archiver.kernel.org>; Mon, 26 Oct 2020 20:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44E9821BE5
	for <linux-dwarves@archiver.kernel.org>; Mon, 26 Oct 2020 20:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603743023;
	bh=HpEwP7aoVhxa1G4+ivlXq8hN1z05mtX42iWzTROkNz0=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=eubDAKHoRkIOJ4+Bp6H5/1PbDjyAZD1fWCSP1ELzc4qrQvACfInJxC9rOUJb0v11u
	 nKjZqZYseUN0LXjIf3iMzXRcUzK1q5lU2PCVVZTkRhhWqJJvllAh/+lhGWp224DL/O
	 Mc82usValeVigJswtkeWTJMq5s+iOZeeXZAdQPN0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbgJZUKX (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Mon, 26 Oct 2020 16:10:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:52338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725927AbgJZUKJ (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Mon, 26 Oct 2020 16:10:09 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA4D021BE5;
        Mon, 26 Oct 2020 20:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603743009;
        bh=HpEwP7aoVhxa1G4+ivlXq8hN1z05mtX42iWzTROkNz0=;
        h=Date:From:To:Cc:Subject:From;
        b=ulUrEB2E3IajCeHQfjS57gBPrGsRG+NDKnjvr5mrB8BD46sjIncAuT3NyY6ezrOiX
         gYxTUQbJuCdTXPU1Mori4qKObkEpb4yGqxRrdb5WHvVMZIFWz24dQvcGko9s3AP4eE
         UWL2QBsTu7LPj35OGJMguNncV+XQa2cxWT81tOf4=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A86F2403C2; Mon, 26 Oct 2020 17:10:06 -0300 (-03)
Date:   Mon, 26 Oct 2020 17:10:06 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>, Hao Luo <haoluo@google.com>
Cc:     dwarves@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>
Subject: btf_encoder: error: found variable in CU that has void type
Message-ID: <20201026201006.GE2449445@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Now with a correct subject :-)

Em Mon, Oct 26, 2020 at 04:58:30PM -0300, Arnaldo Carvalho de Melo escreveu:
> Hi guys,
> 
> 	I just stumbled on this, investigating... This is with what is
> in the tmp branch at
> git://git.kernel.org/pub/scm/devel/pahole/pahole.git.
> 
> error: found variable in CU '/home/acme/git/linux/security/selinux/hooks.c' that has void type
> Encountered error while encoding BTF.
>   LD      .tmp_vmlinux.kallsyms1
>   KSYMS   .tmp_vmlinux.kallsyms1.S
>   AS      .tmp_vmlinux.kallsyms1.S
>   LD      .tmp_vmlinux.kallsyms2
>   KSYMS   .tmp_vmlinux.kallsyms2.S
>   AS      .tmp_vmlinux.kallsyms2.S
>   LD      vmlinux
>   BTFIDS  vmlinux
> FAILED: load BTF from vmlinux: Unknown error -2make[1]: *** [/home/acme/git/linux/Makefile:1164: vmlinux] Error 255
> make[1]: Leaving directory '/home/acme/git/build/v5.10.0-rc1+'
> make: *** [Makefile:185: __sub-make] Error 2

It is something recent:

c815d26689313d8d7 (Hao Luo                  2020-08-24 17:45:23 -0700 440)              if (var->ip.tag.type == 0) {
2e719cca667212840 (Andrii Nakryiko          2020-10-08 16:39:57 -0700 441)                      fprintf(stderr, "error: found variable in CU '%s' that has void type\n",
2e719cca667212840 (Andrii Nakryiko          2020-10-08 16:39:57 -0700 442)                              cu->name);
f3d9054ba8ff1df0f (Hao Luo                  2020-07-08 13:44:10 -0700 443)                      if (force)
f3d9054ba8ff1df0f (Hao Luo                  2020-07-08 13:44:10 -0700 444)                              continue;
f3d9054ba8ff1df0f (Hao Luo                  2020-07-08 13:44:10 -0700 445)                      err = -1;
f3d9054ba8ff1df0f (Hao Luo                  2020-07-08 13:44:10 -0700 446)                      break;

- Arnaldo
