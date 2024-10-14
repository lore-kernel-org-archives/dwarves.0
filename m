Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44721175B1
	for <dwarves@vger.kernel.org>; Mon, 14 Oct 2024 16:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728921755; cv=none; b=gwUsJMax3nGRDmO3RtoSU7+d+A/i5dy4xCvK5XYyjUOGv5R7GcCDTiLN8DqY0gAnumXJzTk6mW7q+40dCdJiUWp/8TwUr/x0O5klmF7jky0fuZwii2+bXnt/s9UuEwuUEDHakG2W4QdR7BPoyXFgF+lS+2egVivKtcRiEXXv+AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728921755; c=relaxed/simple;
	bh=UStX58jhm3j7wPQj3dARGnDB8XdJdi3GPXjf37GegbI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P/CnEABjA0vNQHU8NtGGZGpoSPQFnqWdLM619kcg12XP2VL8vcQ66AmKzBVo9rNN9Ifx6DIULlbxRr21w6aATbrr+8T5a73ciilSNgdhIjoCvM5vZbsflzFnTR5FHFLdVymRp4g2DueV6ZkiyJ6nwMJ3urwUuR/xqzR/oEGLEsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=byZTUoUc; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="byZTUoUc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1728921745; x=1729180945;
	bh=peB5ut7cnMNVFK6MvwcPBIHrordRPlaAQH6PUdUixkQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=byZTUoUc5FnqMLNCC/YlIL4QYeiIYjplxSxgGX0C99UscRExf7UyI6YXB9sM1r3BK
	 2dSpoTEgV+5E0TLwdxR0KR/ZN+QSPD8kR1+SG2fSEzWCRBHu38COE4rvsOfnCdx8Kf
	 M9mnPkHr/95Nml0C+AKAT6Aty/zkR4g7I9OB3VKiDEAp9zwDJ/gVBSxA27sG29QLiw
	 Csap5T9pRyn11+jc/4hSECUpMIBOqdUBGHWH/MEL+Mwtzf0QFEufCHQYi4JXhMRe1I
	 wI59ur/0o/ECSDxcU6xvo62FLnv2SjnfCiUUaEGGUHHSXqJcnDPWlf7QHKe0XRe9G/
	 0IzS57sEJcANA==
Date: Mon, 14 Oct 2024 16:02:23 +0000
To: Alan Maguire <alan.maguire@oracle.com>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: Eduard Zingerman <eddyz87@gmail.com>, dwarves@vger.kernel.org, acme@kernel.org, andrii@kernel.org
Subject: Re: [PATCH v2 dwarves 0/5] btf_encoder: implement shared elf_functions table
Message-ID: <JcUUig9yPN-f6XHqo6SUkFN8J4Qxd0xfCGhvsv8rr4pSl8gN3bVj6iSblNkN1xbDgAvXq4D8XtiusJ2lEtCv-lV2-q-xQJlmEiOdr9QaGgk=@pm.me>
In-Reply-To: <9d3071a1-83fc-4c57-999c-d95f71555dfd@oracle.com>
References: <20241009233520.989453-1-ihor.solodrai@pm.me> <60b79369e829b33c577fe285b6597894e72b7042.camel@gmail.com> <4C0idzPIUJesSQi12dB1SgeTQlGl13N2CCsvjPfdLbvTEemTJoQZ4P-LJcOQqRyM69ZLKVv4mIKDQJvfMYMV2oITse1_uS_m_SjVigh8bL0=@pm.me> <af7ca712-7798-4204-9e15-fa2065154699@oracle.com> <52889283-56c4-4cf6-aad6-b0fbea9e58fb@oracle.com> <m_fH6Yg0CAytjEUTxfZPpbMVGqGQWhuep4D--XMNrOZJh6MUWlIozEXiCC6ulW4FK6UFvCFlZC_sF0oNsAW3sftTvfPBjpz5AN3MdnxfhB4=@pm.me> <CjP57PbrCPwA8EsOHPQuoZ9YnU1UE0mzeYqoqI4gQHTxIVUgXoEmGS-4R2g1gkf1RMPFVlTSE253f49mPUvqHUiuUw4wxwJXBH3Pv5GPwOg=@pm.me> <9d3071a1-83fc-4c57-999c-d95f71555dfd@oracle.com>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 10de23aab3d026dee80f803e7d097a3ccc99948b
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Monday, October 14th, 2024 at 8:06 AM, Alan Maguire <alan.maguire@oracle=
.com> wrote:

