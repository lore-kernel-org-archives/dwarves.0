Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6E8C433F5
	for <linux-dwarves@archiver.kernel.org>; Mon, 27 Sep 2021 20:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9113B610FC
	for <linux-dwarves@archiver.kernel.org>; Mon, 27 Sep 2021 20:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236529AbhI0Ulx (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Mon, 27 Sep 2021 16:41:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:49772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236008AbhI0Ulw (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Mon, 27 Sep 2021 16:41:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7469561074;
        Mon, 27 Sep 2021 20:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632775214;
        bh=imJS+qvkvG0sboLoVEFe01IdzYd32VMnqJ0csQGrtSM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WUyQUIt/SmJytNJTBSlsmjth0p7wpBi6WDdP8h5oIi9Q0DGnsrXJ88vz2VYYGY+GM
         droVe1hHzpuCEi199bwcRbzgjajYu/PAGt7ct0xrUkqQpkFP2yAEBtgL8KogSv4Ri5
         PJU/7mlf5UCaDfnC+XyPoFcerDFQcakusRRBIvmIKI5ZicertPTJ1ToFvI9pdbTA3g
         HXYtq7ZusRWDgNa8WmhhiPrEhnEg+mkzHRu2yz4u/zCFkB7X3LTJFTHh+0l1TAaEDP
         WiBL5rMahTXxMYnIx5TOcl3C9jCQvrnW2cMJwiI7RwFC5MgC2YmhLhcMehP67wnde1
         NNhxj1uZ55djw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E7CB0410A1; Mon, 27 Sep 2021 17:40:09 -0300 (-03)
Date:   Mon, 27 Sep 2021 17:40:09 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Yonghong Song <yhs@fb.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
Subject: Re: [PATCH dwarves v2 0/2] generate BTF_KIND_TAG types from
 DW_TAG_LLVM_annotation dwarf tags
Message-ID: <YVIsKZTWlDugv3Yz@kernel.org>
References: <20210922021321.2286360-1-yhs@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210922021321.2286360-1-yhs@fb.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Tue, Sep 21, 2021 at 07:13:21PM -0700, Yonghong Song escreveu:
> LLVM has implemented btf_tag attribute ([1]) which intended
> to provide a "string" tag for struct/union or its member, var,
> a func or its parameter. Such a "string" tag will be encoded
> in dwarf. For non-BPF target like x86_64, pahole needs to
> convert those dwarf btf_tag annotations to BTF so kernel
> can utilize these "string" tags for bpf program verification, etc.
>         
> Patch 1 enhanced dwarf_loader to encode DW_TAG_LLVM_annotation
> tags into internal data structure and Patch 2 will encode
> such information to BTF with BTF_KIND_TAGs.
> 
>  [1] https://reviews.llvm.org/D106614

Applied both locally, now building HEAD llvm/clang to test everything,

- Arnaldo
 
> Changelog:
>   v1 -> v2:
>     - handle returning error cases for btf_encoder__add_tag().
> 
> Yonghong Song (2):
>   dwarf_loader: parse dwarf tag DW_TAG_LLVM_annotation
>   btf_encoder: generate BTF_KIND_TAG from llvm annotations
> 
>  btf_encoder.c  | 63 ++++++++++++++++++++++++++++++++++++-
>  dwarf_loader.c | 85 ++++++++++++++++++++++++++++++++++++++++++++++----
>  dwarves.h      | 10 ++++++
>  pahole.c       |  8 +++++
>  4 files changed, 159 insertions(+), 7 deletions(-)
> 
> -- 
> 2.30.2

-- 

- Arnaldo
