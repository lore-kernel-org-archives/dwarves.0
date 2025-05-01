Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4138816DEB3
	for <dwarves@vger.kernel.org>; Thu,  1 May 2025 23:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746141949; cv=none; b=QrMF4qsN7Q4vhgyeFGOmcz2Ln93i9DwS/nP8Jcv1hv72UUOOzCDchA4uYkALPBCZloF6KcB0xV+NRrY4DCrJzM0v5Vlg+csDjzkjlQiiM9qXEqEHMDKikGxg7VlKweScgePMmaZylNCvtY2NB2adYCnY29SmAyxLi0hPk8U18T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746141949; c=relaxed/simple;
	bh=Ho9ifl9Bg/RFhgXg4jornoxOpvU4nqzxE7c6QVkFLhI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ciThv/KHG7+HaiZamoelagoPxRBooSViRo7B+GWWUy7d8LtF5SOlyUqWJSqjd8BADY6qy2wPiSoM+T46kCA6pf4X1Q8sJCkM5WpdnsL5ivRokUt/fYCHdF/6Gkkws7+eCz6fvJtm2ohBGaTJoGcZqJ2uSDGon+tu6uz/fUI+EH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kq32fWPk; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kq32fWPk"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7376dd56eccso1728421b3a.0
        for <dwarves@vger.kernel.org>; Thu, 01 May 2025 16:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746141947; x=1746746747; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qvgZM5Vhz0lGODkEv1xd8dgQPkGWwezfV8YiDHE9i+w=;
        b=kq32fWPkC1i5mPLDZPoiN7gm8wG+eoaHPaDJyyKwTG0cB3BYTd90AuXBsz5GTr74wg
         +VZZpfqZm0NnY9w/UiCFn3HphTDh3cYzXszumBKU/VvUq4JRkgUN7C/EMWe529RnCSZZ
         1zNdN5ipbYvEa+MRIOpDz7RhwqWMbU4buFZ/3ITxy0CYqpgFzlTPYik8kuhofiL7NL/a
         fZT8PEnKR0PzF7Vs78ZW2jTPL0xXsU4nHlM0VJeLGJY+CH9F8AAlsd9LpdebdbZnEFee
         64mLrcLAuHI7TiJL1Mssky5omw4pdi7dQPRGku4pWoi+zCK9yTAA6fom7hGatzsQGXVG
         DB5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746141947; x=1746746747;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qvgZM5Vhz0lGODkEv1xd8dgQPkGWwezfV8YiDHE9i+w=;
        b=sFMg0oD5QYFckUKgr4A8jEXI3q9xZ+e5YH+Gyk8gmPTq+7ZeowULGfnlxYGWP9ig9X
         1jEPfUMcEwA33fraiUw6S1tk/lX6WKrYOblyiGRSaLo9Px/OTLEoQ1SFy6xTO0hRP379
         WxDjJ847tXboy5UJlYddgSP2F8N/K9rqO5SYF2GytL+8mfgI4fwzhccXRaDerISLDaGs
         ZQSJaF8Ha+ClXJCpzFjoyBspn+xxw0mTdeCVynX7sQTBtnv14Bw0rrwHWELjd4Nx80iK
         fdMt5NCW38L1MQ1KtoNjqFXs/WnumgXEuBu5muCbvKul5oCM7qwXyeYbP2vJDta2uhhw
         Xhaw==
X-Forwarded-Encrypted: i=1; AJvYcCWu9c+6OeTTtXrPrX0qbP34e14TlKluJyycs1ujk+SzmdjBC4cLv4vHprAhYoXMFVtscWlrBfSC@vger.kernel.org
X-Gm-Message-State: AOJu0YynmsnNUtmGDNMfguIfMQeVINAsCNgjvWyJuZb90/52RWmBiWPN
	d4bLyAbwAmQbrsJwibmjHJg/RSZyCz8YDkZflPpvtEv+vVWZ4LxQT4G4jxDy
X-Gm-Gg: ASbGncsfE+fxdYuzDn3tzPJBDPM0EoBM0vecpB+AQea28klezkg8D6DbD5a+hy36fJd
	NQOxekxgQVkrC89po+VllHgSdfGF9JABn1X7+yjjgpd9NfwtJ/1RfVmAkmyEsCLs9uqZwZrCnq6
	j8kUiDymMpuJ2XBNOeUwehRB0sCFke0aVrQ9nE0Ax3yp87V9eWAEyTltiBgEn1PAkNJvnWxmY6b
	2ga0fGu2GUAqI0yRbRWS/yuxE86rW59M8mH0QxFIhOBesmYssyExtFE/XtwKmEIyRcF2mngJ4hg
	2UphcxlxtKWN+3zQ51UDJhHTbJxs2I+MLvPl
X-Google-Smtp-Source: AGHT+IE6fzg5LVqDOL7moAH/qG19b5i2MESOZgmzRv6SjwnDczQBtRneQ3kSUIrHhTTL+6CVy4OdSg==
X-Received: by 2002:a05:6a20:c892:b0:1f5:8cc8:9cc5 with SMTP id adf61e73a8af0-20cdfdf4ab4mr1241020637.34.1746141947354;
        Thu, 01 May 2025 16:25:47 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74058d7beb2sm250661b3a.1.2025.05.01.16.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 16:25:46 -0700 (PDT)
