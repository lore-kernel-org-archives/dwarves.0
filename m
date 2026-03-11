Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC323E7147
	for <dwarves@vger.kernel.org>; Wed, 11 Mar 2026 18:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773252994; cv=pass; b=i4bNqpl9P9Zsa9bPpSTT36ehzXW7ghHpu1zM42wsPiM8fFwnnsInSnNR76KWA9MHwbHYYWktobNJ+SqBcmGvAEuDK3gRU5SmBUfbeIhNDWF5LqLuz3rpAx5QLC0/iylCHBMqjY2OLtWvphmA+unkGmtPSFADI3x336RGBIZqyyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773252994; c=relaxed/simple;
	bh=v721buQXWScEiaXqHXI3JT2zcbjQc4Gfo8mCNU9j1Uk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dkW3N07URFCC2St+eXd9BX+nH0+C1f6OZNPCBlc8S+Mt816woYnvMz+4DJ8YeKXmWchl2+pHmq0AN0aQJ/0vRtf5/1EChRO0LUxrfPZe18ZFtQlwHalCQ1IplcdiwIFw2aa8WgupnkZnGEWAQku7ve/o0PH9urLNSklcUjcMHIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G8aYreAZ; arc=pass smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8aYreAZ"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c738fecf349so504565a12.0
        for <dwarves@vger.kernel.org>; Wed, 11 Mar 2026 11:16:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773252991; cv=none;
        d=google.com; s=arc-20240605;
        b=OKuOo6aL8XZzdYQ3R7T/hEQ/BPMuORT/Q0Cbc4goyjGsDZ6h+SlRmar167uj7RoeCe
         TYHsTzvcsNDRZi4+NCSPJPQgffz5Bs+0ewOlxsBzHhPMYS1kyPQwy8jSU4uFMNGAOEqr
         6HIlcoVmHMJvCqvNP3UoptJk212RbTWYIel6R7jJyKHqQb1OiAmEY8dn+iFnB2VdKuC6
         C3LnQJDjqcE8j0UPFbjfauuibG5XVYePp0OxjQR0I5769oUpOGHXBIAkKjyGlc3r5xcy
         VU81/4lkx6nZlsXaztLQrmgos4sOOtvtdfa4VZBTaWjbfamxJACJfFy2iUroPdSW/0iM
         YWRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rkLIZH9/W21TFY+KxjMBI5W7jWpQrcpS5BGZj1HFBDA=;
        fh=nDegrE+sSkOn7iGBgKSApAghJpdyYXzS2sBqyDKkt7o=;
        b=A3IH/v3qjAEut/t4XS4BXwWqCPYj0vAt/nDWjturXq5hCIGoU9DAXyZ/ECLG8z0qoR
         OqfaKBtK08O+CqbcOaHgKu5t/5tiDXE3qFXHX9j8AWo7p5uehOnolnxLqC7zVxofQHnx
         CSDI3Xcjh8P76y4RUCNdqiS995e4WUaCy66dFHR+HQlLo4H2vHo2n+CWS9J4+Gao7n9v
         MqsLWrLioShBwdPMWSSH2XK/qoXEndHX5/oFatERA3Ot1gmtD/Yi4GLjbENS/rTRdv8l
         NxX6jWALbqBXOdckfyG4ZGngR6aZgiK54Qgr75+1hz6lKUkrFLQiQyCTEZZZdkRuuWQA
         kEew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773252991; x=1773857791; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rkLIZH9/W21TFY+KxjMBI5W7jWpQrcpS5BGZj1HFBDA=;
        b=G8aYreAZ+snF0n+z2JdRxaYTRpVfLx851rFVao9HMW5uHfkdrQpYMmzOawqn3sn36z
         FGD8ea35hqJS2phbAoG+5NggXjQl/5gpyNvmbpjkow48C5/XK7a7Og2O1EZVtGTniQio
         s4X7hEU4nSlIFRYyEVrD4AJzvnsXahyu/kfZVRD/r6g10mCWhXc/eEziFRldcyyrHgES
         qnIfax4PdiV9x7FI3SAQZ9v8rtxpu2aob81l2+f5ENT3ZvI11H7tgOPmi0ga8SHDIRIb
         Yt/yP0irFL6K2IFXe/dq5x8aHrm6EtGMvn83Kr0FcESLyEhbmqbXUdj9DH6OuQ7U7Xqj
         qkWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773252991; x=1773857791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rkLIZH9/W21TFY+KxjMBI5W7jWpQrcpS5BGZj1HFBDA=;
        b=fZBmpnCQjqWRoT5hrRKIy9Ro5/pPoHNaEn0TJF83DYr1V1owIr4sEBia/8eYPGRokn
         WkEc5y1KyKJ4Nr3kMJnJ7omfu5p9vMo/wjn8Ii2uaRPLEgp6xRzOSY1vbw7AwiR2ZoyQ
         WrWIRbh6Sz6fgrfZWdZP83CGkqIyvWPVlUisDy0p/BJyhtnWi+xNeUdpK+8xOt92pHw7
         7eYW/AL+cEpPbFR78xPlb8plheHGxG8dgOSAPmcIev0cK/gGhb2O2Musdsl9lxg85HMl
         w1wycQEk0yjpFRZEhIjY15EPizZsWouCpWj63OwAfyBgl4omO2i94Cf/bMc+2qP8IO5v
         v8Ig==
