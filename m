Return-Path: <SRS0=a5OZ=EB=vger.kernel.org=dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99128C388F9
	for <linux-dwarves@archiver.kernel.org>; Mon, 26 Oct 2020 20:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51087207E8
	for <linux-dwarves@archiver.kernel.org>; Mon, 26 Oct 2020 20:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603743764;
	bh=AUzbuuiYb+Pp9/sCXDkZCDHhT3cG75TD2a6mE5iGf80=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ayoc3brxOMs26U2I0b/V8y1fGmBgjvG5jtH2WHGHKDNt0FMgC4lpTfW0jjyT6xH0b
	 8q1VxBo74TbTX4cI5r6MV5Xep7nzXj/CPWgyxCe971DFbPivw4fKAS7QeU8aC2sVIt
	 IpR3z8DKyh0DZoqvP4AUT06C8UlEa8AXFrjnkbc8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731347AbgJZUWn (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Mon, 26 Oct 2020 16:22:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:56782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731295AbgJZUWm (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Mon, 26 Oct 2020 16:22:42 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E747521D41;
        Mon, 26 Oct 2020 20:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603743762;
        bh=AUzbuuiYb+Pp9/sCXDkZCDHhT3cG75TD2a6mE5iGf80=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gb4hjfSIbPtFarV8oRanyRBThSejxCsbC7mfhA1AIw2rCqfBr/Eg6z+w+Nldrivw3
         ydQhFvubTl4hd1FAV2HGsWblGufENBhsMLm5UPZXaG1YKjNmrOZgDpcXJ5opxzEXhK
         QRH+4SOIjTsNpowBwbIAVgkbILWBkCBrK4niMNKw=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 07952403C2; Mon, 26 Oct 2020 17:22:39 -0300 (-03)
Date:   Mon, 26 Oct 2020 17:22:39 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>, Hao Luo <haoluo@google.com>
Cc:     dwarves@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>
Subject: Re: btf_encoder: error: found variable in CU that has void type
Message-ID: <20201026202239.GF2449445@kernel.org>
References: <20201026201006.GE2449445@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026201006.GE2449445@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Mon, Oct 26, 2020 at 05:10:06PM -0300, Arnaldo Carvalho de Melo escreveu:
> Now with a correct subject :-)
> 
> Em Mon, Oct 26, 2020 at 04:58:30PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Hi guys,
> > 
> > 	I just stumbled on this, investigating... This is with what is
> > in the tmp branch at
> > git://git.kernel.org/pub/scm/devel/pahole/pahole.git.
> > 
> > error: found variable in CU '/home/acme/git/linux/security/selinux/hooks.c' that has void type
> > Encountered error while encoding BTF.
> >   LD      .tmp_vmlinux.kallsyms1
> >   KSYMS   .tmp_vmlinux.kallsyms1.S
> >   AS      .tmp_vmlinux.kallsyms1.S
> >   LD      .tmp_vmlinux.kallsyms2
> >   KSYMS   .tmp_vmlinux.kallsyms2.S
> >   AS      .tmp_vmlinux.kallsyms2.S
> >   LD      vmlinux
> >   BTFIDS  vmlinux
> > FAILED: load BTF from vmlinux: Unknown error -2make[1]: *** [/home/acme/git/linux/Makefile:1164: vmlinux] Error 255
> > make[1]: Leaving directory '/home/acme/git/build/v5.10.0-rc1+'
> > make: *** [Makefile:185: __sub-make] Error 2
> 
> It is something recent:
> 
> c815d26689313d8d7 (Hao Luo                  2020-08-24 17:45:23 -0700 440)              if (var->ip.tag.type == 0) {
> 2e719cca667212840 (Andrii Nakryiko          2020-10-08 16:39:57 -0700 441)                      fprintf(stderr, "error: found variable in CU '%s' that has void type\n",
> 2e719cca667212840 (Andrii Nakryiko          2020-10-08 16:39:57 -0700 442)                              cu->name);
> f3d9054ba8ff1df0f (Hao Luo                  2020-07-08 13:44:10 -0700 443)                      if (force)
> f3d9054ba8ff1df0f (Hao Luo                  2020-07-08 13:44:10 -0700 444)                              continue;
> f3d9054ba8ff1df0f (Hao Luo                  2020-07-08 13:44:10 -0700 445)                      err = -1;
> f3d9054ba8ff1df0f (Hao Luo                  2020-07-08 13:44:10 -0700 446)                      break;

Printing the variable name and address gives:

  LD      .tmp_vmlinux.btf
  BTF     .btf.vmlinux.bin.o
error: found variable "(null)" (addr: 0xffffffff82f4e260) in CU '/home/acme/git/linux/security/selinux/hooks.c' that has void type
Encountered error while encoding BTF.

Unsure if this is related:

[root@five ~]# gcc --version | head -1
gcc (GCC) 10.2.1 20200723 (Red Hat 10.2.1-1)
[root@five ~]#

[acme@five linux]$ readelf -sw ../build/v5.9.0+/vmlinux | grep ffffffff82f4e260
readelf: ../build/v5.9.0+/vmlinux: Error: LEB value too large
readelf: ../build/v5.9.0+/vmlinux: Error: LEB value too large
readelf: ../build/v5.9.0+/vmlinux: Error: LEB value too large
readelf: ../build/v5.9.0+/vmlinux: Error: LEB value too large
readelf: ../build/v5.9.0+/vmlinux: Error: LEB value too large
readelf: ../build/v5.9.0+/vmlinux: Error: LEB value too large
readelf: ../build/v5.9.0+/vmlinux: Error: LEB value too large
readelf: ../build/v5.9.0+/vmlinux: Error: LEB value too large
readelf: ../build/v5.9.0+/vmlinux: Error: LEB value too large
readelf: ../build/v5.9.0+/vmlinux: Error: LEB value too large
readelf: ../build/v5.9.0+/vmlinux: Error: LEB value too large
readelf: ../build/v5.9.0+/vmlinux: Error: LEB value too large

<SNIP lots more such lines>

- Arnaldo
