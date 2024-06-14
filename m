Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4191836C7
	for <dwarves@vger.kernel.org>; Fri, 14 Jun 2024 03:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718334752; cv=none; b=YzDKZgxAGRn81o5DlcU7FepzLbcFSQiH0Alz2u040ej2nZ5OLEehD/c+4n5rr9iF0qPAzWjrf7FmhUOcOSdOFUQpTkMHsr9Ki7Vlhj3sKIJFgzZ7eqaZHnnZOByyGAd55lmPqLKGckSuoCA/jM1vCNkU8o58kUqOLsZoDW4hIuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718334752; c=relaxed/simple;
	bh=i66+Bdnu2waxNgYgQMfnebJnj0ikVv8W8FGNmxk2kks=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AU4fZ9dvZn61TaoAHroZJmn9IcL3ngndlSaJIjTaNhWtcPS1LVpVmqFXAHoXScOS3sJGq1ExQtqsNj3R360tai7E8VeH+KVGVcGgj/slFAkPHGCzcQT5DTuEnaunbjRXDGtnS9kmynhowH4npRJ2bXjDu6c4EQ3fA38WcYwl5/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AuiBLJYa; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AuiBLJYa"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-25488f4e55aso670610fac.0
        for <dwarves@vger.kernel.org>; Thu, 13 Jun 2024 20:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718334750; x=1718939550; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d+m9zBlLN0VFR580ayHgDp0Tb6SCglJiUeBYZjQlBVs=;
        b=AuiBLJYaCjI7qdQnlxBTWPJihDrK4RAqtbjEVGz8/9s1WC9HufQEklVyG3XzE/dPhg
         t5ZhQ202kSIzgMh1KElf6hRJuElvOj6B31/QmijvaxST80q+5raSjhzI7/Vd2sajl75u
         KbbGCb261RsL50l5Kdv27DCiUZeKugOoOGm2/FripkgHz8UOhQbLcD0+tJ3O91/YulPx
         0IX03aTDkknj5uDc2uTSC1iS0pUEfNrLADE7XK6BuNub4o9U2yci8M4BanCzyYuKWBGb
         PF0p29/6N8kcbk2zLDyD5Ot6wO6ZvIqtYKQQPHPERY3lwMbYM4P2yEaXUahtq+hzjwyE
         7bwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718334750; x=1718939550;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d+m9zBlLN0VFR580ayHgDp0Tb6SCglJiUeBYZjQlBVs=;
        b=lZzewuj/BBfc2bY2cJjDE+JAfRF3j0/a98nINKdIVMVo8Ha49POHKLew11crksB2tL
         1ggsN5QZEoxJHHGPbq2z8GOcocEGoxPYZmkLQGAI/+4zu2RgnTfPjrGvJilMAS+qZCxJ
         dEnOHgSUKfeIvVqJvn2TQfvpBBx9kuJKGwdjgjnGlwO50J4JeAx8R5hx96Pml36MWNoY
         /rPz82mDIMbazVtf7Qu+U+AdQNePE//w7ky5H3vJ2ataWK8awzMtyx2giC6i7bGzJBlO
         qLUu4VroAf9t2s457oK4egXWy3JvIkGBBPC0Ob0s/l/hfi8JixfaKMzXjnzImhIbfjfL
         l3Fg==
X-Forwarded-Encrypted: i=1; AJvYcCWmQGz2XU0FvJOuczmsv/U14SXXSLm3JotzvlPZ68/M7NaVR0XocbYytuNQK+cfNUaqs5ONTVVlAQXmwM68bEks79yZED2i8A==
X-Gm-Message-State: AOJu0Yzrc1NGWVf7UU/+yJg/t10b1wUMqmWfgQjkO+9z09mo+5viTtgJ
	oxhhYYAuTU0Cg2YsiDeQN8ast5bJSl1K4pn2gZpSZkcwHw6dcN00
X-Google-Smtp-Source: AGHT+IFETz/qpkm8feGlhI0fbcrqi2Tj8TvwgBDyUtlFBCjMWEIETbu8mrWKzVb4uzwybUATK6PDGQ==
X-Received: by 2002:a05:6870:7187:b0:254:c777:6331 with SMTP id 586e51a60fabf-25842af7017mr1595223fac.42.1718334749679;
        Thu, 13 Jun 2024 20:12:29 -0700 (PDT)