>=20
>=20
> On 11/10/2024 23:55, Ihor Solodrai wrote:
>=20
> > On Friday, October 11th, 2024 at 9:52 AM, Ihor Solodrai ihor.solodrai@p=
m.me wrote:
> >=20
> > [...]
> >=20
> > Eduard discovered a bug when building kernel using pahole with this
> > patch. I already debugged it and made a fix.
> >=20
> > TL;DR there might be fewer encoders than threads, which I didn't take
> > into account here:
> >=20
> > diff --git a/pahole.c b/pahole.c
> > index a45aa7a..90f712d 100644
> > --- a/pahole.c
> > +++ b/pahole.c
> > @@ -3257,29 +3257,34 @@ static int pahole_threads_collect(struct conf_l=
oad *conf, int nr_threads, void *
> > {
> > struct thread_data **threads =3D (struct thread_data **)thr_data;
> > struct btf_encoder *encoders[nr_threads];
> > - int i;
> > + int nr_encoders =3D 0;
> > int err =3D 0;
> > + int i;
> >=20
> > if (error)
> > goto out;
> >=20
> > - for (i =3D 0; i < nr_threads; i++)
> > - encoders[i] =3D threads[i]->encoder;
> > + for (i =3D 0; i < nr_threads; i++) {
> > + if (threads[i]->encoder) {
> > + encoders[nr_encoders] =3D threads[i]->encoder;
> > + nr_encoders++;
> > + }
> > + }
>=20
>=20
> I tried the above, but still saw segmentation faults; the following was
> needed at my end to get module BTF working:
>=20
> iff --git a/pahole.c b/pahole.c
> index a45aa7a..bb17aec 100644
> --- a/pahole.c
> +++ b/pahole.c
> @@ -3257,20 +3257,25 @@ static int pahole_threads_collect(struct
> conf_load *conf, int nr_threads, void *
> {
> struct thread_data **threads =3D (struct thread_data **)thr_data;
> struct btf_encoder *encoders[nr_threads];
> - int i;
> + int nr_encoders =3D 0;
> int err =3D 0;
> + int i;
>=20
> if (error)
> goto out;
>=20
> - for (i =3D 0; i < nr_threads; i++)
> - encoders[i] =3D threads[i]->encoder;
>=20
> + for (i =3D 0; i < nr_threads; i++) {
> + if (threads[i]->encoder && threads[i]->encoder !=3D
>=20
> btf_encoder) {
> + encoders[nr_encoders] =3D threads[i]->encoder;
>=20
> + nr_encoders++;
> + }
> + }
>=20
> /*
> * Merge content of the btf instances of worker threads to the btf
> * instance of the primary btf_encoder.
> */
> - err =3D btf_encoder__merge_encoders(btf_encoder, encoders,
> nr_threads);
> + err =3D btf_encoder__merge_encoders(btf_encoder, encoders,
> nr_encoders);
> if (err < 0)
> goto out;
> err =3D 0;
>=20
> In particular, nr_encoders must be used at btf_encoder__merge_encoders().
>=20
> With this in place, I hit another segmentation fault, due this time to
> the fact that we need to handle the case where there are no ELF
> functions (this occurs for one module when building the kernel). Fix is
> below:
>=20
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 07d2031..b61a89c 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -2274,6 +2274,8 @@ static int elf_functions__collect(struct
> elf_functions *functions)
> functions->cnt,
>=20
> sizeof(functions->entries[0]),
>=20
> functions_cmp);
> + else
> + return 0;
>=20
> // Reallocate to the exact size
> functions->entries =3D realloc(functions->entries, functions->cnt
>=20
> * sizeof(struct elf_function));
>=20

Alan, thank you again for testing. I missed some lines in the diff I
pasted... Anyway this will be incorporated in v3, thanks.

> [...] 
