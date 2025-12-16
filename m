Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF0F31B117
	for <dwarves@vger.kernel.org>; Tue, 16 Dec 2025 19:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765915139; cv=none; b=fzCfmU3eh1Jn4a2JHZ0bdIzHElHsLdoW0Qej1sdffp2CaOjVQl6C6MjV9CIs2bNbqUi6gK0raVhv7RcA8mm5/wk8Rf718Xc+3xgaKRXAa+GBx7gH2b3cvklDWVXHwhMd00RU4muMSAHBWh7uF19NJuHIlBzdpnjbkd9fv8VQc1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765915139; c=relaxed/simple;
	bh=xD9fvKR6R0xx2QkLJFssk7C8mFDrIQ+I8tOfGVgWHR8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u+PAkSOuO60WSFjx7mOpAosWEgMcrLj8nFJenM7zONF7SE4xexFhI7L4NS9ctbbFVOrlpqaVAD0tXobuk3fJzOf1Z7XwNbHEg1gAcqsy4PEBnvoZwAwKne2HodSkcdejsikIvG7N+0ARIEVTxq6m6uwz1GnTbhtYR4wrIDcuBAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X1vH+mNy; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1vH+mNy"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7b89c1ce9easo5820233b3a.2
        for <dwarves@vger.kernel.org>; Tue, 16 Dec 2025 11:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765915137; x=1766519937; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HcHHcKfq8+aPeSsV2fUtc8qlv3Uw4dEWKUNLIt5sOdE=;
        b=X1vH+mNyb8Yi6JNhR+AcoKD+iDEP97amJvPC5QcKTd6tcJDSttMEDiSg5yLn3N3TEu
         vqY7ujQf3VymzwAqol2RzLORVcIbfb79dF/G8u7S97t+S4wItwQr88gM2/z2Ed99b88i
         93kQTbpvKrbMl4x0zWt6yEPyowzCJFqU0BoRPOzHDpxAWJuEw7GMAqRPCdCuS1aaHhra
         p7uaHvkqAtSuZcyKuASEbRGZlIHRUFlbtalHS74qx7QqpZRDZHKn8uu1IfGvh2cJJdbA
         S/exDJuK8wuBBrhiC4oFxfNpSWps3AJTdrIp8+ozUDhc70M56Px2LRIyl/akjbBQjMjY
         j4xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765915137; x=1766519937;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HcHHcKfq8+aPeSsV2fUtc8qlv3Uw4dEWKUNLIt5sOdE=;
        b=IEvyVhSsm3xgFeQwF1gVrlR562flFPA6ethDh0Yel43Eu1yN8BNRm7yZU0umN9e8Rs
         pPbRWzAzQ8kw6Rre5ohGuduTAThWGDMVVXA0N1Nux01yTmYT080mtJt4TI94Upd5tGE9
         bedmTqLHTiwYzm63+lLxtEL1mV4fMsDj67AU++0+kiSmtw558lVapkJ2KcW5eksUie+3
         HgycQs4KGI3zMsNNifFTjaHDv66IijXdM1+XWGlO6oKcrsVzz4EVT2OKKvX3vs5cP1MN
         PKril9ZuK+NM73RDSImHLy/EwTxihBg7uJDccx360RxK6d6bdRpPsr7Z8V4PEFEf+oB4
         X9LQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdiQnbcVGkPQWzALQIF7zQ50gqx0eXTQmQQAyzwR198/l5Nn+xbfLaOoZGv9dMVo1kcpHPG+5h@vger.kernel.org
X-Gm-Message-State: AOJu0YyBLarmd7zh119jWrqv3Bdhi8NTvFr4ixTqBMb/n/uVxaQRqy5j
	wGNRGF+FrglFFw/szmSfwazbrA6wu5tOjSDobipgZdL+IurF7qCABSfu
X-Gm-Gg: AY/fxX7ICvoIXMrQC2pqhpbqFKgy1zbt+BlnDIXgtqpuBTU0uWUqPVyBHJ0kLrjiiI8
	Qy+9fqHduWreYH4s9uRojfGUgmgWoFkkckSMaPv+sREv18Lft2haXJjii+LQrNNsd2uad9REQX9
	PDHWu0aQhIpiHbmnQ+JaSFgKr7476KMDZb8C2ob5mtRttRNqocTjsQYjvKze4GMn985/lUqvZlm
	yXmSi8iuYnnR1LBHsDZ4uHfqv7L8xJBGiy44ZPXor0IErpRhXv/VGIjyzMx4Mrnjd39oqRh4pgY
	YxwyRahrLDt98T8iIeGfNfp4TsSD4oiGJgWmYjlH8+Ow/8jz9Fp3vBB8hIyWdMKygcNA8objs2c
	tdjytJdavK0o1iV7Bm4/Yj5IowuXWEr3h2IeRkZlZFHrjtFvTibUQWv1L5Qr8MXwoSCBqjWWWfN
	vkE98SZ+/w
