Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB67ED9;
	Thu,  4 Apr 2024 00:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712189294; cv=none; b=rZ8QuR5HvwN8Sk13zMOD3zwHJ/9ve3ehy13Mwtk7c7nsjNsZNE2PCngY1pIKoqZOcvQe1oFkJfgFFjdYjiMgtRowrj4xiorsvVtlCXuWRW7YYqhSkx3uMxcJEoeDFs7P60rmtGYF1QFnpOF9zjF2bjq22w3Syuef8KIzFi+B3vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712189294; c=relaxed/simple;
	bh=CllVtwahg2YM8GmLV6ISoii10jwOcQAdOsftJ9SyRzg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LqdsX/Dw8xRLhMAoxtl5U4ir+JrOU+zlfF/unfNo9NpAaPPtaZMmmIT5Ioxn3szmuQcMYyKqhxOgGH+Aeg5S/CJT4weTFhw7sXrj9dftMSgWI0Owm4SiC/ynTGZhPjBS4+8foFoo6gDPVl6+q7ky6jLpJl14KF8vkQ/2qGTSkRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FGWNRHv5; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGWNRHv5"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d6ff0422a2so4884321fa.2;
        Wed, 03 Apr 2024 17:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712189291; x=1712794091; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SFRNzgRPkJphjrDswSNXJJrKg5DTZ1tH618tA7fEZgI=;
        b=FGWNRHv5Gy57j9wMN5MIoO28nvTVRQOcEGdg90MlSK+QUcnCN5CK85Oa+G7d2c8PjH
         aO+i4JHDHRMk8eWSZLaYFuqvyHUF3GLvkEVA2NZx/Oh9Wg7j4FBEiOmZ4JiahEybduwT
         F5UPf+SjumUBYyKk753Kd0REgBQRRg3zEsamRy/EFbung2tKYWV53EweY3ftZaYGEmLS
         eGkRpdmGfHzu3rt0zWmRHfUpanndsG+Dcks+1uvK4e5nQptQ2H6Rx1sjiNCtdFCXOcA8
         XFfUZKlZfkn40t5DYtyuSpmkujHBLAlFuu2p7LaAZo42rLjDYNfQ8f+BcHtiV0Z/jd0M
         jH8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712189291; x=1712794091;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SFRNzgRPkJphjrDswSNXJJrKg5DTZ1tH618tA7fEZgI=;
        b=FDeulEOaEePUTZc6T/CWsA4KgnUlnaSWFlTDwImFUUwiojKO3Ia8ZAOH56TP9FttdQ
         NgMgIGH6YhorGZ7YcWLrUZ83URRMf3W6JS6Z4nZiFW7CgrGdnd9nLwxlJpgt7cvCuYiR
         u6HduIQ0TzWTbQFGbHaYPr2RhN/+kZ1qkX2IEgWlQVQVlIFCPD2RXtWEE2VdwFJITI6r
         k/P5ER6a3sfpPj7d01xAHpvBQM+JUPOrjoIfcvMuCqxVf+qIdgF/p4dQFF7K8CiqPc+t
         FSMv0HQFCbgKpwvTgF6ljItnwV6///OFWngaYekrGiKuqearFOkQXxjDiYcjv9PFKvuk
         HWSQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5C6fdci86UBmNfTOIPqPUv+0j+JyKRzT+jR3R74DomCy7+fBjB05/8e6zLyYT+ggQQJkM+5FMIYAIuW5M6e0XDA21gxqZkI3YvO29aMCKT2Xw9ImC6vXQ7FKSLQ==
X-Gm-Message-State: AOJu0YwfLL4AxaV3K59rfrjsPOrW961Oo4s96+slRD9zBltYM2VnsMeV
	OwgN2FS3j/3uuPKi6hWOKQWvURtNk1ElJHDUBHg/Ti6/qmG7NJ73
X-Google-Smtp-Source: AGHT+IHKslzmHWyLaSkPtk5bDPtqjzGjGuzMcoZr9KxUEZX3G6neAaq+M+X0Yxq6vIcQ9H8ogtttCQ==
X-Received: by 2002:a2e:be28:0:b0:2d8:2799:fbcf with SMTP id z40-20020a2ebe28000000b002d82799fbcfmr815997ljq.34.1712189290872;
        Wed, 03 Apr 2024 17:08:10 -0700 (PDT)
Received: from [192.168.100.206] ([89.28.99.140])
        by smtp.gmail.com with ESMTPSA id z2-20020a05600c0a0200b0041624ddff48sm654482wmp.28.2024.04.03.17.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 17:08:10 -0700 (PDT)
Message-ID: <747816d2edd61a075d200ffa5da680d2cc2d6854.camel@gmail.com>
Subject: Re: [RFC/PATCHES 00/12] pahole: Reproducible parallel DWARF
 loading/serial BTF encoding
From: Eduard Zingerman <eddyz87@gmail.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, dwarves@vger.kernel.org
Cc: Jiri Olsa <jolsa@kernel.org>, Clark Williams <williams@redhat.com>, Kate
 Carcia <kcarcia@redhat.com>, bpf@vger.kernel.org, Alan Maguire
 <alan.maguire@oracle.com>,  Kui-Feng Lee <kuifeng@fb.com>, Thomas
 =?ISO-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Date: Thu, 04 Apr 2024 03:08:08 +0300
In-Reply-To: <20240402193945.17327-1-acme@kernel.org>
References: <20240402193945.17327-1-acme@kernel.org>
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

On Tue, 2024-04-02 at 16:39 -0300, Arnaldo Carvalho de Melo wrote:
> Hi,
>=20
> 	This allows us to have reproducible builds while keeping the
> DWARF loading phase in parallel, achieving a noticeable speedup as
> showed in the commit log messages:

[...]

> Working on libbpf to allow for parallel reproducible BTF encoding is the
> next step.

Another option would be to apply some sort of canonical ordering to
BTF itself. E.g. put all PTR before STRUCT, sort same kinds by name,
sort same kinds by vlen, etc. Something akin to [1], however this
experiment has several flaws:
- slowdown is much worse than with your patch-set;
- I see a small number of functions with identical names appearing and
  disappearing from final BTF.
 =20
I'll try to figure out the reason for slowdown tomorrow.

[1] https://github.com/eddyz87/dwarves/tree/sort-btf
