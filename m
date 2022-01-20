Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F435C433EF
	for <linux-dwarves@archiver.kernel.org>; Thu, 20 Jan 2022 20:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377565AbiATUQq (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 20 Jan 2022 15:16:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiATUQp (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Thu, 20 Jan 2022 15:16:45 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E048C061574
        for <dwarves@vger.kernel.org>; Thu, 20 Jan 2022 12:16:45 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id e8so5948841ilm.13
        for <dwarves@vger.kernel.org>; Thu, 20 Jan 2022 12:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jIzMfAcDdmkFNiUo845AKwivxgV60oW9s2o0RpARZhU=;
        b=JRcQwBCMHfXEy8seKz8sjlsWF+k/ulC2XwpttJjcvAgf7KH1l9C55Xxi+SLqKqmYfv
         6zeczRaX/xNOiES0WZTFB8ISfMka9RWXwsK7jgjKtmTm/lEg2RPnmVLP/WdLtjTcH4xy
         znLQFttd2S1qXYRaD4xH6RMChpA+YhwK5FXsSwWzLk5v0D+rqhNyEZLnLD72VIKSJB6P
         gRDTr8gaaIj6SzGwbTCEQui1lCcKAIEZbMt5RSwE1eVYB1x0wpBPCNpYoLg1iMlcx+5p
         2TgVYPOx37A43kuI7qlsMOcMNhCewN27UoCtXvsKqWf06pudPk1twlakNsmxpAqd0apb
         i1ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jIzMfAcDdmkFNiUo845AKwivxgV60oW9s2o0RpARZhU=;
        b=sXmLh9TNbEd0/vccOqOcHjEn/6t1YNPx66T51O9i919jBfi0j4sUJwQ4SaexMX1ExQ
         fY70eYdLJFMl02WTSyvHq4XtBWBR2yIiu1T1Y165Xtr+9j3OooRDF9aKA3ixDt1IFDiF
         te/LQTLdpdSfeR9ruvQbUWzMTJV+hRa2SW28jpmtIHGsXmL61ejSuTsKrHEHNk/CUKKF
         vyLZ1hctuOYLoqBQQV75UyyWgTLOAptB3YTeuvsZpE/+gIjUrBHKeD/d4fcWEdPN8QS1
         g+uh/uc6GR1FqdReRpmogkRDxMrvC6ZB6fPLG7qTYCp0rIlkjsiT+5AXUEtz8GAc2A5H
         zM0w==
X-Gm-Message-State: AOAM5335Gh2dm7aDhNCX2mVdN5ny3pYmdmJEF+QSPgInTPI6AjScAtZZ
        lk9a6UB/ZQfLg0HSJ3ZD2XMZmn2xe9WmVw9cg6I=
X-Google-Smtp-Source: ABdhPJx54pdxZKRe+N8NEQF6m9vHXy4lyXkbYD/fgivg9mbzWw8ZZ545yBloHv6d9XxZ98o+3ubdNFYllTY6YxyAtQA=
X-Received: by 2002:a05:6e02:1748:: with SMTP id y8mr339510ill.305.1642709804883;
 Thu, 20 Jan 2022 12:16:44 -0800 (PST)
MIME-Version: 1.0
References: <20220120010817.2803482-1-kuifeng@fb.com> <20220120010817.2803482-3-kuifeng@fb.com>
In-Reply-To: <20220120010817.2803482-3-kuifeng@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 20 Jan 2022 12:16:33 -0800
Message-ID: <CAEf4BzaEWxrEf1BVVzHNDf=mKU3jiMvbn=74W6wS-9Cna5p2Bg@mail.gmail.com>
Subject: Re: [PATCH dwarves 2/2] pahole: Use per-thread btf instances to avoid
 mutex locking.
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

On Wed, Jan 19, 2022 at 5:09 PM Kui-Feng Lee <kuifeng@fb.com> wrote:
>
> Create an instance of btf for each worker thread, and add type info to
> the local btf instance in the steal-function of pahole without mutex
> acquiring.  Once finished with all worker threads, merge all
> per-thread btf instances to the primary btf instance.
>
> Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
> ---

Just a bunch of nits, I'll relay to Arnaldo to verify the logic is sound

>  btf_encoder.c |   5 +++
>  btf_encoder.h |   2 +
>  pahole.c      | 117 +++++++++++++++++++++++++++++++++++++++++++++++---
>  3 files changed, 119 insertions(+), 5 deletions(-)
>
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 9d015f304e92..96a6c1d5fba0 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -1529,3 +1529,8 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu)
>  out:
>         return err;
>  }
> +
> +struct btf *btf_encoder__get_btf(struct btf_encoder *encoder)

