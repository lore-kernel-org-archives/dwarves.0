Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED6728FC
	for <dwarves@vger.kernel.org>; Mon, 14 Oct 2024 16:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728922878; cv=none; b=jCRwBrz4tkAhEr8L52Pw9puLMScheKOW/sSiMDpfwAzuUT5xZLPBLY2BYho7H7nd6mLg0A7vZpwmayexfRGNH9rgLoa0dNaVoxNsy1SdeS4maTmQSGRp6HI6r6auMEnLpjQdCLTDaTww1rMLrAwTAg5CbgESeeq0CHqbe6MUBgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728922878; c=relaxed/simple;
	bh=Y5BEE4xABVYduD74dSzbppaxvHEsr7fCIBzAS21AD+Q=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jOX8nPFJZzrISvqIPH5ivEJ6RrbW8ZLuupfDA+BXq+8aqaJWzkdDWVxdlP3+n6uw255zpu0YQrimnw21Fej5cpfufuUigRPNHU90ISG+6q1Gigub4wwFq8xWSkBoCBLnsFvR5n9shUMU7VwB5PiOoou0HL6Ku93TbBYL9QCt7Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=garSrU4F; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="garSrU4F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1728922868; x=1729182068;
	bh=fiG/PlHheoLHyuL7aDjzmh67coIgoGdRc1TfTkVa4cY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=garSrU4FVajlEUcdAcJW+HGtJZBV8riBLOBPKZNaPQGM3ybrWmzAh0tj5tY1o0N/I
	 bA0KMNnHEvVSqMAEnhFm/c2h3J+mXmivPUlEznrnszYbcqFVqBpcgJy0LURD4yncgX
	 RcUAJZsQTg4OCoTixjZlUstAVomYSWfiT6npAW1WUEkMa2XUbk8ewsshPMjQ7ZFX7u
	 lpHsd67DRlMEZoVrPvCu5gz0/q/VyXR3CqUZevfz11Sh/g6TiCXUzXgs5V8z2Nja2d
	 PvrIHq4QA9PxxKOyr0U5PgUPtD+YedDrrdr1O2V25NaJAR83uPxoyGa8wUhT8DbsEb
	 iMVD6c3/PNq1A==
Date: Mon, 14 Oct 2024 16:21:04 +0000
To: Alan Maguire <alan.maguire@oracle.com>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: acme@kernel.org, eddyz87@gmail.com, dwarves@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH dwarves] btf_encoder: use ELF_C_READ_MMAP
Message-ID: <jirqHvCggrZmHfQ6dDZRDFcowapRgEQVfhG1cHs7cIRyaE07RELdLlfr5AcWXPqsEhSMRZCvHs99o0eu1FEy2Lek0y3sSbdCemzOKtMGGRs=@pm.me>
In-Reply-To: <20241014103142.2280044-1-alan.maguire@oracle.com>
References: <20241014103142.2280044-1-alan.maguire@oracle.com>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 76c82234150d013bfee63c0ab8fc407d46dc7d2a
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable






On Monday, October 14th, 2024 at 3:31 AM, Alan Maguire <alan.maguire@oracle=
.com> wrote:

>=20
>=20
> This reduces peak memory utilization during BTF vmlinux encoding,
> replacing ELF section-sized malloc()s with mmap()s.
>=20
> For -j1 peak memory resident set size drops from
>=20
> Maximum resident set size (kbytes): 1069220
>=20
> ...to:
>=20
> Maximum resident set size (kbytes): 701888
>=20
> ...with this patch.
>=20
> For -j8, peak memory resident set size drops from
>=20
> Maximum resident set size (kbytes): 1121172
>=20
> ...to:
>=20
> Maximum resident set size (kbytes): 963516
>=20
> Signed-off-by: Alan Maguire alan.maguire@oracle.com
>=20
> ---
> btf_encoder.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 5954238..9599faf 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -1879,7 +1879,7 @@ static int btf_encoder__tag_kfuncs(struct btf_encod=
er *encoder)
> goto out;
> }
>=20
> - elf =3D elf_begin(fd, ELF_C_READ, NULL);
> + elf =3D elf_begin(fd, ELF_C_READ_MMAP, NULL);
> if (elf =3D=3D NULL) {
> elf_error("Cannot update ELF file");
> goto out;
> --
> 2.43.5

Alan, I can confirm this reduces max resident set size when BTF
encoding vmlinux. Great improvement from a single flag change! See
below.

    for j in 1 2 4 8 16 32 64; do
        echo -n '-j$j: '
        /usr/bin/time -v \
        ./pahole -J -j$j \
             --btf_features=3Dencode_force,var,float,enum64,decl_tag,type_t=
ag,optimized_func,consistent_func,decl_tag_kfuncs \
             --btf_encode_detached=3D/dev/null \
             --lang_exclude=3Drust \
             ~/repo/bpf-dev-docker/linux/.tmp_vmlinux1 \
        2>&1 | grep 'Maximum resident set size'
    done

Current next (91bcd1d):

    -j1: =09Maximum resident set size (kbytes): 1600036
    -j2: =09Maximum resident set size (kbytes): 1623380
    -j4: =09Maximum resident set size (kbytes): 1635824
    -j8: =09Maximum resident set size (kbytes): 1631412
    -j16: =09Maximum resident set size (kbytes): 1711976
    -j32: =09Maximum resident set size (kbytes): 1799856
    -j64: =09Maximum resident set size (kbytes): 1976184

This patch on top of next (91bcd1d):

    -j1: =09Maximum resident set size (kbytes): 640344
    -j2: =09Maximum resident set size (kbytes): 695272
    -j4: =09Maximum resident set size (kbytes): 769772
    -j8: =09Maximum resident set size (kbytes): 895728
    -j16: =09Maximum resident set size (kbytes): 984908
    -j32: =09Maximum resident set size (kbytes): 1148420
    -j64: =09Maximum resident set size (kbytes): 1573944

This patch on top of elf_functions patch (with segfault fixes) [1]:

    -j1: =09Maximum resident set size (kbytes): 642992
    -j2: =09Maximum resident set size (kbytes): 695432
    -j4: =09Maximum resident set size (kbytes): 746888
    -j8: =09Maximum resident set size (kbytes): 851208
    -j16: =09Maximum resident set size (kbytes): 884232
    -j32: =09Maximum resident set size (kbytes): 930632
    -j64: =09Maximum resident set size (kbytes): 1127976

Tested-by: Ihor Solodrai <ihor.solodrai@pm.me>

[1]: https://lore.kernel.org/dwarves/20241009233520.989453-1-ihor.solodrai@=
pm.me/
