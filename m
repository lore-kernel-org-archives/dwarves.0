Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF146C433DB
	for <linux-dwarves@archiver.kernel.org>; Tue,  9 Mar 2021 11:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EAF06523C
	for <linux-dwarves@archiver.kernel.org>; Tue,  9 Mar 2021 11:49:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbhCILtA (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 9 Mar 2021 06:49:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:53666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229599AbhCILsk (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Tue, 9 Mar 2021 06:48:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B29536523C;
        Tue,  9 Mar 2021 11:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615290520;
        bh=Rg4U517f0o635xHKAtTkB2QRMgJDxt+Ih7wt9Ualf1w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GdeHIJwEnCraWY3fOmycd+ks/zSxlVWSfiIE7M7i3kANljUsjv1so4GO6Wmzo63Uo
         56nqhMx7o1m411xBKxKTfOQNlAMU2mEXKHNaItAvCj8JPGBA9k5LarQr9fP+xjQiOE
         am6kxpk33GKM22NRYW+PUhu+ZKGu93DFG0MQD+xUvfqrGV9cvgpcy8+EtZ6q4/gwQ6
         OJlFqHiee81ThEv0HdCogx4tk539SlZ6GK8GkGfH1Ha5NQFYbUEBXKW3maOtIjfB8H
         kavbalVKve87rDUcjAd/B39BS+cXugZaMf7DOqIHm+JdIV9b2o+s4vNl17wunhf1c8
         yd4TUcpZTJ+fg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CB14040647; Tue,  9 Mar 2021 08:48:36 -0300 (-03)
Date:   Tue, 9 Mar 2021 08:48:36 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH dwarves v2] btf: Add support for the floating-point types
Message-ID: <YEdglMDZvplD6ELk@kernel.org>
References: <20210308235913.162038-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210308235913.162038-1-iii@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Tue, Mar 09, 2021 at 12:59:13AM +0100, Ilya Leoshkevich escreveu:
> Some BPF programs compiled on s390 fail to load, because s390
> arch-specific linux headers contain float and double types.
> 
> Fix as follows:
> 
> - Make the DWARF loader fill base_type.float_type.
> 
> - Introduce libbpf compatibility level command-line parameter, so that
>   pahole could be used to build both the older and the newer kernels.
> 
> - libbpf introduced the support for the floating-point types in commit
>   986962fade5, so update the libbpf submodule to that version and use
>   the new btf__add_float() function in order to emit the floating-point
>   types when not in the compatibility mode and base_type.float_type is
>   set.
> 
> - Make the BTF loader recognize the new BTF kind.
> 
> Example of the resulting entry in the vmlinux BTF:
> 
>     [7164] FLOAT 'double' size=8
> 
> when building with:
> 
>     LLVM_OBJCOPY=${OBJCOPY} ${PAHOLE} -J ${1} --libbpf_compat=0.4.0

I'm testing it now, and added as a followup patch the man page entry,
please check that the wording is appropriate.

Thanks,

- Arnaldo

[acme@five pahole]$ vim man-pages/pahole.1
[acme@five pahole]$ git diff
diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
index 352bb5e45f319da4..787771753d1933b1 100644
--- a/man-pages/pahole.1
+++ b/man-pages/pahole.1
@@ -199,6 +199,12 @@ Path to the base BTF file, for instance: vmlinux when encoding kernel module BTF
 This may be inferred when asking for a /sys/kernel/btf/MODULE, when it will be autoconfigured
 to "/sys/kernel/btf/vmlinux".

+.TP
+.B \-\-libbpf_compat=LIBBPF_VERSION
+Produce output compatible with this libbpf version. For instance, specifying 0.4.0 as
+the version would encode BTF_KIND_FLOAT entries in systems where the vmlinux DWARF
+information has float types.
+
 .TP
 .B \-l, \-\-show_first_biggest_size_base_type_member
 Show first biggest size base_type member.
[acme@five pahole]$
