Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5D0EC7
	for <dwarves@vger.kernel.org>; Thu, 23 May 2024 19:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716492357; cv=none; b=ajU45y9iXpLjJKIzApOwOaPSM5dPBdy9Lq8zQ2i87ocJPRLtzBqfUZsR6N2ccenUgOL2QUHnWEb4MNShxcuJlbT7eFSL5TNHTse8mdJO63nHWR6YVrEBKqylFrVQx/2xu9a2DPAaBYAN8jCEdO09n7BZ4JQ9h1ZDMFFztFhIixE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716492357; c=relaxed/simple;
	bh=0eply8emQzw4j5xxI/w6puwPJ56OOd91d1sNaqAbV/o=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=NbEMhv6k3CoObbvbgztT3JPF74Nysl0J0yy9zb4kkoy4++lel6LMXmIyZqEdG4m6X69FBOiAIBlvIemo4GH8TBtcRO1KpWm+Se403Mmj19FoJz5YwBOQKoIws7DvzNEjLobuqAV7UtWwnWJJtuv6TAG8zmvoTDVlvi20zN+Qv4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2B3y3xxd; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2B3y3xxd"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52388d9ca98so12235738e87.0
        for <dwarves@vger.kernel.org>; Thu, 23 May 2024 12:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716492354; x=1717097154; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0eply8emQzw4j5xxI/w6puwPJ56OOd91d1sNaqAbV/o=;
        b=2B3y3xxdy9LAyJepws3nbvPZbhBS9wVW8gAaA5Bo3RG0GpYu5BnmGqBve9Xxh+iRRv
         rsXjh3dNr8vtbQOz0V9LCjq0Yo+s8tL24JBzDrjIdtP45sWva8/NoGBzurnUXlEGqNjI
         O8cAzK3PHS2U8ko3frT3m3BY6V2/rawT995n8WW9tvUnVQF8Q4iYbCjljNjHizjRzi0U
         BwMFYt8BOXJSH64idbRl/ZFCtUYz1QQCssj0WRHK1zKUF5iod1KgvrlJDuKYZA5egsdM
         4nKdMYzXvqNtDQkP/AWSBvwvLKrAgnYZLy9XPVm8oyhEJA5Tw/cC/Ras0NHMRB3dHX9R
         jOvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716492354; x=1717097154;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0eply8emQzw4j5xxI/w6puwPJ56OOd91d1sNaqAbV/o=;
        b=tbkMjFPo0lWBkIzhG/EcZZ3GEOV5nJSuflmUcGQ9fPG9krp4rv3Dw6Y6Adr/Qvdpir
         +O3j8C0sJu9PZq3X0SKWqsSWKChVSRZm5W0MLQxomOs3vPlKHEntFGHpB87t3HTIy7nu
         cRHCwIOiTMvnJzOIFm5IA5VCJCY3nwTGvkTRY5gcWyElAhc3hERJO6vE/5QftxOp4c3j
         TCbR93qWQrehg3Cq0mjJxsa6GSPnFqTuPQijXu1jtx8zCZEVyJUljWoDLymX03xFGVL4
         73QkDV5Sn7XStl7J6yk1giS/2l+SRycjHEHzX0Mi7kvJbuxQ70Aila5Ka2YrBBNPimP6
         3bKA==
X-Gm-Message-State: AOJu0YzyD9vGyfyDysGcvQIh1UgEmupsltlHMf/TAnbQl02P85ki3tEn
	U4mkQpsrc4KFP9WSo90Rg7XyhDGdu5PORRUSnyWFpYAxCqSdkwMPafCGD8g9dUezEfMJG3XFLjX
	wSuusXvX9tv3WLvpoxLwUrNbfIIR7DMhYOIxsKS6yxGzZSjPYU4QG
X-Google-Smtp-Source: AGHT+IHGa26FY6pr/Jp2x26ChVt5ZIMJP0PkClQ1bGxF+yBkcM4MUxXNk6wttP+mRc8VKEolX32Ol/nQgXGjJSvv7NI=
X-Received: by 2002:ac2:5dc1:0:b0:522:8352:ff29 with SMTP id
 2adb3069b0e04-5296736bb86mr35159e87.42.1716492353587; Thu, 23 May 2024
 12:25:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Giuliano Procida <gprocida@google.com>
Date: Thu, 23 May 2024 20:25:17 +0100
Message-ID: <CAGvU0H=MvKi=fk6K1M7O+OoGdnNzweXE1m=18yv2DHoPbRVASg@mail.gmail.com>
Subject: pahole -J non-determinism and reproducible builds
To: Alan Maguire <alan.maguire@oracle.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: dwarves@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi.

(edited repost due to unfortunate HTML email).

Until the reproducible BTF changes land in a new pahole version, and for
anyone stuck on older versions, pahole -J -j typically produces
non-deterministic BTF.

For Android, we are converging to hermetic, reproducible builds. .BTF
sections are a significant difference we see. I have trivial patches to
pass -j1 instead of -j for the older versions we are using (1.23 and 1.25).

Trivial patches:
https://android-review.googlesource.com/q/Ibd72ac638faa1826f6655b336cc7001591ea70f1

Gaining determinism for the older versions means giving up some performance.
About a factor of 2.1 in our case (or an extra 10s on vmlinux).

Do others want performance or determinism, should I send patches to LKML
and the stable list?

Off-topic: pahole -J -j9 is faster than -j on my machine with 36
cores, by another
factor of 2. This is v1.25. -j1 18.7s, -j9 4.5s, -j 8.9s.

Regards,
Giuliano.
