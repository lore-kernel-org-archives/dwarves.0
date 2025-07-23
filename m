Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746E127A455
	for <dwarves@vger.kernel.org>; Wed, 23 Jul 2025 08:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753259972; cv=none; b=RoVDmWBnNMbc6Gha0EFku9dzBZZ95W+hi6tGsFkeEqmp5ZkUbmeAD8ATWEBY5Iom7ijPddMvyrHmp33uRlvN1qpmHIE3TqoCXigNXT/AZc73LDprIabows0mQmid+Oqma5FwX/FuZ0qJqh/TMh5FuHKBV+cf9/U4EEmYc7dxQQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753259972; c=relaxed/simple;
	bh=WMd0qcKXsIBcI66+3Fg2zqbJYgCfJ736Ovjhvq1dadI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=gKZMwM+fXWflVVzRPF3BxcQb0B8H9XgYe8ZzdM+xnW1HPXS3yHtHhFqo4WgIfufchMc/zYtUpvW4wH2MSX59PrgQsJk6StWm/Vg2JsD6WquhV6rv3VffLRDXXUdg442nMq2kLbLwEFVydgBvSa8olfV3zYa0i7zN3kW+rhQvFK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SepIbj1G; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SepIbj1G"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8A5001F68D;
	Wed, 23 Jul 2025 08:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1753259962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0XlET3V3CfX/WxojKtPgp7gY1eLglT/eI2gCORtSAXM=;
	b=SepIbj1GpeG/A1WvP2aOMpBQak9EkiPg1TqpeiLBusedUlnWFWfMiyRLsjzULSfBA3D5ie
	vs4RIkuZOSn/EMrSSSMC+7Ie3oCeoAX+b0bfzRXOQtW69z5lW589nYg/pwwnfgl8UeGIu4
	MToWzvrqjEGlGkUQ5lhtO973xrTrzBvvt5/xGX2Wunzg1H1RyHvkHsBpa7bhIJ7m4W4mBi
	87G3KHkGrceBUF+7mm5e0szUdS5jKGOF7jD4iI9AzR0mS5f+eyu99v+nc0k6I0xFVzscbx
	BfLLJG6P3YE7iMw256uoBg5CcTD6ZBLo2IjZdgKbCCqdDhJq0RwK3r47MKQftg==
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Jul 2025 10:39:21 +0200
Message-Id: <DBJASAZ3SGNN.364AZ1P0QK6G6@bootlin.com>
Subject: Re: [PATCH] pahole: do not return an error when printing only a
 specific class
Cc: "Alan Maguire" <alan.maguire@oracle.com>, "Arnaldo Carvalho de Melo"
 <acme@redhat.com>, <ebpf@linuxfoundation.org>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Bastien Curutchet"
 <bastien.curutchet@bootlin.com>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>, <dwarves@vger.kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250716-lsk__abort-v1-1-586f31a9d97d@bootlin.com>
 <e1afba7b-93f9-4ed3-9cd5-ef4ff4bebb70@linux.dev>
In-Reply-To: <e1afba7b-93f9-4ed3-9cd5-ef4ff4bebb70@linux.dev>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejjeefvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggfgtgffkffuvefhvffofhgjsehtqhertdertdejnecuhfhrohhmpeetlhgvgihishcunfhothhhohhrrocuoegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepudevleeiudffkeelgffhkeevkedvledvveehjeekkeekjedtledujeduudfgheffnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomheprghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeejpdhrtghpthhtohepihhhohhrrdhsohhlohgurhgriheslhhinhhugidruggvvhdprhgtphhtthhopegufigrrhhvvghssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlrghnrdhmrghguhhirhgvsehorhgrtghlvgdrtghomhdprhgtphhtthhopegrtghmvgesrhgvughhrghtrdgtohhmpdhrtghpthhtohepvggsphhfs
 ehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepsggrshhtihgvnhdrtghurhhuthgthhgvthessghoohhtlhhinhdrtghomh
X-GND-Sasl: alexis.lothore@bootlin.com

Hi Ihor,

On Wed Jul 23, 2025 at 1:42 AM CEST, Ihor Solodrai wrote:
> On 7/16/25 2:04 AM, Alexis Lothor=C3=A9 (eBPF Foundation) wrote:

[...]

>>   	cu__finalize(cu, cus, conf);
>> -	if (cus__steal_now(cus, cu, conf) =3D=3D LSK__STOP_LOADING)
>> +	if (cus__steal_now(cus, cu, conf) =3D=3D LSK__ABORT)
>>   		goto out_abort;
>
> I think we should handle both LSK__STOP_LOADING and LSK__ABORT here,
> otherwise the worker will keep loading DWARF (which is most of the
> pahole's work) and passing cu-s to the stealer function.
>
> I guess in many cases it'll complete without errors, but it's just
> unnecessary work.
>
> Maybe add a check for LSK__STOP_LOADING here with goto_ok?

Hmmm, I am not sure how to follow you here. Even if cus__steal_now returns
LSK__STOP_LOADING, I need to return DWARF_CB_OK from
cus__merge_and_process_cu, otherwise it will be processed as an error
again. Or are you suggesting just make sure to delete current cu but still
return DWARF_CB_OK when getting LSK__STOP_LOADING, as done below ?

--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -3796,6 +3796,7 @@ static int cus__merge_and_process_cu(struct cus *cus,=
 struct conf_load *conf,
        Dwarf_Off off =3D 0, noff;
        struct cu *cu =3D NULL;
        size_t cuhl;
+       int res;

        while (dwarf_nextcu(dw, off, &noff, &cuhl, NULL, &pointer_size,
                            &offset_size) =3D=3D 0) {
@@ -3874,7 +3875,8 @@ static int cus__merge_and_process_cu(struct cus *cus,=
 struct conf_load *conf,
                goto out_abort;

        cu__finalize(cu, cus, conf);
-       if (cus__steal_now(cus, cu, conf) =3D=3D LSK__ABORT)
+       res =3D cus__steal_now(cus, cu, conf);
+       if (res =3D=3D LSK__STOP_LOADING || res =3D=3D LSK__ABORT)
                goto out_abort;

        return 0;
@@ -3882,7 +3884,7 @@ static int cus__merge_and_process_cu(struct cus *cus,=
 struct conf_load *conf,
 out_abort:
        dwarf_cu__delete(cu);
        cu__delete(cu);
-       return DWARF_CB_ABORT;
+       return res =3D=3D LSK__STOP_LOADING ? DWARF_CB_OK : DWARF_CB_ABORT;
 }


Thanks,

Alexis


--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

