Return-Path: <SRS0=Qbgy=EC=vger.kernel.org=dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96CACC388F9
	for <linux-dwarves@archiver.kernel.org>; Tue, 27 Oct 2020 11:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 299AE22258
	for <linux-dwarves@archiver.kernel.org>; Tue, 27 Oct 2020 11:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HzhqbgLG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899138AbgJ0LUo (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 27 Oct 2020 07:20:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44374 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2437789AbgJ0LUo (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Tue, 27 Oct 2020 07:20:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603797643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jhcepl2Gc4bv8fvUBz+22NMGHe4dbWimGzGg0IEIYvQ=;
        b=HzhqbgLGrMk40GfJU0vBUB4ejdQOTNHLwgzCmUiSiER49I/T0qQE5q4W9Q3tCC70sw6snF
        enSVNErieWAXJ78oigQsm30tr+FsH9IBVUpX/AhkkDPiEgnAwMTB0VMRjDzPk2qIdvOY/6
        Syc26HfLQvzwsv2xHOJTlOCpCLWq+bo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-9YQgOWrUOQOC1SQhIiOIRg-1; Tue, 27 Oct 2020 07:20:41 -0400
X-MC-Unique: 9YQgOWrUOQOC1SQhIiOIRg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BE3CE10877AA;
        Tue, 27 Oct 2020 11:20:23 +0000 (UTC)
Received: from krava (unknown [10.40.195.208])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5EE255C1BB;
        Tue, 27 Oct 2020 11:20:22 +0000 (UTC)
Date:   Tue, 27 Oct 2020 12:20:21 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Hao Luo <haoluo@google.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>, dwarves@vger.kernel.org
Subject: Re: [PATCH] btf_encoder: Check var type after checking var addr.
Message-ID: <20201027112021.GA2900849@krava>
References: <20201026221822.29021-1-haoluo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026221822.29021-1-haoluo@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Mon, Oct 26, 2020 at 03:18:22PM -0700, Hao Luo wrote:
> Commit 2e719cc ("btf_encoder: revamp how per-CPU variables are
> encoded") adds percpu_var_exists() to filter out the symbols that
> are not percpu var. However, the check comes after checking the
> var's type. There can be symbols that are of zero type. If we hit
> that, btf_encoder will not work without '--btf_encode_force'.
> So we should check percpu_var_exists before checking var's type.
> 
> Tested:
>  haoluo@haoluo:~/kernel/tip$ gcc --version
>  gcc (GCC) 10.2.0
>  Copyright (C) 2020 Free Software Foundation, Inc.
>  This is free software; see the source for copying conditions.  There is NO
>  warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> 
>  Before:
> 
>  haoluo@haoluo:~/kernel/tip$ make clean -s
>  haoluo@haoluo:~/kernel/tip$ make -j 32 -s
>    LINK     resolve_btfids
>  error: found variable in CU 'kernel/bpf/btf.c' that has void type
>  Encountered error while encoding BTF.
>  FAILED: load BTF from vmlinux: Unknown error -2make: *** [Makefile:1164: vmlinux] Error 255
> 
>  After:
> 
>  haoluo@haoluo:~/kernel/tip$ make clean -s
>  haoluo@haoluo:~/kernel/tip$ make -j 32 -s
>    LINK     resolve_btfids
>  haoluo@haoluo:~/kernel/tip$
> 
> Fixes: 2e719cc ("btf_encoder: revamp how per-CPU variables are encoded")
> Signed-off-by: Hao Luo <haoluo@google.com>

it fixes the build issue for me

Tested-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

