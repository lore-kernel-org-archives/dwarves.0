Return-Path: <dwarves-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28841C001DE
	for <linux-dwarves@archiver.kernel.org>; Thu, 27 Jul 2023 01:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjG0BvS (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Wed, 26 Jul 2023 21:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbjG0BvO (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Wed, 26 Jul 2023 21:51:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3816A271F
        for <dwarves@vger.kernel.org>; Wed, 26 Jul 2023 18:51:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C134661CEC
        for <dwarves@vger.kernel.org>; Thu, 27 Jul 2023 01:51:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E33C433C7;
        Thu, 27 Jul 2023 01:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690422667;
        bh=n318czXBvmsiuPQF5pqoA8pZBhMi3vK7TNvEem/rIbo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nLQFAVCymAeBc0wAfa5yMZG4XoFIhJpjTTsJampE8/k9JeW40e+aH+qLDjj0xIpvG
         5ARxiMfCY23MlKQX7Oc+sCbxWltpAGC/twl/u8mMD+dHrcgVdw7lEA2j0seUup7lgl
         wc7okrmGrSKP7VeNchMsaSvIkwwyovIXfVSMIUo5EQauETGbgEsmOo3VFBHV6q6wJU
         K8NzqzXtzmnpEvTDN6BIt4hdk9uSpl29xybPlmDq0JImuvQTuNZ1WrKIS0gd1V8tQ7
         7o2NeZ5VKfux1R1kug2BPmmIKx/ZbxoXJH19SIazqPGRN+jM1KtJdYEjc8pY2HeVg9
         QuN18+HF+3fnA==
Date:   Thu, 27 Jul 2023 10:51:02 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc:     Alan Maguire <alan.maguire@oracle.com>,
        Jiri Olsa <olsajiri@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Yonghong Song <yhs@fb.com>, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RESEND] BTF is not generated for gcc-built kernel with the
 latest pahole
Message-Id: <20230727105102.509161e1f57fd0b49e98b844@kernel.org>
In-Reply-To: <20230727093814.23681b2b0ac73aa89f368ae8@kernel.org>
References: <20230726102534.9ebc4678ad2c9395cc9be196@kernel.org>
        <ZMDvmLdZSLi2QqB+@krava>
        <20230726200716.609d8433a7292eead95e7330@kernel.org>
        <6f0da094-5b49-954b-21e9-93f8c8cecc3f@oracle.com>
        <20230727093814.23681b2b0ac73aa89f368ae8@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Thu, 27 Jul 2023 09:38:14 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > Yep, BPF generation is more selective about what it emits in 1.25 to
> > avoid cases where a kernel function signature is ambiguous (multiple
> > functions of the same name with different signatures) or where it has
> > unexpected register use. You can observe this via pahole's --verbose
> > option (a lot of outut is emitted):
> > 
> > In a built kernel directory (where unstripped vmlinux is present):
> > $ PAHOLE_FLAGS=$(./scripts/pahole_flags)
> > $ PAHOLE=/usr/local/bin/pahole
> > $ pahole --verbose -J $PAHOLE_FLAGS vmlinux > /tmp/pahole.out
> 
> So this will generate BTF from vmlinux DWARF info.
> 
> > If you want to investigate why a function has been left out, look for
> > "skipping" verbose output like this:
> > 
> > skipping addition of 'access_error'(access_error) due to multiple
> > inconsistent function prototypes
> > skipping addition of
> > 'acpi_ex_convert_to_object_type_string'(acpi_ex_convert_to_object_type_string.isra.0)
> > due to unexpected register used for parameter
> 
> Ah, that's nice. Let me try.

$ pahole --version 
v1.23

$ pahole --verbose -J $PAHOLE_FLAGS vmlinux > /tmp/pahole.out
die__process: DW_TAG_compile_unit, DW_TAG_type_unit, DW_TAG_partial_unit or DW_TAG_skeleton_unit expected got INVALID (0x0)!

OK, so something failed.

$ grep skipping /tmp/pahole.out  | wc -l
0

Nothing to be skipped.

$ grep -w kfree /tmp/pahole.out | wc -l
0
$ grep -w vfs_read /tmp/pahole.out | wc -l
0

But both kfree and vfs_read are not found.

$ perf probe -k ./vmlinux -V kfree
Available variables at kfree
        @<kfree+0>
                (unknown_type)  object
$ perf probe -k ./vmlinux -V vfs_read
Available variables at vfs_read
        @<vfs_read+0>
                char*   buf
                loff_t* pos
                size_t  count
                struct file*    file

However, perf probe can find both in the DWARF info.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
