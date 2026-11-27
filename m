Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795796798;
	b=ypmVWMVzIT/j8aiC0b7RFuXE+VW/0sgq7t2xkRgtwdOnQEveW2wJnI+2nqXdnpSevqxk
	 BGwivvmVN5mn90oxJSY1s40Scb7EUpmSJO+wR2zS+qZxvDNu1XNLjsglL9Y9Owo3qQ1Hg
	 QtdNqV2vXYUVlm2+dPGIP04o82KQ7wRJjzTd91Rm2vNSbzUIUuAmgupMUvmBa0ldbyB3T
	 WCDhGvMF9tL17htLip73KSGTUKokQzlSz9Bjde0XMmaL1MlhttcUjOOUK7BAianIpn41Z
	 68QXymfQJaQyOflAeaMEMq0cyFsOjun+re3SU953Zr/K7P8F9SXihwNaWsi1smTKEgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795796798;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:CC:
	 Subject:User-Agent:In-Reply-To:References:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=G0lbW3aGJSHSzgdIbKHhvksROcZzFNKvKUeYkD4Vw7w=;
	b=SwB5gymD0P1JIymdYJIBxarOJ3r/nVnzy/pSb5A26D9bIkept1I8y7WvHqTFxRvqxtCw
	 W9V91w8MHPFHTlOZidHkIyB/O0PYvWhcPJlJCy4KbYcQAxp2TxThEgdxbU8YJOc7xqU3G
	 d9VP/fblkqXeL3+klzNIlOS73w/OJvxSOHmXRGkdlww649+SSVKihUXm5r7IKU7V/D9wK
	 4ANCrVSr1oFF33aGic73YJYzOYh9uMZpq895wM720LZmzX0h8Ea3MBFJn5JqKAsxbZnDh
	 cCNaPqwasMjyg2o8FBRl7GCDNgDMn+98Z+bniJQ+wQ4T82H6r+4Vn4dDmPQfOqE7nXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Su4nTr5T;
	arc=none smtp.remote-ip=209.85.217.49
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2441B606A321
	for <dwarves@vger.kernel.org>; Fri, 27 Nov 2026 16:26:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2441B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Su4nTr5T
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-7d2db6408cfso4460805137.1
        for <dwarves@vger.kernel.org>; Fri, 27 Nov 2026 08:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795796797; x=1796401597; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=G0lbW3aGJSHSzgdIbKHhvksROcZzFNKvKUeYkD4Vw7w=;
        b=Su4nTr5TJlhZsL7ksXYCT5DNp0Mk73XPBPqTK+wB7IpRCFbqpufmw6bjGArmXb7Lum
         Lw9kjakOmWztQVYVzvtlGA7Gn/hAuPC+wxOSt7TylYwZqU+yvwerlZSbEs54Vlc7k2DE
         cADrjt244s3qC72UnDliBP8LKtuFzVDCfWUoNxl9kbnLDStLtGcDeKoWUfwQMN16s7H5
         gf4WUU6N6X5HHFOiyo4kvwHse/ACImLdNQ5YDtjOQ0vBL5CwBZcBSyILDrRM+j2KhMgr
         /0wxEExVQBkGvU7F03cBB66pdxC9iazs9Yp6nL3CPHovF6r5NmvK2cxi4pcHXp59yxgM
         d6ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795796797; x=1796401597;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G0lbW3aGJSHSzgdIbKHhvksROcZzFNKvKUeYkD4Vw7w=;
        b=Iy+4zK6nzSHBEBzTaVD5SM7j1OpP64XYMflD3UlAKqoEe3pW9Tfu2d3ryfeMXRV26C
         MkmEdGTVsj30C3dPq+mzSKcPJvCdgl9Jdg0z6liGtdiEMdRsmnypDk+zOSnIvUzPtD/m
         pOA4Rw3Ns1ndCoCrIjoa4k0frT/8To6tgEhpJ2BYJDZFk3nBV6CfvWUFXZPyk3QdWbqe
         eOqNvqe/13BnDry8okG3t7by7EHuRCOML126M4XqHw60xT6ygDl/lUoZV6WPIayLy0vH
         UrYZ3a+JB4ccJ+9ZQOKubDa2G04ylZHNbdv1Nn6l9c0fJRaEU8FGhlV60tymVVQp5ydd
         MNZQ==
X-Gm-Message-State: APuU4Z/Z+rw6U2xEMVsHEp8zLttgnu3lv6KuYBmYhosjm2DKqHxDrjoN
	JOOZw9SoklnfmekC7+Xb/RktZI1QJJElXHP4+OPHXT7eQEir9bf0Z+SnOJm+/g==
