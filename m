Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5819E339710
	for <dwarves@vger.kernel.org>; Tue, 16 Dec 2025 06:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765865246; cv=none; b=nm5vsYifjUk2CTZh1sGdZjouQCBZWHTvWQvbe3kpNrSLdvsCNUJPb/qrksFuNdQqS97AGvAXJssjJLm6eeyqju1pmo3PT7C0xPByLCHB5+dEP1rnC6dekTxH90ehzt9GbvVEsH15gOuEABgQsUu6uOw+fEl85gARZusCwLppE8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765865246; c=relaxed/simple;
	bh=j8tHbgh6sMbuf8CLYcBbbfNvN7CoH/WWFH6BqIPVObs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OJ6DA0LRGycJWSJUkwNgAcRtr4+owaM+zlSoqPF5VIoUXekyE6u0IIWVNn5ct7VgMmXmTjjhW8Bqfkhmd3ut7eCThnMAnU+48jWGu5rrvePTnJsVg/7mFHw3vJm7mOtMWjEK1myJ5MRKKMpjmPIHZux7wY3JqoyghFUR63+mHiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ajUU8Apc; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajUU8Apc"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7bc248dc16aso3462364b3a.0
        for <dwarves@vger.kernel.org>; Mon, 15 Dec 2025 22:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765865238; x=1766470038; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2VxSD2VA4nAbIns+0GZj4QRJDG/iBDFgYQC3bPZe6qI=;
        b=ajUU8Apc/1M3rJHWcSyvxvIs+pXu1oaFNOr/mc+4qNfu/v2Muxj9BlSXC+NxRfBULI
         snjM+p4kZUTpZpvPzQwii6zPyFfdsYFuBjP2K1H6YPS2FYU+e/4YtndhNUctZ5B/dp5P
         ahkBgKtdzQ03KYNFsJsbqdAXu68epdgZny8tsdWbhY/DkACKHFR9gmCzqla5lZCf9oPT
         JibzZKIpmVIOm44AAsOCEAmzhinaeE2H1ceOwKEjhPgE6eLfs+BQWFUQQptPyJ0FuTY7
         pXY4h7D01tqKO06NusttOKt/sOGVhHPjOpIgHDJ2bfqE/tBzf4TkpqeOhFenyGzwaLmr
         cj1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765865238; x=1766470038;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2VxSD2VA4nAbIns+0GZj4QRJDG/iBDFgYQC3bPZe6qI=;
        b=Qw/RH3GcWQBlCAzWDHqQdkSEd+uM6/ToEVX6xD8GlExUGVe+XnehKsqPzLgBThH1uL
         zuzcladvyyPrTnnkppMA2th2ERQ7u2Hn7JmsNzkvhtPPSrJRRicxOWqVBByZ2RuAdk6s
         gEEuVTMvPpzgTuzz/2bv8WQmjideUJ0T4oHzDGgdjYpBpneety3I54CxEexxQ+xdBdeW
         qWc6mvrQi5DFF7N6hQURJfBs7xfKPToFjen3E80mTQt9uC5jemg2Ti2It16OlT0rja2C
         a95FhJ4KPZFcNdmSfbBI6+Q03sE4yzBmZCnNyWKJC3EJTzptH1ZNNzVUx3Nf6IAhOqND
         qgeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWs2Wt/4XDb3/XEHOfotB1/IM4NYGZAmTVi2rHWo5jXE7Du1IqpBGsBPlt7HAGJ/yBg1gLVmzC8@vger.kernel.org
X-Gm-Message-State: AOJu0YxD2PxsoOnQhfDNeOmqurTXTT86kyhlMV/wB3SDOhX6fkkPITSY
	4pZ1a7QcgWSI0B0m6S0N+mcGvUoPBPlmxDg8fsJO7srJL+5ds6qRtkW/
X-Gm-Gg: AY/fxX6tGXIstluzqjnlUoajQBgzcmQa0dPpYX/34M+EPCy01lBUsDjMuipo6bQdsox
	U4ijACTozu/wRN+2ZJVZMagiFx/w5E4SeuicMY2tF8xkyqKQt52DfuRhSFLUm+53iBaVy8pafyI
	YknW7NUFbF6rRxtiw1C/+fxvAMa1BD6uetxFabYB85t2PAUcO9cpSVbMjGu/tRKTltirBDo/xVh
	Kmah8cLv0+dkhl0l5ZhNn0YZimZyzbeTgvSZ7vl/6RL+XySsJPczDUJUbFvb7ZdfBfEk28NPLww
	/OXiYrpzxGzhcOb7snNOh218MIZ6FgbAAuJKgdU3rJ+ADUEM5H7Wr6RBk6u/7DI7tRC6hi+2nxX
	5hs7zdRKxusJRM3q4pp5/1nHhDx8yYiWbPUC1f2HKc6/4d2geVpqY8A4xGoAG5y2bAmzLjuc643
	XXNJyLEIly4/ira/9Bmb0=
X-Google-Smtp-Source: AGHT+IHY43b2UFhQc36nFFe5wG0gcwuV6X4l8YdEG84Og8ORlNS7EtzWH3syDhfMVz7eTZI/94adEQ==
X-Received: by 2002:aa7:99c7:0:b0:7fb:c6ce:a85c with SMTP id d2e1a72fcca58-7fbc6ceb799mr673561b3a.6.1765865237755;
        Mon, 15 Dec 2025 22:07:17 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7f4c237f2a5sm14177476b3a.13.2025.12.15.22.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 22:07:17 -0800 (PST)
Message-ID: <9e1b071598f9c1c1adcac0d8cb2591c452a675fd.camel@gmail.com>
Subject: Re: [PATCH v8 bpf-next 03/10] libbpf: use kind layout to compute an
 unknown kind size
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, qmo@kernel.org, 
	ihor.solodrai@linux.dev, dwarves@vger.kernel.org, bpf@vger.kernel.org, 
	ttreyer@meta.com, mykyta.yatsenko5@gmail.com
Date: Mon, 15 Dec 2025 22:07:14 -0800
In-Reply-To: <20251215091730.1188790-4-alan.maguire@oracle.com>
References: <20251215091730.1188790-1-alan.maguire@oracle.com>
	 <20251215091730.1188790-4-alan.maguire@oracle.com>
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

> @@ -395,8 +416,7 @@ static int btf_type_size(const struct btf_type *t)
>  	case BTF_KIND_DECL_TAG:
>  		return base_size + sizeof(struct btf_decl_tag);
>  	default:
> -		pr_debug("Unsupported BTF_KIND:%u\n", btf_kind(t));
> -		return -EINVAL;
> +		return btf_type_size_unknown(btf, t);
>  	}
>  }
> =20

That's a matter of personal preference, of-course, but it seems to me
that using `kind_layouts` table from your next patch for size
computation for all kinds would be a bit more elegant.

Also, a question, should BTF validation check sizes for known kinds
and reject kind layout sections if those sizes differ from expected?

[...]
