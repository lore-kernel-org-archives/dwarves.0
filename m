Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C7F14D439
	for <dwarves@vger.kernel.org>; Mon, 14 Oct 2024 22:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728945901; cv=none; b=ib4QPmyD+g43V6jlYKaOtGPGyCw5HMAUpe1ZpsG+uMrQi4Er7Y1ozYJzalZAG2GVnE85idRti33rnAjlQeh2V++Y09Du7MBldWTYDWpwfZpEt0Wdefo9V1Z3vmTGHDo8Od6sjWrjIsNGupFyBjEVNrTGVwHQrPYjUap7ls2QCtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728945901; c=relaxed/simple;
	bh=0sdPVGj2YaSK1NlvDdPcY3IYtcoohOwjDq1ifqI6f+o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E+zgfBYVZv1n9b380rfxUq5D3JG61ir0DuoH4tCYgtFYXzBLCoVb6RHCp5InCx8fUHTNVK90xC913Y3pOnRDISQXXwnn2DpisEzQeLvs7Vmqu/Z4BHUWvKTl7ws4/pLHwH12qa2d5HAMg5Vnj3U3vd/pC4luVV/oCS0prbzOKU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dhZ2SYDi; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dhZ2SYDi"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71e592d7f6eso1324918b3a.3
        for <dwarves@vger.kernel.org>; Mon, 14 Oct 2024 15:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728945898; x=1729550698; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PkrB0X4XO61wBzSrzFrUxGb8RyCsb6wGUfgeBJ8vfj0=;
        b=dhZ2SYDigh4k0xaOlE34unQ6cE118w6+y/M9Z5AWn4/5DuEzuVZRzOap9gNhzUdYu0
         D6Xm5/OYuaxXrjGx3Ulz4kFl5NxTlZluqiE9SnjDerfWsy7QksjNBq41g6NXoZsLl/2N
         7d88RqN3Zgkl0oL6+uzFjFxlQe7C84NOJHVEAwweNrbEsqlFrw2Hc/2JxvxiWoP3Ap2H
         SO3aD6rqWwn1yKtEE8S9uszSAMFnKwQijwGU0iy6TbtWW/NYsCkWHVzUQ1/xb2c1kNst
         SLR77/P5iyUxgxfvh6QAwj1DNnlH0VWQ+nWWKFeVVX4Xnco0Vwq351FnOvjICzGYoIt9
         ym8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728945898; x=1729550698;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PkrB0X4XO61wBzSrzFrUxGb8RyCsb6wGUfgeBJ8vfj0=;
        b=jxB/qwMzlG5YR+j92FSAunJM2s9+cQDtdek1vSO2y8/abL5wa6i8JePaO1ik6eQaTP
         C6pGI62N+8atWdCqhYlm/cHhegcP3tuRDIL0emQ7CwTORpbOCeNFURz3YBm8SbY6iT64
         kSIYfETDHb4UrTHs3aXu+bEAw8N0sFFbJARlpqc+wot/y6VfQWBYeG4gFmkA8xkqZydu
         OjPfbPU833IeEe9M3Bkv1LJd4w63ti3lGM7NNOIe4XuEtk19LFw3WawaDQAXp8hOI7eZ
         EP+jTNH48UV+My17bwuu70J6tyYcwuZrZk0jd1geNxEN9M8SfSZnvvmlxGPbiJmVMQzD
         Zatw==
X-Gm-Message-State: AOJu0Yx4/Tt9/gAwxZ31VHcDbMGfaaE6nxKAPS4vZtE3IH2uCNECgM2g
	w3n3vPD9X45hlzqigKogbI5qWFckS8kx3yOj8OWmJrX9w8j3Si4v
X-Google-Smtp-Source: AGHT+IFcy2TvIuFODAQMm0/PrnhpmX5AeekJGbvisLJ6jvufc0QPkGPxj5ri3ihm/F15l4vqO0P+vA==
X-Received: by 2002:a05:6a00:1794:b0:71d:f821:1981 with SMTP id d2e1a72fcca58-71e4c139726mr16697671b3a.4.1728945897906;
        Mon, 14 Oct 2024 15:44:57 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e773ea789sm50522b3a.93.2024.10.14.15.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 15:44:57 -0700 (PDT)
Message-ID: <2a7e060714f008f43bf8778fc1d1968299d195e0.camel@gmail.com>
Subject: Re: [PATCH v2 dwarves 4/5] btf_encoder: make elf_functions.entry an
 elf_function list
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: dwarves@vger.kernel.org, acme@kernel.org, alan.maguire@oracle.com, 
	andrii@kernel.org
Date: Mon, 14 Oct 2024 15:44:52 -0700
In-Reply-To: <U_bKKwuFUoWNsHOg6gCjnx3-9xFdYjs2TkaFEc9bK6VUMPwSFrKtXmpHHWVd95-okxFCqcJXxpUApq-ndVz34uFvOsX-AB22iVEa0QjDOb8=@pm.me>
References: <20241009233520.989453-1-ihor.solodrai@pm.me>
	 <20241009233520.989453-5-ihor.solodrai@pm.me>
	 <9f0b3a85b37d10bff446a43b2c154b1abd723d5f.camel@gmail.com>
	 <lVQ48eIOm008BvczqG7o2mjZ7Ofw8u22LnM4gT4L1BGn8yBaE5sZm0TeYi4dBZ6LXGGm0b7l7g-1wtpH2rQoG7AC2LyjdsqP5oK-r5r4ka4=@pm.me>
	 <ccbd5bd24ef1f68b6310434a55752cba961ed20d.camel@gmail.com>
	 <079a99a2e5207d824ef69ba1d11a530d403711f1.camel@gmail.com>
	 <U_bKKwuFUoWNsHOg6gCjnx3-9xFdYjs2TkaFEc9bK6VUMPwSFrKtXmpHHWVd95-okxFCqcJXxpUApq-ndVz34uFvOsX-AB22iVEa0QjDOb8=@pm.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-10-14 at 22:39 +0000, Ihor Solodrai wrote:

[...]

> > Ok, I forgot about the implementation of the find_elf_function_in_list(=
).
> > Please ignore my previous comment and sorry for the noise.
>=20
> Yeah. In case it's unclear for a reader, I'll try to explain.

You point this out original commit message.
Just too much time passed since Wednesday and I lost some context,
sorry about that.

>=20
> btf_encoder__find_function() guarantees that a particular encoder gets
> an elf_function struct that it "owns": meaning no other encoder
> touches it.
>=20
> Because of that btf_encoder__save_func() does not require any
> synchronization code.  We know for sure that an encoder passed to it
> is always the owner of the elf_function passed to it, and so the
> elf_function can be safely modified.
>=20


