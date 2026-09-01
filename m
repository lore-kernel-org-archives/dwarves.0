Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0FD46AA91
	for <dwarves@vger.kernel.org>; Tue,  1 Sep 2026 13:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788268923; cv=none; b=E1WsT73iRwRaT2dH4+MPx1a+rlOO+E91NnONMe+U9dUfaFUm/BN1Ryo7TUd552UBl6+0ZBgA+69nWGfeDliIvgvL9xar+GpibHA+HJM9RD0v6FfFgVd+F6zxrqDJCTyyWRLZJjTfLf6yfabr7venk7BRJOylJS5gEfxgIJKVkow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788268923; c=relaxed/simple;
	bh=LmUjGM56hg00cW5dAYvVPXz1kcMr1V0BqBu/1ztdbt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pnYdSCrlijPs9pZr4MULfqzu7BigMvyMaherTxwaINccUxqbDXY1R5guRe6U5Sb9go0CRriVcq2nbTXkPWwoox7LiWOexNT0aSXoU7AaOgAgDZv4dVx3os9QZhw4c8GOTdoXXT0hLavV6R342LaU+n2rFqFmIPewzp7kQHteNdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YKPcIa6f; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YKPcIa6f"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6a0c8283146so403366a12.0
        for <dwarves@vger.kernel.org>; Tue, 01 Sep 2026 06:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788268920; x=1788873720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pQvNVTQ5x08nGo2AwlqOQ9rVaZ0HkPe7q02EyHhKULg=;
        b=YKPcIa6f9fQQl9Dhr3Ms9+jBMDsjKm9q11zlhtlAtNeJ+ZlWn/4NzaId19IyiZMBWk
         azb1mpgjh6m9AhrlbNd9Rte2BrCfsKGIO09BE0Z2XcX9BAadl+ydmnzlZ2HAau2EqI/g
         6lHWrkBiquPH1dUPv6+h2R4SpFXRQd7pbTkaxkzYutFn8479IqtKDtMKEXxi1aoACOf1
         yAE35QryRq/mB1Q9JvUb52J3djzTPxp4RFMXpmuENgLoX/JOrQ+zHerNrgsgrHfWB4hv
         RXL0X3r8LcP38xaB08UYf94BDRMoqA5JGde+OKSgVrDF4LkBtuxkiWof/MpAnI7lpyjD
         Mbyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788268920; x=1788873720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pQvNVTQ5x08nGo2AwlqOQ9rVaZ0HkPe7q02EyHhKULg=;
        b=TO+FCH4WLN3NY5DW5QiRsia6i567S+zyTzhAReJmU5DOFmUjQa7TmYvkwWDLUHismK
         TY+0V8tx/u21jxWg8pmlwBgaWeEW9d8JQA2kAjiLflgqcYJon3IjpsolxAvpGq+nvK0e
         z3aysFga8n7SgBupsKwRlGKyqBoxdj4RRfI7s/Hldtltyjg8DIQ0jh0eue1ouMmmpuz7
         tt6zxEAdCJ/i01eFRyfuOxcINQrRmUzGXqoGt2q50jHDjwewvLPGq4vXLwr/igJRDs0d
         51YSOBbODytIAd4MvEimg/hGxeDJ5XKEf7v1X4HPivDcRflK64MHjS75DeUZhbQNceBi
         eNLg==
X-Forwarded-Encrypted: i=1; AKwUvBzuzYGhy70NmNEoX8knyVzRDajEJyfYmKCirPJfDa0mspiWTsWKhxKU7TgADeNf7v5ViOEPc1XQ@vger.kernel.org
X-Gm-Message-State: AFuF++lfzleVg3tJhoocMsAOdlLlAMcj1brFQysWEKeHj0EQbfC8/jit
	T8qep39VY4j61UHx+0BsfKM4Hnhr4blnHBgG/ggG2lp2yTnFt8haiMI4LDstePO4
X-Gm-Gg: AYBFou3EhhbJUMET7ssjWxcfiJkeiCo8T9XhMZsq80ShD+UkMn/ZT/g2APl8/SUfkuq
	t51MGreFdXqs+xAhN910gaItv5Xp7xzaISa4/sshLB0um2V8SMdziwMiLeJArlNlFiiptLFxfMq
	yBE7ISRYgXauWEhmCXzlH6DFAjpdGUEDlUYOVlN9BIalxpRzdsL70saVqJsw3rJ+ebu9OeBZEOQ
	XoRZ4CkpO9V+UrRtEi2akJqx/3Wx2nR2SLFiGuSFYSXEtnJcG4Iq3TyBKGLUbuj4i5Un5ZmdVYH
	ZuEyyrFNxyNvCW3irs1/aWDCms75+2EWG5B57SCM/n+4Ut8uNZH9EFujAyGD7COGje7ofWm7rMq
	A6NiaKjjcU2WOEv+PZYYl1/iGJT3h1X/GUZTU4HDJrJ+dUkHEoT2vFMpkzSLEE0cBXnCivjH0aU
	/1c79IPfkStTM3ZWnJd9sBmXW3nvoZDNQHKfhkgPKGlQX1O3+CcYOmn1bRnH0mUkcIh/uZ59S+K
	1wtI0rUX+jagvy5NQ8ASlNREOjK+71Fu+mc3QLFUFGf0ipaT1vdJOkwmYDmoe6hWE+EHTkxsDIO
	VtS9dqWJ1myD+qCrI3pxs2IDjIgYL4OuNCYLEzDCRbMlbZwn
