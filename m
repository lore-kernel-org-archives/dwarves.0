Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC1DC433ED
	for <linux-dwarves@archiver.kernel.org>; Wed, 19 May 2021 21:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40F7761244
	for <linux-dwarves@archiver.kernel.org>; Wed, 19 May 2021 21:18:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbhESVTp (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Wed, 19 May 2021 17:19:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25076 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229454AbhESVTo (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Wed, 19 May 2021 17:19:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621459103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xh5n+899DoO1e547nDK2R0sTY9abh3hItPB/XVvshzY=;
        b=hrYlpbIha4pqY7Mv/etFPDB0e7C1C0zZ1nHyeG9Vz8W1cuuql40fEqgSlLaaJ4OZxF+i3Q
        FiYHejLazbKpAAKZfD7aUIdPw3fLX9FnAJwXM1/+1xV9llnmKloqa9yV1e48PgdqXy+MMM
        tzYYJqgnHjMlZMNqA/veNzD3v1ABWNU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-26XXQprFNIe8Sb-I0rKNcQ-1; Wed, 19 May 2021 17:18:19 -0400
X-MC-Unique: 26XXQprFNIe8Sb-I0rKNcQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E778D801817;
        Wed, 19 May 2021 21:18:17 +0000 (UTC)
Received: from krava (unknown [10.40.192.18])
        by smtp.corp.redhat.com (Postfix) with SMTP id B5E3A19C59;
        Wed, 19 May 2021 21:18:15 +0000 (UTC)
Date:   Wed, 19 May 2021 23:18:14 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo <arnaldo.melo@gmail.com>
Cc:     Shuyi Cheng <chengshuyi@linux.alibaba.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        dwarves@vger.kernel.org, wenan.mao@linux.alibaba.com,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH v2] pahole: Add --kabi_prefix flag
Message-ID: <YKWAlm5KO4S9HBmn@krava>
References: <a249699a-7c6c-4d4a-71b0-87981c8d229e@linux.alibaba.com>
 <YKKA64WWqYN3P7YJ@kernel.org>
 <c3520803-77af-cc34-000a-de4ba6334bcb@linux.alibaba.com>
 <YKO34fq6P8G9IyMD@kernel.org>
 <CAEf4Bzazh4RNCY3rGRRXfO2wJ7DSiMx8w+61B_hjhu9FrOffpQ@mail.gmail.com>
 <ec80d351-ac2f-5c48-c339-c2c503d36d68@linux.alibaba.com>
 <YKVv57HsgJYmCTFi@krava>
 <5D76A4F3-6F5A-4061-A274-34FFE5CBA338@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5D76A4F3-6F5A-4061-A274-34FFE5CBA338@gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Wed, May 19, 2021 at 05:23:31PM -0300, Arnaldo wrote:
> 
> 
> On May 19, 2021 5:07:03 PM GMT-03:00, Jiri Olsa <jolsa@redhat.com> wrote:
> >On Wed, May 19, 2021 at 10:44:44AM +0800, Shuyi Cheng wrote:
> >> To solve problems similar to _RH_KABI_REPLACE. The
> >_RH_KABI_REPLACE(_orig,
> >> _new) macros perserve size alignment and kabi agreement between _orig
> >and
> >> _new.Below is the definition of this macro:
> >> 
> >> # define _RH_KABI_REPLACE(_orig, _new)            \
> >>     union {                        \
> >>         _new;                    \
> >>         struct {                \
> >>             _orig;                \
> >>         } __UNIQUE_ID(rh_kabi_hide);        \
> >>         __RH_KABI_CHECK_SIZE_ALIGN(_orig, _new);    \
> >>     }
> >
> >hi,
> >that macro sounds familiar ;-) I think this should be already
> >solved directly in the header file by this one:
> >
> >https://gitlab.com/cki-project/kernel-ark/-/commit/331be9c5a436057ee852075c102d9d90a9046a30
> >
> 
> But this means newer kernels will not have that issue, so perhaps we should just document this?

I don't think there's released kernel with this issue

> 
> Or would it be worth the effort of having a --ignore_prefix option for the people using all the kernels where this is applicable to and leave the option lingering there just in case?

this is specific to rh kernels and fixed by that patch above,
I wouldn't expect seeing it again

jirka

