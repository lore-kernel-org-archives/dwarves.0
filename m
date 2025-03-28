Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567FC17BA3
	for <dwarves@vger.kernel.org>; Fri, 28 Mar 2025 09:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743152762; cv=none; b=uH92gfPC96SlXEkA6xHfKI/nnerKPAL9nsEMvjrTUMmNPm7URnGhTEsNxt/jvL92KxvSBoBNMTcd4NhWDXmqmsU+hiUpGQ0nAxg+wOOimDwKkSW/rzfh20AL8LVqvnabG+aUgKuCxjtobTCNhlPcxRokLTYK8EzHXrVNZvEV5fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743152762; c=relaxed/simple;
	bh=fyfiHVEf3MHA1I4qRkluSrpsJlTgHHw9Eh3mVMYkfok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h17y/gRD60YniUTJCRljCf3rBFjAy/crGR7hSdSsrf96rhtgQJz91yqCfM8VEeO8blK9LZ/k/7J6EzJTeEIuYFoPo3QkmSyiIyWXK7HCzD8WD1wNaRNE6TiTkO6vkm1m0HZSqMB7vs1VO7xDozfTv4wRjq7GJQQNyApuD7Yb2Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EjxsmTFA; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EjxsmTFA"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5eb5ecf3217so3477988a12.3
        for <dwarves@vger.kernel.org>; Fri, 28 Mar 2025 02:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743152759; x=1743757559; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O8x2TQc3oalMqKdtqYTJUFOJ9QlIsXlOFNNmXCKk0L8=;
        b=EjxsmTFAmOcZp3RjrZISXreWEA7EkLy2Vu2DXwRHPBsk+88XMpgFnAxVl2GzmnrEvV
         7O4DAysp4lhOopwSl+e7zzOE9dm9UR62rs2b/L/r0nfMmkcb5JChkjarPH2PO6MC/SY2
         Z2uOjjBIxJ5wZ7pEhvkpJ9TvPNp/GmUafLO789U+IbT2pSft62AKYxyrIRXq/am6/LcB
         yU9/PktJHhC/x1p7Oay3TUNFW8vgFXHfxBdrkaouNv5FZ+bSnxhdmB2KG5d4vd5P9pS5
         A+UFmnWy5DJMU26ba5RXHiC0/7liiQB9k8DSM+7+gmG9H8nDcd/LaCKeRTHyi+KGFbsr
         uypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743152759; x=1743757559;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O8x2TQc3oalMqKdtqYTJUFOJ9QlIsXlOFNNmXCKk0L8=;
        b=shqs8oz4H6dC3QaCoaJya92ydf4dcc2pXyNGNdkD9wHrRrbh/eyHaLANbuT/yphFB/
         YiW5FLCh2iqTgVD6TungWq02dj/utkzvzy7xORm9HZZW4Khfd5UPn0U3whxLXVmlTBS5
         aaMgOHMwW43NV1sNxoV43sqbbRnxkEClBNn3ELh1bmP9C0unirvJIWDQw4KAh1RL5Ki7
         k8p0RWYxQfo4v9+fm6sTOtaBIZMQrVdiGShCI75qxYD8xJwGvxvznCpk8OuMlHxGorjH
         WXlt/mk03JT/d41Vq90YwM3Z+/nK13WRNagcjZKXqy9BH99T8VZEAJZMSmsAnlmdlCaN
         Dl3w==
X-Gm-Message-State: AOJu0YxCc2kUSB9EeTbwbIhkhiX8d78TN3AKn+tQgyz5WghfsKDX2csD
	XCi8kzgNEWQdDlZ+dTPPL1H6w7fqsC3zxfsQMiXH0WBG6gSwI0GXd5pNiXgo6nW8Sg==
X-Gm-Gg: ASbGncvIPlMpMXOjy73almdO3U3fG7ZMgNzR2s39L97DOdmSrOpscgqkhiVFDyRptry
	1CFBebdnNw7ZXDNXSWLHufp1IIC8vuUTQJ6PfL6FCmpJuVAstazcy6YSa+aL723jPlh5MWq8ftn
	+0yNpplFA6rfgkMmg0QSHGIfVfnDxhAVszXpOn6FkT+gxcE7JUFe2fHH6YPJrx9woUh2EP4CM3f
	VrRrGiV2/+q+cZD59zMO28j9s4KMqaadZdaWruPJ9YNPYSvnx1cTGqc+4cfRDDfsiwFr/H5MbQk
	qdo/8ybGAglw15+rKw==
