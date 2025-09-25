Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03256D1A7
	for <dwarves@vger.kernel.org>; Thu, 25 Sep 2025 14:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758809138; cv=none; b=bf/nSPkFtA3I35GW9lTbHL/KCITYDHy14b/KuBbRzfe+yJf0K4WLDgiExoK4C4dZ96YwYHt0V8bHrFyPamvsm0oacctou9gpS9/LzSEiId0g6YMPmQ2sqdw+OMbsD/NPsfOAI1F8bYicZqdrOtezcvlwiW35cZwJtdyzbUTA7oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758809138; c=relaxed/simple;
	bh=5WLt4e8G8qYs4QI4bxMII7pdtyAa60deF07NK2Rwah8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=La+l4p4mTfxAG4nFPVyBrjZ1hVs1ZMJPetd3jRaiItbT1obSOhGSxwNau30sDk/kpR03zMoHa6AHkS68ubAbXM0UYbnAnqLBlNPoEPMwlczG/kRK1mLfPmkL/9ZyIsTc/o63TO03OwvivqqAG9IuoYOPpvJCOGwKLLvAjAcF600=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iqysoy8E; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iqysoy8E"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3f0308469a4so644411f8f.0
        for <dwarves@vger.kernel.org>; Thu, 25 Sep 2025 07:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758809135; x=1759413935; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RBu380y0ThMkvKMZAdflPO4ayhtFxUm++NTY5wBMv1o=;
        b=Iqysoy8E8epzqBj7hwTL3QEwMoKu7NWU3+wedcMHnt67pt2c7EJPo9PT6lrSe3y6j0
         4ArLX651AA9u6l5HTfw9kfbYVx399GaslnwE/Kvz8oJwfFSKlJ3PPuoEO1T8yukxIsQa
         FPKckNfMhe20S8PRLNBlygBl/Sl8mOshSF+iveiqD057VkaW6EwvQf1UD75wKmkXRPzB
         nxazuZQw8kKfHFDC+eaKW7nO1tYtqA62blcN2597iZrQ8l9Wg0MqOc7FmwG/aV+78o70
         3P3tELG6gXtx8ZSAZwIoFFcTgUUnWIPyAIi3Zf0l13EgFpg7rGFKwpGJWGp9D/LNpjut
         TUHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758809135; x=1759413935;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RBu380y0ThMkvKMZAdflPO4ayhtFxUm++NTY5wBMv1o=;
        b=r1WKHzRsehOdvyHX1fFQZmoydJkpCG0YsEJVqEOMevJ0Gr1Nf5b0yJv6dGIVUoy3sx
         aWOHGt/MghUSoi6lAQc3hHUBDTCa1JJhKG1xPeEtDi37Ud5q5O5E1ak0dGEMop8a/mwF
         H0W3jrYaSddyUdaye1gYbgkTt3L8UEHdu/MPNnPbPRKxaDZHunKZ8N3zJHzLLk02t1El
         eCgOTdQWyd71AogLq4BA/Dhm5W1o/wJ/bgOuapBaIB7LkIEXnFV8OHxDr+VV5G1DGsJE
         +GXc2Nu5Udli+893x4NTjIVbeunTuKHjxUrt9PH5UIV2Rsb1DTb3ZFZrFKTPIfeAZVrj
         a1gQ==
X-Gm-Message-State: AOJu0YzMUjqYEvNFvL/kUGsHK/KazyEAk5PnLFqf3tI7yWxAsX2vX1U1
	ww3ofMWj6cs3rDlmrV/Qn8y2Q8xceoJBZkwjGaujNLgJMe1v+DCkNT8g
X-Gm-Gg: ASbGncuDdM4qoo5906Ds3gk8euzoEMu2E+rfxDblEuMp4EWqWCy3/4dNNVNgYzQOJyP
	hpK22OTm3mEYBbTPeani+SZW7fFnYQ7i94xzgzVTzJQaJ23jr8SdR5A2AaG8oiEr8R1SiFA/lY2
	hhLBEQj40roQgUlrPolC2BTivvPCAHN/Dz1oI8bREZZ3ghWLJ3Ci4TaZ0GYuz2cOneN45AN3fSH
	EYnrhr9BlqNbkG9D228iqRg4tMPGIkieTIzj3mvIBzQz8JCl5vVLtDA0CjYo/E+3yLc5jfsODVj
	tNPk83zHXdK6nSGx++8kNVYayp01G6J+D2ubSTUKeTmHaMlldWiB9Fd3HReWFIRZuo9i0pofBbR
	9S8jyye/OH0foy3oBETKuf/RTCnf/7rW47GcOs6MVUcBOt3ctn759WZRSr/295lbMbBOxX1UlGm
	JDiXRnlfQ=
X-Google-Smtp-Source: AGHT+IFrUhzu/cOQyopFFO11YhjTli4GP6WS+UV5MIedbRMvpVIJciiibvQmgs//C0aivZTw+MPJ4g==
X-Received: by 2002:a05:6000:18a5:b0:3f4:5bda:271a with SMTP id ffacd0b85a97d-40e44777081mr3459717f8f.6.1758809135093;
        Thu, 25 Sep 2025 07:05:35 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7? ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb9d26ef7sm3338215f8f.26.2025.09.25.07.05.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 07:05:34 -0700 (PDT)
Message-ID: <e8450c79-88cf-4b8f-ba2d-2a9e4194f820@gmail.com>
Date: Thu, 25 Sep 2025 15:05:33 +0100
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1 6/6] bpf: mark bpf_task_work_* kfuncs with
 KF_IMPLICIT_PROG_AUX_ARG
To: Ihor Solodrai <ihor.solodrai@linux.dev>, bpf@vger.kernel.org,
 andrii@kernel.org, ast@kernel.org
Cc: dwarves@vger.kernel.org, alan.maguire@oracle.com, acme@kernel.org,
 eddyz87@gmail.com, tj@kernel.org, kernel-team@meta.com
References: <20250924211716.1287715-1-ihor.solodrai@linux.dev>
 <20250924211716.1287715-7-ihor.solodrai@linux.dev>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250924211716.1287715-7-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/24/25 22:17, Ihor Solodrai wrote:
> Two kfuncs that use aux__prog argument were recently added [1]:
>    * bpf_task_work_schedule_resume
>    * bpf_task_work_schedule_signal
>
> Update them to use the new kfunc flag and fix usages in the selftests.
>
> [1] https://lore.kernel.org/bpf/20250923112404.668720-1-mykyta.yatsenko5@gmail.com/
>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>   kernel/bpf/helpers.c                             | 16 ++++++++--------
>   tools/testing/selftests/bpf/progs/task_work.c    |  6 +++---
>   .../testing/selftests/bpf/progs/task_work_fail.c |  8 ++++----
>   .../selftests/bpf/progs/task_work_stress.c       |  2 +-
>   4 files changed, 16 insertions(+), 16 deletions(-)
Acked-by: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
