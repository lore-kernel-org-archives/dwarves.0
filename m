Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584EBB663
	for <dwarves@vger.kernel.org>; Thu, 10 Oct 2024 00:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728520624; cv=none; b=taNgej/ArRnvJz5IeJ0sdPsKj5fYfJnjO9BXFg5wSklbl6rE5/O36FMvjLxiuMBtSFXUDhF+QBDqX5d9kI6imiwt99XJ3MCSfJ3ZU2DZV2gQ5zU5k1FPDvYeEAETC2XKkBUQ3t3GLJWDak5/WG4tHtPSNuJA2KpZAQtcb3anhM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728520624; c=relaxed/simple;
	bh=EI3wvk6gL5QfB8CDB5/29iijBeqV0zAo+O+L+EQRQOg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PLbU0OTra5uzDJJEFZZiqgd4MBSKX6OhhEsWJEPoJpxHd4Xssu/H/FgwJfdD9khWdbzE4Zkr1FJzIdRLUGxxLwyYZkIk3IsvZQk5DPgjdalKTLNLcYdZqXptBXV45DWW3xWs9I0X+Claj+az73/GrvLsSMVc3cWQwoF9900rSEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=eS95tMuS; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="eS95tMuS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1728520614; x=1728779814;
	bh=gxUfe+297dmJAvSkve4BFYwz5N6LB4IFXISD/oagaxs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=eS95tMuSU59rBLPt3w6hPu2DX+eSqnLn3WfNSQtW0WzyM0F3b+TNdqYz/B/miLtfp
	 HzIKtCtKtpxDmWGGkurvMgMS8FoG5pp0Y1x0qkPvmJEK7pBKDkhm9U0+b7sXWR8nYE
	 clQAcbROwov+66NW1tgTFN/ea1dnI/MD+AdyYcS22yE/jZ8cWq0fv9rr5vmH5LZQSs
	 KM40B7iEqSYAyg62o3BDCMp9Ze4tYYuvEBWgyqGXq83MA+F2SYIAnpGsiQznwNhq/R
	 YT2IlC7Zp7xSmWLlyxt5aUKwQBj47Ow90tdgt1pAgve6bMhW4EdXoGyMFbP2/EkZAP
	 8rDnYBuk7Ksog==
Date: Thu, 10 Oct 2024 00:36:52 +0000
To: Eduard Zingerman <eddyz87@gmail.com>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: dwarves@vger.kernel.org, acme@kernel.org, alan.maguire@oracle.com, andrii@kernel.org
Subject: Re: [PATCH v2 dwarves 0/5] btf_encoder: implement shared elf_functions table
Message-ID: <4C0idzPIUJesSQi12dB1SgeTQlGl13N2CCsvjPfdLbvTEemTJoQZ4P-LJcOQqRyM69ZLKVv4mIKDQJvfMYMV2oITse1_uS_m_SjVigh8bL0=@pm.me>
In-Reply-To: <60b79369e829b33c577fe285b6597894e72b7042.camel@gmail.com>
References: <20241009233520.989453-1-ihor.solodrai@pm.me> <60b79369e829b33c577fe285b6597894e72b7042.camel@gmail.com>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 3e9deedbe288e92d492911098a21e9db7beffe8b
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wednesday, October 9th, 2024 at 4:43 PM, Eduard Zingerman <eddyz87@gmail=
.com> wrote:

[...]
>=20
> Do you have the performance / memory usage stats for next vs this patch-s=
et?

Hi Eduard.

Yes, I ran perf stat, and looked at max memory as reported by
`/usr/bin/time -v`. The difference is insignificant compared to
acmel/dwarves:next (a1241b0) [1]. See below.

In terms of speed I didn't expect an improvement. It might have=20
even gotten worse due to potential encoder threads synchronization
when accessing elf_functions table. The table is now built once, but
before the changes it was built once *per thread*.

As for memory, no difference is a little surprising as we now have one
table instead of N (where N is number of threads). But more stuff was
added to elf_function, so I guess it ate all potential gains.


Performance counter stats for './pahole -J -j8 --btf_features=3Dencode_forc=
e,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func,decl_ta=
g_kfuncs --btf_encode_detached=3D/dev/null --lang_exclude=3Drust ~/repo/bpf=
-dev-docker/linux/.tmp_vmlinux1' (31 runs):

acmel/dwarves:next

    68,904,383,016      cycles                                             =
                     ( +-  0.30% )

            5.5862 +- 0.0304 seconds time elapsed  ( +-  0.54% )

vs this patchset

    68,235,717,886      cycles                                             =
                     ( +-  0.30% )

            5.5550 +- 0.0412 seconds time elapsed  ( +-  0.74% )

Memory on acmel/dwarves:next
       Maximum resident set size (kbytes): 1392640
       Maximum resident set size (kbytes): 1394600
       Maximum resident set size (kbytes): 1393788

Memory on this patchset:
       Maximum resident set size (kbytes): 1393564
       Maximum resident set size (kbytes): 1394840
       Maximum resident set size (kbytes): 1392348

[1] https://github.com/acmel/dwarves/commit/a1241b095de948becfed882929dda7c=
4318e022a


