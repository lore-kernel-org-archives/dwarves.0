Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC27236A91
	for <dwarves@vger.kernel.org>; Tue, 14 Jan 2025 13:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736860484; cv=none; b=M9PPfvbya+uLlVwkt7LPX0QLTaN1h9FZvXUGk+C8c/LA/rTCGE6HyegKoPCy35O0jmt2NjbP5gV19OldKqVvLyhOIFVZL3IOnkblJBGEqkme+/MqRJAJKk1M6//Bzz66FoqprZU6zVN/DHRnHyidnE3Vm7cmWJ7yZDTtcmOwYdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736860484; c=relaxed/simple;
	bh=HeIXxTkR5PjLK8tzU9ck8wam72+Ik/wdoHLlRI1lJ8I=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=N3hm6reJrO516KNJpf6ihHGuY037X3t91NkyzF+Bvztg9zeDSWIy5BppAIZ/m44s+QD/GJJJHov/rlyuypBlF9nzrfXv0CVRvn2ygFsJUpS2C3gAppz3DOVWUCSqqzFTTOVgv0N0TcjZgdcx69WCzkJL0hkVEP6ihsJJRH1euJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C6BD+qZ4; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C6BD+qZ4"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53e44a42512so4909e87.1
        for <dwarves@vger.kernel.org>; Tue, 14 Jan 2025 05:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736860479; x=1737465279; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AUuQcOrj29R42NEvcq6oiwoNuldSaVYIqlASlAVpyIc=;
        b=C6BD+qZ4/PDXbcfzeLBtxwZ7+ovWYAlMpoykE2fEkmG893g6+J5U7/GtIFs9JEK1XV
         uRq/Sfox/+ntd3ghd9dolBpVELrJJUMW4nstgB/gi0EqQuv7E1fA5KzEm+Y0QwGEjZbl
         3ga0dwmTO+bUNYax8LEIRGcvLEBeJSQWy7vp/R1bz65iyZvRmbKlz7Gb0Re1u2/sPtXe
         Bd0HwMHi5LR3QYbvCoUd6e8/tpS9XaxRbs7f1Le5z/ffnvbtm+FIp9LYW0XCWTb09sYy
         AoJWHQOY0VRx/+IEEjzQTZvupLuqpZQrsgCoKcj+LwvKNRhlqfuI+CxPt6g53qM9bsru
         H4sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736860479; x=1737465279;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AUuQcOrj29R42NEvcq6oiwoNuldSaVYIqlASlAVpyIc=;
        b=PzjFuewc6IDlC1KC9vt51pcGtdC7RVIqY08754zZM9B+6pnhZ571wMEMmgrD1hxViX
         MbtwEEt4vMWeEl5gFtx4mT25tGvivfKUEGYQab6oSqm+tsqhUZiibL316nflQl9DXs4Q
         iMTYRvMPwlF/vgxAqYRVCH5KonKbgT/5OLanqXoKG0Q06hHDfK9gi9O+DdqBzuvS4R2v
         W0WcTIY9JTo2QvC11lhfdtbtgrac2mPb/x12MSmIy4sViizmCRnW6pwOAkSFvEJSyPED
         zZ0Ei+PAIgXUHVvvbwgEyIya8wyK02adedlVd11G4rz3PDDDcLzKWuMwo+bYvKKbmhk0
         AuaA==
X-Gm-Message-State: AOJu0YxcW8Y6m9nHcbYyYmxXadxqkRPZnQiuJfL7EFqqLapb6/LIWjJq
	vcfKuW+NKadV+FYXZM7HIGZQKZGD2qgl3crYtzQvxIj2OGDh/+XdKeTwVQSGao91Ppf48j2law7
	PTUt9dpUxyXO3ooBdtS3flSH34p7VxBGdT3cclGDXcXuqKGxCqD+e
X-Gm-Gg: ASbGnctM8yc9r/RkmebLCStQVPBmlw39n2q5/QOow3/ymnMiHtOcOhRyR507NsfLCDY
	MwU4sWwAE54Kc9yRNBT0HmQ6kqd/JrLL4yg4iQWB7s2Kcxwc07Pv2dEtq4rI5/gEcjQ==
X-Google-Smtp-Source: AGHT+IFpfe1xXKcamvFwpEOPx9G2z+6aEtAm3qiBuEHCcXTNRsiEi4zRkiCqHV4g91d2icaFusr28XzgDMXWsLE7/hc=
X-Received: by 2002:a19:c218:0:b0:53d:ce29:b0ef with SMTP id
 2adb3069b0e04-542a799b8bdmr150785e87.7.1736860479026; Tue, 14 Jan 2025
 05:14:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Giuliano Procida <gprocida@google.com>
Date: Tue, 14 Jan 2025 13:14:02 +0000
X-Gm-Features: AbW1kvaJwVWs1EFU9JN-Bouao12Vja69cAbZ2FM67lzGu1yHZaR9iEZD28-oxnU
Message-ID: <CAGvU0Hkx7gzjZkAVGXQyp+_6Mp7gBOD3uOtbEQuyhPApQy_iFQ@mail.gmail.com>
Subject: pahole -J mishandles types in function scope
To: dwarves@vger.kernel.org
Cc: Aleksei Vetrov <vvvvvv@google.com>
Content-Type: text/plain; charset="UTF-8"

Tested with pahole v1.24.

The following code, when compiled with either GCC 14 or Clang 16 or
several other versions, and post processed with pahole -J, results in
the private definition of foo in bar being exposed as part of the type
of baz in BTF - which is definitely wrong.

struct foo;

int bar() {
  struct foo {
    int x;
  };
  struct foo j = { 0 };
  struct foo k = j;
  return j.x == k.x;
}

int baz(struct foo* j) {
  return j != 0;
}

Note that we had exactly the same bug in STG and I resolved it by
pushing an anonymous scope before processing the function child DIEs
(we deal with C++ scopes). You could perhaps push / pop a flag which
inhibits type definition processing.

It's not possible to just ignore type DIEs inside functions because
(at least) Clang sometimes emits references outside the function to
such DIEs.

Regards,
Giuliano.