X-Google-Smtp-Source: AGHT+IFv3ODhtSb0L+Le4kdFabV0AVBP3s2kdKANWYCxJqYIXKs1TDVLinxkpxuMI7zbj41ORdFabA==
X-Received: by 2002:a05:6a00:4a0c:b0:7f7:2a77:7567 with SMTP id d2e1a72fcca58-7f72a777764mr9145729b3a.15.1765915137200;
        Tue, 16 Dec 2025 11:58:57 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7fcbc0be691sm348016b3a.58.2025.12.16.11.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 11:58:56 -0800 (PST)
Message-ID: <27e4a60100602f769f3c5410a398a75fe0151967.camel@gmail.com>
Subject: Re: [PATCH v8 bpf-next 03/10] libbpf: use kind layout to compute an
 unknown kind size
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Alan Maguire
	 <alan.maguire@oracle.com>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, 	song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, 	kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, 	qmo@kernel.org,
 ihor.solodrai@linux.dev, dwarves@vger.kernel.org, 	bpf@vger.kernel.org,
 ttreyer@meta.com, mykyta.yatsenko5@gmail.com
Date: Tue, 16 Dec 2025 11:58:53 -0800
In-Reply-To: <CAEf4BzYQeiECx9UpDqv6zRjd1EPjw8B44YX3KPGR1Z4dFKi1UA@mail.gmail.com>
References: <20251215091730.1188790-1-alan.maguire@oracle.com>
	 <20251215091730.1188790-4-alan.maguire@oracle.com>
	 <9e1b071598f9c1c1adcac0d8cb2591c452a675fd.camel@gmail.com>
	 <6f3027ee-576d-45de-9795-9a8e620292e9@oracle.com>
	 <CAEf4BzYQeiECx9UpDqv6zRjd1EPjw8B44YX3KPGR1Z4dFKi1UA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-12-16 at 11:42 -0800, Andrii Nakryiko wrote:
> On Tue, Dec 16, 2025 at 7:00=E2=80=AFAM Alan Maguire <alan.maguire@oracle=
.com> wrote:
> >=20
> > On 16/12/2025 06:07, Eduard Zingerman wrote:
> > > On Mon, 2025-12-15 at 09:17 +0000, Alan Maguire wrote:
> > >=20
> > > [...]
> > >=20
> > > > @@ -395,8 +416,7 @@ static int btf_type_size(const struct btf_type =
*t)
> > > >      case BTF_KIND_DECL_TAG:
> > > >              return base_size + sizeof(struct btf_decl_tag);
> > > >      default:
> > > > -            pr_debug("Unsupported BTF_KIND:%u\n", btf_kind(t));
> > > > -            return -EINVAL;
> > > > +            return btf_type_size_unknown(btf, t);
> > > >      }
> > > >  }
> > > >=20
> > >=20
> > > That's a matter of personal preference, of-course, but it seems to me
> > > that using `kind_layouts` table from your next patch for size
> > > computation for all kinds would be a bit more elegant.
> > >=20
> > > Also, a question, should BTF validation check sizes for known kinds
> > > and reject kind layout sections if those sizes differ from expected?
> > >=20
> >=20
> > yeah, I'd say we'd need your second suggestion for the first to be safe=
,
> > and it seems worthwhile doing both I think. Thanks!
>=20
> ... but we will just blindly trust layout for unknown kinds, though?
> So it's a bit inconsistent. I'd say let's keep it simple and don't
> overdo the checking? btf_sanity_check() will validate that all known
> kinds are well-formed, isn't that sufficient to ensure that subsequent
> use of BTF data in libbpf won't crash? If some tool generated a subtly
> invalid layout section which otherwise preserves BTF data
> correctness... I don't know, this seems fine. The goal of sanity
> checking is just to prevent more checks in all different places that
> will subsequently rely on IDs being valid, and stuff like that. If
> layout info is wrong for known kinds, so be it, we are not using that
> information anyways.

Ignoring layout information for known kinds can lead to weird
scenarios: e.g. suppose type size is N, but kind layout specifies that
it is M > N, and the tool generating BTF uses M to actually layout the
binary data. We are being a bit inconsistent with such encoding.
