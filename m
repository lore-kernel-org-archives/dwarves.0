Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E163AEF45
	for <dwarves@vger.kernel.org>; Fri, 27 Feb 2026 23:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772233929; cv=pass; b=hy7lbgHslOkdz8oahYyVaJYZumg7TyBtWU/kuFSHPT8yfSRaGeuWMB3+hnrP3oSa95q45KWAnGQRpO/TZ9zRueYmYr4b7Wk4bilR5vDpLkmJ95lvUzMBDbHivjTAtoeYOE9rn4JBys32ZZuDmPH1qcbSNfeVlRz++Zt5X0k3Nvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772233929; c=relaxed/simple;
	bh=V5qCzTsaOJWbI8bIApMpk9pkO68rB+P9FzJgy77rz7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=riDywcYCfgq3HVoqLrYiLjrua91HbN7xymGSmOW9Ms7wVE6MG98spZlhSvtfdG4YGJ9BxEPXArkpp/7Y+TReArWzslyyY6Q5z3EzMDp3LNORM2Fv43WOaxNEpP1A6GWyc8YU8bxh0M9+c1BrwJr0TMs1hbyuOFQ6tL8DYmRNBO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dkq7OMed; arc=pass smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkq7OMed"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4806cc07ce7so27627645e9.1
        for <dwarves@vger.kernel.org>; Fri, 27 Feb 2026 15:12:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772233927; cv=none;
        d=google.com; s=arc-20240605;
        b=g8qTFoejd+OCvxfieq4erXBlE2qJyAF9/xPDR1VUL8uF5AiaZNYvkLWM0k6/M6crZk
         /GriSupllcWXKEbdg9BgvCEdOg91AV6z8Fbc7MhQz9In4LWFLg4YVhx5hA8hQSQ9Mt2C
         uRRSAPcgE9rTr6rZ9mZF316nndjirGS3TqzlXt+hpZontePYjaQlRWc1VBTViXJngpem
         RjOl9FFec4KtXxXs9YsvE99qGfGE2GGfCfqERmrtpeEHdySTd8Xwn6ssdDloJYICZfJy
         KcBWuyH8tdxNYoL6S23vAkE+PJSpAfKvvEmYXFnNsQ1gvjf/KX+w2kqIzvXZo74z0nAa
         bmVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cfiGTap6WKsl2m5t2cK3AsLCB7wpzSkIUOVFSYi5LCE=;
        fh=AmVXHFD61yGCeLvpxtwbeMErrp3UN1vmi7Ba18cFJog=;
        b=eYHn98SwtO+N0Pd91VDVf3N0SGKnJYVJs9JKaTcQDapuzsRT1c7KFMo72TGeH/2swT
         dZ1Sohs7QUyaLvWKuAqLdLFVw2UopckqoiFYMFTT+U0C1V5DnurICgLCBMBjSUtFV9Yq
         Aqykky5KZsR/dWmnNZGvX0ad/lHsg16Ha+FuJnnfI5lotPdzSL9+aL8MQxvr4IPSJa0G
         yThyCCnov0UwstpS1wOyxJvBIv4hLL4UVQstU10cQnibCLjKUnnUIepRmJLS9APSwb31
         8/YmVyzfBTCOBcDeFF0UesnY8nYkNAAXS3aezxh1SkdZxyPPOE3lY1sPtflXE2xnCh5n
         Iq3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772233927; x=1772838727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cfiGTap6WKsl2m5t2cK3AsLCB7wpzSkIUOVFSYi5LCE=;
        b=dkq7OMedQy//LIJK+gYkjWnwFgfZy6eJgW+ok36WuYjM/Ea1VUoYSSDLbIs7qiNbY0
         UKj1OaBixaUysc+L3MQC/QkeX7LRyO6+wNSlcAI7Z5MgM7NDMSVdW1S7tEbsNbx028I3
         QCRTac/lWoq1ib5KokF0DWNgRsaA7Obz0y32tKkk9kx2Z6DmBtZen1sRMNlmvLdReDdx
         qd/8ffDphR9hE7UeV7IqPGiIEshLqMZeCN20Tq+yU5ZEx719d+xRRmGSLQ6CoPsNKIil
         0Tv+ocFWvkpEnHfNBXbo9M0CQeDTrrusL8QPVYvstCubAMQPCNJiv396oiXoSJWwy26x
         +MGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772233927; x=1772838727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cfiGTap6WKsl2m5t2cK3AsLCB7wpzSkIUOVFSYi5LCE=;
        b=sgnuSSwYTwiXwsPb8z6d3KTwocTHLxoe+SpHBv1e+3HQtbO0DAklRjVdAb7gbN/0Gi
         cWxjkr9iy86VgquzesmdUmqHGj7KlRHhnrmYeH9mSWH1IfKqOGSNp7kJsSZZLvWulIlp
         vynqkXdS5aRwm9M4xgt0EL/NyjxM+9Sc1NL4OCzhV+W3ntzkCSy/SuOsDwIanMvbLotS
         O5mhIgW+rRW0Co1FB+LIoyBvdhpvZmmQrwoZcRQkuCCzCfg3X/0lQN+8Mvy6Ls6gST6E
         yAkyff6yX7ATZH2LNiT5MRmnnczoyd7jNARMGpxWWZjqTF++azXKf0M/iD5qVLGIjnVd
         yMmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcuLoAjYUOyX20T6QXKRIPeGyCoqzO1UYMoaSPlQ/dKvxFqxaryNKUnBvbc7tZAkDajTSGSY5Z@vger.kernel.org
