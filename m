Return-Path: <dwarves-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B36BEB64D9
	for <linux-dwarves@archiver.kernel.org>; Thu, 15 Jun 2023 15:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343845AbjFOPPv (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 15 Jun 2023 11:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241131AbjFOPPt (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Thu, 15 Jun 2023 11:15:49 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32131FD5;
        Thu, 15 Jun 2023 08:15:47 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f764e9295dso3404632e87.0;
        Thu, 15 Jun 2023 08:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686842146; x=1689434146;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YUaNNvZJKqvPxJEh/yVf9+7PUgSKVV+0gV2t9sS/ypA=;
        b=gtBkvbmC3awURjBcjuKRpkhNYHCGwqQEiP6++Pg23rRI2myK8abB/2Yrc28Ahk05RB
         mGwlv917eC5NWYSrmwmqPEzLf4v1pJo0M6q3ztvTmxAp2rtvnOMp7n0NxqQrct2zFgsr
         ATAk2MXKyVx2E3J6DsT5aVsEJHmQnwYso/xL7lla2Dv1hpA8XqP9qzy+jpIBa15Du+Z9
         uUax8ZynxmYBl9hOKkVYsS4zRh4DO8DAcT+KZvG5fWLwj6Us0+g+nmMxNa/N3OVoKGF9
         UceRQxmE7eayNwl5vLvnxp+ScOrgaC+AKoTa7TKQQooSCD0LkEn31+kSZf+U4EWpZceI
         syIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686842146; x=1689434146;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YUaNNvZJKqvPxJEh/yVf9+7PUgSKVV+0gV2t9sS/ypA=;
        b=T1MgtlidX3Ni0wYIp3HdvLP9ZFIaPhZlzaP2SFTz23tY+d9k9O6AuFYLD8U7qNtHUz
         ePB4cxEQ2kKwM9gN8wodkpBQG1vy1d//CoB0uRgdmIAiuXQ/W9rI7jgoR/rJuRRgVMnd
         7UJF2GBZ0mWg79RW0AEPfAVjJptO4dKjgNXVgOPbJLC5YWZ45XsIkx2uKx9kDb2fQ9fb
         FxfyhDH5Eg1xbPxJBngsVoD0kQw0JWenZ33ZOSQB5Eyrw26j7yd/tC91o5JTRLR4ELd2
         H5xQeBgPUaQ5lEuBHv+wWGCOSVcnmRWtQbs65yL3Iz+bVYp8x+jL+P/Q8CHGbN+TYK3a
         5PXQ==
X-Gm-Message-State: AC+VfDy3i+y2iLJs+fpGX/3Qx8SW5JfTmuyTcEA6EQxEliVzqBPcrQHQ
        AmnluZ/ERrf/clwCX4Mx8ys=
X-Google-Smtp-Source: ACHHUZ7LhhmoE7hT+VcIyuQuudJ0L1nUjSBZ3wptDDSycMrHh+TqsBiBWohqsUUEKBo6/BEHPQn0Kw==
X-Received: by 2002:ac2:4d96:0:b0:4f6:259d:3d40 with SMTP id g22-20020ac24d96000000b004f6259d3d40mr9934961lfe.2.1686842145828;
        Thu, 15 Jun 2023 08:15:45 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id 16-20020ac24830000000b004e95f53adc7sm2639097lft.27.2023.06.15.08.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 08:15:45 -0700 (PDT)
Message-ID: <8d6c094ec12c32e4166299f4a89be7fa4d0f9360.camel@gmail.com>
Subject: Re: ppc64le vmlinuz is huge when building with BTF
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Dominique Martinet <asmadeus@codewreck.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        dwarves@vger.kernel.org, bpf@vger.kernel.org
Date:   Thu, 15 Jun 2023 18:15:43 +0300
In-Reply-To: <ZIqGSJDaZObKjLnN@codewreck.org>
References: <ZIqGSJDaZObKjLnN@codewreck.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Thu, 2023-06-15 at 12:32 +0900, Dominique Martinet wrote:
> Hi,
>=20
> coming from alpine: https://gitlab.alpinelinux.org/alpine/aports/-/issues=
/12563
>=20
> alice noticed the kernel packages got quite bigger, in particular for
> ppc64le I've confirmed that the vmlinuz file size jump when building
> with BTF:
> currently released package with BTF:
> https://dl-cdn.alpinelinux.org/alpine/edge/main/ppc64le/linux-lts-6.1.33-=
r0.apk
> 272M	boot/vmlinuz-lts

Hi Dominique,

I've just checked the linked apk and it looks like DWARF sections are
not stripped and take most of the space, e.g.:

$ llvm-objdump --headers boot/vmlinuz-lts | grep \.debug \
  | gawk '{ sum +=3D strtonum("0x"$3); } END { print sum; }' | numfmt --to =
iec
228M

Compare this to BTF sections size:

$ llvm-objdump --headers boot/vmlinuz-lts | grep BTF \
  | gawk '{ sum +=3D strtonum("0x"$3); } END { print sum; }' | numfmt --to =
iec
3,9M

>=20
> test build without BTF:
> https://gitlab.alpinelinux.org/martinetd/aports/-/jobs/1049335
> 44M	boot/vmlinuz-lts
>=20
>=20
> Is that a known issue?
> We'll probably just turn off BTF for the ppc64le build for now, but it
> might be worth checking.
>=20
>=20
> While I have your attention, even the x86_64 package grew much bigger
> than I thought it would, the installed modules directory go from 90MB to
> 108MB gzipped); it's a 18% increase (including kernel: 103->122MB) which
> is more than what I'd expect out of BTF.
> Most users don't care about BTF so it'd be great if they could be built
> and installed separately (debug package all over again..) or limiting
> the growth a bit more if possible.
> I haven't tried yet but at this point ikheaders is probably worth
> considering instead..
> Perhaps we're missing some stripping option or something?
>=20
>=20
> Thanks!

