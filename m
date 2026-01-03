Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3677129A30E
	for <dwarves@vger.kernel.org>; Sat,  3 Jan 2026 09:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767431512; cv=none; b=eez8B9HLRBTudo7EtLQ72vEDIOlaqPhRx2mfMBf7seek/Ov2Yo8krgXav8bntZvQh9qIMljPvo0OTSHFYXBI8BPrvvw9s9BYbu4a+7z/lrtxIvR5Ge8e/tWpvKUfUdn14ZYNsl00tByyzpBteqbBvZs/qrfw75rWmY5z75vSZQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767431512; c=relaxed/simple;
	bh=HA43poXcwQpADE2V9nU830RzFH6YDFnRj5guQFKHWY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R1oZ+IMF6eAqZHZ1iSyGHFLSQV3JWTYlhPazyiWTG6CrQ5VnZcDHYbOk45QrACWs/JNbr+KG2b/cNMSWqlIXXut6f7bC5MDL2frzHOZFzeyeDWOHqQUaTLfXKkPQUt0PQlv4bafEV9vHaSYxF/k1D6evtxzVlirQhEzN+SgvR7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QBUVEBi8; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBUVEBi8"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7acd9a03ba9so13042718b3a.1
        for <dwarves@vger.kernel.org>; Sat, 03 Jan 2026 01:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767431510; x=1768036310; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CbB/u4Boyz6wim8LLKDK6vrmsmGBVfzV79ZjNtpeGas=;
        b=QBUVEBi82nqruvb4sfB04p3544/imFFRNhSir75cFMCYEf4h7wFYoiCRPAb2RDlCUI
         JerEuwpOEZ0GOxQ8jFm34HljVvdV5bYZafRfcssETKyeqFGT39xc0+IHNUcmMeHbwoDU
         FprCWxpzDtZY7DMFALG2r1vbuE8T7s6QlLk2RSj6hW+OSjM5W6mi3GBXRjauu0pptzFM
         c3hH95Ec9RJvj4mBlgHlSQ0LUkY4aOK+PSr/O8tdqqxMbs7WpK6/LQ1EBXhbvcy+QoE0
         FteuA3DvB8BRlyGkbU6KogeB1GAtL9ry9eLbltQrdGuLSVt3hPOqNDbi7sXQvHmDH21g
         +JtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767431510; x=1768036310;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CbB/u4Boyz6wim8LLKDK6vrmsmGBVfzV79ZjNtpeGas=;
        b=LJWT6Xy9UV5AgchwA3U4YAzLI85gSxCGZB4KG/DvcFDc7gXVVExN6zEczAhNmv5HKe
         2GtwKwzjGWLJ2YnKJmWrA2iYovA562OpoNsj8BUDFMddxwGuJtowQKKM5hprfmrhVcyk
         jhO3MkcGb+stYGI+1JWhwBCHEK/CJRM2AkowcJu0/qwngkWRM9MRE3UuL9pa4p59vYz7
         a3BVD1r3XG0Sau0FFhOrhURUo3L6+YvtkVKjfuAHxmaq1RKMQHwjAVzon8MdFzIg1VYV
         1EMMhBkiqYUwV7gZiNK9bycQARVGABuYQkJ4t+RVinwPzf8D5q1HZ41idNe5UV5Qj//K
         zh5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXBSQ8V+fhRhMAl+jR8kPvQ2Ei0ldvNNX9p2skK6QDeeudvsxSO3JnpCXBrVjHwxmftHGpsPOMq@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6SKV0J1kxl5HRMh3JifmjMUwocz+khbSOVMsYCloW1LNQ6Dvw
	/xytDgT4zKmjO/w9QL3UwjIbottZXiYwse1C5Ru4WTcGiHAwC71aat2A