X-Gm-Message-State: AOJu0YxW4gJbRrJl4yAQny8F2af1LlWoo/q9YIDMJW/dRasYn4xRlrKt
	T2MJVVlIoco8zohRTMFR1Fbk9GCkp3L3cg8EoxJPcTfRZrmR56VmXv9ZQo+Ei864XMTavMZO3Xa
	3DdaNP0UqOaG4V+vjdZzLTqIP6QaO2F8=
X-Gm-Gg: ATEYQzzm5wUuAH7FVnPzKXuc/TXDisf6X2i3tWuPVjLc8DMzNOgfPIClVusbTFE++Ig
	f0vCvxDKvoRzncIR56Xb4GPq2oOsyxL7BqP9dxzlQxj+0j9yndZ/8pTEi8SphBYFaGlBFyAH/d9
	J3mrAY63MhZKXhfnFt1FWwAy9bIGu5l2fvGPPNpuudmmRDyIaAhB6WLq3/cwRvjTh+cSR8qHsMx
	oDq11CAcNokDwiPuyInvEO5JFcZ2b1OYL3j9m1Lk9iDQgMaz1kvfRYHOSGOhH6v3FwTcr9XcNMX
	VE/oWfL8B4rUiKDBc4IscnHjk3SmZXQuNKrPKzF32PhGPjShqV3Ss22vUM8hXc3tCEQHIBgWfEV
	LnMyjAZvQh6vNR4/aD1lEtW/Lr35BPJ8JsBz4
X-Received: by 2002:a05:600c:1f91:b0:477:8985:4036 with SMTP id
 5b1f17b1804b1-483c9ba7dffmr77716515e9.1.1772233926427; Fri, 27 Feb 2026
 15:12:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227100426.2585191-1-alan.maguire@oracle.com> <20260227100426.2585191-5-alan.maguire@oracle.com>
In-Reply-To: <20260227100426.2585191-5-alan.maguire@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 27 Feb 2026 15:11:54 -0800
X-Gm-Features: AaiRm51KCOJfLdsYm1FFkILb08m0Ill72NSzmMEkye0mgAEcVQ0oJxnYCifdQqI
Message-ID: <CAADnVQ+xtkQ1hDpwg+RiUaxdwQHZbtW-PjuqTrob3xEVNEY1vQ@mail.gmail.com>
Subject: Re: [PATCH v10 bpf-next 04/10] libbpf: Add layout encoding support
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Quentin Monnet <qmo@kernel.org>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, dwarves <dwarves@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2026 at 2:05=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> Support encoding of BTF layout data via btf__new_empty_opts().
>
> Current supported opts are base_btf and add_layout.
>
> Layout information is maintained in btf.c in the layouts[] array;
> when BTF is created with the add_layout option it represents the
> current view of supported BTF kinds.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tools/lib/bpf/btf.c      | 62 ++++++++++++++++++++++++++++++++++++++--
>  tools/lib/bpf/btf.h      | 20 +++++++++++++
>  tools/lib/bpf/libbpf.map |  1 +
>  3 files changed, 80 insertions(+), 3 deletions(-)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index db13c15a0049..0c7fc0b49f20 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -29,6 +29,35 @@
>
>  static struct btf_type btf_void;
>
> +/* Describe how kinds are laid out; some have a singular element followi=
ng the "struct btf_type",
> + * some have BTF_INFO_VLEN(t->info) elements.  Specify sizes for both.  =
Flags are currently unused.
> + * Kind layout can be optionally added to the BTF representation in a de=
dicated section to
> + * facilitate parsing.  New kinds must be added here.
> + */

Pls use proper kernel comment style in any new code.