X-Google-Smtp-Source: AGHT+IEAk8alIRzgubJpCK7nkl/0Wxe6GaF+Hlp1dpgG85e0OQ3ktEbz+fi/2z/7AqAWfynuAQq7Fw==
X-Received: by 2002:a05:6402:1d4e:b0:5ec:958b:6f5a with SMTP id 4fb4d7f45d1cf-5ed8f5f726amr7348471a12.28.1743152758252;
        Fri, 28 Mar 2025 02:05:58 -0700 (PDT)
Received: from m4.lan ([2a0b:f4c2:3::68])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5edc16f02bdsm1066596a12.43.2025.03.28.02.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 02:05:57 -0700 (PDT)
Sender: Domenico Andreoli <domenico.andreoli.it@gmail.com>
Received: from cavok by m4.lan with local (Exim 4.96)
	(envelope-from <cavok@localhost>)
	id 1ty5f1-000HV6-0Z;
	Fri, 28 Mar 2025 10:05:55 +0100
Date: Fri, 28 Mar 2025 10:05:55 +0100
From: Domenico Andreoli <domenico.andreoli@linux.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: dwarves@vger.kernel.org
Subject: Re: parallel pahole hangs while building modules from
 nvidia-open-kernel-dkms
Message-ID: <Z-ZmcwXyMtAQjaoE@localhost>
References: <Z-JzFrXaopQCYd6h@localhost>
 <83315e0bce204f7745448fff550574d44b09b4c1@linux.dev>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bgkpY+s0VLJ60rOX"
Content-Disposition: inline
In-Reply-To: <83315e0bce204f7745448fff550574d44b09b4c1@linux.dev>


--bgkpY+s0VLJ60rOX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 08:48:51PM +0000, Ihor Solodrai wrote:
> On 3/25/25 2:10 AM, Domenico Andreoli wrote:
> > Hi,
> >
> >   This a forward of Debian bug report [0] where you can find more
> > details. At [1] and [2] you can get the kernel and module to reproduce.
> > I could reproduce on both amd64 and arm64 using pahole 1.29.
> >
> > This is marked as serious severity because it makes the autobuilder hang
> > as well [3].
> >
> > Could you please help?
> >
> > Regards,
> > Domenico
>=20
> Hi Domenico, thanks for the bug report.

Hi Ihor,

>=20
> I debugged the hanging, and it appears that "abort" handling in case
> of a BTF encoding error was overlooked in recent changes to speedup
> parallel encoding.
>=20
> Could you please try the diff below, and check if it resolves the
> hanging?
>=20

Yes, I tried it and the hanging is gone.

Now both parallel and sequential invocations fail with this error:

  dwarf_expr: unhandled 0x12 DW_OP_ operation
  Unsupported DW_TAG_reference_type(0x10): type: 0x28172
  Error while encoding BTF.
  dwarf_expr: unhandled 0x12 DW_OP_ operation
  dwarf_expr: unhandled 0x12 DW_OP_ operation
  dwarf_expr: unhandled 0x12 DW_OP_ operation
  libbpf: failed to find '.BTF' ELF section in nvidia-modeset.ko
  pahole: nvidia-modeset.ko: Invalid argument

I guess this is another story that was simply covered by the previous bug.

> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index 84122d0..e1ba7bc 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -3459,6 +3459,7 @@ static struct {
>  	 */
>  	uint32_t next_cu_id;
>  	struct list_head jobs;
> +	bool abort;
>  } cus_processing_queue;
> =20
>  enum job_type {
> @@ -3479,6 +3480,7 @@ static void cus_queue__init(void)
>  	pthread_cond_init(&cus_processing_queue.job_added, NULL);
>  	INIT_LIST_HEAD(&cus_processing_queue.jobs);
>  	cus_processing_queue.next_cu_id =3D 0;
> +	cus_processing_queue.abort =3D false;
>  }
> =20
>  static void cus_queue__destroy(void)
> @@ -3535,8 +3537,9 @@ static struct cu_processing_job *cus_queue__enqdeq_=
job(struct cu_processing_job
>  		pthread_cond_signal(&cus_processing_queue.job_added);
>  	}
>  	for (;;) {
> +		bool abort =3D __atomic_load_n(&cus_processing_queue.abort, __ATOMIC_S=
EQ_CST);
>  		job =3D cus_queue__try_dequeue();
> -		if (job)
> +		if (job || abort)
>  			break;
>  		/* No jobs or only steals out of order */
>  		pthread_cond_wait(&cus_processing_queue.job_added, &cus_processing_que=
ue.mutex);
> @@ -3653,6 +3656,9 @@ static void *dwarf_loader__worker_thread(void *arg)
> =20
>  	while (!stop) {
>  		job =3D cus_queue__enqdeq_job(job);
> +		if (!job)
> +			goto out_abort;
> +
>  		switch (job->type) {
> =20
>  		case JOB_DECODE:
> @@ -3688,6 +3694,8 @@ static void *dwarf_loader__worker_thread(void *arg)
> =20
>  	return (void *)DWARF_CB_OK;
>  out_abort:
> +	__atomic_store_n(&cus_processing_queue.abort, true, __ATOMIC_SEQ_CST);
> +	pthread_cond_signal(&cus_processing_queue.job_added);
>  	return (void *)DWARF_CB_ABORT;
>  }
> =20
> @@ -4028,7 +4036,7 @@ static int cus__process_file(struct cus *cus, struc=
t conf_load *conf, int fd,
> =20
>  	/* Process the one or more modules gleaned from this file. */
>  	int err =3D dwfl_getmodules(dwfl, cus__process_dwflmod, &parms, 0);
> -	if (err < 0)
> +	if (err)
>  		return -1;
> =20
>  	// We can't call dwfl_end(dwfl) here, as we keep pointers to strings
>=20

Is this patch already final or do you prefer I'd wait for review and marge =
first?

I would apply it on top of Debian's 1.29 and release a new 1.29-3 package.

Thank,
dom

--=20
rsa4096: 3B10 0CA1 8674 ACBA B4FE  FCD2 CE5B CF17 9960 DE13
ed25519: FFB4 0CC3 7F2E 091D F7DA  356E CC79 2832 ED38 CB05

--bgkpY+s0VLJ60rOX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEGSWGdoKrcEzTtUezikr1XMf+zOIFAmfmZm8ACgkQikr1XMf+
zOKGTxAAnHhG4JPfjr5NWG4nQUiJ3TpXEPHh37hesir6GXgfKR2ellL87h9ZRU4V
QMhWz8wSdBdptIY4oDvR4mmKb67GvkMnjT5n+e5l4JRhx0VXa80pbeiJdvZtGzxb
pizA7F8qLH6Cux7r+cnAildDgsl/Uf/gkjjkMBxcscbXzHecIMbN2MK8K3F8FsKA
N/AWz+Y/izuerrDYYlvql1YR0SpsHeI7X1l+AndI0K1MTsD2YxFim6KM7Zwhq16M
C2IV4j6DBU5H8cmbD3uJ0qHDDieU2TeBrHq317EEbZFvM9/ZBR6Qs5b7jL8Rvm05
BEt8kdE1ggHb9dR41A09qtS6M3uaXQPA8vbf7z8fwXJ8Pa1V5MiUU+Y4oXXygxqj
MatOWUzmDrTcr2GBjl/nBqHG9G6Tqinnoih3gA4IUN/mcRxd7qOhV3TChiHTt66g
CFs/hzjddTe629SjhGFm4KAF65jsxfziP/2vgNbYoe+W0i7zTQysRscLxbPFCWsA
pvLOPWkDXPeWdRyLZz3FI6UqLUjFqL5TQqrO51wUhE+Pfxwp1E1aqd24DogWM+jE
zoC9ZlmekFX2Zo0oC0COWDCNFg+dCg3u72qDP/teL81awQKLrgrhWBjN+JXmbf/i
AbxMRogTaKR6nIPD++zjnoBYpnGQcw/sQQhy4ZE7aCmLUsHv7LI=
=k2aD
-----END PGP SIGNATURE-----

--bgkpY+s0VLJ60rOX--
