Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E46D20D4F5
	for <dwarves@vger.kernel.org>; Tue, 18 Mar 2025 16:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742314537; cv=none; b=aYvhM1xPHHl0LkXkxakrmHufv7qKCEnXF2ZlszHKz5/iGghSWkA2kKry4LzFTa6RH5oMXnSQygU/Jz5e26W0DzwNapgq0SFOV7uXhrjawyR5r9yjQEGzoGbzKxgl1l6Q5OXmGaJcFS2auoNv+NKGYUKabEu4iazzCIUsAudcQ7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742314537; c=relaxed/simple;
	bh=R7eA5Mv2ZRBzZPTP51WxwulE4PDYO0DbiP30DfcHZtM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OyFB+R+eawhqdWn86llFETmzMpb4PTc9PNuAzA7vT8rNPiML6FZOT3lBdJGeHxsf3sSB9M1bRdZ/pKeNuaAiQhwuuRF83IL9c9CdhIfXCvmRKksBCJmPh21mlrYgk99K10IZ++UpV+20pellslTqlanLzbXKzToW9Z2LgzrAF6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EaLPPLmR; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EaLPPLmR"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e789411187so10173a12.1
        for <dwarves@vger.kernel.org>; Tue, 18 Mar 2025 09:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742314534; x=1742919334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+jmJDqj16bmJCjhJHgSW9PkuV4ug8h0RWaHNKUC3WIA=;
        b=EaLPPLmR4u4noMPIIkN2JBdGTFs1GEsOCI68LWIK9gyleiC++WfGQnNfKhRctd+r92
         gXaWka0OTGRRXWjc0Ba+gi/hSG/STYaMAgqNV4v2YmJXYFwta0MxTrkMcqoEjlnY4lu6
         lKgHEY3pUFmfYls0oKE9w9ywib/2c3F6kzwKWsjqrXbwI5cjjCHhJT4Zo3RlefdTVzG+
         XGNoJw6THpVBHYp6H/I5zWDu+PE5azaXx6exDxHjooDMvpV+B5STnvCBcusXVl4RqAVI
         KkcqbSheKzahUvUQiHg1UvZfioOdJwU4OXank233F5YIYEx50zN8NWZ/VHoc0scngajA
         QR+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742314534; x=1742919334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+jmJDqj16bmJCjhJHgSW9PkuV4ug8h0RWaHNKUC3WIA=;
        b=EDN9nxcr4/S1NjyTEADB6HWUmUta37PXkGNaYBKa1NxNJymPMbZA9OoJA8OY0cdh0u
         X8gnskvw4x5ZfSG2ORXKlvDAZ4w00npzKvf2nbWR6dsQKlZhGEyrVhqrqI/pkfMnOU8q
         9NLL0cS2IMWpyo/6liQcAphTBSRYeW/WpPzwaQQX8iv3j09NsRqzS6MjLtiHRCZD5dCX
         n9igyhP4QexPlRD/5cjQG5mJavANp8ytJkZyVtQUdN7pyZ/JYHji6wWMkGrmKOz9YYZF
         TgbEKT05hBBg4mDTjCyaODKi9Nk0xmzbnmPndqwzTxHHk/6abk00JlXkxVguXD/RPS56
         zoPA==
X-Gm-Message-State: AOJu0Yxmzxaa9J3sbfvplUuP/E070Bkh7J7WDWAClMFiavhqdNfe1sy/
	y4R5erGEb/yYL9+iVrLMNog7lgH7jHih2n2mo9pdRAUdv++jSmU7lKFvXKOClfjC6U0VXYQ8tw1
	kmx/b2I8YkZzmtlJnPvtpUUFgKApr/iRz0vwr
X-Gm-Gg: ASbGncsX/CuqgHZpoHNiG554pOETXIPVH67wLZqlH7gejniYh/nYJcrYS8UhOLYfGYD
	4RBjfo3FQY6whckLdJx2CNt5Vh06ptYF6wwnU/Tw0m72oSaef2VCBQUieg9Rea8f+pivYEG2dxO
	a7BqInZwKufQ5LC6CjpBsJzcL58VlhwhE8oOY8r46Fjf+dZBkU4QWnRg==
