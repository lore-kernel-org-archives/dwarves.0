Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27F274C0D;
	Thu,  4 Apr 2024 09:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712223774; cv=none; b=L6AEVO0sVqwMag+OdkQDOIfbaaiio+hykAc+/B0B0q7pH+33ckkM9kCIqrloLnauagD1Wg3oX59vSODZOfFCKLxifUfvDKXqnzOi0w/eE95Q37tGEnA2M9aN1bTW6CG8lJ6vey6Ncu1qlmxE+A1XzwkTulCaOIPT+jmPpWsKMKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712223774; c=relaxed/simple;
	bh=LiXgRGtMtoes9MQ4ZfOq1mn6IwEV7jAURmg3MriSQPQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dkdk6+UN0iPtsXd/qHa50ObNm2oiH2mEkuDGrw/besv+/oEzxxJvEp4DQGX7fu/Wbgmf+J82vzk6vpbWgCPBWNysO0hxxU9gbI8JlFkWJhAubbsHXI8ELw58ciEMEGCAqbiePmO89JADna5+BBFeGvIpKmYyMFxyuObb83WlhT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MgfPjqFH; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MgfPjqFH"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-516c547fb4eso1002850e87.0;
        Thu, 04 Apr 2024 02:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712223770; x=1712828570; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Twe0/F7vbXk44ZJbN35Pz/jDTTbFE1kzz1Yx9HYbdi4=;
        b=MgfPjqFHJ0yiCpFQ4GKiIG104sHIOrYJfv/bJ8HhXEh1l4oh6bhJgWtKm/drVUO8ia
         wOYWDLvbh3OqlIt813kTsBy8Jy+XSAcY0zhEJfMFB+Twb66OD9jTlsrhB9erORibSXAV
         2MyU2MQtT8LgLmTJvCycJ5BStD8UEj6HMlBDWuZ6hYf85bngZYygCcpptCTbxmEC7f6+
         oZagWh1PvJyd7PtxXEFmoWfgmNBhJq/1yHh38QWt3uVFoR9lZmlW+BIWKsXbsqDkVT3C
         lgqIZe9uEngyAnPQcDUB/teTBL1jltkjrxQX71IlCYsXiMUdvZnG5LgWThWy12cqkSB0
         5uQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712223770; x=1712828570;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Twe0/F7vbXk44ZJbN35Pz/jDTTbFE1kzz1Yx9HYbdi4=;
        b=k/okcvEbtuH1KkUufLKU7ehBDe1+T3koYAflBAVjXGpD02zF3xs9+F7gK7qODkWOlr
         6RHYPWCnvyNaGZhqC5kYGSb1WzSEYZ/TDlTWZRkm426NlmxSxkIBJ/ByIV5hjtlbZzMA
         ylY4UNqp+0uHa984YOCEx4qUn052YuhKXJIqNwvk/ESIQRgW17eIEXdEDsqJkvUe2buv
         9lEkHd3e0QVxDf7JSNyM7+gCQiQela7k8tAis4lvh1FAhWUmqnA/zevWtpsGQNQRCWWo
         k9oAAo3GtqyOs7oVTjlHmY7Wh9dqUmcPZQIBG7Adnld8XF6oCh4LgPmXc4+vXNEn1qJo
         PhNw==
X-Forwarded-Encrypted: i=1; AJvYcCWcdY+KbGcFdynTsRegXfYhXMq/XT3dgZ1V2tUW02uVQbCLFPWH0hAEIoEthY9RSVgoJwPVjfpLWh/kOWlZGMudcUy/
X-Gm-Message-State: AOJu0Yy1xvO7ZBTAp9wW/070pba4R/L6yfLLIa0YmprqYW+Lm5YT4l9q
	q7so4IDZo4xGc8bhYN96A4iyk7QPLj+Zxv4xcqK1NlyOa4OL7JLM
X-Google-Smtp-Source: AGHT+IGU5LqbchUF3Kx6kSvqtDm7sw2Sz6VOYC9dsl6GIvUvyRoCXlWNHvZ9S31aRVNVEVftbLwLTQ==
X-Received: by 2002:ac2:4428:0:b0:516:a328:b080 with SMTP id w8-20020ac24428000000b00516a328b080mr1330492lfl.1.1712223769707;
        Thu, 04 Apr 2024 02:42:49 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id r18-20020a05600c35d200b004157ff88ad7sm2076566wmq.7.2024.04.04.02.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 02:42:49 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 4 Apr 2024 11:42:47 +0200
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: dwarves@vger.kernel.org, Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>, bpf@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Kui-Feng Lee <kuifeng@fb.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Subject: Re: [PATCH 02/12] pahole: Disable BTF multithreaded encoded when
 doing reproducible builds