X-Gm-Gg: AY/fxX56BCQQUvAj6VF7utvhvzCXFffX9Mc9PVOp+LuK4lhK0tDad0bYLj5/4zHRDWP
	1ggxG1vapx+NARpCSnP/JTpr1vZugQrsZQmY57XtMlZAf7P/zY1TyKt5AVZn7aVnZiodb6koxKX
	FnCDF/Ljw36kLppHbU9O3OoX+fmoUb/2lhK+d/YOODjXPj7Tm3FP1sW5HXsPDAoUFJuDn+xMUT6
	0/clU+QRbZ63GMUnjRLuC8nRiHqP4t2R+g5pEJMCVzB8G9J3J4O9/1s+cqxA34l3HCxAMPqfnYq
	ab2tdt6qSCCI38kfKbMp6faSC3pgzf1yw5GvaleqgK3Z7gF1UnChTsyroJ7xAyGvOF7wAUgxIgg
	5IItyWoF3iLcN4xe206Q/VtHaM5H1jNHt5kw5CbCBqGNxDcNl7Kco0vy7wwqi9tLoqIRkJdMn2j
	MkDEXZPD7hO+0=
X-Google-Smtp-Source: AGHT+IHj+Yc5i5BlyxHw8XH6x0veUjij66PZD5scVA7u5fS2kWQiygSaCY5f39DOPJCDQFwr9SkNbQ==
X-Received: by 2002:a05:6a00:e0f:b0:7e8:4398:b34f with SMTP id d2e1a72fcca58-7ff66079339mr38129658b3a.34.1767431510268;
        Sat, 03 Jan 2026 01:11:50 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e797aadsm42981212b3a.61.2026.01.03.01.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jan 2026 01:11:48 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id ABA154092C2B; Sat, 03 Jan 2026 16:11:46 +0700 (WIB)
Date: Sat, 3 Jan 2026 16:11:46 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>,
	Hemanth Malla <vmalla@linux.microsoft.com>, bpf@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
	yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org, vmalla@microsoft.com, corbet@lwn.net,
	Alan Maguire <alan.maguire@oracle.com>,
	dwarves <dwarves@vger.kernel.org>
Subject: Re: [PATCH bpf-next] bpf, docs: Update pahole to 1.28 for selftests
Message-ID: <aVjdUjai0lzpMeHv@archie.me>
References: <1767352415-24862-1-git-send-email-vmalla@linux.microsoft.com>
 <bcd23277-a18e-4bb5-ba76-3416c84511c2@linux.dev>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x53cqXSfhecsAUML"
Content-Disposition: inline
In-Reply-To: <bcd23277-a18e-4bb5-ba76-3416c84511c2@linux.dev>


--x53cqXSfhecsAUML
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 02, 2026 at 07:33:50AM -0800, Ihor Solodrai wrote:
> On 1/2/26 3:13 AM, Hemanth Malla wrote:
> > diff --git a/Documentation/bpf/bpf_devel_QA.rst b/Documentation/bpf/bpf=
_devel_QA.rst
> > index 0acb4c9b8d90..3a147b6c780e 100644
> > --- a/Documentation/bpf/bpf_devel_QA.rst
> > +++ b/Documentation/bpf/bpf_devel_QA.rst
> > @@ -482,7 +482,7 @@ under test should match the config file fragment in
> >  tools/testing/selftests/bpf as closely as possible.
> > =20
> >  Finally to ensure support for latest BPF Type Format features -
> > -discussed in Documentation/bpf/btf.rst - pahole version 1.16
> > +discussed in Documentation/bpf/btf.rst - pahole version 1.28
>=20
> Hi Hemanth, thanks for the patch.
>=20
> Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>
>=20
> 1.28 is needed for --distilled_base [1], which is only a requirement
> for tests using modules. Many other tests are likely to work with
> older versions, but the minimum for the kernel build is 1.22 now [2].
>=20
> Not sure if it's worth it to add this nuance to the QA doc, although
> in general we should recommend people running the selftests to use the
> latest pahole release. Maybe add a comment?

I guess minimum pahole version can be added to
Documentation/process/changes.rst.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--x53cqXSfhecsAUML
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaVjdSgAKCRD2uYlJVVFO
o/ofAP9+4EXkvyXn4xtHYs/ZObOs1c59JDS0PbftimugULAbBQD/bWQidzmK3WT/
kSgpPyJVYNhsw4M7WZ30T5LQm9z0QQk=
=xORZ
-----END PGP SIGNATURE-----

--x53cqXSfhecsAUML--
