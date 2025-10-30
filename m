Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AE51D90DD
	for <dwarves@vger.kernel.org>; Thu, 30 Oct 2025 00:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761785051; cv=none; b=UGeTkuzYJ9gEujlq3tXiAy0ORmaIedI5C10SF0c0kcUo0NXzgKGBGBD4KD50MNLn4Nkl5yxgrOZaRQdfqHjyyaxr7TQpO50T0q18CIQ/MEM661WVHu8Y2FWjabEqalg9jmGJoTNFN7nGjMMOPAHHO4dHAEiFS1V0JanCWl+jAuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761785051; c=relaxed/simple;
	bh=I+WgTPaNnSzDBETHmmnN0SSttG2OMYV1Sg6AU3YNRyk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V+q30+pSmqNcBc/XqqKlsM7KmPJD175OreQL+sMlzd6XtxXL3bZ1uFJmUvGGnJITFO2O7UfHtlqFDNsJ9IMwDXonmgkEzdybClEqBRZ+UDCOaSEStSoMwjoiToM8snMDDKbZlL3xRL8IetfCgT58Mr4SCz5cvEoOtFyYpwTQTlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BJeLP0eT; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJeLP0eT"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b6ceb3b68feso416540a12.0
        for <dwarves@vger.kernel.org>; Wed, 29 Oct 2025 17:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761785049; x=1762389849; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cJAFdiNGbg/PA+Qv0N/d0kPPmEjoCTtUxDRG6LiXmBY=;
        b=BJeLP0eTlx6A18BPHHK9G01Asxvi08J4Meq3LFvsjbJEEvUXkT1lkCx5HFGrcEWTr9
         dJwEbyZH+XSz/ic3BiTjCmfkCzwk9y8vLa4vsbAWMX6ufZbaUV6Plu1mzR1OMi3LADP4
         1uWhVD8JR1osusntG8WJwiNAf3wa0ep5pQYclWX1vQyaA0BgRQ1ZDyYAOfd7YkAqKUdL
         TXnhgInXiaOS1V7CAyOz2+MLgWqlJ0rfqun9vAQcU2x+BDvDswCKwp5fBO7i6pGQdFa4
         kkBSjM3p2xXiQ4yq4/JxKa7k56R3O+x9734b+dm7ng4OAg0R8WOmdTfRYeoUhoWytWYu
         rMrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761785049; x=1762389849;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cJAFdiNGbg/PA+Qv0N/d0kPPmEjoCTtUxDRG6LiXmBY=;
        b=ZY8nGY8ZKnmYiaofAB1SZFtSML1Gu3alE9PSOJZwyFdho2bE5rU+eLleukI0KmlPYI
         fy/kxSqPCdyzvrE4xx363+/7F5VnQZqNdMzmmbqpNK3wPqZDVLRd0Pbzk9he3I0jYATP
         YzsO9nrU8V43p+yGO3MxCaUGnWHsatTbMD2Sz3YkuHJ8Kq+GVZR8nxq7kwKgvGqZoghB
         YNfGpIr3/t+cynvRgnF/O4fXeEOsAROYeFt8AiPR6OVBQta8Wp03NWBVSkvJbJI1WrLw
         vZL+8/do5KdWiXcbWA+c3nCSGEtHPwaqVT2Wprsl5LEQLnbzUTPIQnQiEdpweRb7rIPC
         jTqg==
X-Gm-Message-State: AOJu0Yz5jBOTjdNzCgGTYPeL8Td3jJOnAHKj9WfhFqw/9DGGdWeSur/p
	v7zjq/OoYZdwHEMyQMOt2+AyX0WIRrUD1Bfgwd+l9hF9IXdf52DanHOW
X-Gm-Gg: ASbGncs9UcXQQF4BXCQtUV4sCiUmHZp2t7uTDTQhbN2UOkJPIYTClwe8z7nZA6uO06p
	z87YMe72nH7Ec1Nypw0lor7sLpxnoxuVuntsB2DZ4UaqcTh4H5dvIULtHGKh5oyf+LzPu9T36//
	/9W3JPzGqyhkuIJTcWN469OboFX7YlTeKSIsvuNJLSJP1v3ZWsA2hiS99cM0kD15JI7jWGlnC2U
	FbIv8pxAzKlhsn/ZuqZ2Xu9GJ8D3X1a/8T/hWt07gIFPsKcT8eq7+6sKctfzyLEsVvJt/VI5jls
	sKG7R/W0TOMdXr078YpOiP8+0b+5Efdi9BMFErIN0PL/Q3eFa2HBtGnD360hWb72jl/QAnBOIps
	9u1g/MvkRRhS3pmp7wPAGhyQEgXifFZG5p+uvoEuUHMtL4Wuzo6/N/s8LTtNzT4sbA7Bf2dHLbC
	l8kO+sOR8/e4M69PQN2pdBSWUBRw==
X-Google-Smtp-Source: AGHT+IGCbbG0NDrHaKAWMisnV6NPj2EnZJOkjrA78/MDp4MssYSmrC/T9/+kg7TlIICD72V8eRm7Jw==
X-Received: by 2002:a17:902:ea10:b0:294:fbe5:89ef with SMTP id d9443c01a7336-294fbe59666mr1934105ad.28.1761785049369;
        Wed, 29 Oct 2025 17:44:09 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:3086:7e8a:8b32:fa24? ([2620:10d:c090:500::5:6b34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d27433sm164768845ad.58.2025.10.29.17.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 17:44:09 -0700 (PDT)
Message-ID: <50ddff79d33d6e2d57e104f610273d647530ddbc.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 0/8] bpf: magic kernel functions
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, bpf@vger.kernel.org, 
	andrii@kernel.org, ast@kernel.org
Cc: dwarves@vger.kernel.org, alan.maguire@oracle.com, acme@kernel.org, 
	tj@kernel.org, kernel-team@meta.com
Date: Wed, 29 Oct 2025 17:44:07 -0700
In-Reply-To: <20251029190113.3323406-1-ihor.solodrai@linux.dev>
References: <20251029190113.3323406-1-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-10-29 at 12:01 -0700, Ihor Solodrai wrote:

Do we break compatibility with old pahole versions after this
patch-set? Old paholes won't synthesize the _impl kfuncs, so:
- binary compatibility between new-kernel/old-pahole + old-bpf
  will be broken, as there would be no _impl kfuncs;
- new-kernel/old-pahole + new-bpf won't work either, as kernel will be
  unable to find non-_impl function names for existing kfuncs.

[...]
