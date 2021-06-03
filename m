Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD2FC47096
	for <linux-dwarves@archiver.kernel.org>; Thu,  3 Jun 2021 15:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 681CD60FF0
	for <linux-dwarves@archiver.kernel.org>; Thu,  3 Jun 2021 15:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbhFCPS1 (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 3 Jun 2021 11:18:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:49676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232181AbhFCPSZ (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Thu, 3 Jun 2021 11:18:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8C80760E09;
        Thu,  3 Jun 2021 15:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622733399;
        bh=RbTJtwehHPUCZ5OIDX5oEa46lygMDLWG25VY+Qeez4s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YIN8PTcGdvmne8uIUV8DcNElRcaajwtTe+NF9wQ+pKJQC78LKMdkDfTxlFqLj+q9O
         0L23mI6w4FX9UpS16DHPcVUWFFY6R0YuJGr8NzseZgJtL3oZ9yONQAqvzWGEYvyWXP
         6iaiKwANZ4Xiaf6BUxXD0vaPo8XBBoaruGIqDyLwllvxKOgJEdwtBen0gndaJOFyCu
         scwlARpSp/GXUPcjmJN64VGGpEIgxotwEHEKQ92WROhgev+WR7SLGas/llURVe4Mfj
         67MIsXQ5swoD+4yVbmCNatao0u69mTPAvL9S6rl9dGOIhlKk0H5uv4OJmvK8v5i0Wx
         3/2s20p2cQKHQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3C60840EFC; Thu,  3 Jun 2021 12:16:37 -0300 (-03)
Date:   Thu, 3 Jun 2021 12:16:37 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Deepak Kumar Mishra <deepakkumar.mishra@arm.com>
Cc:     dwarves@vger.kernel.org, qais.yousef@arm.com
Subject: Re: [PATCH 2/2] README: add documentation for -DBUILD_SHARED_LIBS
Message-ID: <YLjyVQXwd9TajVfr@kernel.org>
References: <cover.1622612388.git.deepakkumar.mishra@arm.com>
 <6307fc26935026e9c9a765ae2f0f50226c891d34.1622612388.git.deepakkumar.mishra@arm.com>
 <YLeFM9VnG/kBwlB2@kernel.org>
 <7150cf9b-345e-dc38-4c60-1e51155ed69c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7150cf9b-345e-dc38-4c60-1e51155ed69c@arm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Thu, Jun 03, 2021 at 01:08:23PM +0530, Deepak Kumar Mishra escreveu:
> Hi Arnaldo,
> 
> On 6/2/21 6:48 PM, Arnaldo Carvalho de Melo wrote:
> > Em Wed, Jun 02, 2021 at 11:26:24AM +0530, Deepak Kumar Mishra escreveu:
> >> added a section in README to give details about use of -DBUILD_SHARED_LIBS
> >> cmake option and existing documentation reformatted to accomodate this.
> > 
> > So are you changing the default to build as static? Please keep the
> > existing default and make building statically the opt-in mode, ok?
> > 
> As per Cmake documentation if -DBUILD_SHARED_LIBS is present and true, 
> cmake will cause all libraries to be built shared.
> https://cmake.org/cmake/help/latest/variable/BUILD_SHARED_LIBS.html 
> 
> If you still suggest, I can override the default behavior to SHARED and 
> only when -DBUILD_SHARED_LIBS=OFF is provided, it will make STATIC.

Please keep the pre-existing default, i.e. people building pahole all
these years expect the shared library to be produced, if after this
change that isn't the case, some confusion will ensue.

Now if you could provide numbers for, say, 'pahole -J' liked statically,
that would be great and would help understand what decision to make.

- Arnaldo
 
> Kindly confirm. 
> -Deepak 
> 
> > - Arnaldo
> >  
> >> Signed-off-by: Deepak Kumar Mishra <deepakkumar.mishra@arm.com>
> >> ---
> >>  README | 13 +++++++++++--
> >>  1 file changed, 11 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/README b/README
> >> index 576cd42..40ca984 100644
> >> --- a/README
> >> +++ b/README
> >> @@ -6,8 +6,17 @@ Build instructions:
> >>  4. cmake -D__LIB=lib ..
> >>  5. make install
> >>  
> >> -Default is to install to /usr/local, use -DCMAKE_INSTALL_PREFIX=
> >> -when invoking cmake to specify another install location.
> >> +cmake Options:
> >> +  -DBUILD_SHARED_LIBS
> >> +    By default STATIC libraries are created and applications are linked to it.
> >> +    use -DBUILD_SHARED_LIBS=ON while invoking cmake to create SHARED libraries
> >> +    and link applications to it.
> >> +
> >> +    Ex. cmake -D__LIB=lib -DBUILD_SHARED_LIBS=ON ..
> >> +
> >> +  -DCMAKE_INSTALL_PREFIX
> >> +    Default is to install to /usr/local, use -DCMAKE_INSTALL_PREFIX=
> >> +    when invoking cmake to specify another install location.
> >>  
> >>  Known to work scenarios:
> >>  
> >> -- 
> >> 2.17.1
> >>
> > 

-- 

- Arnaldo
