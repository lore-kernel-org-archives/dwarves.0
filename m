Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CBC26738A
	for <dwarves@vger.kernel.org>; Fri, 14 Feb 2025 16:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739550868; cv=none; b=vDyvALXUUAdIbCI/KOPPmFVFRQXTO9o9YceLYb5uiNXylplTuxpYsNgcFgAyZX2fzrd2MBG8i+1nP+zX0zIwCSdFwhZp4vUylRV8Avzp0yuJlIP/SXggdPNXUzF04NP09FnMX09ubE0fDt4vTcQAvJz5AccUWZRGyFADdKoVhnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739550868; c=relaxed/simple;
	bh=Pco5uU8eZZWM2Ihxw+JjePc70qbvyy/2MU9nltYH5Qw=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=kHG1WYL6Jg58nxRTl0DazTgUHp2g4i040YyvapqJNOFOjnP9hoyWbNua53qXUTkt5UPstsEARzx/yKMg/nvzdtLncetLkI1aZ2CPudb2u4SHJW5RQvSVuTb+ESIGlkWy8YsShzP8GChkBdwGBdwKEssIM9gjxAzMm0Jshao76VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=t28KYlj2; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="t28KYlj2"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4395f66a639so14637115e9.0
        for <dwarves@vger.kernel.org>; Fri, 14 Feb 2025 08:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1739550864; x=1740155664; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:content-language
         :to:user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pco5uU8eZZWM2Ihxw+JjePc70qbvyy/2MU9nltYH5Qw=;
        b=t28KYlj2wWIiwYcVSF8mDxAEvZTQzjb9pxHfqUpcdi96EVWYfAwhzw5xHDE3QG45DU
         kIrUZO6uQTu99mSDTlUQYWajPmrm0RReJ8rhw7snP+dbMKOz75gH1CalY27RtnGyBSbi
         lxtZowIX5YcEbaHq6AhDN5LGqcYKv8IwkFgss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739550864; x=1740155664;
        h=content-transfer-encoding:autocrypt:subject:from:content-language
         :to:user-agent:mime-version:date:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pco5uU8eZZWM2Ihxw+JjePc70qbvyy/2MU9nltYH5Qw=;
        b=LgYxrlnYxvg3Cu5eoMWKtgUvF6GARcJUCB5hxrnhPekmOVY92ZObJSoq6Sm9BU08/y
         a+24w0MhH7wpPIBYDCuxSwC2ia2c+G9jvJTS69J3+eus0DgaawzWevaLI+1taNePEg9T
         VdGNNh/2EThfIkBRi7E0jAe7NHrTgsvMbho446DCf6TivAdOr+fVPHaP6EAzhjFCG8db
         JZd2UICgcahKEZsOliMrEzDF1498bHYjlQCYsBjQMLNyZrfQR78XGLJCIID718ZoV2YZ
         3Tk301mYfMNsIptiDaE9TMcIrV7iVjO5exaiScokn+wSP8PilI3AGg1nT7JDWjDEXRO4
         Z9SQ==
X-Gm-Message-State: AOJu0Yzx+XLK/EomNLO9ZLkKr3Bq9Z0i7EIsCk0DjwTZr47ttQe+i+/+
	wktMcxpDmCZ0nJOlVqySDIUS1pzsfbkodRX2HIqwIpx1yaQM2uB/v3ZkO1X1olGbl3tIGjNV5lb
	U
X-Gm-Gg: ASbGncumY5B5wK641UkiNM61a7ODU6t+bANkdoR++oeUWXweF0l960sVFRXvhQ2ngku
	0krsMDN9oU/nWEeNeuMCnuA6iwTt9lfEdiOTuVZ+UA+A918mCLccBMhgUR+qubzrqVfdVdfMMUx
	MTZvoyxA91SADv1n/QUHWo3e4UTY6ZhUo2Pih99qbtnd2S8j0NiqyBKGTB8Vun7nXFANoRL547+
	e+EFsu5Q1+SI/mwQyu/7jIruZja7fkd0b/gWBp4AOkf45j/WgEhP5dySmTJfBLnfkja3LXxcOZc
	e7AjaqUsc1APmi3HAaIHjxkkBQ==
X-Google-Smtp-Source: AGHT+IGmR6H2HlSfcJe1ijVQ8m4SxtLs5yXgeN6RfSzwhykgPgxAuLy3qllgVVHTvb1U4jNhyq9tRA==
X-Received: by 2002:a05:600c:6d3:b0:439:6017:6689 with SMTP id 5b1f17b1804b1-43960176866mr98626465e9.9.1739550864554;
        Fri, 14 Feb 2025 08:34:24 -0800 (PST)
Received: from [10.81.43.157] ([46.149.103.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4396b0aa4e9sm11143405e9.16.2025.02.14.08.34.23
        for <dwarves@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 08:34:24 -0800 (PST)
Message-ID: <07381c66-f102-44ea-8966-9a49222847b8@citrix.com>
Date: Fri, 14 Feb 2025 16:34:22 +0000
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: dwarves@vger.kernel.org
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Alignment information
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

I think this is a new feature request.

I'm tracking down a UBSAN failure (only shows up on one arch, and it's
in a list_for_each() so there's loads of container_of() going on too).

Newer versions of pahole have the overall structure alignment given the
end, but I can't seem to persuade it to give the the alignment of each
field.

More concretely, I'm looking at a structure which is nearly 4k in size,
differs per arch and has an overall alignment of 128, but I can't find
which sub-struct within it is causing such an alignment requirement.

Would it be possible to also print the alignment information in the
comments that exist already?  i.e., instead of:

/* $offset    $size */

could we have

/* $offset    $size $align */

?

~Andrew
