Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036157D401
	for <dwarves@vger.kernel.org>; Fri, 23 Aug 2024 21:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724448521; cv=none; b=VynL1A2KqDLOP2p9VwUxRSVYRgsz0jT7RfXJW5xgF9wgqLN3dIwkJSP7XtMOIKuD9PXA1rco69j1wvVPtLgbRIrwy2veAOZxlI2HZ88g5BEJJ/gmv7BDDPSKtskG3YGwRSucHJO++L8rNGXiIQEBmeY7vzWjZRPuQyAwt5XcCgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724448521; c=relaxed/simple;
	bh=R3xTIYzj/4qKUh6HAoZaOMKrkAWhzz0jYm6T9tTQFS0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q8VLBrN1Ow61XLTFlFxN7a8ja9YNiR0XOJT1EbRJyl8ccyhIxfdf0ER3fm5Scr3HEUSZbtyT8bAnGw9nCg6alXzdISt17lXSY3FxCo8hfReDBvDBnE7Mhq6Nfa/Ei6Ca7RTL7kmnbvoXY5k/wzNWVGGYeZggBUsq608RD2hNC9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=obs.cr; spf=none smtp.mailfrom=obs.cr; dkim=pass (2048-bit key) header.d=obs-cr.20230601.gappssmtp.com header.i=@obs-cr.20230601.gappssmtp.com header.b=xxh/ZIB3; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=obs.cr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=obs.cr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=obs-cr.20230601.gappssmtp.com header.i=@obs-cr.20230601.gappssmtp.com header.b="xxh/ZIB3"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5d5c7f23f22so1711939eaf.0
        for <dwarves@vger.kernel.org>; Fri, 23 Aug 2024 14:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=obs-cr.20230601.gappssmtp.com; s=20230601; t=1724448519; x=1725053319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lRBYVq8gj337fLTwE2FQO7omhlSiqftyZ7WJosiQJ34=;
        b=xxh/ZIB3+t8ToayBz51Z3IgANhmf9rWB5/7jfZarQnTY2FcPqgP4OcelEKYcVM9ske
         SjYT7yZQ5odDENwzJQKZT9Vixf0GcnKGfbyQKQ0Y7hK5rrWiXpAO3Q0U6D7Urlki54f5
         OlbgX31Pf8N7DioXRfKcoKkN9w/kCRtJrfu7nCzP9KYxhQ+bA0ZEMsmElPJjtQCx13cg
         jcKVS80TrxIMiQEcfqQ01DKQRvBLe34XdIs8X8SxuZ9BY231stIkD3BpuIaPi/cLSm90
         fIvfKD3FcnEqJffzTvOBQcfsWK1WvdmnMnkhd+LrIm68YuDOERdeBuysgmOQDYsQ8Oj2
         0Fjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724448519; x=1725053319;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lRBYVq8gj337fLTwE2FQO7omhlSiqftyZ7WJosiQJ34=;
        b=jph+5kbGS3xsH1R+hD5nzeXba8u0L+OY/Ph6HVn7NMmEZYTQny8AOI5aeJsvsdKJux
         eVkGaJXkzBhXg+CitL6WoD/XdlfQp1w783DIzJj8Q7MBNWgQnwWsmnFk+vmTxfQ+AziH
         xfZnSvz/T2kCKJtrIETz+lbVQZhKfzazhP9Kaj4aEcHneVqRXAsQh7YhIr0w8Vp48wJj
         bDoUk8b9I+hmUL3LJW1gOmsPSf5/yXY9Mm5vXCfqV8NK9GLtqfCoCZV+9yzU9bAY9Fyw
         73cD3yWcsi/i8kPT2TFcwlk2KCr07kcMXwWkTii4XpeOnnwEoapMvdrhsGkcQATFaZe6
         2e7g==
X-Gm-Message-State: AOJu0Yy3mHSMnRhJyPnXvV8iMdfFpiRT83wqdipWbe3DbPbFDa4dRVk5
	VU2nlzOXxjraAlgvbLFoS5SirRGO3kzMspBBRAlJr/Ic3BTLNH4YyKcTHo3P/fyH1UMtYaBtIDh
	L
X-Google-Smtp-Source: AGHT+IERD8FloUc7cDlPMZeUnwD+aHG4KMoS/FSURH9B45RskEEWCxeguiZtGXD/UvL0+qM9gE9szA==
X-Received: by 2002:a05:6820:1e12:b0:5da:b554:b84c with SMTP id 006d021491bc7-5dcc625d655mr3323450eaf.5.1724448518865;
        Fri, 23 Aug 2024 14:28:38 -0700 (PDT)
Received: from ininer.rhod.uc.edu ([129.137.96.15])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ce710bb1c9sm1114893173.129.2024.08.23.14.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 14:28:38 -0700 (PDT)
From: Will Hawkins <hawkinsw@obs.cr>
To: dwarves@vger.kernel.org
Cc: Will Hawkins <hawkinsw@obs.cr>
Subject: [PATCH 0/1] btf_loader support for subprogram linkage
Date: Fri, 23 Aug 2024 17:28:30 -0400
Message-ID: <20240823212835.1078351-1-hawkinsw@obs.cr>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

First, 

I am a huge fan of pahole (and friends). I volunteered to work on
helping to edit the BTF spec for the IETF and so I've started to look
more deeply at BTF and the tools. 

Second, I hope that what I am offering is being sent to the right place
and is in the right format. I tried to follow what seems to be the
"right thing" by looking at mailing list archives.

This patch add supports to the btf_loader for subprogram (BTF_KIND_FUNC)
linkages. For example,

```
$ cat a.c
static int x() {
  return 5;
}
$ gcc -gbtf -g -O0 -c a.c 
$ ~/code/pahole/build/pfunct -Fbtf --compile a.o
int x(void) /* linkage=static */
{
	return 0;
}
```

Sincerely,
Will

Will Hawkins (1):
  btf_loader: Support linkages for BTF subprograms

 btf_loader.c | 8 ++++++++
 1 file changed, 8 insertions(+)

-- 
2.45.2