Message-ID: <Zg52F0lPy9zrU7MQ@krava>
References: <20240402193945.17327-1-acme@kernel.org>
 <20240402193945.17327-3-acme@kernel.org>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240402193945.17327-3-acme@kernel.org>

On Tue, Apr 02, 2024 at 04:39:35PM -0300, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Reproducible builds need to produce BTF that have the same ids, which is
> not possible at the moment to do in parallel with libbpf, so serialize
> the encoding.
> 
> The next patches will also make sure that DWARF while being read in
> parallel into internal representation for later BTF encoding has its CU
> (Compile Units) fed to the BTF encoder in the same order as it is in the
> DWARF file, this way we'll produce the same BTF output no matter how
> many threads are used to read BTF.
> 
> Then we'll make sure we have tests in place that compare the output of
> parallel BTF encoding (well, just the DWARF loading part, maybe the BTF
> in the future), i.e. when using 'pahole -j' with the one obtained when
> doing single threaded encoding.
> 
> Testing it on a:
> 
>   # grep -m1 "model name" /proc/cpuinfo
>   model name	: 13th Gen Intel(R) Core(TM) i7-1365U
>   ~#
> 
> I.e. 2 performance cores (4 threads) + 8 efficiency cores.
> 
> From:
> 
>   $ perf stat -r5 pahole -j --btf_encode_detached=vmlinux.btf.parallel vmlinux
> 
>    Performance counter stats for 'pahole -j --btf_encode_detached=vmlinux.btf.parallel vmlinux' (5 runs):
> 
>          17,187.27 msec task-clock:u       #    6.153 CPUs utilized   ( +-  0.34% )
>   <SNIP>
>             2.7931 +- 0.0336 seconds time elapsed  ( +-  1.20% )
> 
>   $
> 
> To:
> 
>   $ perf stat -r5 pahole -j --reproducible_build --btf_encode_detached=vmlinux.btf.parallel.reproducible_build vmlinux
> 
>    Performance counter stats for 'pahole -j --reproducible_build --btf_encode_detached=vmlinux.btf.parallel.reproducible_build vmlinux' (5 runs):
> 
>          14,654.06 msec task-clock:u       #    3.507 CPUs utilized   ( +-  0.45% )
>   <SNIP>
>             4.1787 +- 0.0344 seconds time elapsed  ( +-  0.82% )
> 
>   $
> 
> Which is still a nice improvement over doing it completely serially:
> 
>   $ perf stat -r5 pahole --btf_encode_detached=vmlinux.btf.serial vmlinux
> 
>    Performance counter stats for 'pahole --btf_encode_detached=vmlinux.btf.serial vmlinux' (5 runs):
> 
>           7,506.93 msec task-clock:u       #    1.000 CPUs utilized   ( +-  0.13% )
>   <SNIP>
>             7.5106 +- 0.0115 seconds time elapsed  ( +-  0.15% )
> 
>   $
> 
>   $ pahole vmlinux.btf.parallel > /tmp/parallel
>   $ pahole vmlinux.btf.parallel.reproducible_build > /tmp/parallel.reproducible_build
>   $ diff -u /tmp/parallel /tmp/parallel.reproducible_build | wc -l
>   269920
>   $ pahole --sort vmlinux.btf.parallel > /tmp/parallel.sorted
>   $ pahole --sort vmlinux.btf.parallel.reproducible_build > /tmp/parallel.reproducible_build.sorted
>   $ diff -u /tmp/parallel.sorted /tmp/parallel.reproducible_build.sorted | wc -l
>   0
>   $
> 
> The BTF ids continue to be undeterministic, as we need to process the
> CUs (compile unites) in the same order that they are on vmlinux:
> 
>   $ bpftool btf dump file vmlinux.btf.serial > btfdump.serial
>   $ bpftool btf dump file vmlinux.btf.parallel.reproducible_build > btfdump.parallel.reproducible_build
>   $ bpftool btf dump file vmlinux.btf.parallel > btfdump.parallel
>   $ diff -u btfdump.serial btfdump.parallel | wc -l
>   624144
>   $ diff -u btfdump.serial btfdump.parallel.reproducible_build | wc -l
>   594622
>   $ diff -u btfdump.parallel.reproducible_build btfdump.parallel | wc -l
>   623355
>   $
> 
> The BTF ids don't match, we'll get them to match at the end of this
> patch series:
> 
>   $ tail -5 btfdump.serial
>   	type_id=127124 offset=219200 size=40 (VAR 'rt6_uncached_list')
>   	type_id=11760 offset=221184 size=64 (VAR 'vmw_steal_time')
>   	type_id=13533 offset=221248 size=8 (VAR 'kvm_apic_eoi')
>   	type_id=13532 offset=221312 size=64 (VAR 'steal_time')
>   	type_id=13531 offset=221376 size=68 (VAR 'apf_reason')
>   $ tail -5 btfdump.parallel.reproducible_build
>   	type_id=113812 offset=219200 size=40 (VAR 'rt6_uncached_list')
>   	type_id=87979 offset=221184 size=64 (VAR 'vmw_steal_time')
>   	type_id=127391 offset=221248 size=8 (VAR 'kvm_apic_eoi')
>   	type_id=127390 offset=221312 size=64 (VAR 'steal_time')
>   	type_id=127389 offset=221376 size=68 (VAR 'apf_reason')
>   $
> 
> Now to make it process the CUs in order, that should get everything
> straight without hopefully not degrading it further too much.
> 
> Cc: Alan Maguire <alan.maguire@oracle.com>
> Cc: Kui-Feng Lee <kuifeng@fb.com>
> Cc: Thomas Weiﬂschuh <linux@weissschuh.net>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  pahole.c | 25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/pahole.c b/pahole.c
> index 96e153432fa212a5..fcb4360f11debeb9 100644
> --- a/pahole.c
> +++ b/pahole.c
> @@ -3173,6 +3173,14 @@ struct thread_data {
>  	struct btf_encoder *encoder;
>  };
>  
> +static int pahole_threads_prepare_reproducible_build(struct conf_load *conf, int nr_threads, void **thr_data)
> +{
> +	for (int i = 0; i < nr_threads; i++)
> +		thr_data[i] = NULL;
> +
> +	return 0;
> +}
> +
>  static int pahole_threads_prepare(struct conf_load *conf, int nr_threads, void **thr_data)
>  {
>  	int i;
> @@ -3283,7 +3291,10 @@ static enum load_steal_kind pahole_stealer(struct cu *cu,
>  				thread->btf = btf_encoder__btf(btf_encoder);
>  			}
>  		}
> -		pthread_mutex_unlock(&btf_lock);
> +
> +		// Reproducible builds don't have multiple btf_encoders, so we need to keep the lock until we encode BTF for this CU.
> +		if (thr_data)
> +			pthread_mutex_unlock(&btf_lock);

