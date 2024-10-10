Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA021A3038
	for <dwarves@vger.kernel.org>; Thu, 10 Oct 2024 09:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728550905; cv=none; b=LO3hiGxsWqxx8qrcmw87qGB2R7i6oxKwgASr/gK+vrJgkPfZmwKCTpgJgXU4dzJEmrXrpaNibUyvPPIKLLclijKpA+KMR4hyJ+BgpdOMKaNm6aMQP2wRsqj5k4U7YuLu9y3mjbYCx1RNyqAazdTqTWZ2v9KcYJaN8CBvntstSBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728550905; c=relaxed/simple;
	bh=7KaYRCZUNyLgZ+Ow3VI6rkqsXv2fNtkW/7glMDvI4Q4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=huKRFGCoLQTiCPu0XK3KAWGjSHMEsiHIAxB+GkUxUExpWu8VeF1jicdzX8TOjKFMfqXinqpZQ/opnG99YgO4EehVnu4guChR1YNylqXsS+HGYOT19SKfKVagVTaWaO+uRPHqJgSy5JpCvBw1e9DFhpZWxr8kdLsvprjMa9piKLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZa/0mHO; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZa/0mHO"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20b49ee353cso5660265ad.2
        for <dwarves@vger.kernel.org>; Thu, 10 Oct 2024 02:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728550903; x=1729155703; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AUzPrFQgGnoa2Cm6Xold+RYkAGVhn/NQjac8Tw5V7Io=;
        b=eZa/0mHOyjsl0izto9JYNtmcDZAbHdtWXfCxlhdHGrpCPP75HfFpJ/WTxp9c1xhyKW
         Ii00QvEr7l6VnfR4mKoMQgfaCJKbaF0yXaPCjnZuiCh6eZyKj8cChSCK66zU2EniRmhk
         dLzinDmj9nDPpNQ8iVLXwxWmGvbuGdIyfDC6CIKvk0YVCeEewOChuKF9F7sj1/HzqICZ
         Frfz3ub5NlOo2gpqrmM893SH9ifqGKcy8NXWcPiU/G57cQrT5/oGKOQ9xjB7BcoP7E1K
         bXgCDeXzHPNQNszEnSpRGBHt/zANNPOGnf9V9tgAvGEsaqUsokZlgikfaIdkQDbQOJ4H
         JiOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728550903; x=1729155703;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AUzPrFQgGnoa2Cm6Xold+RYkAGVhn/NQjac8Tw5V7Io=;
        b=v4L+1fUi3vhZaSQhgl5Xy5kLzsX1JHSaIdAZzNwI7F2E2q0AZzuxvTZn9TM6JBoclg
         t8n7jkUxi8VO91N4NmEl/X3igLxdBFs9i/W+08ZxXWXz3X1labClDHo23pEenkBcJ95Z
         4ZYTlQH6exU6CiT/FIRQbqqzHRPh99X2Evlc9EK534pygpnRHHnS3daKgwSAb7Z/rX+Q
         bxEO1BSP5fR01mtqSxmFNVc4/nFJGX/Twvv5ko7XpNEtR9Hz70kcMuO7pnp1XiNxAcaM
         Gt201VSv4+ZjcrmXFhoxOfJ498PNPqzfYBmcnSppkmlHFRFcPYxYQQd3OmhPthMbhPrV
         2frA==
X-Forwarded-Encrypted: i=1; AJvYcCVjVTmApUJ1TqNuM8Q1MorV4YLgHwTr0RZH24/+K8pS8uopOywwGJBP1PZzoSPxWoP+hEL/q45k@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvmeeqyl4dV4KKEkd+R/O2DWQO6d+8lp0l2lZRM9LYOK7gK9/3
	DTxjrtlv3tINrkXgNxCR0OdL7jDuCftR4poq0D9aao87b47PVdFy6ee/1Q==
X-Google-Smtp-Source: AGHT+IHFYZILo1/6iNHIybzVQ8BjCr4adU6lK9aUaGKdIc5rmR0m9UtSvE9t1DaoJChGm+1RShv7AA==
X-Received: by 2002:a17:90a:f517:b0:2d8:8d60:a198 with SMTP id 98e67ed59e1d1-2e2a256349amr6001525a91.37.1728550903298;
        Thu, 10 Oct 2024 02:01:43 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2a55ff9f2sm3086204a91.15.2024.10.10.02.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 02:01:42 -0700 (PDT)
Message-ID: <4ab088f283bb209277a50c6cdd10d74099a845b4.camel@gmail.com>
Subject: Re: [PATCH v2 dwarves 0/5] btf_encoder: implement shared
 elf_functions table
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@pm.me>, dwarves@vger.kernel.org
Cc: acme@kernel.org, alan.maguire@oracle.com, andrii@kernel.org
Date: Thu, 10 Oct 2024 02:01:38 -0700
In-Reply-To: <20241009233520.989453-1-ihor.solodrai@pm.me>
References: <20241009233520.989453-1-ihor.solodrai@pm.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-10-09 at 23:35 +0000, Ihor Solodrai wrote:
> This version of the patchset rebases the changes on top of next
> (a1241b0).
>=20
> In comparison to v1, elf_functions_entry struct and related code is
> removed.
>=20
> Originally (even before I submitted v1) I used gobuffer to store a
> collection of elf_function-s. But that used too much memory, because
> gobuffer allocates big chunks, and these lists mostly contain just a
> few elements.  This prompted me to switch to a list in v1.
>=20
> While rebasing I realized that we may avoid maintaining a mutex for
> each elf_functions_entry if list updates are made atomically. With
> that change it became obvious that elf_functions_entry abstraction is
> unnecessary, so I removed it.
>=20
> Also I removed reallocarray_grow logic, which was used for
> elf_functions->entries. I noticed that the number of functions (at
> least in vmlinux) is almost as big as the number of ELF symbols, and
> we can use this to pre-allocate the entire table and then adjust after
> function collection is complete.

I tested this thing sequentially applying patches 1 through 5 and
executing command [1] (same as used for kernel build) and generating
vmlinux.h from resulting BTF, at each step generated vmlinux.h was the
same as for current 'next' (modulo usual small fluctuations).

[1] pahole --btf_encode_detached=3D... -J -j \
    --btf_features=3Dencode_force,var,float,enum64,decl_tag,type_tag,optimi=
zed_func,consistent_func,decl_tag_kfuncs

[...]

