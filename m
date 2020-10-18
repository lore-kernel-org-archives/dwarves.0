Return-Path: <SRS0=7/3o=DZ=vger.kernel.org=dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D6AC433DF
	for <linux-dwarves@archiver.kernel.org>; Sun, 18 Oct 2020 23:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AB8221D7F
	for <linux-dwarves@archiver.kernel.org>; Sun, 18 Oct 2020 23:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uLuIuh69"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729606AbgJRXSq (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Sun, 18 Oct 2020 19:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbgJRXSq (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Sun, 18 Oct 2020 19:18:46 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13237C061755;
        Sun, 18 Oct 2020 16:18:45 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id h2so4043198pll.11;
        Sun, 18 Oct 2020 16:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=FO4mDbBP+BBfJY9p5OcubUJVlHsGofkZoBj46ylAG8g=;
        b=uLuIuh69ehJGgDQl/M0MaznpaQmYZK8Lie2BYp9rFv0Vpo3F2voQ7mey6a+FGx0cIM
         slu+VPuGgQKCWqrUM9LgEUefsoIAp36fCObpOmzYRkKnhxof/hTD0fe9rplfs5UCbaX8
         vzAEqBaABboOkHi4e2I/8nItVwHcd0Ki8XnyL2QhT9K8xnnArNgHKGSitYQ9w7x6P8Vs
         cdH84ik55/Wc/ARFzD75RquR6MctBxTTPkEK/7h6JWkwyFECm591eyKL2kLpWHSHAri0
         4OuG1MC0XA0yiqnsWKlO7+HRdTMPxskLMrADd81xeuOC8eYtnHTXjk954r45EI90LiSU
         APxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=FO4mDbBP+BBfJY9p5OcubUJVlHsGofkZoBj46ylAG8g=;
        b=WpAtRVS7aS5NgRdJKJuEPs+0s0CcO0xnw3MryBThypqDxySaT/g0ncsYNvaXB6qNGt
         c7GRFoxcjmPrPDWJ7kKh5tDQbyTrwuk9Hjxm+EtMSC9+ExlYtea/AljTpFK0PB4Npcxo
         avxpRsgpBVC9nWrN88tr4BosO1NJSsC9rB7VJRcgSexj8qutYoMpboO8ThYmjtJlBP2e
         xMLDwxAcWa/M+VnQOdiHqhpX/XD3sD1AeGCUfObiRxNpdH0zNwCIdMEsmYT00UnBglAn
         5Z/EFd6S5XlXg45ei6BymDYgruFUH55FVxLyOBcHDUXsxPQUcV3Zj2ie3RMSjGorzVt/
         efOg==
X-Gm-Message-State: AOAM531n6MUqNNI3rEmPfUQCT6YoFJz8KBLT+rWhirHRpYNiSZcRFz4d
        cZa/E3nHBUWNIkH8BrqB8bUaSqVrch/HJLkH+kRZ38j2urbX6Q==
X-Google-Smtp-Source: ABdhPJwB5VaEhdoWIuYtVmphOtsWH2XZq6Q1sXDpZ7iCjElLYhrwLRWhpgaY0xXrb369NRSXdRPEmmGaeMK6Y+j1obk=
X-Received: by 2002:a17:90a:8684:: with SMTP id p4mr14503486pjn.232.1603063124327;
 Sun, 18 Oct 2020 16:18:44 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?w4lyaWNvIFJvbGlt?= <erico.erc@gmail.com>
Date:   Sun, 18 Oct 2020 20:18:33 -0300
Message-ID: <CAFDeuWM7D-Upi84-JovKa3g8Y_4fjv65jND3--e9u-tER3WmVA@mail.gmail.com>
Subject: Segfault in pahole 1.18 when building kernel 5.9.1 for arm64
To:     dwarves@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Hi!

I'm trying to build kernel 5.9.1 for arm64, and my dotconfig has
`CONFIG_DEBUG_INFO_BTF=3Dy`, which requires pahole for building. However, p=
ahole
version 1.18 segfaults during the build, as can be seen below:

PAHOLE: Error: Found symbol of zero size when encoding btf (sym:
'__kvm_nvhe_arm64_ssbd_callback_required', cu:
'arch/arm64/kernel/cpu_errata.c').
PAHOLE: Error: Use '-j' or '--force' to ignore such symbols and force
emit the btf.
scripts/link-vmlinux.sh: line 141: 43837 Segmentation fault
LLVM_OBJCOPY=3D${OBJCOPY} ${PAHOLE} -J ${1}
  LD      .tmp_vmlinux.kallsyms1
  KSYM    .tmp_vmlinux.kallsyms1.o
  LD      .tmp_vmlinux.kallsyms2
  KSYM    .tmp_vmlinux.kallsyms2.o
  LD      vmlinux
  BTFIDS  vmlinux
FAILED: load BTF from vmlinux: Unknown error -2make: ***
[Makefile:1162: vmlinux] Error 255

It is possible to force the build to continue if

  LLVM_OBJCOPY=3D${OBJCOPY} ${PAHOLE} -J ${1}

in scripts/link-vmlinux.sh is changed to

  LLVM_OBJCOPY=3D${OBJCOPY} ${PAHOLE} -J --btf_encode_force ${1}

The suggested `-j` or `--force` flags don't exist, since they were removed =
in
[1]. I believe `--btf_encode_force` should be suggested instead.

It should be noted that the same build, but with pahole version 1.17, works
without issue, so I think this is either a regression in pahole or the scri=
pt
will need to be changed for newer versions of pahole.

- [1] https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/pahole.=
c?h=3Dv1.18&id=3D1abc001417b579b86a9b27ff88c9095d8f498a46

Thanks,
=C3=89rico
