Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B1F19C57C
	for <dwarves@vger.kernel.org>; Mon,  2 Sep 2024 13:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725283420; cv=none; b=RXbXJ/MrbOaLFFe8+t2bf1yebKAqGcq3aNKCO36ajCQ4pxtD1q3tT8WMXHcPsQlBUvgGJN8fgarbh9g78nUbktSTgw6/T32GGm1y5BuJzFxdbT2RD2GCwSiHVK35FY4zEF7riLQlr4ho72pMLW3tU65I9LyYOcOd0OUiHpSWNZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725283420; c=relaxed/simple;
	bh=QR6yQFD77j4HA8ujCJpbF0hqee6sNSQcmA7GQF97x+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E1lRnnkwLlZMlgIKZpiygTjzYwRU8WiQDLo5lA8P+cr3Ml29d9kxDGCovwZ2bgxPyML4/gucaQb4W+RFCOIRgcNY7TNTtbPmHX92W0SfmmXDqWzwWgbwgtNa19+5Yi69zSX7y7xx9Up62D4Xjr4Ptad5/kRYRA3/N4hYkO0MMZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hpm8VsOu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hpm8VsOu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725283418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UIB3i0GhNUpCB8S1O/uMO+rqRfL7G81U6gsRqmSyFc8=;
	b=Hpm8VsOu7YfqiM/Q1/eoDg82oT3KWWVng4MBdeByC4EUdUU7I6qGCBXJwzNr/whq/l0xou
	FQnO0FTJHmdb0oVjcRB+2fokNOAQc4/enxsaGdW8eknGUn/d6UoJzxZg2svESlRLeMzyJC
	q2BaRqiJtWKzBdCGdErIeQlFLNyDeBk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-3rdOOYNhNyGO-P3X7YpkRg-1; Mon, 02 Sep 2024 09:23:37 -0400
X-MC-Unique: 3rdOOYNhNyGO-P3X7YpkRg-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5bed6ef4f92so2978723a12.2
        for <dwarves@vger.kernel.org>; Mon, 02 Sep 2024 06:23:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725283415; x=1725888215;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UIB3i0GhNUpCB8S1O/uMO+rqRfL7G81U6gsRqmSyFc8=;
        b=qXs9gPjeHSbH282UlgA9WsONqhUAy8ornvTs/HTPV/rq0svfSn0nUGaasQl8ylRevg
         LnHLhbmDf4L/sa9Kjp2u/lPpSNC6hnevzmtvixtMpJ7utbbaEDSp/+uWn47Sp9yGx3h+
         QIwNMxFbiYHAfXLzlvGQaW+SVdSDMoiZpdZ5Om9WPdYkYJi1tGAcNAGXcQCE7ah2zohM
         9JXV4VQ18I50/7gs64/Tf2AfJU7+Yfu5P3gugi5tDxjFkmA47e+JvF6iOxJDxdDOOrCg
         9mN7kKH3cq3vrJk7ea0vfsQnA0Xx0e03JTeNIOEdlTy9ieZ42hEctRy36InOgnF3tgqc
         +T9A==
X-Gm-Message-State: AOJu0YyaiaNoGMkzO9Yr3fqjONwPCDDFPg+q75Dvi4EtKVU29dYw6Eth
	QS5X6NgnXNkz30bnJ54E5QBmyAab4arPcn/UwoT4prId5eu8DTBfxbYBixAWCD6TuPWhJW3xnOP
	e/AIwNKctRXIdIVjv5TQ25+Pxv5G99fShhwKsHO7HcO+G8uhzH4nbBQMo3Ya/YA==
X-Received: by 2002:a05:6402:3551:b0:5c2:1298:3517 with SMTP id 4fb4d7f45d1cf-5c21ed5523bmr8912896a12.20.1725283415234;
        Mon, 02 Sep 2024 06:23:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjG08RLqROQxwDyQU1H1AyHzqfwmW03banKdlEVFeCPbjrpq7S5vRCKTgVmyyiPf1HCCSt1w==
X-Received: by 2002:a05:6402:3551:b0:5c2:1298:3517 with SMTP id 4fb4d7f45d1cf-5c21ed5523bmr8912852a12.20.1725283414241;
        Mon, 02 Sep 2024 06:23:34 -0700 (PDT)
Received: from [192.168.0.113] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c24435fcacsm3098140a12.53.2024.09.02.06.23.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 06:23:33 -0700 (PDT)
Message-ID: <e17da8c8-e15e-4749-bc7e-625ec1c00376@redhat.com>
Date: Mon, 2 Sep 2024 15:23:33 +0200
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves] dwarf_loader: Fix memleak in dwarf_cus__create_cu
To: Alan Maguire <alan.maguire@oracle.com>, acme@kernel.org
Cc: dwarves@vger.kernel.org
References: <20240902111157.748247-1-vmalik@redhat.com>
 <3e5c79bf-6c6f-435d-9dd2-5a3fa5fb7334@oracle.com>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <3e5c79bf-6c6f-435d-9dd2-5a3fa5fb7334@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/2/24 15:16, Alan Maguire wrote:
> On 02/09/2024 12:11, Viktor Malik wrote:
>> Coverity reports a possible memleak in `dwarf_cus__create_cu` due to
>> `cu` not being freed for the case when it was allocated but
>> `cu__set_common` failed. Fix the leak.
>>
>> Signed-off-by: Viktor Malik <vmalik@redhat.com>
>> ---
>>  dwarf_loader.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/dwarf_loader.c b/dwarf_loader.c
>> index 04f5637..ad36e3c 100644
>> --- a/dwarf_loader.c
>> +++ b/dwarf_loader.c
>> @@ -3378,8 +3378,10 @@ static struct dwarf_cu *dwarf_cus__create_cu(struct dwarf_cus *dcus, Dwarf_Die *
>>  	 */
>>  	const char *name = attr_string(cu_die, DW_AT_name, dcus->conf);
>>  	struct cu *cu = cu__new(name ?: "", pointer_size, dcus->build_id, dcus->build_id_len, dcus->filename, dcus->conf->use_obstack);
>> -	if (cu == NULL || cu__set_common(cu, dcus->conf, dcus->mod, dcus->elf) != 0)
>> +	if (cu == NULL || cu__set_common(cu, dcus->conf, dcus->mod, dcus->elf) != 0) {
>> +		cu__delete(cu);
>>  		return NULL;
>> +	}
>>  
>>  	struct dwarf_cu *dcu = dwarf_cu__new(cu);
>>  
> 
> Good catch! Looks like there's another few instances of cu leaks like
> this later on in __cus__load_debug_types():
> 
> 
> 	if (*cup == NULL) {
>                         struct cu *cu;
> 
>                         cu = cu__new("", pointer_size, build_id,
>                                      build_id_len, filename,
> conf->use_obstack);
>                         if (cu == NULL ||
>                             cu__set_common(cu, conf, mod, elf) != 0) {
> need cu__delete() here ->
>                                 return DWARF_CB_ABORT;
>                         }
> 
>                         if (dwarf_cu__init(dcup, cu) != 0)
> need cu__delete() here ->
>                                 return DWARF_CB_ABORT;
> 
> 
> Could you respin to fix them too? Thanks!
> 

Sure, I'll check those and send v2 tomorrow.

Viktor

