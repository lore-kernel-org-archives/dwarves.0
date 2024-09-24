Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEF68C1A
	for <dwarves@vger.kernel.org>; Tue, 24 Sep 2024 19:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727205020; cv=none; b=ulc78IOQ260d8aLP98YYEVZZDkaQHbF/kK0fF6q7eInGAEg3aB8pLWdl7XX+lkvQKdiW4DwRNaY3lIT1Bhq0dq1YS6AVzFzcmwrCuHljg9g0YPNlztsh44dHvRoj/1AJFQzxPXSZS8/oCWD8/w58+bhVsOVSAQvmU07YASn/bDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727205020; c=relaxed/simple;
	bh=yb0shKBiTRdxivT4QKv8U8UkIB2dkM1GCAB3V8jQj0o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aqwdXU/3v61s+HGD5ScNWJ6/ghnhLDNYY3Ji2TCMhvggVzu6z3uIkpRR4K6GdugkL7kPPMIovw++WaZnyPjttdTd5rwWubZuuX6vzhgPoe3VqvRF2qGLgxV4tZsnHjcDZ9Gg51hL6TfDZQ67WnIhVgvTUCw7WYdk0bAiBgNGusM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WdQqmOb2; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WdQqmOb2"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7d4fa972cbeso4147186a12.2
        for <dwarves@vger.kernel.org>; Tue, 24 Sep 2024 12:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727205019; x=1727809819; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZmqquJARuoSAGMEF/+4cEtXPU83BcLRXtxEytvbtIts=;
        b=WdQqmOb2xrxpKryILsEXIjMGlOp9enlfFVBGN5+MUcXne3LzvMN1sB2Ael3QUnwEKG
         W4cr70VQMRJbkyjY9P8Hw/mgEgB1+pVm8LafAlJfFX6FG/YokdTLrwzHB2Fm4DJFxQdI
         jbHBVB7cnz0ctos/RBhSVVtUzObWkCiPiBmw0J66AUHj1l0cncP9PcZ5PR6blT1DpDFa
         oPIyYi7AhzLIvlUAzVC/VOKHJy9827TxiYdIkmXFY3xMmTqUR1rdwxnvv6dXJ/6bsiqe
         q87htTSOxWRZ6D+B2tkr9fqJDwE1Vd6we4511+llIh/211pFc1G66z3HpXLR1wjsNgZR
         unSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727205019; x=1727809819;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZmqquJARuoSAGMEF/+4cEtXPU83BcLRXtxEytvbtIts=;
        b=Cq2OHB3HKhEfzBDZHm21MTiNNujQ21UOkwtHN2o3TXCDRm4qoRiVOlwS8VS2Xl5cXW
         YNbBUMHJ5472qnjNfgfCNqf8JMjbe9Tz+faPmfn/w644CYL3FtRXT4/uLLzf54h7OaXE
         XheEirhvftUyd3bqSJdL0Hzq3HMHqRczTnXloYmH5R5id6LUc8u4i33RS/YhXBk0to3X
         Vz6iWCNYUq7TA9Q3H8DCOY6z4h0o32Bm3vLUc5RQC8mKKEGVbFj2JbYIDK5kh7FPxNbX
         aoVq7/dYKnjeAa+lV21nqxCswb7hpZSh2xu0JXE89SiqkHuaLnyPEoSby0cfGxqkR+0y
         Q2UQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6q+kT+CEuc7JEw2ZGrd/yD0DUhUHCKDE/K7hUCI5jcGQDJxh5uIz5lCkzZ/RZtJeuI4hPoVk0@vger.kernel.org
X-Gm-Message-State: AOJu0YxuE2IQZmZUYwbT32c2SxMvyiDrW7aSzDtVhbvFfmBn4whOG858
	28mMf9/7Q4+frzVsAd6/Ss1n89cF998Qppoq/2TndMp6RpT2/qNI
X-Google-Smtp-Source: AGHT+IFtMOxqAW1BY0Am5QMGLC1ri97OjgNx4aBh88rNLJZMbAVf5U0dgGQdIGeobMI++4T6sHpaGQ==
X-Received: by 2002:a05:6300:4043:b0:1cf:9a86:6cb7 with SMTP id adf61e73a8af0-1d4d4abe8demr203542637.20.1727205018619;
        Tue, 24 Sep 2024 12:10:18 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dd6ef3a344sm11699710a91.36.2024.09.24.12.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 12:10:18 -0700 (PDT)
Message-ID: <7f8babfd7156de98d089b2ed476dff7f652246a7.camel@gmail.com>
Subject: Re: [PATCH v2 dwarves 1/3] btf_encoder: record BTF-centric function
 state instead of DWARF-centric
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@pm.me>, Alan Maguire
 <alan.maguire@oracle.com>
Cc: acme@kernel.org, dwarves@vger.kernel.org, olsajiri@gmail.com, 
	shung-hsi.yu@suse.com, jirislaby@kernel.org
Date: Tue, 24 Sep 2024 12:10:13 -0700
In-Reply-To: <aQtEzThpIhRiwQpkgeZepPGr5Mt_zuGfPbxQxZgS6SSoPYoqM1afjDqEmIZkdH3YzvhWmWwqCS_8ZvFTcSZHvpkAeBpLRTAZEmrOhq0svfo=@pm.me>
References: <20240916134946.3893204-1-alan.maguire@oracle.com>
	 <20240916134946.3893204-2-alan.maguire@oracle.com>
	 <2be35785218e6df18d3e05ddcaf0406227e05109.camel@gmail.com>
	 <a78ff51c-059b-45b3-9c81-2c2d5a5b5e9d@oracle.com>
	 <aQtEzThpIhRiwQpkgeZepPGr5Mt_zuGfPbxQxZgS6SSoPYoqM1afjDqEmIZkdH3YzvhWmWwqCS_8ZvFTcSZHvpkAeBpLRTAZEmrOhq0svfo=@pm.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-09-24 at 19:02 +0000, Ihor Solodrai wrote:
> On Tuesday, September 24th, 2024 at 7:31 AM, Alan Maguire <alan.maguire@o=
racle.com> wrote:

[...]

> However, as I understand, Eduard suggests that these tables might be
> unnecessary at all, if the way of checking for and merging
> inconsistent functions is changed. Eduard, please feel free to correct
> me or expand on the idea.

I was thinking about keeping the functions in a separate BTF before
decision is made if that function has valid prototype.
But the table would still be necessary because of the flags tracked in:

struct parameter {
	struct tag tag;
	const char *name;
	uint8_t optimized:1;
	uint8_t unexpected_reg:1;
	uint8_t has_loc:1;
};

I'd say let's ignore this for now and do a simple refactoring with a
lock/atomic that you describe.