Received: from kodidev-ubuntu (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc91e133sm2068110b3a.24.2024.06.13.20.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 20:12:28 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
Date: Thu, 13 Jun 2024 20:12:25 -0700
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Giuliano Procida <gprocida@google.com>, dwarves@vger.kernel.org
Subject: Re: pahole -J non-determinism and reproducible builds
Message-ID: <Zmu1Gc72f1VfrdVy@kodidev-ubuntu>
References: <CAGvU0H=MvKi=fk6K1M7O+OoGdnNzweXE1m=18yv2DHoPbRVASg@mail.gmail.com>
 <Zk-p8EPf-5juWsS1@x1>
 <e6b30dd4-531e-41e9-96ad-39e6fe73be40@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6b30dd4-531e-41e9-96ad-39e6fe73be40@oracle.com>

On Sat, May 25, 2024 at 03:42:50PM +0100, Alan Maguire wrote:
> On 23/05/2024 21:41, Arnaldo Carvalho de Melo wrote:
> > On Thu, May 23, 2024 at 08:25:17PM +0100, Giuliano Procida wrote:
> >> Hi.
> >>
> >> (edited repost due to unfortunate HTML email).
> >>
> >> Until the reproducible BTF changes land in a new pahole version, and for
> >> anyone stuck on older versions, pahole -J -j typically produces
> >> non-deterministic BTF.
> >>
> >> For Android, we are converging to hermetic, reproducible builds. .BTF
> >> sections are a significant difference we see. I have trivial patches to
> >> pass -j1 instead of -j for the older versions we are using (1.23 and 1.25).
> >>
> >> Trivial patches:
> >> https://android-review.googlesource.com/q/Ibd72ac638faa1826f6655b336cc7001591ea70f1
> > 
> > That should be at least configurable thru a CONFIG_REPRODUCIBLE_BUILD
> > that then would check the pahole version and if less than 1.27 then
> > would use -j1
> > 
> > So it continues to use -j from the version where it was introduced,
> > 1.22, but for people wanting reproducible builds it plain don't use -j
> > or if you really want to be explicit, uses -j1 as you did.
> > 
> > For >= 1.27 we will have 'reproducible_build' added to the
> > --btf_features= line if CONFIG_REPRODUCIBLE_BUILD is set.
> >  
> >> Gaining determinism for the older versions means giving up some performance.
> >> About a factor of 2.1 in our case (or an extra 10s on vmlinux).
> >  
> 
> From the original thread [1] looks like we could also use
> KBUILD_BUILD_TIMESTAMP as an indication a reproducible build is needed,
> though an explicit CONFIG variable might be clearer. Only thing is it
> might be harder to backport with a new CONFIG value; not sure what the
> stable backport perspective is on introducing new CONFIG vars.
> 
> [1] https://lore.kernel.org/bpf/Zf2_fgs0cqW82zEu@x1/
> 

Hi Alan,

Are there plans to implement this? It would be nice to see environment
based checks to enable reproducible builds, and in the past I've come
across distro patches also using SOURCE_DATE_EPOCH to force passing -j1.
With version 1.27, would something like the following be reasonable?

--- a/pahole.c
+++ b/pahole.c
@@ -3723,6 +3723,9 @@ int main(int argc, char *argv[])
 		goto out;
 	}
 
+	if (getenv("SOURCE_DATE_EPOCH") || getenv("KBUILD_BUILD_TIMESTAMP"))
+		conf_load.reproducible_build = true;
+
 	if (dwarves__init()) {
 		fputs("pahole: insufficient memory\n", stderr);
 		goto out;


Thanks,
Tony

> >> Do others want performance or determinism, should I send patches to LKML
> >> and the stable list?
> > 
> > But that is with older paholes, for 1.27, to be released next week, one
> > will just use '--btf_features=+reproducible_build and continue to have
> > parallel DWARF loading with serialized BTF encoding, which should be
> > close to the non-reproducible build numbers.
> >  
> >> Off-topic: pahole -J -j9 is faster than -j on my machine with 36
> >> cores, by another
> >> factor of 2. This is v1.25. -j1 18.7s, -j9 4.5s, -j 8.9s.
> > 
> > I'll try to profile that on a 5950X (16 cores, 32 threads) and a 14700K
> > (8 performance cores (16 threads) + 12 efficiency cores (12 threads),
> > total 28 threads) to try and see if I can get a better heuristic that
> > takes into account these factors on the most recent codebase that will
> > become 1.27 next week.
> >
>  > - Arnaldo
