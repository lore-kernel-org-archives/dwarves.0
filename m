Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31ABC1A76CC
	for <dwarves@vger.kernel.org>; Mon, 14 Oct 2024 19:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728932637; cv=none; b=uvkNRbZKbAcUltuj58nE4u1GW6SUJBBFwtykIXBFLZQUtS/joASiQwoP0goJ7mrVjHBLMrZ2Utz5EkV1Aey0ALGbQAQIGukmmLIJu45n07ZIUuePnGONMpLtmID8/plwA1yoRjqxWZsD6L92I1oF526eCSm5/UnkHgCrpW4oljM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728932637; c=relaxed/simple;
	bh=OTHaItToB9HmCFMBXpshR9I/OimmP13iKZnGxPFxwnw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J2NtN7lOyJRcFbmuRahPSD2vplWNHQAL1heYEF9RJwxE/vR4/TCrbK90ZPFsHThWnIvu4Ms8rj1Z0DP1GKo9mCOMzQfEOIzdvVIY/VO9I3gbBWf6gTok2nMVXgwHZeqAUCD+YJzk+G/utAF/kGd6Hz9pMFxoit7a1v93+PeWVuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VrcjdXqV; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VrcjdXqV"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2e2eba31d3aso2376460a91.2
        for <dwarves@vger.kernel.org>; Mon, 14 Oct 2024 12:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728932635; x=1729537435; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OTHaItToB9HmCFMBXpshR9I/OimmP13iKZnGxPFxwnw=;
        b=VrcjdXqVJX1wr6VXBFCYDdhruPBRiShhkNOq70fS56ra+UPADx7GHKkp0RL2zWLk9J
         4+tGz+kP7H3+Y/BS3WihXMKGJIUIvvVHzzCLA6s1kId+JYpBUNuj47Eydt1eaNCvR+C5
         v9dAr5l6kfjyDAaXaPXeN5n3Bmr9fKYsBiSAaaceAyNbqfmg1hpKtDKE1VRJWkpZgBXa
         RJVatfiAuJmlxW+Wd3r1fslKgn0zyujnRuIY7WOgESMhx88bzJJcxVv4c5tm8eT0qMzu
         SpVBto0q+TEXwHS+BKMYwq4Z7LM/BN1jzecS+09Mt+W3c6Lgs3aK4NtNDXPcILKJlHXk
         Msuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728932635; x=1729537435;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OTHaItToB9HmCFMBXpshR9I/OimmP13iKZnGxPFxwnw=;
        b=d1VlpW0wtMS3AmR9BBteJGF6sTq1B3mizMG8X6bPMyNQHpfCpnjDl7fJM0pP98B8DV
         JVw/1afGML3Qlnm8OJL1Bdek/hlue7EqbqPZk1lrwNoeMKz8op3Ym1qunTpEpWBC6aa3
         S/e4MeAe+cj4x0mCDMlJk8U5iOWpLVuJOHXeIqMI8fFL4suoXpdX53G0YE7vprYibKDr
         +T/zfnmPy+/EHNfs+zUxITxcYXBW1hQ4iz2IkJFQ3pJMmz1ya6xlOb5oJVUy5skUUmcl
         4L5Qsi66ZZEzx0rzwCDEnELpxn6O1o6CUaguYfXaBpnldDHLgpXTKDydAktym4i/pw1T
         VSCw==
X-Gm-Message-State: AOJu0YyewURpNVfvGYNKmt5XuC0XWYAZ9aN7XY0bmHX0419Rc6OmIS/Q
	NPyZ/qj0x/RAYSA2MIFFZg3zVRE/mj6Lruo86UxA8b+q24qDOFW3
X-Google-Smtp-Source: AGHT+IFhRV89XOncbHrPUn/aP3JgyJT8ihpB/87xY65K5tLp/ti4y26q4Q15EdNK72xOleyBTKPztg==
X-Received: by 2002:a17:90a:bd92:b0:2e0:77aa:fecf with SMTP id 98e67ed59e1d1-2e2f0dfdc29mr13891912a91.41.1728932635361;
        Mon, 14 Oct 2024 12:03:55 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2d5f0af7csm9260192a91.32.2024.10.14.12.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 12:03:54 -0700 (PDT)
Message-ID: <010770092dfc1bdae333431c7c2f82490a5816ce.camel@gmail.com>
Subject: Re: [PATCH v2 dwarves 1/5] dwarf_loader: introduce pre/post
 cus__load_module hooks to conf_load
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: dwarves@vger.kernel.org, acme@kernel.org, alan.maguire@oracle.com, 
	andrii@kernel.org
Date: Mon, 14 Oct 2024 12:03:50 -0700
In-Reply-To: <6Il82Jpy0bf96RO5Vr2PRs46GF6pnbcanxCJ0oym7pDBkRpdtRddo1cv7y08lVtRyIAHyMRHlx5_iEFU21dn7NAiTdnE7uPwZB3opLJWbJo=@pm.me>
References: <20241009233520.989453-1-ihor.solodrai@pm.me>
	 <20241009233520.989453-2-ihor.solodrai@pm.me>
	 <cb5084defae910442d1dc959d8c642b82ee76744.camel@gmail.com>
	 <6Il82Jpy0bf96RO5Vr2PRs46GF6pnbcanxCJ0oym7pDBkRpdtRddo1cv7y08lVtRyIAHyMRHlx5_iEFU21dn7NAiTdnE7uPwZB3opLJWbJo=@pm.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-10-14 at 18:50 +0000, Ihor Solodrai wrote:

[...]

> > I'd name these `module_pre_load` and `module_post_load`.
> > The `post_cus__load_module` does not seem to be used in this
> > patch-set, so I'd exclude it for now.
>=20
> I used these names with the idea that more hooks may be added in the
> future, so a convention like pre_<exact_fname> and post_<exact_fname>
> is appropriate. Maybe that's too verbose. How about `pre_load_module`?

=C2=AF\_(=E3=83=84)_/=C2=AF, still like `module_pre_load` more, but whateve=
r.

[...]

