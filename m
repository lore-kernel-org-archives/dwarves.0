Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103271805A;
	Wed, 19 Feb 2025 07:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739951303; cv=none; b=UpCGKydWOeU62wUVFpylmpuPVSF5IgNX4ekHKqJHgFxym0mDv/KV4pei7DY5x4iS+SZOupEfh3ao4HT7LvSQ2HmXtABbrw9OVat9eS4OiQ6hnEHZ/QqzXIaTf8deLo5HWAqKSmkz9eX3ZMr+lnbWg7fqVowT3Ya7z5Fv3nGrgAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739951303; c=relaxed/simple;
	bh=UPm48SNvkxK9A7sB6MyVbaxyiIPkXc5a7Lc5C9KCdR4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jEvQrcazpcKxlnIAXOrQFdaijSJFe1fF1MHKlUqiclFv6didd9SdLnSZD4ipkB5WNzg1pMsXrBs5JZQOllKxH3qGgTnusd+ENlI1F9Y/nLf5HODt0MK47y1p+635eKCEQqpjI5kQQ/ByP9I7EItv+F2vAJrTaNZSMBIXDpi/1/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OobVl1O8; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OobVl1O8"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2fbfa8c73a6so11860878a91.2;
        Tue, 18 Feb 2025 23:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739951301; x=1740556101; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lsVKDsU0mv5Z/zrU+8jSbfSE2rbJ+sUT0SGVWNZEIzA=;
        b=OobVl1O8yJDowVfP8JpTemohbMWnydR6n2xvCYoENSR8zF+qn2eOjdgT9dQM/OKeCl
         DBFOUzINwnZCai/hryzaxzjkcWT8dNNXC2ta+XHCjwZEMtB5F7+PmLxphUqNvKXIgEDf
         dgc1opWhGAbdcXUz3Q1195zRO6FUgCPKewiS87z/kob7S7YTg++zD72e8xwfQ4t6OLL+
         Oh+W1ZqM/WNvHC9aO3Q1WKpvmML7soASs7pmZ0nmadSHT5uMPJW0i0X8KmcdDGKRkon2
         LEWgMjqrI+LMlZU/kpj2VKIH6bF5DvqmacdfdElnVKOjNaTKHXtJmImp9URlyHUQtgf9
         /Wmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739951301; x=1740556101;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lsVKDsU0mv5Z/zrU+8jSbfSE2rbJ+sUT0SGVWNZEIzA=;
        b=gfzwjYXkMRBYr4mbkg10u82rkmrgf9R9HZ8OV1LYTcS7djgMTjUBJZF14i+Aj555cp
         JrRlYShCGZU/YqPWGK4Y+n6pfksOfN6PmNTTTnZJGS8hIN69nvRH7OuWluEl8ezvEK8T
         qRM1Pey1VsXD1lIk5gWDhbehTivH9WVTfklL2V5y2HnCWyhvqSLFb5cbR+zFTrly1rgz
         DmYNABaWvWmuWYSu4d7SHo/lrix0n2pH++sC0G1jhsDx8cXkorOQkV2wzN0Ajs2DuavH
         LnFQgap3S6qng7XLjkIAB0BdjDU2R6fVoZxJLQDglFeFYPnuS1CtyP3zo9wZZ8vmFAj4
         PM3w==
X-Forwarded-Encrypted: i=1; AJvYcCW0BXADsJ9wfmLmcnejBi2w5D1QPqVNQkBMIZ3SuC4X8v3ANllWE03q5azRe9KAgBmlvTSZMaYCPxd9t6YP8L4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvVBAztODNYcJNAzrMR5nTc7/hhSNjtL40wKXI0m9/nxsrL/v6
	uVq49y1H3o+YU/onOLqwjrFG7dgE3dPSAYHAfqCYfT4lrTJCU1Ay
