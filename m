Return-Path: <dwarves-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0412CC61DA4
	for <linux-dwarves@archiver.kernel.org>; Thu, 23 Feb 2023 20:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjBWUsB (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 23 Feb 2023 15:48:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBWUsA (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Thu, 23 Feb 2023 15:48:00 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B28114EA4
        for <dwarves@vger.kernel.org>; Thu, 23 Feb 2023 12:47:59 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id bi9so1213894lfb.2
        for <dwarves@vger.kernel.org>; Thu, 23 Feb 2023 12:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=e45iNqzsYR9ZXrZFkAtsllYBHd9FAtMdwEZKCLF39TU=;
        b=PpIh/BHndaNoBYfRpu1uaCkHMlSyEKfOv59/cfsjac9+3/XlAV5U/QJvsKW5+XMAr0
         IQ0yIgLLpm1crFL0SNwLjohuehAV2OaP+1jIKwnPDS+lpeIqQVOAossjGSGV16g//CiC
         YuHMSE47u57RI1b7RIpbqmCxo3W/rEaz7kOj0l83KBtdja2GSq4ZGStseQsSMmM+qJfQ
         EfAZCMdIDSDn8WWCSMXCCOaJeb4K4Z2dqoNfsJFliuEWNsi5W+5Iy9fGuH9lgb2uh0ex
         LGCk/FnBcr1UC7cIRtmUd14V//d6Kp0TD42ZdA7koN66NjMlzv48snAMiuSf9dp0ehGF
         fmrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e45iNqzsYR9ZXrZFkAtsllYBHd9FAtMdwEZKCLF39TU=;
        b=UYrMUa+akWuipmeMm65LH13JX+gvfLfdmPFNu2tdzSBBtaiP9BDMfeSb8OTjoDRpsE
         l4VUl3hRMOUieij+48n21BRclZS4jSw3FjoWigXH/lrXTXLi/p31FIsSH9voFhNxa1al
         ehAuMR+0uUrJAcN0gB+TGkZn3YNcuzfcxS15/3klUSvBdD9Rj/BGSDKhpvPEUYpskWUA
         i9NjxzMVlKgEtTpPw2qdmMIGrgaHfwru6+FhrobxnIMewKe27hxTzYSeoFfqzfLC7QGz
         HII6Sdi5bDdLfYpUqgEKtPCvHEaH1vsXarXkcQf6Cy1imMPKV3cM8/c2iykHXrYYEEVR
         wOCA==
X-Gm-Message-State: AO0yUKUlUE58YgCMpCQVfNjHwSrd8t2Ovp9GjL57GtqSEZNpRUhCRFcd
        jzgCKSnDo6A7Qp/hDehkLHAbktvv4iPe8y5U
X-Google-Smtp-Source: AK7set8Yg5QH0cF6J2cjhpqvGeC8Wk+TU1i90frb8/IP6DYC4cpS/Jw0JcQEioxGy0OzkZKE/aiOnQ==
X-Received: by 2002:a19:7502:0:b0:4db:3cea:ef02 with SMTP id y2-20020a197502000000b004db3ceaef02mr4836361lfe.68.1677185277175;
        Thu, 23 Feb 2023 12:47:57 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id l9-20020ac24a89000000b004dc7fae3cfcsm1503780lfp.75.2023.02.23.12.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 12:47:56 -0800 (PST)
Message-ID: <92b71fbfc8d768103d533d3b0edded0bd6750b0f.camel@gmail.com>
Subject: [question] dwarves/pahole testing
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     dwarves@vger.kernel.org
Cc:     arnaldo.melo@gmail.com
Date:   Thu, 23 Feb 2023 22:47:55 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Hello Dwarves community,

I have a set of changes that add support for "btf_type_tag" attached to the
hosting type, as discussed in [1]. I'd like to test these changes before
submitting via this mailing list. I have some local tests for the feature
itself and I checked that kernel build / BPF selftests work as expected.
Are there any additional tests I can run?
Maybe some manual testing procedures?

Thanks,
Eduard

[1] https://github.com/eddyz87/dwarves
    Dwarves update to support btf_type_tag:v2
[2] https://lore.kernel.org/bpf/87r0w9jjoq.fsf@oracle.com/
    Discussion about update for btf_type_tag encoding in DWARF