X-Received: by 2002:a05:6402:2483:b0:6a3:8652:a373 with SMTP id 4fb4d7f45d1cf-6a663a61f85mr7065329a12.3.1788268919424;
        Tue, 01 Sep 2026 06:21:59 -0700 (PDT)
Received: from ip-10-0-1-42.eu-west-1.compute.internal (ec2-34-242-91-155.eu-west-1.compute.amazonaws.com. [34.242.91.155])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a66ccc8c24sm850110a12.7.2026.09.01.06.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 06:21:58 -0700 (PDT)
From: Aditya Dutt <duttaditya18@gmail.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Aditya Dutt <duttaditya18@gmail.com>,
	dwarves@vger.kernel.org,
	Alan Maguire <alan.maguire@oracle.com>
Subject: Re: [PATCH dwarves] pahole: --unions shouldn't bypass struct-only options
Date: Tue,  1 Sep 2026 13:21:35 +0000
Message-ID: <20260901132137.1206269-1-duttaditya18@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <apXzlIKeb4tc8x88@x2>
References: <20260831185641.971022-1-duttaditya18@gmail.com> <apXzlIKeb4tc8x88@x2>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Aug 31, 2026 at 06:35:16PM -0300, Arnaldo Carvalho de Melo wrote:
> Please split this into multiple patches, so that we can cherry pick
> independent patches when we have some issue with one of the patches in
> the series.

I'll split this change to 3 patches.
1. Fixing only the segfault by adding the guard at the top of
print_packable_info. Contains the Fixes tag.
2. --with_flexible_array and --with_embedded_flexible_array guard if !struct.
3. In the case of unions, don't ignore struct-only filters.

Is this good, so that whatever is needed can be picked up?

> I can imagine looking for an union with bit holes:
>
> union x86_pmu_config {
> 	struct {
> 		u64                event:8;            /*     0: 0  8 */
> 		u64                umask:8;            /*     0: 8  8 */
> 		u64                usr:1;              /*     0:16  8 */
> 		u64                os:1;               /*     0:17  8 */
> 		u64                edge:1;             /*     0:18  8 */
> 		u64                pc:1;               /*     0:19  8 */
> 		u64                interrupt:1;        /*     0:20  8 */
> 		u64                __reserved1:1;      /*     0:21  8 */
> 		u64                en:1;               /*     0:22  8 */
> 		u64                inv:1;              /*     0:23  8 */
> 		u64                cmask:8;            /*     0:24  8 */
> 		u64                event2:4;           /*     0:32  8 */
> 		u64                __reserved2:4;      /*     0:36  8 */
> 		u64                go:1;               /*     0:40  8 */
> 		u64                ho:1;               /*     0:41  8 */
> 	} bits;                                        /*     0     8 */
> 	u64                        value;              /*     0     8 */
> };
>
> The sum of that bitfield is 42 bits, so we have a "padding"/hole of 22
> bits in that union, can't see quickly a use fase for this right now, but
> maybe someone can have this corner case need?

You can already get that using 'pahole -a -A' (both flags are needed).
For example:

	$ cat /tmp/a.c
	typedef unsigned long long u64;
	union u_hole {
		struct {
			u64 a:8;
			u64 b:8;
			u64 c:1;
		} bits;
		u64 value;
	};
	union u_hole u;
	$ gcc -c -g /tmp/a.c -o /tmp/a.o
	$ pahole -a -A /tmp/a.o
	struct {
		u64                        a:8;                  /*     0: 0  8 */
		u64                        b:8;                  /*     0: 8  8 */
		u64                        c:1;                  /*     0:16  8 */

		/* size: 8, cachelines: 1, members: 3 */
		/* bit_padding: 47 bits */
		/* last cacheline: 8 bytes */
	};
	union u_hole {
		struct {
			u64                a:8;                /*     0: 0  8 */
			u64                b:8;                /*     0: 8  8 */
			u64                c:1;                /*     0:16  8 */
		} bits;                                        /*     0     8 */
		u64                        value;              /*     0     8 */
	};

The padding is for the anonymous struct and not the union itself.
Does it make sense for '--unions' to show the results for the anonymous
structs inside a union?

Maybe a '--recursive' modifier is better? Which looks inside
structs/unions and unions when applying the filters, so that the outer
struct/union returned if a filter applies to any inner struct/union.

> > --with_flexible_array and --with_embedded_flexible_array were missing from the
> > struct only list, so add them too.
>
> Well spotted, please put this in a separate patch, with the
> corresponding fix.

Same thing here, a union cannot have a flexible array directly but a
union may have a struct inside containing a flexible array. Maybe a
'--recursive' modifier makes sense? And optionally, you can specify the
depth to which we search '--recursive=2' etc.

-- 

Thanks,
Aditya Dutt