X-Gm-Gg: ASbGncuzx0k0ops4ZKY7CUHuQlj2QujYckm6JgX0LsY2onSyWSyNog0SaR2rdBC83Z6
	xq/7akWwUA/TNBLo9lL05A0A9+PQKba7XMFye86Hif/sWlYne/PHQey0ndu+Mn11/wgmMf7r09j
	6WlEiTY1j+cPiBKxGT8EOA0GM7RbxvYhPldRWTlP1fdgjhkj/oHhWhE0yCQSODVEdFFFb8+YLP0
	oQJoAdCJy34LYYJugCDwuhzmqQPUySDAeXr94sb5WHbYmKZsNViRcCyAfM+pbOJ5vQIpDtqseBn
	wVR+wGispRDK
X-Google-Smtp-Source: AGHT+IETi0NYn4pmmZ57DgnwXV/4vSwokmTZThL5ChJ9QAiQtXAlPurI950LCe2j8RNsFta/lWoOqw==
X-Received: by 2002:a05:6a00:6f05:b0:732:6217:8c69 with SMTP id d2e1a72fcca58-73262178e79mr26953397b3a.3.1739951301109;
        Tue, 18 Feb 2025 23:48:21 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73264729945sm7980588b3a.179.2025.02.18.23.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 23:48:20 -0800 (PST)
Message-ID: <64482b97d2431957923a72242edd6e8de371ec13.camel@gmail.com>
Subject: Re: [PATCH 0/3] Fix duplicated VAR and secinfo
From: Eduard Zingerman <eddyz87@gmail.com>
To: Stephen Brennan <stephen.s.brennan@oracle.com>, Alan Maguire
	 <alan.maguire@oracle.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>
Cc: dwarves@vger.kernel.org, linux-debuggers@vger.kernel.org
Date: Tue, 18 Feb 2025 23:48:16 -0800
In-Reply-To: <87v7t7fb1v.fsf@oracle.com>
References: <20250212005003.1413091-1-stephen.s.brennan@oracle.com>
	 <377e9ec2-35fe-440d-923c-8918756fc635@oracle.com>
	 <87v7t7fb1v.fsf@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-02-18 at 08:54 -0800, Stephen Brennan wrote:
> Alan Maguire <alan.maguire@oracle.com> writes:

Hi Stephen, Alan,

[...]

> I wonder if there's a hidden catch here... DECL_TAGs can refer to VARs,
> but as far as I can tell, the semantics are that the DECL_TAG actually
> *modifies* the VAR - it says "this variable declaration had this
> annotation / tag / whatever". This is fundamentally because the
> var_secinfo doesn't point at a chain of DECL_TAGs, it points directly at
> the VAR. (Compare that to, e.g. const/volatile/restrict qualifiers)
>=20
> So, in a hypothetical situation where there are two variables of the
> same name & type, but one of them has a DECL_TAG referring to it, would
> the deduplication keep these separate?  It seems to me that would be the
> correct behavior.

This is something too look out for.
E.g. this is certainly true for decl tags attached to structs.

[...]

> > Anyway I'd be interested to hear what others think about whether solvin=
g
> > this in BTF dedup itself or pahole makes most sense. Thanks!
>=20
> Thanks for taking a look into this! Hoping to hear from other
> experienced voices on this question as well.

[...]

Deduplication for variables would be a bit of a weird one.
As Alan notes in the previous email, for each data section there is a:
- 'btf_type' entry of kind BTF_KIND_DATASEC where 'vlen' specifies
  the number of variables in the section;
- followed by a number of 'btf_var_secinfo' entries,
  with 'type' referring to 'btf_type' entries of kind 'BTF_KIND_VAR,
  and 'offset' specifying offset of the variable within section.

So, we are talking about deduplication of these 'btf_var_secinfo'
entries. Nothing in existing dedup algorithm handles deduplication of
"addendum" items like 'btf_var_secinfo', the subject of deduplication
always has an ID.

A new step, walking each BTF_KIND_DATASEC and collapsing identical
'btf_var_secinfo' entries can of-course be added.
(Which also raises a question, whether this has to be done in a loop
 with an attempt to collapse duplicate BTF_KIND_DATASEC entries?).

A case can be made both for and against this, but given the
"weirdness" described above and the fact that Stephen already has the
code, I think performing this deduplication at the pahole level is
Ok at the moment.

Thanks,
Eduard


