Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EB813664A
	for <dwarves@vger.kernel.org>; Mon,  5 Feb 2024 20:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707165597; cv=none; b=OD/VoG44Cavsgvc7kImPo59khINgykIoUzP5afqYsmpeS2+kkiKMFBTX0hAe/jlipdctbi5lr8x1tt+Is3/T0w0zVbag9OFYBEx5aiKqLpiOT/H8Un1UlWPnXmEsYFbqz6B29UWRjBVSjxlwy1HofBCBLmEj+pBYeJnbK+aUUe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707165597; c=relaxed/simple;
	bh=8FLHVPDIrh8O12wQRZOYHhqGV0FqoBujpp6trk+Vdsg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iarmwKHpKHAOMiwxyqFNVOS0X2vm1TFfUfG+/hObKDAlG1x9I0Dm3Ns+xNPr1fJIUfNcwwySYowijMzoD5eS+FdeCPoSZOLSVK4lPps4nedubhyJjGQmEMIQCaHoxfwd4ldsI+Q8JdgO/nViYOT75OPmFIVHHfyqCe00qkYvU5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NeEvxdJT; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NeEvxdJT"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a380a1fa56fso32917866b.0
        for <dwarves@vger.kernel.org>; Mon, 05 Feb 2024 12:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707165594; x=1707770394; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=saXiP78+5zyAJswsdG09t0N1UVuMMNPV+Q42/KAgx8M=;
        b=NeEvxdJTSXdHc9BdmNDsiIhGkOKsuABuJghDWI4WzfW6yOsY4QKqnDRBWIYa2vfBBL
         1UAzJiEbFx+XbJlOmiRy8tC8TD4mbMeyikVXoMjxH74171bKzUoz035Ui8Gi3lt2LYNr
         GZedRVN491eeZ+Tg1eRtZ4eUsMR/14M4eS32LeznXpuCJDhJc0TvOflZNeCT4ezjr9Ph
         K3tHvxuPz+57jd2W2+BrKSIT6rDZKhtpaTpUWNIjEKClSWPMNvhUHQwJn97AYoO+Hx/K
         Fc3GiRAGFL2iSlwqqjQ/RBMOVkg8jIsRzngqWURjygmmcNnT4I4QPINX7U6Vwg0wBXFL
         +TeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707165594; x=1707770394;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=saXiP78+5zyAJswsdG09t0N1UVuMMNPV+Q42/KAgx8M=;
        b=WRufAabU2G1tp5gc8BPYroplFcBg/W0xCHe1hQyozbnWdQm1hoGzPydFrvghdd0qy8
         exmZf9SgDaOR47YiS3qmUw0RDqrd83q518Y2wrp5DS0hoFgqzVXNVG7xs43U2WY1EPYY
         nlixNVidG/zJrC+FLu9qiqHMEpRDS0r31B+JuRGssI0m2y940DKdUsG0ein6RtVH99sC
         w8ZafozjRbrixr9FH73iSxyw9hfJ+mfw8WbpulyBZZwGyZMWv5EhlH7ETp+Mq9jQhKvw
         PYi0lA6OuYTPRUIHPsvZds00ORgjYOj0O1ZqJnzS0NnD7+CFpW6FTpoI+Z3SKy82t89P
         e4MA==
X-Gm-Message-State: AOJu0Yy2xKWeV3yQtmk56yFoKxcyaXMlVE5hEaFVY21wzln5uB0x1V3h
	Dqv42Khfq6hAhQqIeX3EDur0bmtzBf7w6zn49kfeaXHR1XxCKlHN
X-Google-Smtp-Source: AGHT+IHlc34wa92e1YiGozHK6Vf3D6DjcB68ePWxKcpTJMSqv/r61J9cOqncDh5pXhJhUlXBR1Lrmw==
X-Received: by 2002:a17:906:1c05:b0:a36:877a:edde with SMTP id k5-20020a1709061c0500b00a36877aeddemr838754ejg.11.1707165593798;
        Mon, 05 Feb 2024 12:39:53 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW1bMrCg2W0tjuFGIUvC0Q8aTk+43SeLjQej5XVnLfIclnwUMWunpuD/TbwvzIzOq26RS5jogCTag38MhrfIsYiHutS689Rqg==
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id c6-20020a170906340600b00a3550c56127sm237353ejb.9.2024.02.05.12.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 12:39:53 -0800 (PST)
Message-ID: <72898cd3fffb42ad3af8adf3f2faf83e25639383.camel@gmail.com>
Subject: Re: [PATCH 1/1] pahole: Make sure the features string is NUL
 terminated
From: Eduard Zingerman <eddyz87@gmail.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Alan Maguire
	 <alan.maguire@oracle.com>
Cc: dwarves@vger.kernel.org
Date: Mon, 05 Feb 2024 22:39:52 +0200
In-Reply-To: <ZcE1PJ8MPXzVb3mJ@x1>
References: <ZcE1PJ8MPXzVb3mJ@x1>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-02-05 at 16:21 -0300, Arnaldo Carvalho de Melo wrote:
> To address this compiler warning:
>=20
>   /home/acme/git/pahole/pahole.c: In function =E2=80=98parse_btf_features=
=E2=80=99:
>   /home/acme/git/pahole/pahole.c:1353:9: warning: =E2=80=98strncpy=E2=80=
=99 specified bound 1024 equals destination size [-Wstringop-truncation]
>    1353 |         strncpy(f, features, sizeof(f));
>         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
>   $ gcc -v |& tail -1
>   gcc version 13.2.1 20231205 (Red Hat 13.2.1-6) (GCC)
>   $
>=20
> When building in Release mode, for instance by using the buildcmd.sh
> script.
>=20
> Cc: Alan Maguire <alan.maguire@oracle.com>
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Fixes: 7bc9b9975545ab53 ("pahole: Add --btf_features support")
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---

Can confirm, warning is fixed by this patch.
strncpy() API is not great :(

Tested-by: Eduard Zingerman <eddyz87@gmail.com>