X-Forwarded-Encrypted: i=1; AJvYcCV+iaH+rrORo++KHXNCdrU4g7fhfi6DiVIuv+XcWdvMegrkuJaxqRx3NbY/hn1xjksNbPS1M3c4@vger.kernel.org
X-Gm-Message-State: AOJu0YxVmsKfoRYnZthsPAPAhEPEsCy3oNqohbuQq9rSM2MY+Q3twVmC
	FEzubUB0IzAaqlxzJ1sdhwj1n/p0VA5p1CKR+jk+VT9C/aRbMLhi8yWmWYukuS1/JnsTx8h5luS
	IOYsm5vlMe0YMZbMDM8w39P6YaDj043o=
X-Gm-Gg: ATEYQzzEaVattkLFZ9ChRoQfxJISSGUrzrFL8rVW6H3T89lArVv+X3GpTTbKPp6Zs7F
	0emnGlzJSz0y6Bs6U997nCSlg54g3su6ZryQjuLFHSoxhuEMhz3UGNxBJatO2L9IYJLnNlaLSlf
	mCbpJae4yZNMzhb3Yzoshv5fLYrhZMaiB7ih2rDQYUVY+2pp4VZR2S2vX5FnvJVn2DEhj6a96gD
	TuyaY/zDpKx/hlizrPbiGSi+jKiYXZ/O/nKhiqgNqzRP5CPzKVdSrUViwRw+CRjDK6amxc+X9Ev
	VHkZkzs=
X-Received: by 2002:a17:902:d54e:b0:2ae:4ad5:b76c with SMTP id
 d9443c01a7336-2aeba4753c8mr4403515ad.10.1773252991222; Wed, 11 Mar 2026
 11:16:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306113630.1281527-1-alan.maguire@oracle.com>
 <20260306113630.1281527-3-alan.maguire@oracle.com> <CAEf4Bza_kJowGmin4Hh2iOpwXZVgNoeGNniidSpZEjRjqWnVyA@mail.gmail.com>
 <128e9cac-c935-49ef-98df-30f3b6cd7822@oracle.com>
In-Reply-To: <128e9cac-c935-49ef-98df-30f3b6cd7822@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 11 Mar 2026 11:16:18 -0700
X-Gm-Features: AaiRm53ugynNFDPuMYw-OIyz79aaybCfAwXypomT0BqpvKOno3TFHWMQoe6x_1o
Message-ID: <CAEf4BzZefR6qQwu1jENEMg15UCXXnfqfwHYRV5y4NAXWwuo4zw@mail.gmail.com>
Subject: Re: [PATCH v13 bpf-next 2/8] libbpf: Support layout section handling
 in BTF
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, qmo@kernel.org, 
	ihor.solodrai@linux.dev, mykyta.yatsenko5@gmail.com, dwarves@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 11:10=E2=80=AFAM Alan Maguire <alan.maguire@oracle.=
com> wrote:
>
> On 11/03/2026 17:46, Andrii Nakryiko wrote:
> > On Fri, Mar 6, 2026 at 3:37=E2=80=AFAM Alan Maguire <alan.maguire@oracl=
e.com> wrote:
> >>
> >> Support reading in layout fixing endian issues on reading;
> >> also support writing layout section to raw BTF object.
> >> There is not yet an API to populate the layout with meaningful
> >> information.
> >>
> >> As part of this, we need to consider multiple valid BTF header
> >> sizes; the original or the layout-extended headers.
> >> So to support this, the "struct btf" representation is modified
> >> to contain a "struct btf_header" and we copy the valid
> >> portion from the raw data to it; this means we can always safely
> >> check fields like btf->hdr.layout_len
> >>
> >> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> >> ---
> >>  tools/lib/bpf/btf.c | 309 ++++++++++++++++++++++++++++---------------=
-
> >>  1 file changed, 200 insertions(+), 109 deletions(-)
> >>
> >
> > [...]
> >
> >>
> >> -       memcpy(p, hdr, hdr->hdr_len);
> >> +       memcpy(p, hdr, min((__u32)sizeof(struct btf_header), hdr->hdr_=
len));
> >
> > in all these cases where we have sizeof(struct btf_header), this
> > smells like a potential issue, tbh. We are silently truncating the
> > original header here, potentially. Which is ok for read-only case, but
> > do we error out if someone is trying to modify/write such BTF where we
> > don't really understand all of it? Should we?
> >
>
> The kernel enforces that any additional data in the header beyond fields
> we know how to deal with is zero. We don't enforce this here, but we
> get a similar effect since we only copy the fields we care about. In effe=
ct
> we wind up removing the aspects of the BTF we don't know about, so if we
> read in such BTF, writing it out would not preserve any additional header
> information (say a new section offset/length) beyond the current size of
> struct btf_header. So writing such BTF after reading it in converts it to
> the BTF representation libbpf knows about (header fields + sections).

I don't think we should be doing this. Let's error out when someone
tries to modify BTF where we don't understand *all* aspects of it.

And also you hinted at another missing part: BTF layout info
"sanitization". Check bpf_object__sanitize_btf(), I think that one has
to drop layout information if kernel doesn't support it (unless kernel
will ignore layout info).

Either way, can you please manually check that BPF object having BTF
with kind layout can be successfully loaded on old kernel that doesn't
yet know about BTF layout?

>
> That seems ok to me, but I guess the user might want to at least know thi=
s
> was happening; would a warning or similar when encountering additional
> non-zero fields be helpful maybe?
>
>
>
> >>         if (swap_endian)
> >> -               btf_bswap_hdr(p);
> >> +               btf_bswap_hdr(p, hdr->hdr_len);
> >>         p +=3D hdr->hdr_len;
> >>
> >>         memcpy(p, btf->types_data, hdr->type_len);
> >
> > [..]
>
