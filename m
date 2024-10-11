Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1431CF5E9
	for <dwarves@vger.kernel.org>; Fri, 11 Oct 2024 22:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728687352; cv=none; b=uGOTCE6rqCGRAiKs+RMixJgCbSBEKYk1sXFLWLWlcssPhNs/p3ZEz2ypfBEQFIoFDDZ0iXnz1W5wjQIcmtSfUw/i0beA2ZV+1y6hxMwTBqBkKDAQMRLiuc1GozqNAwhUTvx7H+7Yj6SLcavCKpfKeJOT52iwkz2GCprkD9NeCbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728687352; c=relaxed/simple;
	bh=yPEjli6zo7yjJ48qzKKNmkvWq7kNEMyitRsXXpP2fls=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GY+D8+zq1b2Cw4OnMwDMBmshwV5sqm5wNd43TSa7s1ZNPPesmG6jTThLosHQ16p1xO+/vzJXJ2JvG0OFWqPqufMxILbCzb7LouvwkiQwDDtT08uP/ftS3/HpnyOB00LaWk54Of6uwiuXL7jDISUEmBHuWwq3YBRFOIEWbcXrTvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=KYRw6AhC; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="KYRw6AhC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1728687348; x=1728946548;
	bh=1Rfs5BOKKEZoj44U9FbF3tly2WLm5I8BjgBoH4WFIDw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=KYRw6AhCPH5s4h/KonGdGiYHsSgGqM2TB8rT3tud8nQfQwiAEH0vjIkI/5bZIl9G3
	 OFs08NJ18eOTn9wP3/fSnteR5cnzSpRebEiVm6xSMqVCVJXqmwE+M49d0uNK+HGAHY
	 66FwQVWV+Dqsl1ZMY02e1JKfRYe2blCDovLV4gSvXr55NPCdSvszilZh1O57NthBZZ
	 tinxJEdjWo7YNE40AZ5eq9opKl1q+S7T65xEpiD+Ehpsj7+9Rms6smdxF0/XcdqJBI
	 NG+vjsFHDbSEsx5sOhOiWYY/0KUNDB7eyEjAr1KJKM7QfzJGHHquNHBOksW+SgC61U
	 hUHVGuxtPDmpA==
Date: Fri, 11 Oct 2024 22:55:44 +0000
To: Ihor Solodrai <ihor.solodrai@pm.me>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: Alan Maguire <alan.maguire@oracle.com>, Eduard Zingerman <eddyz87@gmail.com>, dwarves@vger.kernel.org, acme@kernel.org, andrii@kernel.org
Subject: Re: [PATCH v2 dwarves 0/5] btf_encoder: implement shared elf_functions table
Message-ID: <CjP57PbrCPwA8EsOHPQuoZ9YnU1UE0mzeYqoqI4gQHTxIVUgXoEmGS-4R2g1gkf1RMPFVlTSE253f49mPUvqHUiuUw4wxwJXBH3Pv5GPwOg=@pm.me>
In-Reply-To: <m_fH6Yg0CAytjEUTxfZPpbMVGqGQWhuep4D--XMNrOZJh6MUWlIozEXiCC6ulW4FK6UFvCFlZC_sF0oNsAW3sftTvfPBjpz5AN3MdnxfhB4=@pm.me>
References: <20241009233520.989453-1-ihor.solodrai@pm.me> <60b79369e829b33c577fe285b6597894e72b7042.camel@gmail.com> <4C0idzPIUJesSQi12dB1SgeTQlGl13N2CCsvjPfdLbvTEemTJoQZ4P-LJcOQqRyM69ZLKVv4mIKDQJvfMYMV2oITse1_uS_m_SjVigh8bL0=@pm.me> <af7ca712-7798-4204-9e15-fa2065154699@oracle.com> <52889283-56c4-4cf6-aad6-b0fbea9e58fb@oracle.com> <m_fH6Yg0CAytjEUTxfZPpbMVGqGQWhuep4D--XMNrOZJh6MUWlIozEXiCC6ulW4FK6UFvCFlZC_sF0oNsAW3sftTvfPBjpz5AN3MdnxfhB4=@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: c9121fa1968167b47b6313dacc308aa0a5cf31ff
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Friday, October 11th, 2024 at 9:52 AM, Ihor Solodrai <ihor.solodrai@pm.m=
e> wrote:

[...]

> Hi Alan. Thank you for testing!
>=20
> I was going to run a couple more experiments today and respond, but
> you beat me to it.
>=20
> I am curious about the memory usage too. I'll try measuring how much
> is used by btf_encoders and the elf_functions specifically, similar to
> how I found the table was big before the function representation
> changes [1]. I'll share if I find anything interesting.
>=20
> [1] https://lore.kernel.org/dwarves/aQtEzThpIhRiwQpkgeZepPGr5Mt_zuGfPbxQx=
ZgS6SSoPYoqM1afjDqEmIZkdH3YzvhWmWwqCS_8ZvFTcSZHvpkAeBpLRTAZEmrOhq0svfo=3D@p=
m.me/

Alan,

A heads up: there will definitely be a v3.

Eduard discovered a bug when building kernel using pahole with this
patch. I already debugged it and made a fix.

TL;DR there might be fewer encoders than threads, which I didn't take
into account here:

diff --git a/pahole.c b/pahole.c
index a45aa7a..90f712d 100644
--- a/pahole.c
+++ b/pahole.c
@@ -3257,29 +3257,34 @@ static int pahole_threads_collect(struct conf_load =
*conf, int nr_threads, void *
 {
        struct thread_data **threads =3D (struct thread_data **)thr_data;
        struct btf_encoder *encoders[nr_threads];
-       int i;
+       int nr_encoders =3D 0;
        int err =3D 0;
+       int i;
=20
        if (error)
                goto out;
=20
-       for (i =3D 0; i < nr_threads; i++)
-               encoders[i] =3D threads[i]->encoder;
+       for (i =3D 0; i < nr_threads; i++) {
+               if (threads[i]->encoder) {
+                       encoders[nr_encoders] =3D threads[i]->encoder;
+                       nr_encoders++;
+               }
+       }


Regarding memory usage, I tried instrumenting with prints of rusage,
but that got too inconvenient quickly.

So I ended up making flamegraphs [1] for:

  perf record -F max -e page-faults -g --
   ./pahole -J -j8 \
            --btf_features=3Dencode_force,var,float,enum64,decl_tag,type_ta=
g,optimized_func,consistent_func,decl_tag_kfuncs \
            --btf_encode_detached=3D/dev/null \
            --lang_exclude=3Drust \
            ~/repo/bpf-dev-docker/linux/.tmp_vmlinux1

And compared between next (91bcd1d) and this patchset.

If you check the number of samples of=20
    btf_encoder__collect_symbols() - that's a table per thread
vs=20
    elf_functions__collect() - a shared table

the results are what you might expect: for -j8 shared table is about
6x smaller.

However, even the duplicated tables have relatively small memory
footprint: ~4-5% of the page faults.

The biggest memory eater is elf_getdata() called from
btf_encoder__tag_kfuncs(): more than 60%. Maybe that's expected, I
don't know. Certainly worth looking into.

Of course, these are page-faults not a direct memory measurement.
If anyone has suggestion how to get something better, please share.

[1]: https://gist.github.com/theihor/64bd4460073724a53d26009e7a474b64

