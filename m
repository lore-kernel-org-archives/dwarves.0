Return-Path: <dwarves-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C498EB64DD
	for <linux-dwarves@archiver.kernel.org>; Mon,  3 Jul 2023 10:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjGCKWX (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Mon, 3 Jul 2023 06:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjGCKWW (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Mon, 3 Jul 2023 06:22:22 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0608AB8
        for <dwarves@vger.kernel.org>; Mon,  3 Jul 2023 03:22:21 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-991fe70f21bso497400766b.3
        for <dwarves@vger.kernel.org>; Mon, 03 Jul 2023 03:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1688379739; x=1690971739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=unqcElCbSbz/KEz3tHCnOGA+1HlEI/erWDnqqETONqQ=;
        b=Jhnz677l0fZ4iq/NsN3FykPeJVv/5KTyQQc4oU8H1FPdCgz0Q3pTBFlXZ3z7HPGihv
         QLM/4vPPlsmpJNXHYfo7z2fQFW/Wq+SjPKKuTysqEzBWXivZX2PifUllYW5zztB1CV6+
         1xrigfRKd0D0qlQ9Wm7z6ADq6ZUjPHGB3ThaE7mHThbJvtBjRy1rc9T9+Dmv20HDxl73
         0qwzc+Qyq+s160Kd+GSpAoabCrO5wbOJUxe9EGFrWZuV16zETMp0bh5iJ2ohLlO4riMX
         aBcLUNbQJojnp745+ZuSi2cea9OeMOtYB09v5SIdwKJrA2DRIjpyH8vFSnpajcGeYMda
         uSJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688379739; x=1690971739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=unqcElCbSbz/KEz3tHCnOGA+1HlEI/erWDnqqETONqQ=;
        b=UoLKKviZEXqcU3sBTCnaULslql6vdH4oA7Q6CEGB80dzjuyhN00u8SNidJHEKP/K/v
         flscGz4ijP6r964K5S6NGmPHRPYxRE2+5u9QMbLWzrvwLMimDcslAsrnmeyi4WBSzdLZ
         5h4aEB1uCy97o/VyomZWxILqB8qDKh5ftmbwt/fTE9dXNerhww5zyTzL0p/TeW4AYNzl
         mpCRJtscULhMgxg+erUHq04aUQReC2ovNYE43WsBUHjJF5j2WpkGFWB1EiRoa6hvTmAW
         fL3rwG4BBXjNPnGA709Tfb8WzoPVMbu8CvTuriP6RWnwsIKARiPz+r9rG/8Kb7w9Lpnl
         Ftuw==
X-Gm-Message-State: AC+VfDxw7DfEVFVGXQU6SQmTiS66byzeKPy108revf3rb0EU9+u7YYSx
        UICf9UzqadfMlTDt/tyM0NLMhc3rsC4HrvuEHvxYmA==
X-Google-Smtp-Source: ACHHUZ47dr4fst2/lpHmqBiNeSYZl6uU6lPdH+cI1OOKc8eSLR9/3/ddokI5Mo+6nikJ7zZBtaiuo6D+qD6raJVaXyI=
X-Received: by 2002:a17:906:f9d5:b0:96f:f19b:887a with SMTP id
 lj21-20020a170906f9d500b0096ff19b887amr6216107ejb.56.1688379739559; Mon, 03
 Jul 2023 03:22:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAN+4W8junMrqMTQJ1cy-5fhd9FFsASWOndRPaprspKXMXShJYQ@mail.gmail.com>
 <aaf6220c-dddf-ee5f-37a2-e16bd580c0a7@iogearbox.net> <CADWks+YaTqLbmADDzeJC4WvfMtLCEzYw_+qibEMbM-Q6JGJHMg@mail.gmail.com>
In-Reply-To: <CADWks+YaTqLbmADDzeJC4WvfMtLCEzYw_+qibEMbM-Q6JGJHMg@mail.gmail.com>
From:   Lorenz Bauer <lmb@isovalent.com>
Date:   Mon, 3 Jul 2023 11:22:08 +0100
Message-ID: <CAN+4W8gotgUJ5hHz5oc+smQcL8A2FG=M5AxWCEef+9Ze4eR-Mg@mail.gmail.com>
Subject: Re: PSA: Ubuntu pahole creates buggy BTF
To:     Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>,
        dwarves@vger.kernel.org,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Domenico Andreoli <cavok@debian.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Thu, Jun 29, 2023 at 4:17=E2=80=AFPM Dimitri John Ledkov
<dimitri.ledkov@canonical.com> wrote:
>
> Hi,
>
> Yes it is. This was fixed in Mantic already, and it is due to be SRUed to=
 jammy soon. Apologies for the delays.

Thanks for the quick follow up. Do you have a link where the update
can be tracked? What should I look out for?

Thanks
Lorenz