so the idea is that this code is executed in threads but with
NULL in thr_data , right?

>  
>  		if (!btf_encoder) {
>  			ret = LSK__STOP_LOADING;
> @@ -3319,6 +3330,8 @@ static enum load_steal_kind pahole_stealer(struct cu *cu,
>  			exit(1);
>  		}
>  out_btf:
> +		if (!thr_data) // See comment about reproducibe_build above
> +			pthread_mutex_unlock(&btf_lock);
>  		return ret;
>  	}
>  #if 0
> @@ -3689,8 +3702,14 @@ int main(int argc, char *argv[])
>  
>  	conf_load.steal = pahole_stealer;
>  	conf_load.thread_exit = pahole_thread_exit;
> -	conf_load.threads_prepare = pahole_threads_prepare;
> -	conf_load.threads_collect = pahole_threads_collect;
> +
> +	if (conf_load.reproducible_build) {
> +		conf_load.threads_prepare = pahole_threads_prepare_reproducible_build;

would it be enough just to set conf_load.threads_prepare to NULL? 

there's memset in dwarf_cus__threaded_process_cus doing the same
thing as pahole_threads_prepare_reproducible_build

jirka

> +		conf_load.threads_collect = NULL;
> +	} else {
> +		conf_load.threads_prepare = pahole_threads_prepare;
> +		conf_load.threads_collect = pahole_threads_collect;
> +	}
>  
>  	// Make 'pahole --header type < file' a shorter form of 'pahole -C type --count 1 < file'
>  	if (conf.header_type && !class_name && prettify_input) {
> -- 
> 2.44.0
> 
