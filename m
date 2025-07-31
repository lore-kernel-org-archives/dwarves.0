Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A388F9EC
	for <dwarves@vger.kernel.org>; Thu, 31 Jul 2025 16:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753978126; cv=none; b=l8Epj9iQxi3/Rp+3CaArUebzSae8vKJtN33wNBGSule4dOc0TjLAdbvmaiqhZid12Bu6NFN5FdpawxbpuXUndpwzZR9ikKf/vuPyYV4mCZ4tHAa1Ms2Ilc0FNNtZCTX2u8vcU6GsHaEKi90/hw7NFI/H4omAW9UK4zMBf3cdxHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753978126; c=relaxed/simple;
	bh=30G9Z0Ik84SaUSHQ8KIpPiQrP/UZLenKaXzRntGM5mA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:From:To:Subject:
	 References:In-Reply-To; b=rLkorLk7ewJ0F5q+8RrKLWpPA7cJCx2MK+gtCmORDAtXiA+nNjDC0ZEuSU7/Ie9faagtlsuEv+M7HwLfYEpcqfEFoujAQiE3ydtLu3u+lo3e8gmjewI7CZ7o/mSp10SmAW0GHs7ZCE5CwJXrAyx56EeI3AQ7wkcwpL+r2pbO2ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=osyxKs0w; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="osyxKs0w"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0F582438F1;
	Thu, 31 Jul 2025 16:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1753978121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZLvftJplfw24zFRY3f0vQ41cB3h6ZKcO/v0ZxzOBgiQ=;
	b=osyxKs0wvuyFnHNtB9kTuTMJASvH7SiesVLfuynowdpAnl9mZfQ6jjxBYKAV4lkH0zdeTu
	Tk1iA1s+EB1zBZ3zUmi/tweG+OI7v4rQ9Y9weco5q0rzPEo8RMCE8KJbtNVMzq2uhTlByb
	ys0Uan6mCCaLRz4xQClonVJC802eqEJmxOemrXx5peh4iS8xTgub2KtroHiiwgUF5s4KFl
	ZlEE0uYiwo2ZHwrUa526TxT1GVkPAWPhuCSDkPolIp/VKZ2eoX823TuNIkFn/yBSY1HHjM
	8tJXQ6919YgWNerO7hL5v3Lbs2JnCy/8I9aDMzIdEVW5zXmtJ1Ewqm9uIatvPQ==
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 31 Jul 2025 18:08:40 +0200
Message-Id: <DBQDCOXBLOA9.A8R3S0BLIW08@bootlin.com>
Cc: "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Arnaldo Carvalho de Melo"
 <acme@redhat.com>, <ebpf@linuxfoundation.org>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Bastien Curutchet"
 <bastien.curutchet@bootlin.com>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Alan Maguire" <alan.maguire@oracle.com>, <dwarves@vger.kernel.org>
Subject: Re: [PATCH v2] pahole: do not return an error when printing only a
 specific class
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250730-lsk__abort-v2-1-fcec3172a878@bootlin.com>
 <150ae6e2-08fb-4d47-84db-ccf1bd3996ad@oracle.com>
In-Reply-To: <150ae6e2-08fb-4d47-84db-ccf1bd3996ad@oracle.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdduvdehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegggfgtfffkvefhvffuofhfjgesthhqredtredtjeenucfhrhhomheptehlvgigihhsucfnohhthhhorhoruceorghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeetleekhffhtefgvefffeehfeegvdejtdfgteettdejgffhvdevgeehgedtgfduveenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepjedprhgtphhtthhopegrlhgrnhdrmhgrghhuihhrvgesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepugifrghrvhgvshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehihhhorhdrshholhhoughrrghisehlihhnuhigrdguvghvpdhrtghpthhtoheprggtmhgvsehrvgguhhgrthdrtghomhdprhgtphhtthhopegvsghpf
 heslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhm
X-GND-Sasl: alexis.lothore@bootlin.com

Hi Alan,

On Thu Jul 31, 2025 at 11:10 AM CEST, Alan Maguire wrote:
> On 30/07/2025 16:26, Alexis Lothor=C3=A9 (eBPF Foundation) wrote:

[...]

>> Signed-off-by: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@boo=
tlin.com>
>
> a few small things below, but
>
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

[...]

>>  		case JOB_STEAL:
>> -			if (cus__steal_now(dcus->cus, job->cu, dcus->conf) =3D=3D LSK__STOP_=
LOADING)
>> +			ret =3D cus__steal_now(dcus->cus, job->cu, dcus->conf);
>> +			if (ret =3D=3D LSK__ABORT || ret =3D=3D LSK__STOP_LOADING) {
>> +				dcus->lsk_status =3D ret;
>>  				goto out_abort;
>
> nit: I was thinking we could rename out_abort (rather than out_error) to
> out_early since we can exit due to either ABORT or STOP_LOADING now.

Yes, true, I did it for dwarf_cus__process_cus, but I forgot to do it here.
I'll update it here as well.

[...]

>> @@ -3386,15 +3386,16 @@ static enum load_steal_kind pahole_stealer(struc=
t cu *cu, struct conf_load *conf
>>  	/*
>>  	 * If we found all the entries in --class_name, stop
>>  	 */
>> -	if (list_empty(&class_names)) {
>> -dump_and_stop:
>> +	if (list_empty(&class_names))
>>  		ret =3D LSK__STOP_LOADING;
>> -	}
>>  dump_it:
>>  	if (first_obj_only)
>>  		ret =3D LSK__STOP_LOADING;
>>  filter_it:
>>  	return ret;
>> +dump_and_abort:
>> +	ret =3D LSK__ABORT;
>> +	return ret;
>
> nit: we could just return LSK__ABORT at all the places we do "goto
> dump_and_abort" and avoid adding a new goto label here I think.

Ok, I'll add those few returns and get rid of this goto

Alexis

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

