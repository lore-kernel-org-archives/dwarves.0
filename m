Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E775AC4321E
	for <linux-dwarves@archiver.kernel.org>; Mon, 24 Jan 2022 21:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353899AbiAXVqn (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Mon, 24 Jan 2022 16:46:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1450063AbiAXVTl (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Mon, 24 Jan 2022 16:19:41 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F25C06127D
        for <dwarves@vger.kernel.org>; Mon, 24 Jan 2022 12:13:49 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id x3so214251ilm.3
        for <dwarves@vger.kernel.org>; Mon, 24 Jan 2022 12:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=muIlGK7UGSHsmiZXBnqQJlhzGz4pKwXporPdHYLKUJw=;
        b=BYQf2L17GFihur95boNA/PZD+zjA74GwdrKZMdFm+KJC92lPLDMp2NsvjqsqQepnHR
         cggpsJC9wZQloUN7L3VsNRh8axg4r5zwcXvuM53YC6QqHktgu7/fWA/fVRc9Z5BxnldI
         u2Kqbj4Q43YymptzCGiSEkRaJAPw10AFHOeCgWqqAklunmQWDO/BE6J4aMvF9DvsHCUq
         JhHZrQrzx4zppGTnAN+d6sBe/jA4VDMppVJ51yf8FM7tnv/lvTssuJLw2zFyO1Z1x1OO
         coztFT1+utf8dLlFE3ta+IEL+/qJutSvZI754uuay3O7fqE4OjWItJepK9bWKfPDa6WC
         Sslw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=muIlGK7UGSHsmiZXBnqQJlhzGz4pKwXporPdHYLKUJw=;
        b=8KeK37T2kKGGndHBy6fglSYiQMDQnr8SefAoGpJ0pB6SKv/sFA61zaSphvWhV1gjOD
         sZlqJlyXvhOuV1MWaZY7aSO/GEKwURnJALkvwN9jt8Yqwqd6+eOArEHJ775Tcib5h6BJ
         haDC1Xah1EJJt/s4geGF7Slo/B4oY30LlcIjpDtAi8WPXIp7L4Ecupl4msQfeXeWMFMR
         Xn0/kN1BoEE2EO/IUTeJFDtb2N4jaUUbyao228tbstxiXIPpHhzWQbW0zvvZJvASB6+W
         c+t4/oBxjQOprw/ZPlDfzPTKb7mBdykw/iBmqZLPn8wwRXTRoB95BitKwDoTbPL7D3fM
         VJ7Q==
X-Gm-Message-State: AOAM531JKtMdTZ2VIExqhG9magujC6cS0XrPyZ0hFyD9++0aYNAJJE/N
        1caZO23XPLrOFtNWC5igg2b/BulHJQE6TvzEGFY=
X-Google-Smtp-Source: ABdhPJy0BgObTPb/8SOtJO2ApCbI8aIpvAxVfrFKDTiuwNuHCn80XgWYLkVjNMwqcWKGGN9M9iuTKf4whV8nwtCz1RM=
X-Received: by 2002:a92:db0b:: with SMTP id b11mr9513687iln.98.1643055228604;
 Mon, 24 Jan 2022 12:13:48 -0800 (PST)
MIME-Version: 1.0
References: <20220124191858.1601255-1-kuifeng@fb.com> <20220124191858.1601255-4-kuifeng@fb.com>
In-Reply-To: <20220124191858.1601255-4-kuifeng@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 24 Jan 2022 12:13:37 -0800
Message-ID: <CAEf4BzaZSw7kG-ohiff-MDgFMR5BpZB-4VZotO2M2y=tYyooQg@mail.gmail.com>
Subject: Re: [PATCH dwarves v2 3/3] pahole: Use per-thread btf instances to
 avoid mutex locking.
To:     Kui-Feng Lee <kuifeng@fb.com>
Cc:     dwarves@vger.kernel.org,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Mon, Jan 24, 2022 at 11:19 AM Kui-Feng Lee <kuifeng@fb.com> wrote:
>
> Create an instance of btf for each worker thread, and add type info to
> the local btf instance in the steal-function of pahole without mutex
> acquiring.  Once finished with all worker threads, merge all
> per-thread btf instances to the primary btf instance.
>
> Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
> ---

BTW, I've already synced your btf__add_btf() optimization to Github,
so you can bump pahole libbpf submodule reference in the next
revision. You'll get a bunch of deprecation warnings, so it would be
great to fix those at the same time.

>  btf_encoder.c |   5 +++
>  btf_encoder.h |   2 +
>  pahole.c      | 114 +++++++++++++++++++++++++++++++++++++++++++++++---
>  3 files changed, 116 insertions(+), 5 deletions(-)
>
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 9d015f304e92..56a76f5d7275 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -1529,3 +1529,8 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu)
>  out:
>         return err;
>  }
> +
> +struct btf *btf_encoder__btf(struct btf_encoder *encoder)
> +{
> +       return encoder->btf;
> +}
> diff --git a/btf_encoder.h b/btf_encoder.h
> index f133b0d7674d..0f0eee84df74 100644
> --- a/btf_encoder.h
> +++ b/btf_encoder.h
> @@ -29,4 +29,6 @@ struct btf_encoder *btf_encoders__first(struct list_head *encoders);
>
>  struct btf_encoder *btf_encoders__next(struct btf_encoder *encoder);
>
> +struct btf *btf_encoder__btf(struct btf_encoder *encoder);
> +
>  #endif /* _BTF_ENCODER_H_ */
> diff --git a/pahole.c b/pahole.c
> index f3eeaaca4cdf..93b844f97c38 100644
> --- a/pahole.c
> +++ b/pahole.c
> @@ -2798,6 +2798,73 @@ out:
>
>  static struct type_instance *header;
>
> +struct thread_data {
> +       struct btf *btf;
> +       struct btf_encoder *encoder;
> +};
> +
> +static int pahole_threads_prepare(struct conf_load *conf, int nr_threads, void **thr_data)
> +{
> +       int i;
> +       struct thread_data *threads = calloc(sizeof(struct thread_data), nr_threads);
> +
> +       for (i = 0; i < nr_threads; i++)
> +               thr_data[i] = threads + i;
> +
> +       return 0;
> +}
> +
> +static int pahole_thread_exit(struct conf_load *conf, void *thr_data)
> +{
> +       struct thread_data *thread = thr_data;
> +
> +       if (thread == NULL)
> +               return 0;
> +
> +       /*
> +        * Here we will call btf__dedup() here once we extend
> +        * btf__dedup().
> +        */
> +
> +       return 0;
> +}
> +
> +static int pahole_threads_collect(struct conf_load *conf, int nr_threads, void **thr_data,
> +                                 int error)
> +{
> +       struct thread_data **threads = (struct thread_data **)thr_data;
> +       int i;
> +       int err = 0;
> +
> +       if (error)
> +               goto out;
> +
> +       for (i = 0; i < nr_threads; i++) {
> +               /*
> +                * Merge content of the btf instances of worker
> +                * threads to the btf instance of the primary
> +                * btf_encoder.
> +                */
> +               if (!threads[i]->btf || threads[i]->encoder == btf_encoder)
> +                       continue; /* The primary btf_encoder */
> +               err = btf__add_btf(btf_encoder__btf(btf_encoder), threads[i]->btf);

You've ignored my question and suggestion to move btf__add_btf() into
pahole_thread_exit. Can you please comment on why it's not a good
idea, if you insist on not doing that?

> +               if (err < 0)
> +                       goto out;
> +               btf_encoder__delete(threads[i]->encoder);
> +               threads[i]->encoder = NULL;
> +       }
> +       err = 0;
> +
> +out:
> +       for (i = 0; i < nr_threads; i++) {
> +               if (threads[i]->encoder && threads[i]->encoder != btf_encoder)
> +                       btf_encoder__delete(threads[i]->encoder);
> +       }
> +       free(threads[0]);
> +
> +       return err;
> +}
> +
>  static enum load_steal_kind pahole_stealer(struct cu *cu,
>                                            struct conf_load *conf_load,
>                                            void *thr_data)
> @@ -2819,8 +2886,8 @@ static enum load_steal_kind pahole_stealer(struct cu *cu,
>
>         if (btf_encode) {
>                 static pthread_mutex_t btf_lock = PTHREAD_MUTEX_INITIALIZER;
> +               struct btf_encoder *encoder;
>
> -               pthread_mutex_lock(&btf_lock);
>                 /*
>                  * FIXME:
>                  *
> @@ -2828,21 +2895,55 @@ static enum load_steal_kind pahole_stealer(struct cu *cu,
>                  * point we'll have cu->elf setup...
>                  */
>                 if (!btf_encoder) {
> -                       btf_encoder = btf_encoder__new(cu, detached_btf_filename, conf_load->base_btf, skip_encoding_btf_vars,
> -                                                      btf_encode_force, btf_gen_floats, global_verbose);
> +                       pthread_mutex_lock(&btf_lock);
> +                       if (!btf_encoder) {

are you trying to minimize lock contention here with !btf_encoder
check outside and inside locked area? Why? It just adds more code
nesting and this locking can't be a real bottleneck. We are talking
about a very few threads being initialized. Please keep it simple,
lock, check !btf_encode and goto unlock, if it's already set.
Otherwise proceed to initialization.

> +                               /*
> +                                * btf_encoder is the primary encoder.
> +                                * And, it is used by the thread
> +                                * create it.
> +                                */
> +                               btf_encoder = btf_encoder__new(cu, detached_btf_filename,
> +                                                              conf_load->base_btf,
> +                                                              skip_encoding_btf_vars,
> +                                                              btf_encode_force,
> +                                                              btf_gen_floats, global_verbose);
> +                               if (btf_encoder && thr_data) {
> +                                       struct thread_data *thread = (struct thread_data *)thr_data;
> +
> +                                       thread->encoder = btf_encoder;
> +                                       thread->btf = btf_encoder__btf(btf_encoder);

Can you summarize the relationship between thr_data, btf_encode and
thread->encoder? I'm re-reading this code (including `if (thr_data)`
piece below) over and over and can't figure out why the initialization
pattern is so complicated.

> +                               }
> +                       }
> +                       pthread_mutex_unlock(&btf_lock);
>                         if (btf_encoder == NULL) {
>                                 ret = LSK__STOP_LOADING;
>                                 goto out_btf;
>                         }
>                 }
>
> -               if (btf_encoder__encode_cu(btf_encoder, cu)) {
> +               if (thr_data) {
> +                       struct thread_data *thread = (struct thread_data *)thr_data;
> +
> +                       if (thread->encoder == NULL) {
> +                               thread->encoder =
> +                                       btf_encoder__new(cu, detached_btf_filename,
> +                                                        NULL,
> +                                                        skip_encoding_btf_vars,
> +                                                        btf_encode_force,
> +                                                        btf_gen_floats,
> +                                                        global_verbose);
> +                               thread->btf = btf_encoder__btf(thread->encoder);
> +                       }
> +                       encoder = thread->encoder;
> +               } else
> +                       encoder = btf_encoder;
> +
> +               if (btf_encoder__encode_cu(encoder, cu)) {
>                         fprintf(stderr, "Encountered error while encoding BTF.\n");
>                         exit(1);
>                 }
>                 ret = LSK__DELETE;
>  out_btf:
> -               pthread_mutex_unlock(&btf_lock);
>                 return ret;
>         }
>  #if 0
> @@ -3207,6 +3308,9 @@ int main(int argc, char *argv[])
>         memset(tab, ' ', sizeof(tab) - 1);
>
>         conf_load.steal = pahole_stealer;
> +       conf_load.thread_exit = pahole_thread_exit;
> +       conf_load.threads_prepare = pahole_threads_prepare;
> +       conf_load.threads_collect = pahole_threads_collect;
>
>         // Make 'pahole --header type < file' a shorter form of 'pahole -C type --count 1 < file'
>         if (conf.header_type && !class_name && prettify_input) {
> --
> 2.30.2
>
