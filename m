Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8711C3BFC
	for <dwarves@vger.kernel.org>; Tue, 14 Jan 2025 18:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736879911; cv=none; b=HOxRba6LXurzCa9AXTQCvDXlvZrcJbQO+E+xM2aGELRT7X+rVaMfCYy8A2J3CIRMkz6ANTb2iX1sh/FnX0M+I6Or/7QRws4faMlkkDDF4QyRB88ZIBJ73f6viDZ+WvGQMxPPV/tTl/rXiwMJVqAqlYTXlDgsGlllmpN4qXV44ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736879911; c=relaxed/simple;
	bh=dkTZG/dG+1EzlbHCtNN+OVdnCQZa3eDG5Yz1ChyOJsY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Dsc1nTDggKp5BhXeu/IKjlqNDhRSzSrcG42Jnd12d8g8unC3A+OOhCPNZqE60sjAEgg31f4J9tZdKde52KIz1Xx2rBbQn13a+rrBda0/vaFAGGp3Ae7LFkAF7sZ8uOELlxySNZEQMNUxAz3fpqEzPMMfn754p7JwOxtV8gKwv7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZFAHfGfp; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFAHfGfp"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2162c0f6a39so1265195ad.0
        for <dwarves@vger.kernel.org>; Tue, 14 Jan 2025 10:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736879909; x=1737484709; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6hzBJdPNSBbMdZrR6Ni5BFZ72hTymMv/oD0JXG7PbQc=;
        b=ZFAHfGfpeSNcOF1p6ruunzmlmsJgbXp6Pz0Jc8c9srvNWoC+yoy8umEvFsGk3gEfOx
         Rvjp9kiaSMmG9sI58qRE+LuyvdDbZXKWI5grcxH78xyJVsr5p2cOFXWXZduhkKAirUo3
         NbTtJqUNy6dM4r6cMczMZVSztFs61bebaH/b3nd871OtHQqqf9eglgjJlta+0lXFBV10
         I62C+ISrhzZQZw5dDPb876BTfnm5ykdGwkS9wdO1uIxi9LhObHEoq6qvcYAQqTt3s/oU
         nzAJqGAu5mFu6YHSNXQVvzbeQBDLdSsWTsfhWXzJZJer1n/hwoTo3IBVzKRO0NVq3BRz
         u3Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736879909; x=1737484709;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6hzBJdPNSBbMdZrR6Ni5BFZ72hTymMv/oD0JXG7PbQc=;
        b=SchmXGB5lqo8xyO4FC/fbzgMY97xkgS1OrhtFcJH65WWA9/Cjx0c2CNZfOy1n04PgP
         Sc5oO6uNBsQ8ma4JleVv2DVWpVMfj+ncQssB7KpGZzFdEXbEyLVAhRoUmVO0p3cpMMAL
         cLU/qFCrWN6YarZ9q1krsdO7IW9r5nx06d1f91jdNUEOL7P6CeesY8mkgZosJsZTJJ0M
         pu1wkiQe0Glfd/CzdfdvLV7IZIsZ/J/1m/ia3tSZBA7DfutU2ThnSXip6zkZFWtYHJ7y
         jfvzZqfUMeuKM6ujm9w3tXtB3TpUTs4YvRs2Bq2KFqap/JZOKaM9eHJi9IzsW5EHW9Sz
         Ok6A==
X-Forwarded-Encrypted: i=1; AJvYcCWCUgvaPUtsdpHLFxuCFYwZSu8wuCUN2SEougIx8vlpRtw6xiHPBzY8RoLwViA/cPbPPB2Ir2N/@vger.kernel.org
X-Gm-Message-State: AOJu0YwRtUjYFlAbHWgVF1xK7QQ+uUoiDAx+UwxAXIOAHNHeiK3YzDdP
	yJ+h0tu/oary/kS7YfJHfOdhzcd5I3Ro5rj5i0SywJPf1T8UfBRUWhvjow==
