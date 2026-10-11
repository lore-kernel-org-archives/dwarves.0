Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C0439A07B
	for <dwarves@vger.kernel.org>; Sun, 11 Oct 2026 10:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791716274; cv=none; b=qSsXI6yH8bQiKzoeeFNCSV4QCdobvRV0NKZ3L0263PcsG9rBKqh+Ow6CpCn0DOQpBqBQfm/QdvWwciNDJJnzeYu3X1g3RkwrtsqT1Sl1FzzuGPwxboIjcF8wDY5Nt6lw/z8BkjZWzS6dsdL0eNMTQLroG5Jg1Tmw+5OsU0eRc5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791716274; c=relaxed/simple;
	bh=jurhZonTAHPcRoXR87rUYd6+VfE68pFociMCFbOfTT8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=phc4gqONnigvX8igrwEt8OuGEUn3R5sBYCcJrQGsdNxgsOxOs1Ltk7zeHqUkaN4gHpkh0xeDvir3yBk1bgRgb3D0czvyykeSZnrMu9wBoBc88TEFqWZRhIYfvMbKQVi+HPysJg/PW7EntpPRUlhtchF3xADQw/3Mi6P3GxS//Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hpXyppH2; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpXyppH2"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6a0a4aa99bdso1176194a12.1
        for <dwarves@vger.kernel.org>; Sun, 11 Oct 2026 03:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791716271; x=1792321071; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fKhg3P7K9JH6IPxkoS6kW4Qa3bVqrpmsAGquZuq3bmc=;
        b=hpXyppH2E88Qwzd8PdC863VMawEwEKgMgnlAnWTckV7RkHkT4kOWeqN1LUDsi/mR2h
         lmeB0rGoTe3MY1iUn+PuCDXpB8jf9i0QiGffLJE+gQctu7OQKhxenRJhvqWwCNJNIcxa
         m0sjrADk5Tkd1GMrEpbSLqe+Gx7NUgVxWWSd5yzWNrDVHAojhJh0Ob6tsEP7y7pnp2sv
         4yJiTzmCKCkmfS8cg/vISMygkMfmEKY04RO0gW+6kmi6wFVZr7LykaPtNu/V3svPdGny
         b5z/b22zz+rSZGULmHLtN+gxc6vzNcCGRuxLH1RsYzDGyZCMyQ5J6Yf6nrnjs5kzBwVH
         v0uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791716271; x=1792321071;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fKhg3P7K9JH6IPxkoS6kW4Qa3bVqrpmsAGquZuq3bmc=;
        b=ahRifLvqDqJjM4bgJXgYhu11vYZHX4SVYy3kYBRMRiXlXeVdmBL7xbUQ8ZdqycQt2J
         M+ZHBFMqHFNMtuKIAh4+3Z/is0OiurE86V7sY38wOub3g6I5JZNQHHmJkqdIIawKQ78Z
         Ke/7trWR7QDtOcv0LQafjYSz6y8VTZH9SmRtp4lyawZ7gtMeyQjvneojmy1IukbqnIVS
         GLzQC5CcNUOmZoOjQ5UOO5ml8j68YPqwonI+INpE918diWwmi5EbeMic7UBZZeqGjIlT
         GXVJ9poqfT3+mjRdVyJpPIGxx+ZaYYZG0SXydetL47tC5L21fUrQTrQ45GIAcHvmBCqg
         whpA==
X-Forwarded-Encrypted: i=1; AKwUvBxrwyrXR91cWPFlgfvfr1xedS6/Zg8UsDXAL2FZ1zDEn/8O2Z8jGIHnAA8XusMk723RQgAyfKBb@vger.kernel.org
X-Gm-Message-State: AFq9FYIe5QIJZnKKMYhQib9e7PXPznPHan5PxIrzKknc8DmbUYJqV3gZ
	Y/YA6jWc4vZdMQXCj4H6TMLzeI4WgAV/dwLH7SRYyLDd9EvgMaH/RAkA
