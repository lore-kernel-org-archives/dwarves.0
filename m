Return-Path: <SRS0=a5OZ=EB=vger.kernel.org=dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 012A6C388F9
	for <linux-dwarves@archiver.kernel.org>; Mon, 26 Oct 2020 20:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92E2B20780
	for <linux-dwarves@archiver.kernel.org>; Mon, 26 Oct 2020 20:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XZMZ706O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732066AbgJZUcq (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Mon, 26 Oct 2020 16:32:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43813 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732192AbgJZUcp (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Mon, 26 Oct 2020 16:32:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603744363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Gg/LTLBrH1uP5qfgpTlMyWX5R6ffeahGYiLJAeFyro8=;
        b=XZMZ706OWG/TDRwj4gUNz2iaHMCcvsytZNapPu6l4cJeP/w8XVlWpaJI8ZphA776CKQa2H
        omGXieEyjTDRD4bmS+QtwN0KkzSdi8DyYO70GuWxe6oBKgQ3t/vtw6SC7E8+r6GPBBgT+h
        YBGBo5MXRlgH0Z3QPSg0YIAZ3k4MTiQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-J8ltRZSaN4qolIKQ7Uom7w-1; Mon, 26 Oct 2020 16:32:41 -0400
X-MC-Unique: J8ltRZSaN4qolIKQ7Uom7w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E208800D53;
        Mon, 26 Oct 2020 20:32:40 +0000 (UTC)
Received: from krava (unknown [10.40.192.65])
        by smtp.corp.redhat.com (Postfix) with SMTP id DE49610013D9;
        Mon, 26 Oct 2020 20:32:38 +0000 (UTC)
Date:   Mon, 26 Oct 2020 21:32:38 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Andrii Nakryiko <andrii@kernel.org>, Hao Luo <haoluo@google.com>,
        dwarves@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH dwarves] cmake: make libbpf's Linux UAPI headers
Message-ID: <20201026203238.GH2726983@krava>
References: <20201026195830.GD2449445@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026195830.GD2449445@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Mon, Oct 26, 2020 at 04:58:30PM -0300, Arnaldo Carvalho de Melo wrote:
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

yep, I see the same and when I use --btf_encode_force,
it shows more of them:

error: found variable in CU 'arch/x86/kernel/cpu/mce/core.c' that has void type
error: found variable in CU 'security/selinux/hooks.c' that has void type
error: found variable in CU 'security/selinux/hooks.c' that has void type
error: found variable in CU 'security/selinux/hooks.c' that has void type
error: found variable in CU 'security/selinux/hooks.c' that has void type
error: found variable in CU 'security/selinux/hooks.c' that has void type
error: found variable in CU 'security/selinux/hooks.c' that has void type
error: found variable in CU 'drivers/platform/x86/intel_pmc_core.c' that has void type

I have no idea how variables are encoded in dwarf,
but I wonder it's another gcc bug ;-)

jirka

