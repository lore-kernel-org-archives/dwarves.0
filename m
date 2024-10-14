Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C5C1CEEAA
	for <dwarves@vger.kernel.org>; Mon, 14 Oct 2024 20:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728936512; cv=none; b=HDQ8k6fWbi4G3zmycADP9qzSvFSOwIqE15geV7UGfcjmaiJ3G717FAY1l83iwbmrivgDfqhWL+L9Okbn38JnLzkegP9zQTlnhnxTRk4bcTnKycnx+HpJBzn0LpSpjSFBJQyOKV7fVGxAeRHvaHdp3aGFJBvXb08/f1JUmYtN/p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728936512; c=relaxed/simple;
	bh=DVvL2N7yxmro/HGICijwf/2Q/88u8rJvCIXjNU/hsuM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h1EHKBVHlSOPJn0pYrevGtFzVBuzGR4Q/ockwGrg+AIL0dnlLsGU+LT6u+YkQtfuUodTO1G310+AXca9KsjSYFaJsveWmerabOPw0pEC3ibB1QsHAQ8dcGylmoqxJGYNZwOSXocWujolrz70Il7jlkFXYw/3xDoaVLNoO43zkno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hG9lmCip; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hG9lmCip"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7ea8d7341e6so794186a12.3
        for <dwarves@vger.kernel.org>; Mon, 14 Oct 2024 13:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728936510; x=1729541310; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=V1NoRMlI9Qp9hhxKAS0C6oWr/WcPO/wPrHclu/dnIOk=;
        b=hG9lmCiprdCr5pE2SjMdF0upD8wvhvKghlv6bYL0BrI7UZXMTO4C9YZKjpFJ/LEbBT
         jHOee24qg8uEFhAurTabS8ZaYZWgVx5UAyNE/59MORPT4l9Z0c+eM6knGXS01Map6KAr
         69ghfx7h5QAAVUyWMznC0PQ6xUmGP5xzK9DqWIlBOdoJz+RAsIuKqeLMxFjXP27Ph7i4
         wKiFyGeMKPwMk+nzukbHxZHVOt3ZDIAYqXyCD4nNU7lhvaKieNkG+ut2FE3PlWbe9BCu
         El9KbHL6IqcSmBg7GpMZgueABbedyhbfEqmvmqOP1PQHbiDWOqrarKp7suAABwGzYWP1
         jbnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728936510; x=1729541310;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V1NoRMlI9Qp9hhxKAS0C6oWr/WcPO/wPrHclu/dnIOk=;
        b=c8VphjGicxGNASInwxk55ny0smGZRkfthxFZbif7Odbzn/UzG8nPYHKkQd3O+eqyu+
         /3NALgIxR+2bIPn4/Au/W1IAskaZg0D6i8sO2tAwPW9obISZTIyQxYXtDP+MqURu/Nwp
         0NBB0rP4tz+ZNsWPb4HoOfZex2ug0I+Hnq/2n7rck8oav7TWAzCAHwqIUd+FMa/6jlNY
         AgCAqqgpDOz+uXCD8nKPP7ctFeUMb73ePVi73l5GO8vKY09opFXDtHXRB8DKh6lxXIs2
         MotlCQ6d0UAQeqQ9P8mniw9n4DrdjNRVO4WxPDgNbuefMKdtVWAz6yk00/iZx6pFyOfo
         A09A==
X-Gm-Message-State: AOJu0Yz6YTjOsd5KbECQ7El3tXiWipryTWossoGMRf16H033T6tJYFF8
	cLzCAtUPkLuBXsRmZQqB0jrYZ2PCTUbh/NnBtY7i7+4wHImyB37y
X-Google-Smtp-Source: AGHT+IHSFwS4KDdeIyVZVFB59mS0wm6qachfovb3Rb/hNO+bMifeJnRvpZX7eO5bRYLRkuOn8K2o2Q==
X-Received: by 2002:a05:6a21:2d89:b0:1d3:ba1:18f4 with SMTP id adf61e73a8af0-1d8bcf3dc47mr21574721637.26.1728936510473;
        Mon, 14 Oct 2024 13:08:30 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e4ee79d80sm5053560b3a.18.2024.10.14.13.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 13:08:29 -0700 (PDT)
Message-ID: <ccbd5bd24ef1f68b6310434a55752cba961ed20d.camel@gmail.com>
Subject: Re: [PATCH v2 dwarves 4/5] btf_encoder: make elf_functions.entry an
 elf_function list
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: dwarves@vger.kernel.org, acme@kernel.org, alan.maguire@oracle.com, 
	andrii@kernel.org
Date: Mon, 14 Oct 2024 13:08:25 -0700
In-Reply-To: <lVQ48eIOm008BvczqG7o2mjZ7Ofw8u22LnM4gT4L1BGn8yBaE5sZm0TeYi4dBZ6LXGGm0b7l7g-1wtpH2rQoG7AC2LyjdsqP5oK-r5r4ka4=@pm.me>
References: <20241009233520.989453-1-ihor.solodrai@pm.me>
	 <20241009233520.989453-5-ihor.solodrai@pm.me>
	 <9f0b3a85b37d10bff446a43b2c154b1abd723d5f.camel@gmail.com>
	 <lVQ48eIOm008BvczqG7o2mjZ7Ofw8u22LnM4gT4L1BGn8yBaE5sZm0TeYi4dBZ6LXGGm0b7l7g-1wtpH2rQoG7AC2LyjdsqP5oK-r5r4ka4=@pm.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-10-14 at 19:39 +0000, Ihor Solodrai wrote:

[...]

> Ok, I'll try making the explanation better.
>=20
> Just so it's clear, in this patchset there are no changes to
> btf_encoder__save_func() at all.

[...]

> I remember we discussed off-list simple accumulation of elf_function
> structs, and removing merge logic from btf_encoder__save_func(). I am
> hesitant to switch to that, because this would mean that multiple
> elf_function objects for the same encoder might be stored in
> elf_functions table. This in turn would require more changes. For
> example, how btf_encoder__find_function() should behave then?

Then I don't understand how elf_function objects are protected against
concurrent update, btf_encoder__save_func():
- mutates elf_function instance;
- is called from btf_encoder__encode_cu(), called from pahole_stealer(),
  executed concurrently;

Here is a fragment of the btf_encoder__save_func():

	existing->optimized_parms |=3D state.optimized_parms;
	existing->unexpected_reg |=3D state.unexpected_reg;
	if (!existing->unexpected_reg &&
	    !funcs__match(encoder, func, encoder->btf, &state,
			   encoder->btf, existing))
		existing->inconsistent_proto =3D 1;

If concurrent access to elf_function instance is allowed,
'|=3D' operations need to be atomic and funcs_match() needs some mutex to
prevent BTF update (as you point out in the commit message).
What do I miss?

> I am inclined to stick with current (v2) approach, but want to make
> sure you're aware of this.
>=20
> Let me know what you think.

[...]

