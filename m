Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A72342ABD
	for <dwarves@vger.kernel.org>; Mon, 30 Sep 2024 11:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727695217; cv=none; b=UyOzaiBpefiVmlofMRYuqB/p2kYMvLR5JWz4P0y6Y2VJKAyCSRgTAiS04OCfw5dmJ4UhmN2CorYzzmqzuFsAfsCm5TwZBUC8tYEQALyQCCuVjmbho2k9OKop++63llB0FelZw+5F63atdAk0qJe5sNtVBMjHKnpPRdi/7PIbxHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727695217; c=relaxed/simple;
	bh=5NUT23Qa2ApSu1OChBlkbuzbSeVaoTNWKDwMv8o0w5o=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JkCEMTJW00ASTKv7MycXrc+Cta9/qMTZSaNzEMtAzOeUm/ol5lGRjXxtW+5woJEXwqkfg9txaUP0Gjzw2kWBu57fcLcDSf77nrFZOUNBJDsmiAAqabklzFlc6xm/XMe+B2ur88H+dQJUzqhwAX/gNJlvA3Qk1rM8zlCwQfb0TYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jNCOfbIk; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNCOfbIk"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37cce5b140bso2752826f8f.3
        for <dwarves@vger.kernel.org>; Mon, 30 Sep 2024 04:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727695214; x=1728300014; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8WrkDVustaRU6jJtsxLyx3vdewcj0DbhABoL4nflMLc=;
        b=jNCOfbIk6PkVV+rAujBCJ4hB1EZohOpYk526aPtlrKAQVpuhMGgkzGCHY3CZn3koXP
         tYh2zZugFXY33RBfqPYrwYiES6eSBTndlt4bNmnwbBowR3FiysfLFX2ICDtRj79ss8jA
         AIKuYcTuPta473b5FqjW9oVNZczAdrseUxL0/tUhPEDmHga+nLIvUxswTqVaLEeY9InZ
         yqXY6X7Sg/GWrWltEJSP+ekt/D1ct4HtcW8tVOtqSVAD2A2jDN/UB9wwdlbdLUhvUs/f
         VtQCadGyrrKdKb+rh4kbn3MF4uavgy4Y88DeHi2yqb9KvCqNLbhttHJT7yHMCiMxPQiZ
         EKQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727695214; x=1728300014;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8WrkDVustaRU6jJtsxLyx3vdewcj0DbhABoL4nflMLc=;
        b=Ab260C66Ud3FrKndbp+ONeC8CiwI7u98c56M/95DKTB3mWD9MTaDUCPBPr5BTF5N1E
         lBZImGRxp6Xzznhuti6o9fifBVaYNwDUcIL+Z0MBEJE1x7ZF3fByeGDEtvfTGEQ6o4FQ
         3lDSdFxssGi4U54AxQvuiYdsAzc2ZkHSBQtXsF7xfhejLRVTuUTn6lHXr6llVZ53lUIP
         nY30KVXblPTulL0E9KAm4rIOZ5SxRTCmoYmk/05Xwl8v4y4Qu5i85KMfIQnGbgEh4cqS
         e9yp2xW3fRu8Uh9VUX+0AFzBPsR39JaQFowUrnD7fw3VZ2n7PnRUW2iJQpZVk//Rql0k
         4rtA==
X-Forwarded-Encrypted: i=1; AJvYcCU9wlHoJkZCEJ1NUFGd7ps4cbT2bW9T5ewwrbEOJj7RR7LI/E8ijh7TkV1aRVvkPVFB0WLN9dZd@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+fB+Ogx5TZ8T7BL/JQdeb4XVMs4iDUzRmuBQG9pxVxoR8isIc
	L/JMeBnDsbA9MS4p37TqU1k9YPxkGLLeXcHmOdrS5HWiRXgUmfdG
X-Google-Smtp-Source: AGHT+IHKWzS4APmNMS5yyn/+w2a6y99ZYPH3Z16/GF2VniQs8NwOM4yecg/kuLkFvjJuYVd6yL4ruQ==
X-Received: by 2002:adf:f8c8:0:b0:37c:cee9:4682 with SMTP id ffacd0b85a97d-37cd5b1dd78mr6978033f8f.54.1727695214227;
        Mon, 30 Sep 2024 04:20:14 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd5742230sm8833995f8f.92.2024.09.30.04.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 04:20:13 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 30 Sep 2024 13:20:11 +0200
To: Alan Maguire <alan.maguire@oracle.com>
Cc: acme@kernel.org, dwarves@vger.kernel.org, eddyz87@gmail.com,
	olsajiri@gmail.com, shung-hsi.yu@suse.com, jirislaby@kernel.org,
	sedat.dilek@gmail.com, w@1wt.eu
Subject: Re: [PATCH v4 dwarves 0/2] fixes for memory optimized BTF
Message-ID: <ZvqJawSN_UVwQdAc@krava>
References: <20240930081725.2465825-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930081725.2465825-1-alan.maguire@oracle.com>

On Mon, Sep 30, 2024 at 09:17:23AM +0100, Alan Maguire wrote:
> This series is identical in effect to [1], it is simply applied
> on top of the "next" branch which now includes v2 of the series.
> 
> Patch 1 fixes issues identified in code review around use of
> func->state, strncpy issues.
> 
> Patch 2 speeds up the btf_functions.sh test by reducing the
> number of greps/pipes, shaving ~1 minute off execution time.
> 
> [1] https://lore.kernel.org/dwarves/20240925091734.1943742-1-alan.maguire@oracle.com/
> 
> Changes since v2:
> 
> - fixed checks of func->state since it is always non-NULL and removed
>   now-unneeded fields from dwarves.h; added assertions that either
>   ELF or DWARF data is present for func encoding (Jiri, patch 1)

lgtm

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> - fixed strncpy() issues, improved equality comparions between types
>   (Eduard, patch 1)
> - reworked btf_functions test to minimize overheads (patch 2)
> 
> Changes since RFC:
> 
> - fixed free issues (Jiri, patch 1)
> - embed func state into struct elf_function as each function
>   has state, and we can use the stack for state comparison
>   avoiding the cost of additional allocations (patch 1)
> - fix an intermittent coredump that resulted from using
>   btf__str_by_offset() string in adding function prototype;
>   needing more space could sometimes result in strset memory
>   movement which would in turn invalidate the char * string,
>   so copy it to a char array for param name/tag value encoding
>   (patch 1)
> - improve logging of decision to skip functions so that we can
>   gather that info more easily for testing in patch 3
> - added new option to pfunct to show all instances of a function
>   prototype and - if no function is specified - use the stealer
>   to dump out all prototypes more rapidly to aid quicker testing
> - added test covering BTF function generation, checking that
>   DWARF/BTF are consistent and that for skipped functions the
>   skip rationale was valid (Jiri, patch 3)
> 
> Alan Maguire (2):
>   btf_encoder: fix strncpy issues, other issues identified in code
>     review
>   tests: improve btf_functions.sh by reducing greps/pipes
> 
>  btf_encoder.c          | 68 ++++++++++++++++++++++++++++--------------
>  tests/btf_functions.sh | 22 +++++---------
>  2 files changed, 54 insertions(+), 36 deletions(-)
> 
> -- 
> 2.43.5
> 