X-Gm-Gg: AYBFou0vuONgViawD0amW/IMNYpkYfFpDyT53hn/AcOGFXIcJ6cKyvMM8T1uS/WNxxu
	LnG9C9RppTX1J/qHReKIRQIaRNLHPiKzKKhSqBb5uJYEMJRcjml/VSEqChzVAjkhbUs4SACx7U8
	iqrAyx8ko4ABDGkI0FRGCHla61L4HYLwvwY47ULEJlPTIkOU+RBFzVWj8R1d0Uvdy5IBdiZ1dpz
	iTk+FO7kRzfadCBLkBt8ayQMUrHe0UyZrSIV+BXjJ3MUTcx7QyVhyK6rxVxJZPPEowyZ0FvNdF2
	YKQ2x3lb60XjdZCaxb8vZP3FedSCooPk7dcKQUbFB3hUzN+IbquNBLSAeZ9VGRRzkXH6lNbZQld
	d4ddLEc0npLYIwgMzNQzwbJp0pnMO7jkD/w4vb0GVUOBz/Krhx12VNe+CEWJUMN1rNG3Wt91Pg1
	B1qxEGh27x8/eAL8e2QeKtHkcwuNG7B1xPI07OQg9OxgYbQolZUwIukxaUKbI=
X-Received: by 2002:a17:907:d89:b0:c2e:42e:4da0 with SMTP id a640c23a62f3a-c31a9d0df2bmr756672366b.19.1791716270775;
        Sun, 11 Oct 2026 03:57:50 -0700 (PDT)
Received: from krava ([173.38.220.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9767227sm344722966b.11.2026.10.11.03.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 03:57:50 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 11 Oct 2026 12:57:48 +0200
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, acme@kernel.org, ast@kernel.org,
	andrii@kernel.org, eddyz87@gmail.com, qmo@kernel.org,
	dwarves@vger.kernel.org, daniel@iogearbox.net,
	ihor.solodrai@linux.dev, yonghong.song@linux.dev, song@kernel.org,
	martin.lau@linux.dev, memxor@gmail.com, emil@etsalapatis.com,
	bpf@vger.kernel.org, nsc@kernel.org, puranjay@kernel.org,
	yatsenko@meta.com
Subject: Re: [PATCH v5 dwarves 05/10] pahole: Support inline BTF location
 encoding
Message-ID: <astrrAe245p3pBMf@krava>
References: <20261002174043.3823987-1-alan.maguire@oracle.com>
 <20261002174043.3823987-6-alan.maguire@oracle.com>
 <asjoNE3H9ZqL4rsR@krava>
 <0980d4bf-a1f9-4984-ac7c-51141d498e6c@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0980d4bf-a1f9-4984-ac7c-51141d498e6c@oracle.com>

On Fri, Oct 09, 2026 at 06:32:43PM +0100, Alan Maguire wrote:
> On 09/10/2026 14:12, Jiri Olsa wrote:
> > 
> > On Fri, Oct 02, 2026 at 06:40:33PM +0100, Alan Maguire wrote:
> > 
> > SNIP
> > 
> >> +static int btf_encoder__add_inline_expansion(struct btf_encoder *encoder,
> >> +					     struct inline_expansion *ie)
> >> +{
> >> +	struct ftype *ftype;
> >> +	struct loc *loc;
> >> +	struct parameter *param;
> >> +	uint32_t section_idx, section_offset;
> >> +	int err;
> >> +
> >> +	if (!ie->function || !ie->name ||
> >> +	    !btf_encoder__inline_addr_to_section(encoder, ie->ip.addr,
> >> +						 &section_idx, &section_offset))
> >> +		return 0;
> > 
> > hi,
> > we get inline locations also from .init.text, which then fail kprobe
> > address validation.. is there some usecase for keeping .init.text
> > locations?
> > 
> > I currently disable them in kprobe_multi change I have on top of this,
> > but I wonder we could just drop them completely in here with something
> > like:
> > 
> > 	if (strstarts(encoder->secinfo[section_idx].name, ".init"))
> > 		return 0;
> > 
> > thanks,
> > jirka
> >
> 
> hi Jiri,
> 
> Yeah, it's a great point, and certainly doable. I guess the question is 
> if they would ever be useful? Are there any cases like early boot-time
> tracing that might find them useful at some point say? Or even informationally -
> i.e. function foo() is inlined 700 times in the kernel, 20 in .init.text
> and 680 in .text. Not sure..

actualy looks like ftrace might be able to trwce early after boot, so it
might be handy if we manage to use this via ftrace

> 
> On my kernel the inline.init.text sites are ~2% of the overall number of 
> sites, so it's not nothing in terms of storage, but a lot less than the 
> .text section. So I'm happy to filter them out if we think it makes sense;
> maybe we should add a section option to the inline feature or something?

so it's like around 200kB? I this it's ok to keep it, nevermind ;-)

thanks,
jirka