X-Gm-Gg: AZFdTZfdOMl+Mm6ITVoBeJ85rGw60+3mDSa1QH2NouBgPIPbaApyReBHUBFZGJl9VFP
	kkmz8M3/11YJ+xQvnu0LtRDIzx6Y+EP09PVzVdyhsr8ssDKxYFoVkusQkwzIns1asmbqu9zYr5Z
	3X0MFgdAgdz3Y2WEeZ28MgCaiDVhkBx1kWRlE7UdrsYs6Pd02uXjY2qkSlomYDnJDyZLG161zb6
	U7/ErjQPqgI56h39Npld7LhST4Io8hf7VvNVBhi3kS9QKw/RWYpKwIYn2lMD9nU4NHlfYmRE5PQ
	8BWhFTecfUFxhS6dqt0IMP25RixU+jnNEF3Wpf100xdZS2sjsgHBa5vpzr/VJWNZAEOUYciSfJn
	Y8HlT6tmdeFBp4XPcUBlIGijHB/CEZdv4IqbgD/L2dHwi8y52aiDg+CL0B8QfgJ86dNq9HwxvI1
	S/FIg+9pFzlvlfyNrasL0OAF9BUYEkJu2htWAkpKhgyXEBDHmcQk7Nziaf+2QbgJwL4NOx4qAT/
	AvSTEOgfNZeYY8bnnVOi2rIrr0O2EfkWRT6w6x01BJB3sCtmumQrGCQZtew1Zi447xjrgeJJV/y
	vBKRth8lq7HnH/HWm1h58/OOjNbkI6fUw9fDLyq4/WwKZA==
X-Received: by 2002:a05:6102:1492:b0:7cb:bb33:8413 with SMTP id ada2fe7eead31-7d7393ff54fmr15250302137.9.1795796796884;
        Fri, 27 Nov 2026 08:26:36 -0800 (PST)
Received: from ehlo.thunderbird.net ([2804:388:90c1:771c:18eb:ef7b:e7f8:aab3])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6e81cee49sm26337881137.8.2026.11.27.08.26.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 08:26:36 -0800 (PST)
Date: Fri, 27 Nov 2026 13:26:30 -0300
From: Arnaldo Melo <arnaldo.melo@gmail.com>
To: Alan Maguire <almagui@kernel.org>,
 Stephen Brennan <stephen.s.brennan@oracle.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
CC: dwarves@vger.kernel.org, linux-debuggers@vger.kernel.org,
 Alan Maguire <alan.maguire@oracle.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_dwarves_2/2=5D_btf=5Fencoder=3A_f?=
 =?US-ASCII?Q?ix_DATASEC_assignment_for_ET=5FREL_files?=
User-Agent: Thunderbird for Android
In-Reply-To: <7b0e61e9-5b8f-49b8-afc0-a56be82ed0ee@kernel.org>
References: <20261119185236.4113166-1-stephen.s.brennan@oracle.com> <20261119185236.4113166-3-stephen.s.brennan@oracle.com> <7b0e61e9-5b8f-49b8-afc0-a56be82ed0ee@kernel.org>
Message-ID: <1EBC126D-E4E0-4A9F-8873-7D693E7C72E1@gmail.com>
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Post: <mailto:dwarves@vger.kernel.org>
List-Help: <mailto:dwarves+help@vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
List-Owner: <mailto:dwarves+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On November 27, 2026 1:12:06 PM GMT-03:00, Alan Maguire <almagui@kernel=2E=
org> wrote:
>On 11/19/26 6:52 PM, Stephen Brennan wrote:
>> When building a kernel with the global_var feature, I encountered some
>> kernel modules whose BTF encoded a DATASEC named "=2Edebug_info" and
>> assigned some variables, such as "__this_module" to this section=2E
>>=20
>> For ET_REL files, libdwfl assigns a synthetic address to allocated
>> sections, starting at around 0x10000=2E Non-allocated sections, like
>> =2Edebug_info, start at address 0=2E If large enough, a non-allocated
>> section's address range can extend past 0x10000, into the synthetic
>> address range of an allocated section=2E This can happen with Linux ker=
nel
>> modules, resulting in the above behavior=2E
>>=20
>> Pahole iterates the sections in order, so if a variable's address falls
>> into the overlapping range, and the non-allocated section appears first=
,
>> pahole assigns it to the non-allocated section=2E
>>=20
>> Currently, get_elf_section() has logic to filter which sections are
>> actually considered for variables=2E It uses a cached value of sh_type,
>> but we have no cached sh_flags=2E Rather than cache more data, we can j=
ust
>> filter out ineligible sections when we initialize the secinfo array,
>> allowing us to remove cached sh_type altogether=2E This keeps the
>> eligibility logic in one place, and removes the need to cache a field=
=2E
>>=20
>> Signed-off-by: Stephen Brennan <stephen=2Es=2Ebrennan@oracle=2Ecom>
>
>hi Stephen, this one needs a respin I think as the context in
>btf_encoder=2Ec has changed; did you build on top of github=2Ecom/acmel/d=
warves
>perhaps? Latest is always at https://git=2Ekernel=2Eorg/pub/scm/devel/pah=
ole/pahole=2Egit/
>
>Arnaldo, would you mind syncing next, master with pahole=2Egit? Thanks!

Will do it later today,=20

- Arnaldo 