X-Google-Smtp-Source: AGHT+IGXt+xqNpAVcpebaXRpxd9bCxp02FSds3ENDxbbFRWzfDZuvvK6vbayuYFf8wzaBO32B6LUhost6TotQ85rfzc=
X-Received: by 2002:a50:ab14:0:b0:5e5:ba42:80a9 with SMTP id
 4fb4d7f45d1cf-5eb3c17c749mr84493a12.1.1742314533554; Tue, 18 Mar 2025
 09:15:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317222424.3837495-1-samitolvanen@google.com> <Z9lCVHIyjLjQ4BOs@krava>
In-Reply-To: <Z9lCVHIyjLjQ4BOs@krava>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Tue, 18 Mar 2025 16:14:55 +0000
X-Gm-Features: AQ5f1JoXfdBPbJRrnsraWCFbKaMMxt3_bX5Xqq1EC96SWysXOKWn97Dz_vL-zOE
Message-ID: <CABCJKud4e_bBvOrXSrOmkiw+XX8DJzKBC=nxmNP7e=GusGEkOw@mail.gmail.com>
Subject: Re: [PATCH dwarves] btf_encoder: Filter out __gendwarfksyms_ptr_
To: Jiri Olsa <olsajiri@gmail.com>
Cc: dwarves@vger.kernel.org, acme@kernel.org, yonghong.song@linux.dev, 
	ast@kernel.org, andrii@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, 
	song@kernel.org, eddyz87@gmail.com, stephen.s.brennan@oracle.com, 
	laura.nao@collabora.com, ubizjak@gmail.com, alan.maguire@oracle.com, 
	xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jiri,

On Tue, Mar 18, 2025 at 9:52=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Mon, Mar 17, 2025 at 10:24:24PM +0000, Sami Tolvanen wrote:
> > With CONFIG_GENDWARFKSYMS, __gendwarfksyms_ptr_<symbol>
> > variables are added to the kernel in EXPORT_SYMBOL() to ensure
> > DWARF type information is available for exported symbols in the
> > TUs where they're actually exported. These symbols are dropped
> > when linking vmlinux, but dangling references to them remain
> > in DWARF, which results in thousands of 0 address variables
> > that pahole needs to validate (since commit 9810758003ce
> > ("btf_encoder: Verify 0 address DWARF variables are in ELF
> > section")).
> >
> > Filter out symbols with the __gendwarfksyms_ptr_ name prefix in
> > filter_variable_name() instead of calling variable_in_sec()
> > for all of them. This reduces the time it takes to process
> > .tmp_vmlinux1 by ~77% on my test system:
> >
> > Before: 35.775 +- 0.121  seconds time elapsed  ( +-  0.34% )
> >  After: 8.3516 +- 0.0407 seconds time elapsed  ( +-  0.49% )
>
> makes sense to me, I just can't reproduce the speedup
> could you please share your .config?

Sure, here's the config I used to repro this:

https://gist.github.com/samitolvanen/dca66a1a779861be27579f88c9b6ba5d

This is essentially x86_64 defconfig with GENDWARFKSYMS and
DEBUG_INFO_BTF both enabled. When building this config with gcc, we
end up with 0 address __gendwarfksyms_ptr variables in DWARF:

...
0x0001b5c6:   DW_TAG_variable
                DW_AT_name      ("__gendwarfksyms_ptr_system_state")
                DW_AT_decl_file ("../init/main.c")
                DW_AT_decl_line (129)
                DW_AT_decl_column       (1)
                DW_AT_type      (0x0001b5dc "system_states *")
                DW_AT_location  (DW_OP_addr 0x0)
...

Note that this doesn't seem to happen when building with Clang.

Before commit 9810758003ce this resulted in pahole thinking all these
variables are in the .data..percpu section, which resulted in
btf_datasec_check_meta() failing with "Invalid offset" during boot.
pahole/next doesn't have this issue, but validating the 0 address
variables is unfortunately a bit slow when we have a lot of them.

Sami
