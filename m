Return-Path: <dwarves-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A27C61DA3
	for <linux-dwarves@archiver.kernel.org>; Sat,  4 Mar 2023 01:31:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjCDBbW (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Fri, 3 Mar 2023 20:31:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjCDBbV (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Fri, 3 Mar 2023 20:31:21 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5163660D5E
        for <dwarves@vger.kernel.org>; Fri,  3 Mar 2023 17:31:20 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id f16so4118558ljq.10
        for <dwarves@vger.kernel.org>; Fri, 03 Mar 2023 17:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677893478;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YFKFEsEXiU8dXQYS6fk5z249RKAtuax94r9kObgH1ns=;
        b=jGFLJ0AyUHoG8mkO/bognQuYHQ4i3rG5u3XM+UMrZQhZ+M8DKrgn38WTsOn14R4qF9
         /D6yyMQzdbMU1sc1rvlYnCcR04V6XSFT84FdX2pYGisobo/ixhLyMvJcSFoVOlPsftuY
         bZHKZA2R7eNBCK3CdQHjjMscaa9hy9CdnX6zlaPpitAnkGpkeNhRobCrgEqZWlTUP305
         vZ8c35JrPYBueSZVS93jfh0xgB+l1OdfgLSxdJ4norJdnDHxrHR3rZjhkza4T8Etm/oZ
         3qXLpNGET+DG2KOC0FXjtXJLxYCTQCFwvTcm8PF+8RT6bcoCfy7cDrDmVzPI9zpNOImV
         Li+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677893478;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YFKFEsEXiU8dXQYS6fk5z249RKAtuax94r9kObgH1ns=;
        b=BTuz1gzC9tXF0nhv+cCYF5l/niJk8TwUNhwGWz9FJrGWanu+JyqAUo4hQewyyw6vff
         s5YaEaneAj+R0hxGhKDHCUeSWNchUeemRELSvNQF6gXwMG+55GJOAMTvztwba/ojeadp
         nzVpOXmDtyQOldrPUz8/TP51jqiQC4mrgfFbvbnx5GFcXgl7OF/AF2JH72GYNob2SZKX
         mSmFnBmHfakwmZbxpy5/uK6an3Pq7TWUfAXyKYIVXk9UV1oEU7tmAW/Ux/AukU35szTV
         B/3YwFs6G5DyDSpEpr8qcAUTBl+wt86y9HOk5RtT1qTJiIXvstRxKMExl1/pGAaVwAUW
         sc0A==
X-Gm-Message-State: AO0yUKUs0EpAOpK5kgG3DntRXlblCi1FU8LlszZRp7PMpNZ5wbgv07vM
        C+7jRZp2nv/8aNxeNxu7qDGvNhrBmE8=
X-Google-Smtp-Source: AK7set8fC6YjxtIhnSyI0Pv5rL64DCKDmNUg2YzflAKYUO6BQR/8QL5pLot8mc+el6+bKPf4T7JNQA==
X-Received: by 2002:a2e:9089:0:b0:295:a2cf:b1ca with SMTP id l9-20020a2e9089000000b00295a2cfb1camr1078652ljg.14.1677893478402;
        Fri, 03 Mar 2023 17:31:18 -0800 (PST)
Received: from [192.168.1.94] (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id z13-20020a2eb52d000000b0029839faa74fsm163490ljm.134.2023.03.03.17.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 17:31:17 -0800 (PST)
Message-ID: <62cd4979a4080f3529f1bdf61639c6feb490af01.camel@gmail.com>
Subject: Re: [question] dwarves/pahole testing
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     dwarves@vger.kernel.org
Date:   Sat, 04 Mar 2023 03:31:16 +0200
In-Reply-To: <Y/5jGjgCdQpUe1Ak@kernel.org>
References: <92b71fbfc8d768103d533d3b0edded0bd6750b0f.camel@gmail.com>
         <Y/5jGjgCdQpUe1Ak@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Tue, 2023-02-28 at 17:24 -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Feb 23, 2023 at 10:47:55PM +0200, Eduard Zingerman escreveu:
> > Hello Dwarves community,
> >=20
> > I have a set of changes that add support for "btf_type_tag" attached to=
 the
> > hosting type, as discussed in [1]. I'd like to test these changes befor=
e
> > submitting via this mailing list. I have some local tests for the featu=
re
> > itself and I checked that kernel build / BPF selftests work as expected=
.
> > Are there any additional tests I can run?
> > Maybe some manual testing procedures?
>=20
> You may want to test using 'btfdiff vmlinux' after encoding BTF from
> DWARF.

Hi Arnaldo,

Thank you for the recommendation.

I've noticed that with my config this method might get a bit
non-deterministic because of the following two data structures:

drivers/net/ethernet/intel/e1000/e1000_param.c:
struct e1000_option {
    ...
    union {
        ...
        struct {
            int nr;
            const struct e1000_opt_list { int i; char *str; } *p;
            ^^^^^
                 this const is not present below
        } l;
    } arg;
};

drivers/net/ethernet/intel/e1000e/param.c:
struct e1000_option {
    ...
    union {
        ...
        struct {
            int nr;
            struct e1000_opt_list { int i; char *str; } *p;
        } l;
    } arg;
};

Both are present in the BTF.

As far as I understand, which one would be picked by
"pahole -F btf --sort" depends on exact order of types in the BTF,
because:
- `pahole.c:type__compare_members_types()` does not compare fields for
  inline structures;
- `pahole.c:type__compare_members_types()` ignores qualifiers;
- hence, `pahole.c:resort_add()` considers these types identical.

I can try to modify the comparison function to address both points
and thus generate both versions of the `struct e1000_option` in the output.
Is it worth doing?

Thanks,
Eduard

> =20
> > Thanks,
> > Eduard
> >=20
> > [1] https://github.com/eddyz87/dwarves
> >     Dwarves update to support btf_type_tag:v2
> > [2] https://lore.kernel.org/bpf/87r0w9jjoq.fsf@oracle.com/
> >     Discussion about update for btf_type_tag encoding in DWARF
> >=20

