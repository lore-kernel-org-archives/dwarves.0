Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E488DC433EF
	for <linux-dwarves@archiver.kernel.org>; Tue, 25 Jan 2022 21:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233348AbiAYVuK (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 25 Jan 2022 16:50:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbiAYVuI (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Tue, 25 Jan 2022 16:50:08 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27464C06173B
        for <dwarves@vger.kernel.org>; Tue, 25 Jan 2022 13:50:08 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id 9so9772957iou.2
        for <dwarves@vger.kernel.org>; Tue, 25 Jan 2022 13:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6/XQmEyollK8/QUclMmGJj553v6nma4fXt5E2IyclQk=;
        b=faO7V+tNPdurISypCRmZ2B++s801y7qaWEtuyQQMNYI133wa20Nay3uzl1PG0EcrQI
         c4fP0R60dcDhwEoZuHN2OOfnQkOQtJWmZBp4nlp9rPQ0H0HIfNqN8dANdNzIAfTNTn6T
         OYzPEMqgGkB1U6AwySM6nDbEHSr726hF5khwyIvemtGgG5COkTC8APi7SvunhA0vdKAz
         5Sug16NkZnsD9eYEXTMIJnBymSwEUDipF8Dno/BUHbgIgOtdORQj6ZkJjB/zzlOViT80
         tbItDw1ZE/J460D+xDyjpfIAuNv9c+8TlhigyMl5gbIchOSGFie4DvywlDx7t4RLawqQ
         NkTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6/XQmEyollK8/QUclMmGJj553v6nma4fXt5E2IyclQk=;
        b=NAA7A6tIIqz1ip0TvVmzj4+ZJ7tNd0yT9OetBHERhAodo+MHRUAWLRk0BzLUGst//Z
         pYRkoEvNZznM7J7LpXFyR1FFGZPQlkt13Y+pPtV1xXDnC9Bz+CuAmebjOkBDiTXOcIzq
         miog7vZaX92gYTbtMbs0ROgNNVGtR0mzJ4MvIkrVGH0LQNqbh4go4DSus1iD0zMx3YiV
         CHfofJNG+QKQuLi37q8h3lOd7my6+Jn0g8PFfRs8SUvqj6AxS2iJzndWExF+etXQ2x57
         xtcPb0vkIq8VkJkhmoi1wysJ7YYKE5tmXJvh3ytMRJ8dcH25+IJjOaL213Iqcdygw1Si
         D9NA==
X-Gm-Message-State: AOAM531X4FsvwbjYTQ36nQ6DoI7YYLOBaSmDVTWI9RtDNN/b/LW2zZa1
        sBP1KibD9cIz+fZ0IeZPXCZEsZQNu8Tr1Wd8L/2YWcfm
X-Google-Smtp-Source: ABdhPJx6DY4t6273QMueJR0MEAg1wOPDLOj4RA6CkwCU3S9YeYzoZjYhoNXQMrWzOmR8t3CP62HubP1AZbq1LOR046Q=
X-Received: by 2002:a5d:9f01:: with SMTP id q1mr12037281iot.144.1643147407258;
 Tue, 25 Jan 2022 13:50:07 -0800 (PST)
MIME-Version: 1.0
References: <20220124191858.1601255-1-kuifeng@fb.com> <20220124191858.1601255-4-kuifeng@fb.com>
 <CAEf4BzaZSw7kG-ohiff-MDgFMR5BpZB-4VZotO2M2y=tYyooQg@mail.gmail.com> <8cbd916060c08243bb9b1b335cbd69c3f961d30a.camel@fb.com>
In-Reply-To: <8cbd916060c08243bb9b1b335cbd69c3f961d30a.camel@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 25 Jan 2022 13:49:56 -0800
Message-ID: <CAEf4BzY8FP2914NYzme-E11cNOjoZ+GELeap+3cSNVaWmW1eLg@mail.gmail.com>
Subject: Re: [PATCH dwarves v2 3/3] pahole: Use per-thread btf instances to
 avoid mutex locking.
To:     Kui-Feng Lee <kuifeng@fb.com>
Cc:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "arnaldo.melo@gmail.com" <arnaldo.melo@gmail.com>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "dwarves@vger.kernel.org" <dwarves@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Tue, Jan 25, 2022 at 11:38 AM Kui-Feng Lee <kuifeng@fb.com> wrote:
>
> On Mon, 2022-01-24 at 12:13 -0800, Andrii Nakryiko wrote:
> > On Mon, Jan 24, 2022 at 11:19 AM Kui-Feng Lee <kuifeng@fb.com> wrote:
> > >
> > > Create an instance of btf for each worker thread, and add type info
> > > to
> > > the local btf instance in the steal-function of pahole without mutex
> > > acquiring.  Once finished with all worker threads, merge all
> > > per-thread btf instances to the primary btf instance.
> > >
> > > Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
> > > ---
> >
> > BTW, I've already synced your btf__add_btf() optimization to Github,
> > so you can bump pahole libbpf submodule reference in the next
> > revision. You'll get a bunch of deprecation warnings, so it would be
> > great to fix those at the same time.
>
> Got it!
>
> ...... cut .....
> > >
> > > +static int pahole_thread_exit(struct conf_load *conf, void
> > > *thr_data)
> > > +{
> > > +       struct thread_data *thread = thr_data;
> > > +
> > > +       if (thread == NULL)
> > > +               return 0;
> > > +
> > > +       /*
> > > +        * Here we will call btf__dedup() here once we extend
> > > +        * btf__dedup().
> > > +        */
> > > +
> > > +       return 0;
> > > +}
> > > +
> > >
> > You've ignored my question and suggestion to move btf__add_btf() into
> > pahole_thread_exit. Can you please comment on why it's not a good
> > idea, if you insist on not doing that?
>
> Sorry for not replying for this part.
> I tried it yesterday, and I don't see obvious improvement.  I guess the
> improvement is not big enough to be observed.

I see. It still seems a good move anyways, because those per-thread
BTF instances are owned by each thread, so when the thread is done
it's cleaner to merge it into common BTF and free up local BTF,
instead of keeping it around for longer than necessary.

>
> > > @@ -2819,8 +2886,8 @@ static enum load_steal_kind
> > > pahole_stealer(struct cu *cu,
> > >
> > >         if (btf_encode) {
> > >                 static pthread_mutex_t btf_lock =
> > > PTHREAD_MUTEX_INITIALIZER;
> > > +               struct btf_encoder *encoder;
> > >
> > > -               pthread_mutex_lock(&btf_lock);
> > >                 /*
> > >                  * FIXME:
> > >                  *
> > > @@ -2828,21 +2895,55 @@ static enum load_steal_kind
> > > pahole_stealer(struct cu *cu,
> > >                  * point we'll have cu->elf setup...
> > >                  */
> > >                 if (!btf_encoder) {
> > > -                       btf_encoder = btf_encoder__new(cu,
> > > detached_btf_filename, conf_load->base_btf, skip_encoding_btf_vars,
> > > -
> > > btf_encode_force, btf_gen_floats, global_verbose);
> > > +                       pthread_mutex_lock(&btf_lock);
> > > +                       if (!btf_encoder) {
> >
> > are you trying to minimize lock contention here with !btf_encoder
> > check outside and inside locked area? Why? It just adds more code
> > nesting and this locking can't be a real bottleneck. We are talking
> > about a very few threads being initialized. Please keep it simple,
> > lock, check !btf_encode and goto unlock, if it's already set.
> > Otherwise proceed to initialization.
>
> Got it!
>
> .......................
> > > +                               if (btf_encoder && thr_data) {
> > > +                                       struct thread_data *thread =
> > > (struct thread_data *)thr_data;
> > > +
> > > +                                       thread->encoder =
> > > btf_encoder;
> > > +                                       thread->btf =
> > > btf_encoder__btf(btf_encoder);
> >
> > Can you summarize the relationship between thr_data, btf_encode and
> > thread->encoder? I'm re-reading this code (including `if (thr_data)`
> > piece below) over and over and can't figure out why the initialization
> > pattern is so complicated.
>
> thr_data keeps per-thread information to worker threads. So, every
> worker thread has its instance to keep an encoder. The main thread use
> btf_encoder to encode BTF. thread->encoder is for a worker thread to
> add type info. Once finishing all worker threads, the main thread will
> add the btf instances of thread->encoders to the btf instance of
> btf_encoder. However, I reuse btf_encoder for the first worker thread,
> which reaches this function to create btf_encoder. It avoids copying
> data for the first worker thread.
>
> Does it make sense? If so, I will put the explanation in the code.
>

Oh, I see, thanks, it makes it a bit clearer. Yes, please leave a
comment describing this, thanks!