Message-ID: <85008f75b2715a6679cbbb84ec473fadd77c7a39.camel@gmail.com>
Subject: Re: [RFC dwarves 3/3] btf_encoder: use function address to match
 ELF -> DWARF
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, dwarves@vger.kernel.org
Date: Thu, 01 May 2025 16:25:44 -0700
In-Reply-To: <20250501145645.3317264-4-alan.maguire@oracle.com>
References: <20250501145645.3317264-1-alan.maguire@oracle.com>
	 <20250501145645.3317264-4-alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-05-01 at 15:56 +0100, Alan Maguire wrote:
> Currently we use function names (or prefixes in the case of
> foo.isra.0) to match betwen ELF symtab entries and DWARF
> representations.  This can lead to wrong matches, especially
> where optimized function representations are concerned.  Instead
> sort and search ELF functions by address, and use the retrieved
> "struct function" address to carry out DWARF->ELF matches.
>=20
> Note this is work-in-progress and many functions are missing as
> many functions do not have - or at least we have not retrieved -
> address info associated with their DWARF representations.
>=20
> As things stand, there are exactly 1000 functions missing from
> BTF encoded using the address-based approach, since we skip functions
> for which we have no address info.  This approach actually adds
> 63 functions, so there are effectively 1063 missing functions.
>=20
> 485 of these missing functions are __probestub functions we do not need, =
i.e.
>=20
> [66116] FUNC '__probestub_xhci_setup_device' type_id=3D61452 linkage=3Dst=
atic
> [61452] FUNC_PROTO '(anon)' ret_type_id=3D0 vlen=3D2
>         '__data' type_id=3D108
>         'vdev' type_id=3D44186
>=20
> The real function is:
>=20
> [147543] FUNC 'xhci_setup_device' type_id=3D147542 linkage=3Dstatic
> [147542] FUNC_PROTO '(anon)' ret_type_id=3D21 vlen=3D4
>         'hcd' type_id=3D37057
>         'udev' type_id=3D37029
>         'setup' type_id=3D44209
>         'timeout_ms' type_id=3D9
>=20
> This leaves us with a mismatch of 578 functions.  These include
> 140 missing __bpf_trace_ functions, which are definitely needed.
>=20
> So perhaps we can fix up our DWARF representation to find associated
> addresses for some/all of these, but we may end up having to fall
> back to name-based association for some cases.
>=20
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---

Hi Alan,

The change makes sense to me, the code updates look reasonable.
Interestingly enough, I observe much smaller discrepancies, when using
llvm (version 19) for kernel compilation:
a. functions detected by dwarves/next but not detected with patch: 56
b. functions detected with this patch but not detected by dwarves/next: 70.

I only investigated group (b) and noticed two oddities, there are probably =
other.
- function "kmem_cache_release" is discarded from BTF by dwarves/next
  with the following log:

    kmem_cache_release (kmem_cache_release): skipping BTF encoding of funct=
ion due to param type mismatch for param#1 s !=3D k
 =20
  while it is present with this patch.
  Debugging a bit I can see that btf_encoder__save_func() is called
  for this function only once with patch but twice by dwarves/next.
  I suspect this happens because of how btf_encoder__encode_cu() looks afte=
r this patch:

    int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, =
struct conf_load *conf_load)
    {
        ...
        cu__for_each_function(cu, core_id, fn) {
            ...
            if (...) {
                ...
                func =3D btf_encoder__find_function(encoder, addr);
                ...
            } else {
                if (!fn->external)
                    continue;
            }
            if (!func)
                continue;
   =20
            err =3D btf_encoder__save_func(encoder, fn, func);
            if (err)
                goto out;
        }
        ...
    }

  Previously find function call used name: `btf_encoder__find_function(enco=
der, name, strlen(name))`,
  Because now it uses address specified in DWARF I suspect that:
  - The function is inlined or something and has different addresses
    encoded in DWARF but only one address encoded in ELF symbol table.
    (There is an inlined instance of the `kmem_cache_release` in DWARF).
  - `func` is NULL for one of two DWARF instances
    of this function and `btf_encoder__save_func` is not called.

- another oddity is about functions with aliases, here is an example
  from `thermal_netlink.c`:
 =20
    static int thermal_genl_event_threshold_up(struct param *p) { ... }
    ...
    int thermal_genl_event_threshold_down(struct param *p)
        __attribute__((alias("thermal_genl_event_threshold_up")));

  In symbol table it is encoded as:
 =20
    238180: ffffffff82b2d590   611 FUNC    GLOBAL DEFAULT     1 thermal_gen=
l_event_threshold_down

  While in DWARF it is encoded as:

    DW_TAG_subprogram
      DW_AT_low_pc    (0xffffffff82b2d590)
      DW_AT_high_pc   (0xffffffff82b2d7f3)
      DW_AT_frame_base        (DW_OP_reg6 RBP)
      DW_AT_call_all_calls    (true)
      DW_AT_name      ("thermal_genl_event_threshold_up")
      DW_AT_decl_file ("/home/eddy/work/bpf-next/drivers/thermal/thermal_ne=
tlink.c")
      DW_AT_decl_line (263)
      DW_AT_prototyped        (true)
      DW_AT_type      (0x059ec28b "int")

  And I assume that it is not in the BTF generated by dwarves/next
  because of the same `btf_encoder__find_function` check.
 =20
Thanks,
Eduard

