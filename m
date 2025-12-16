Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C337E31ED91
	for <dwarves@vger.kernel.org>; Tue, 16 Dec 2025 06:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765864896; cv=none; b=JbAgRF+nL1obx5L8qrN4jyRXA/7nQRjrl6+g3/Xy6pXNP8hdWX4c06mtO3FtNdWdGBBzV8ZBO4BAzeY6QuC6D7/ylhiSHuFoZhu4Gk2k5WjnJKUzjEk9M9PGUxiW8N4C6iJ2JI0HqrvouZcPb2l8sP0xKJJ0zvbxaoUrlR1Exk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765864896; c=relaxed/simple;
	bh=XwpAaVywCyEesvbhFD+1jRlGMpfd5SIgyHs2knNz78o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V0NaLf8hn1Y4TdY0yVeMPESEWwd1gPz3XQa+Ox9pigMVOBkJgiX3ZCJkqHYV/1xNr+j5Yy7GMFVEsjgCx9uurXLdni1/nlcsaz+fVQxqaJSpmGtFxyEF/1mC+a2fe5s7fPzVlmdbY/COUkGfFJFmE4a0YdtUTtas6lBM5zsukhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WgPvnOgg; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WgPvnOgg"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a07fac8aa1so30937375ad.1
        for <dwarves@vger.kernel.org>; Mon, 15 Dec 2025 22:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765864889; x=1766469689; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nU4M/L03xqpLSAHFWlJdaAXrhrSY3fxk1G2NJhrZ0VE=;
        b=WgPvnOggoJAdUe422rISE76jMDZpzMmQi05St+BsdKL6Nm8Mr6+aLDbEpBMKi1Y8l1
         ffZqfNdPhN7uEpyIpfr/pW3j7ehTiZtNaQIkwBfYpOhzb0koNF1on36KWEQoL25OQP2/
         xZTegeBBUMMNKz1FziTU/rw0qcDtN1jhG+CZb3cu9rBjC0A+XLCnCSDRAG+Rc4TO5L39
         Who18ldVsJAwLLPu7lU8ccdIVIhs0zL7nS/hWQH5HTsqCr6SC7rxlnugIviPwDNQkvXp
         QWIje3bB1x6+SAfpH04GCkzi7kvtX8rVye2gq35anebwMZBJNEf8yL/oBgGng/5DwHI4
         5c4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765864889; x=1766469689;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nU4M/L03xqpLSAHFWlJdaAXrhrSY3fxk1G2NJhrZ0VE=;
        b=MmRd5GTQJ9Mz/Hw6IyBak82fjUOjVl+aXUOelo+vaO+Hy+E219cyU4S/VsWFzMplv9
         Fu06OwYgmYgfEcMImW6RH2vMD4dxkiqT5LnL96k0QAgi8ucATL+ehZmt3NrYQzEUgwTH
         cuwY1vF826c+0wxXhWyB47gu7tnFhe1TndKHi5BDz5oX1PICIRN2rlyJYqYLbdo9rbKa
         8NORF5vFLVvZs1K2mAcC2Ho05MGHXc0sDPXfpGC1sLA1JQkESnlj1/2HcmQuPOZFwnyY
         44R8juBX+uK3GSgoe3wd6EV0rzqy/0Qh+T0FoGtfRiZ6MUFr5rJwFLWWrft30PmFLY6v
         ptJw==
X-Forwarded-Encrypted: i=1; AJvYcCV0LBdQO8QGHI48sD1kCg99BXHcH5owUO1BtiQJML3YJ/YYEtd0um7Oyo87TRWbpt7F90M5zd/w@vger.kernel.org
X-Gm-Message-State: AOJu0YzdJI3kHj4gTZijKSMPgaNTMkBfJh3J5MiCfMowWK1m9e53bPoF
	gQ7e2ycaWVb+7+yReCEX1pfMBgOxDkywCs6G1BQXYrUT7CfZ6JFBF92J
X-Gm-Gg: AY/fxX7YtrPa+i/gw4h4j/w/NsLmwHMVjkUUcRyAcTtIi0gjkKQBdX0wvt1eTR0rq+2
	B31x/smQpuolheglx76CwnMAhY9RQjrx8QJYJ5MoieK68QuG8XJB7/Q454cTUlh5vhMuBP3zNcN
	piumBwP8ooShORMTcpe5q+gISwG271pKIPMMlDsFGf31jMewgTCpaY4tkHxGK9fTRFkWUHaZTeU
	mQq3iVng190fuYyM21d5aNEY0uNsKNUnTqGQAXcki4lw9KCJiks3HZ40RoeEWhNzt2C/nOPqXSA
	VAk9IYwvfYMr5x7jVTuqd5fWz2c9/8cP9yAtIM3KXT/gInDIosKunfIyqPzoJVa6UgDiXkHnZqP
	phjW8MTJY+hKDuwAhbdgkrCPhMxpaNyqXt8zkGqrw7SNMFjhoqZL0kGM+JENhVqDTzm+v5GPBpa
	z0dRiXP1sXp3q2Q46PvBk=
X-Google-Smtp-Source: AGHT+IGLwJVTz3tjNQHSPJ/HY/ivy2hxThwRXBUXcpoCVjhIFzGo5NEhsgAINS8tX2jDpRUlvpGoXA==
X-Received: by 2002:a17:902:dac8:b0:2a0:34ee:3725 with SMTP id d9443c01a7336-2a034ee381dmr127282095ad.14.1765864888964;
        Mon, 15 Dec 2025 22:01:28 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a0b7f5c457sm70288645ad.67.2025.12.15.22.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 22:01:28 -0800 (PST)
Message-ID: <73e7a9185fa9de89513108a5ec2b545fa344d237.camel@gmail.com>
Subject: Re: [PATCH v8 bpf-next 02/10] libbpf: Support kind layout section
 handling in BTF
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, qmo@kernel.org, 
	ihor.solodrai@linux.dev, dwarves@vger.kernel.org, bpf@vger.kernel.org, 
	ttreyer@meta.com, mykyta.yatsenko5@gmail.com
Date: Mon, 15 Dec 2025 22:01:25 -0800
In-Reply-To: <20251215091730.1188790-3-alan.maguire@oracle.com>
References: <20251215091730.1188790-1-alan.maguire@oracle.com>
	 <20251215091730.1188790-3-alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-12-15 at 09:17 +0000, Alan Maguire wrote:

[...]

> @@ -951,7 +1018,8 @@ __s32 btf__find_by_name_kind(const struct btf *btf, =
const char *type_name,
> =20
>  static bool btf_is_modifiable(const struct btf *btf)
>  {
> -	return (void *)btf->hdr !=3D btf->raw_data;
> +	/* BTF is modifiable if split into multiple sections */
> +	return btf->modifiable;
>  }

One more thought.
If some kinds are not known to libbpf, BTF modifications are not safe,
e.g. endianness swap will fail for non-native endianness and anything
that depends on btf_field_iter will produce partial results.
So, maybe forbid conversion to modifiable in such scenarios?

[...]
