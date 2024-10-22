Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE3C12B93
	for <dwarves@vger.kernel.org>; Tue, 22 Oct 2024 18:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729622768; cv=none; b=BEPuwEmLOFMUZi4W5cQMN+IjSye3fiIIiWOEPN/Sv8L9bZoH/BDDuP872bM19SSslAmK/n9cFe+Dw0Y5q5vvlaV1KHepq7s9dotGlHvD7z8qaLewgPWlrGjiE5RwyUFKQnFV9KFypYRGAm70prJAvqiS9cn9Z5fTnnw2/Mzstvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729622768; c=relaxed/simple;
	bh=gPgTus7u/6SEq9hMcqAbHA/p8DBEZHsSCyhAv+EAS90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SOQTypVshMVTUn6wUvCYeJ5ZPRf/e1q7TIn0dXasdy4deKM1r0OZW94A6NL5KICPPyILKBe9eNqsQ3vg/63EOjCWkO51vGwzgCfWPmWQBQa6NKFemMG9V0RMFXdl++K02s1Lse79MtgQ232O6oqzM6pUgq6DW0ky5M6zXWz9UBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dpfj02z5; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dpfj02z5"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2e2b4110341so967600a91.1
        for <dwarves@vger.kernel.org>; Tue, 22 Oct 2024 11:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729622766; x=1730227566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0bM1CKJ7gDWf8S857jvqAzWr/tgoppspZwaRDRdUxNs=;
        b=Dpfj02z5/RZLiXWE/pjhl6BVBnVrsDZx4PDF5mloCKPNrMbAgLXfvWfsXF4bu8ZR+/
         IS8O2XCb7Ekb7Ylj1gawq3poAvzRPawGpcYueTV7XaMxHPF4t7VX1Jj/To8jcnW6a3ex
         gVlYhLWmE3Zl9Ywvwi1xNvhek6fESwHyPC4nfDjvN9QNZJ6oWQLjwBmnc+YRaSI4xwYT
         ywqHBaD0lWlfGZPAxVH+3F1LwXAF+uUwhIIXZ9WrNVPTJ+vj12LFX9xs0HvXJ/G+4dHr
         zUrE+EIUt3wibwd0Cu7htcUuHcPizzyjq4FQu6N2lUuVTIlAS5P2bD7VB0/w2BRLZSgO
         lo5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729622766; x=1730227566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0bM1CKJ7gDWf8S857jvqAzWr/tgoppspZwaRDRdUxNs=;
        b=LWaPFurtDptGk81Z1TSPaR/mEDdZ1zvvjbHeLpcpEBhFb8RdYBdSutVdGxuq2M0r5K
         yGyKzGGV2f8GmFqHL8+8tA38h2kqtqkSyQaUf5rPGMQWS5vWUh7JpmVmpafdgkoOhr0/
         qD/p1wd6f9aFYsLSAsmvHclabGENXu5/PzSpqcy4SIsseOQJB2kafEelZv09IDFBiZ1u
         pB5tCzS38S/GCoVThLUA2lqyDEAzFVSCOgn4evYJwFlfcZNJQqKSxPWNogSxpxvFxJKW
         SyJeYM4nhvfxGKscSALm9yWLheFkOm2RPuw2wp3mFrVh5r7DklvSrD+65e5hL12OiFWe
         U5uw==
X-Forwarded-Encrypted: i=1; AJvYcCVorxvPW1EHvr0R8i5RqZBUDsEhz20azbPPjVBCPyX55OFfT54Jj05ofqznkSlmyMAxaYhEO0SC@vger.kernel.org
X-Gm-Message-State: AOJu0YwAFauFd4wcfLR4TdV6u+MnRcx71hssnqPP1fXAELeLCnlvLfIH
	6FJzGOKr37s4g8L8NhQOYQNA8AArcWue+ehOxpTePEFvnFS1ttV0gxH1PP9Crrayi4b851CY3hz
	H9zARNXEb5+/izQR05NYonD0tbfw=
X-Google-Smtp-Source: AGHT+IF/pDePq4oeyqXT8FZDLkBm0MkYchsZoG1kNAfDE4e/g4wWio9YaY36Tyi5dQpE5wa0xy+mXKTPKjJSm0yOG94=
X-Received: by 2002:a17:90a:5882:b0:2e2:e139:447d with SMTP id
 98e67ed59e1d1-2e561444475mr7696664a91.0.1729622766659; Tue, 22 Oct 2024
 11:46:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZxGJruLvv9NRUT19@x1> <38ceba63-719b-4312-a028-14957e4ccb32@oracle.com>
In-Reply-To: <38ceba63-719b-4312-a028-14957e4ccb32@oracle.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 22 Oct 2024 20:45:53 +0200
Message-ID: <CANiq72kR0cRAVJjb_=dK-qUYWuivYa+8EsZT08cuD=mn=h10_A@mail.gmail.com>
Subject: Re: Fedora kernel enabling Rust
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Jiri Olsa <jolsa@kernel.org>, dwarves@vger.kernel.org, 
	Stephen Brennan <stephen.s.brennan@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 11:47=E2=80=AFAM Alan Maguire <alan.maguire@oracle.=
com> wrote:
>
> think. I've sent a patch for that [1]; if you could test it (or can
> point me at a vmlinux with the symbols I can do so) that would be great.

Thanks for quickly taking a look at this!

I tested it by running the `tests/btf_functions.sh` script that
Arnaldo shown, and indeed the warnings disappear when applying the
patch. I sent a `Tested-by` there in case it is useful.

In any case, but it is a good idea that you have a `vmlinux` around
that you can use for debugging this sort of things easily, so I
uploaded one to:

    https://github.com/Rust-for-Linux/pahole-rust-cases/releases/download/r=
ust-1.82.0-linux-v6.12-rc4/vmlinux

I also took the chance to update and add a few more object files to
this repository we had from the past:

    https://github.com/Rust-for-Linux/pahole-rust-cases

I hope that helps!

Cheers,
Miguel
