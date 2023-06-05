Return-Path: <dwarves-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FED0C7EE24
	for <linux-dwarves@archiver.kernel.org>; Mon,  5 Jun 2023 13:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233568AbjFENr2 (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Mon, 5 Jun 2023 09:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233716AbjFENr1 (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Mon, 5 Jun 2023 09:47:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CB6EA
        for <dwarves@vger.kernel.org>; Mon,  5 Jun 2023 06:47:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43D2E622BA
        for <dwarves@vger.kernel.org>; Mon,  5 Jun 2023 13:47:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC7EC433D2;
        Mon,  5 Jun 2023 13:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685972845;
        bh=OHXz1OKPeLqjsvKzYaWmG3JfzQJvaSjKi8PweDxzETQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IFLdiaFa6dJxabXAjCiytv0nBxnWvbaR+SfmFBkl+itxfKR10Qii37ivsTQFZCoXd
         DfqDLBMg16twIFpPieJu3aNZn+5MRrc5OLFUMcDFjcSSIcFulAUd0BKdIiKOhcPJmM
         R49TQlmdInwA6JQHNxk+FvvIRweuHmW3lRKG0v9SjMMzlaW9V3kBg5pbnlNxPfF75j
         owdIGTbC1ib2hJmqKWNuEz0csqyVMYghBjayulIL9qPMcj2LU8A8ihfNoT4YifWuWM
         Aep7EunZs6Tw8JLFIKeMzARgi5UzO6rzFy0aMdnZSFpc+uzB9wT5Wq6PE7W3/p4NQ1
         YJMXAo4YhBztQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0C32940692; Mon,  5 Jun 2023 10:47:23 -0300 (-03)
Date:   Mon, 5 Jun 2023 10:47:22 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org, bpf@vger.kernel.org, kernel-team@fb.com,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, mykolal@fb.com
Subject: Re: [PATCH dwarves] pahole: avoid adding same struct structure to
 two rb trees
Message-ID: <ZH3nalodXmup6pEF@kernel.org>
References: <20230525235949.2978377-1-eddyz87@gmail.com>
 <ZHnxsyjDaPQ7gGUP@kernel.org>
 <a15b83ebc750df7edd84b76d30a72c50e016e80f.camel@gmail.com>
 <ZHovRW1G0QZwBSOW@kernel.org>
 <c9c1e04b10f0a13a3af9e980d04ce08d3304ac3a.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9c1e04b10f0a13a3af9e980d04ce08d3304ac3a.camel@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Fri, Jun 02, 2023 at 09:08:51PM +0300, Eduard Zingerman escreveu:
> On Fri, 2023-06-02 at 15:04 -0300, Arnaldo Carvalho de Melo wrote:
> > Em Fri, Jun 02, 2023 at 04:52:40PM +0300, Eduard Zingerman escreveu:
> > > Right, you are correct.
> > > The 'structures__tree = RB_ROOT' part is still necessary, though.
> > > If you are ok with overall structure of the patch I can resend it w/o bzero().

> > Humm, so basically this boils down to the following patch?

> > +++ b/pahole.c
> > @@ -674,7 +674,12 @@ static void print_ordered_classes(void)
> >  		__print_ordered_classes(&structures__tree);
> >  	} else {
> >  		struct rb_root resorted = RB_ROOT;
> > -
> > +#ifdef DEBUG_CHECK_LEAKS
> > +		// We'll delete structures from structures__tree, since we're
> > +		// adding them to ther resorted list, better not keep
> > +		// references there.
> > +		structures__tree = RB_ROOT;
> > +#endif
 
> But __structures__delete iterates over structures__tree,
> so it won't delete anything if code like this, right?
 
> >  		resort_classes(&resorted, &structures__list);
> >  		__print_ordered_classes(&resorted);
> >  	}

Yeah, I tried to be minimalistic, my version avoids the crash, but
defeats the DEBUG_CHECK_LEAKS purpose :-\

How about:

diff --git a/pahole.c b/pahole.c
index 6fc4ed6a721b97ab..e843999fde2a8a37 100644
--- a/pahole.c
+++ b/pahole.c
@@ -673,10 +673,10 @@ static void print_ordered_classes(void)
 	if (!need_resort) {
 		__print_ordered_classes(&structures__tree);
 	} else {
-		struct rb_root resorted = RB_ROOT;
+		structures__tree = RB_ROOT;
 
-		resort_classes(&resorted, &structures__list);
-		__print_ordered_classes(&resorted);
+		resort_classes(&structures__tree, &structures__list);
+		__print_ordered_classes(&structures__tree);
 	}
 }
 
