Return-Path: <dwarves-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F416EB64DB
	for <linux-dwarves@archiver.kernel.org>; Thu, 15 Jun 2023 21:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjFOVTl (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 15 Jun 2023 17:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232432AbjFOVTk (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Thu, 15 Jun 2023 17:19:40 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F9F2976;
        Thu, 15 Jun 2023 14:19:38 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f122ff663eso11276602e87.2;
        Thu, 15 Jun 2023 14:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686863977; x=1689455977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aSrIA6HMckGI9xZTB6coBdEpIW5zLcYElWgXV+iuyQ4=;
        b=fZo9zyTGSxfCPF7SxAyCvblHEr/SC1AV1msThQqNN3XOTMvaTZvZ4YchSW+GtNpuzS
         vM+Vsj+kB/X/9+hdC706Rct5edTuoEJ7HMuT6OqwMWhD6bq0SJ2YCWc1/Ol6JoLTNA5B
         ktpampixT/xSdPUxrQW5qjHgBUB2qCTs58JdMN83CE2a4dXc753nVFMXKNbUlgKlv7GZ
         wn/UN/veVha20UI3GAtL0vDyWyJCMfrTQHVCT1JvePTvLyC2Uyf1Fw3tW3bTnO6Yi8yF
         lyqBruhaQ1Z11pl6bzsTgkJZNnaGDEtq3v7MhI3A1cDbMH0X5qbU6xSO4ToJp4em5HTc
         /ZwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686863977; x=1689455977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aSrIA6HMckGI9xZTB6coBdEpIW5zLcYElWgXV+iuyQ4=;
        b=lFVHPW4WVMh596NyMpRehQUBWdnosPrNfvaAMYY3qS80hUV1AbZYB5Jls3AtQUB/az
         413kqwroh3ejDRBwlcJ+SXNBIVCyZpWou6wblNjxx7qGMondl/EVf8qKooBam+7PaXJq
         /0DPK8EM23mac5jUM0dSp81rdV0JlQCFZq8iY7mr/JN5iKrnM/GLOBPPP0IMHLUstXNn
         CtNA+3XaRc69F4e+zaH/T1o2yIFf0FDPSsfIypezPIiyzNHmAUpJwUMuFLSo+XtDK4Id
         asmcc9Nknxf+yIiugDIO3ke54e05iZ9XWj78sdZlxghn8MXQnI3dvc0G42m2/8Evm4LI
         1XPg==
X-Gm-Message-State: AC+VfDxB9z2ucnmPuRi5k2FnW/3ISwX1q5XGtIne8ljtsT3CIbQydCg5
        Kds7hpE30LrQF3/aWXxDS14AtO0cXozLdMBH3xs=
X-Google-Smtp-Source: ACHHUZ7RoTKQY4ewyhKX08KnWvwssVnwZ549q82vqpn0YYaeXbzUvT6R9IX5KyDGWDA6LrU47N7Ee7DH0ca2JbYebKg=
X-Received: by 2002:ac2:464d:0:b0:4f4:c972:981f with SMTP id
 s13-20020ac2464d000000b004f4c972981fmr12532342lfo.54.1686863976438; Thu, 15
 Jun 2023 14:19:36 -0700 (PDT)
MIME-Version: 1.0
References: <ZIqGSJDaZObKjLnN@codewreck.org> <ZIrONqGJeATpbg3Y@krava>
 <ZIr7aaVpOaP8HjbZ@codewreck.org> <6b26dfef-016c-43df-07f5-c2f88157d1dc@oracle.com>
 <ZIt11crcIjfyeygA@codewreck.org>
In-Reply-To: <ZIt11crcIjfyeygA@codewreck.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 15 Jun 2023 14:19:24 -0700
Message-ID: <CAEf4BzZjiXBPiEwqw9CDeQkB=C6gdbu6ER4WFvtHHHcRyuedAQ@mail.gmail.com>
Subject: Re: ppc64le vmlinuz is huge when building with BTF
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Alan Maguire <alan.maguire@oracle.com>,
        Jiri Olsa <olsajiri@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        dwarves@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Thu, Jun 15, 2023 at 1:35=E2=80=AFPM Dominique Martinet
<asmadeus@codewreck.org> wrote:
>
>
> Alan Maguire wrote on Thu, Jun 15, 2023 at 03:31:49PM +0100:
> > However the problem I suspect is this:
> >
> >  51 .debug_info   0a488b55  0000000000000000  0000000000000000  026f8d2=
0
> >  2**0
> >                   CONTENTS, READONLY, DEBUGGING
> > [...]
> >
> > The debug info hasn't been stripped, so I suspect the packaging spec
> > file or equivalent - in perhaps trying to preserve the .BTF section -
> > is preserving debug info too. DWARF needs to be there at BTF
> > generation time in vmlinux but is usually stripped for non-debug
> > packages.
>
> Thanks Alan and Eduard!
> I guess I should have checked that first, it helps.
>
> We're not stripping anything in vmlinuz for other archs -- the linker
> script already should be including only the bare minimum to decompress
> itself (+compressed useful bits), so I guess it's a Kbuild issue for the
> arch.
> We can add a strip but I unfortunately have no way of testing ppc build,
> I'll ask around the build linux-kbuild and linuxppc-dev lists if that's
> expected; it shouldn't be that bad now that's figured out.
>
>
> > FYI we're aiming to make BTF module-loadable via CONFIG_DEBUG_INFO_BTF=
=3Dm
> > in the future, I'm hoping to get an RFC patch out for that soon once
> > other BTF-related issues are sorted. Hope this helps
>

Besides this, in the past it was requested a few times to make
CONFIG_DEBUG_INFO_BTF=3Dy not imply CONFIG_DEBUG_INFO_DWARF. That is,
make it possible to get BTF without .dwarf* sections being left in the
vmlinux image.

Of course, implementation-wise, DWARF would still have to be generated
at runtime, but would be automatically stripped out after BTF
generation, unless CONFIG_DEBUG_INFO_DWARF* is set.

I think it would help in this case as well. So if anyone has free
cycles, it would be awesome to make this possible.


> Oh, that's interesting -- I assume that'll only change the 'built-in'
> BTF info? Or will that also split BTF info in other modules as
> e.g. modfoo_btf.ko?
> For x86_64 the size increase of vmlinuz itself is rather acceptable
> (<2MB), but the sheer amount of modules (the -lts package has over 3k
> modules...) means that even a small size increase for each module ends
> up taking proportionally a high amount of space (+20MB from 90MB), so
> being able to package separately would be appreciated (alpine likes
> splitting optional features in subpackages)
> Packaging-wise I'm not sure it'd make sense to keep the overhead in
> other modules and just split the 'main' btf infos.
>
> Otoh even if it doesn't help with packaging, having a smaller vmlinuz
> means faster boot and lower kernel memory footprint (I think *2?) for
> people who don't need it, so I think it's a good idea and we'll probably
> enable it once it becomes available. Thanks for the heads up!
>
> --
> Dominique Martinet | Asmadeus
>