nit: btf_encoder__btf() is how we'd call this in libbpf, not sure
which naming convention Arnaldo prefers

> +{
> +       return encoder->btf;
> +}
> diff --git a/btf_encoder.h b/btf_encoder.h
> index f133b0d7674d..e141ec2e677d 100644
> --- a/btf_encoder.h
> +++ b/btf_encoder.h
> @@ -29,4 +29,6 @@ struct btf_encoder *btf_encoders__first(struct list_head *encoders);
>
>  struct btf_encoder *btf_encoders__next(struct btf_encoder *encoder);
>
> +struct btf *btf_encoder__get_btf(struct btf_encoder *encoder);
> +
>  #endif /* _BTF_ENCODER_H_ */
> diff --git a/pahole.c b/pahole.c
> index f3eeaaca4cdf..56bd7dc4e62e 100644
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
> +       struct thread_data *threads =
> +               (struct thread_data *)calloc(sizeof(struct thread_data), nr_threads);

nit: split variable declaration and initialization, if it's not
fitting on a single line? You also don't need casting of calloc()
result in C.

> +
> +       for (i = 0; i < nr_threads; i++)
> +               thr_data[i] = threads + i;
> +
> +       return 0;
> +}
> +
> +static int pahole_thread_exit(struct conf_load *conf, void *thr_data)
> +{
> +       struct thread_data *thread = (struct thread_data *)thr_data;

same, casting not needed

> +
> +       if (thread == NULL)

nit: !thread

> +               return 0;
> +
> +       /*
> +        * It will call dedup here in the future once we have fixed
> +        * the known performance regression of libbpf.
> +        */

uhm... it's not a regression, it's BTF dedup algorithm not really
supporting partial dedup and subsequent dedup. I'd drop this comment
for now, it just adds confusion, IMO.

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
> +       if (error == 0) {

reduce nesting:

if (error)
    goto out;

> +               for (i = 0; i < nr_threads; i++) {
> +                       /*
> +                        * Merge cotnent of the btf instances of

typo: content

> +                        * worker threads to the btf instance of the
> +                        * primary btf_encoder.
> +                        */
> +                       if (!threads[i]->btf || threads[i]->encoder == btf_encoder)
> +                               continue; /* The primary btf_encoder */
> +                       err = btf__add_btf(btf_encoder__get_btf(btf_encoder), threads[i]->btf);

if you do btf__add_btf() in pahole_thread_exit() (under mutex, but
that's fine), you can offload some time spent in btf__Add_btf() to
worker threads. Have you tried that? I bet you'll get a bit of speed
up that way as well.

> +                       if (err < 0)
> +                               goto out;
> +                       err = 0;

move this to after the for loop

> +                       btf_encoder__delete(threads[i]->encoder);
> +                       threads[i]->encoder = NULL;
> +               }
> +       }
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
> @@ -2828,21 +2895,58 @@ static enum load_steal_kind pahole_stealer(struct cu *cu,
>                  * point we'll have cu->elf setup...
>                  */
>                 if (!btf_encoder) {
> -                       btf_encoder = btf_encoder__new(cu, detached_btf_filename, conf_load->base_btf, skip_encoding_btf_vars,
> -                                                      btf_encode_force, btf_gen_floats, global_verbose);
> +                       int new_btf_encoder = 0;

this is boolean variable, use bool

> +
> +                       pthread_mutex_lock(&btf_lock);
> +                       if (!btf_encoder) {
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
> +                               new_btf_encoder = 1;
> +                       }
> +                       pthread_mutex_unlock(&btf_lock);
>                         if (btf_encoder == NULL) {
>                                 ret = LSK__STOP_LOADING;
>                                 goto out_btf;
>                         }
> +                       if (new_btf_encoder && thr_data) {
> +                               struct thread_data *thread = (struct thread_data *)thr_data;
> +
> +                               thread->encoder = btf_encoder;
> +                               thread->btf = btf_encoder__get_btf(btf_encoder);

maybe do this initialization right after you created btf_encode above
(under lock is fine, there is nothing slow here)

> +                       }
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
> +                               thread->btf = btf_encoder__get_btf(thread->encoder);
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
> @@ -3207,6 +3311,9 @@ int main(int argc, char *argv[])
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