X-Gm-Gg: ASbGncsQrOvf4VUi2w//q20gRMRqDmETf7Gg/9zuPOroD68pAoQ0j+0Hixk6/hP6FQv
	YdmkpHM0Nm7WsYXHxC8Y2VJhRSSmVQj7sF/9mj5hcfJJaenmm7uBc4dk8rDUGMnovUdheZozXNn
	pwdSPMKuG2rigLA6L60jKTFXIG3cKSgWr0dx8L9YnvUQZuC6cMW/t2lMFExptV/yNl3mt6lRLyN
	rc2nhHTxnOasgUfIbcjjsmUwJ/E3EnRSsMGNG3orlx65sSZyvTDeA==
X-Google-Smtp-Source: AGHT+IEOCsQh4QeQ5GIy4VOyEGP7Qk1yEHAN0X8Ia80VfhUQgdF360b1hnzBIu4T6usDVa/SCGOfzQ==
X-Received: by 2002:a05:6a20:d706:b0:1e1:b878:de64 with SMTP id adf61e73a8af0-1eb02506183mr88125637.6.1736879908964;
        Tue, 14 Jan 2025 10:38:28 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a31844ba221sm8597572a12.24.2025.01.14.10.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 10:38:28 -0800 (PST)
Message-ID: <e020162afdf6f8a4d319a54bb8236cac2d6c3e19.camel@gmail.com>
Subject: Re: pahole -J mishandles types in function scope
From: Eduard Zingerman <eddyz87@gmail.com>
To: Giuliano Procida <gprocida@google.com>, dwarves@vger.kernel.org
Cc: Aleksei Vetrov <vvvvvv@google.com>
Date: Tue, 14 Jan 2025 10:38:19 -0800
In-Reply-To: <CAGvU0Hkx7gzjZkAVGXQyp+_6Mp7gBOD3uOtbEQuyhPApQy_iFQ@mail.gmail.com>
References: 
	<CAGvU0Hkx7gzjZkAVGXQyp+_6Mp7gBOD3uOtbEQuyhPApQy_iFQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-01-14 at 13:14 +0000, Giuliano Procida wrote:
> Tested with pahole v1.24.
>=20
> The following code, when compiled with either GCC 14 or Clang 16 or
> several other versions, and post processed with pahole -J, results in
> the private definition of foo in bar being exposed as part of the type
> of baz in BTF - which is definitely wrong.
>=20
> struct foo;
>=20
> int bar() {
>   struct foo {
>     int x;
>   };
>   struct foo j =3D { 0 };
>   struct foo k =3D j;
>   return j.x =3D=3D k.x;
> }
>=20
> int baz(struct foo* j) {
>   return j !=3D 0;
> }
>=20
> Note that we had exactly the same bug in STG and I resolved it by
> pushing an anonymous scope before processing the function child DIEs
> (we deal with C++ scopes). You could perhaps push / pop a flag which
> inhibits type definition processing.
>=20
> It's not possible to just ignore type DIEs inside functions because
> (at least) Clang sometimes emits references outside the function to
> such DIEs.
>=20
> Regards,
> Giuliano.
>=20

Hi Giuliano,

Thank you for the report, indeed, the BTF generated for your example is:

    [1] STRUCT 'foo' size=3D4 vlen=3D1
            'x' type_id=3D2 bits_offset=3D0
    [2] INT 'int' size=3D4 bits_offset=3D0 nr_bits=3D32 encoding=3DSIGNED
    [3] PTR '(anon)' type_id=3D1
    [4] FUNC_PROTO '(anon)' ret_type_id=3D2 vlen=3D0
    [5] FUNC 'bar' type_id=3D4 linkage=3Dstatic
    [6] FUNC_PROTO '(anon)' ret_type_id=3D2 vlen=3D1
            'j' type_id=3D3        // <-------------- this is wrong
    [7] FUNC 'baz' type_id=3D6 linkage=3Dstatic

Thanks,
Eduard

