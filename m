Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E2135C19D
	for <dwarves@vger.kernel.org>; Mon, 16 Mar 2026 21:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773696206; cv=pass; b=affvJr1Kld6PGXLKhaTI24YBSu/KTqv4wrKPaiskn9g2Cxj3auym6iazHbY+kQEY/jNWZ42bDxyEE2jk4hbJ2T/wHnfVPgDbOtMkSu9UMHngwRQQW3b+5tthzBFpMk4OZUocBKFK0gufux7tTPP3vyEq89yfZ2NVN3EzntiXJuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773696206; c=relaxed/simple;
	bh=/8sIoW4MjsdYYnujR5VehRV1+h4N8zwWl5eyao4AHJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QPJ9N+vhVLFQsnQS5LfLVXRFwFy8aL+Q4mqxL4M4ZHoVk4m2wHQ886CoYMSGbb29c2KQEi7hrkeg2Yd+ejy4+OICin528lq2d2KJd0+zK2pJ/BEZSDT80funK4nNb8g5ptYoBWtpsRRFwDzVVZxDAB1RC8smhcnuBUx9SI8muqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ceo688Z8; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ceo688Z8"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b94358796a1so724375066b.2
        for <dwarves@vger.kernel.org>; Mon, 16 Mar 2026 14:23:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773696204; cv=none;
        d=google.com; s=arc-20240605;
        b=BUixYl53rsYccFn0ayu9IlgAYswaPFIp0DX+W7hHrO0KheoElByozjq+aTvVuccSRc
         QQWPwj44sP3eFsE+IT8QyifmRFtLpZu4ldfHr4bOdUiVHq9DAa4F58xdRoeirL9NrYGf
         7iqxevBgng9Q2iJDV2R0o0xl6WWdl3YYKRCZB3LKvXjmM5MSbBj9/o7ReXK++5XgwIcA
         vh3xV8UgRInMcFeHBpqVQLg5dlAa22Gubvh17HbsoG96+5Z1sBpYGX3WBYqJjZGU/3FJ
         kXG+j6dx71io0owPvdm2qo2UkfZC5jb1qfN0gdbj/SQn7wPTkFHdVAHoIJq6L7lLpv6A
         Yvfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RtshWmELDHLhHkvCZQKJ0YpTfAaXFcKMwe324rRtIfM=;
        fh=WkJ4kZhBIOisPvnaXfFAuG0j5iBixiyOkKBeHUw2SjA=;
        b=Jl5Ut5D6nQuQYo5GaPKiadKz7RTqVlR1OpmNR4b3Wg+izglD08QJEAPHAzayohmY72
         mFAMS4xf+L10Bif6XpmqH7gkHXA/Gkjlogg6smrFFzJroedtmvAa1YVDZj2iRhjKQKej
         WLGeOZYq+bM7GKItZunFX74+1hwWCG1zxRotsQYSy0E1UIEokC62OhabxwN+B0KxgGRe
         zDUWarrcde0xI0NagZ2339JNZBHqN0g6j6yXUzlIfhjHR43R9vEOAjHPKS4JHEijUhwx
         ejjMdazaYPxoX8QlRygebA+iV8osUxVJUYsGmAtyzYjTcUxNayuwoIZwiZC5wv9YtlvW
         EB3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773696204; x=1774301004; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RtshWmELDHLhHkvCZQKJ0YpTfAaXFcKMwe324rRtIfM=;
        b=Ceo688Z8jsQHqGSh1+quQ48ESGgte0FikUV8TtZ5H3tFRqnzwFgyADjtyRJZ2XPZu6
         1XmPWC/qwcTLgO5lvPlp8aafIHPjqXObA42u3j5hysU5FDZMUceq3T76+VDYcE1MxqkA
         E9zg/uz6XPNVciNhmp1AO5EHWb1dB++3lnXZuWZUklEVmiUw5t8xSd6bCri9zcCht/dJ
         4MUYLGve53XRm1pqcTrteEOhuCNhGk/iOgV/+EC9fwuS1nk6vacEGxSpowTV3iq8B6G9
         BtXlgU8Ecn38nYgjV4mCjRbPbbnyLc+NdiSFBlI54jjtjyJrpz3judMJC1S/uVqmTtB0
         UN2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773696204; x=1774301004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RtshWmELDHLhHkvCZQKJ0YpTfAaXFcKMwe324rRtIfM=;
        b=Mh6eJV7osH2NTZqlfV50H483kLwjPoE9Y5Ab8zB4wcSO8YqEe3ydhhl/FJbN8HxSU0
         vLpCJsxeHsqPxGuqOtFGWtVdJJtPzaqliUpF6nl6cUlq3JzNX6qJH8QN7iSQVRB3KR47
         5qresFledTmm2uJoaOPOITr9SEkWnAqKfgEVhaFASke0cE2pM2a2X3U0Guqmh4yjEkpV
         glYsoDV8zivN65z3NX0Ktxl84kPAfsMEsYqLEHwe6fsnqYnj8AaEbpJ4f1Gw0ECXOMXx
         o8rjsLx1CkFYSxBAhq6/YpolSQB7JU0VudAt+tMresqe4Wt8MV90JQNP+aVLI2AQKMpy
         T31g==
X-Forwarded-Encrypted: i=1; AJvYcCW1jr3ff99jgRDLZsM8gtb5ix+LLDZlkXHHUPcZkLwSEVi+HhA517PoFPCroGU6/4uCjq2IekB3@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ+UvTRimOBixV/kAkPGnq7Fej8ul6sj5vErTncGJbWnat5cvE
	gKISsWXDJqTCpyyhIHHaxud5NGV6F1DickNf7bcLkDybhG75cqrOIbPoy/2zeLJdQjyJmfGrZvG
	9l9w4klPm8bcG7DqUq9wyCyVQQ/Gcdag=
X-Gm-Gg: ATEYQzxRhI8l9Zm0w6jRxUQI3cgQgxsl9FHOEVPpjpaqE/CvBis/rFPM2COzgoLlZvz
	Sihzof3iJ/2cplzqUl7SH7z3kw0/3/o30P1te5g+HEJJpeRHo9Xf6Ga3mWoz3sxmh2ciPmNJa5I
	32MER/ozSC+kWXTftFxTkjisd4ugs4kSSnwS9VoXWoQ4R8OMmYW8+necAoEcroJqyDEzCE7HMg6
	FHPE0QT0TtBw6YpZT6TgRArIuo6Cam7lQ5TCtf/XagK49em7OHvRWT6AmDZVW3VNQ4Vx+NmiK1f
	06cYpu60ESS3gHS6Ml1ukx4BJTBDHEE=
X-Received: by 2002:a17:906:68d:b0:b94:2ca0:3bfc with SMTP id
 a640c23a62f3a-b9765376548mr751806766b.47.1773696203274; Mon, 16 Mar 2026
 14:23:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306113630.1281527-1-alan.maguire@oracle.com>
 <20260306113630.1281527-3-alan.maguire@oracle.com> <CAEf4Bza_kJowGmin4Hh2iOpwXZVgNoeGNniidSpZEjRjqWnVyA@mail.gmail.com>
 <128e9cac-c935-49ef-98df-30f3b6cd7822@oracle.com> <CAEf4BzZefR6qQwu1jENEMg15UCXXnfqfwHYRV5y4NAXWwuo4zw@mail.gmail.com>
 <50f76d21-ff5c-471d-bb11-208925778d32@oracle.com> <CAEf4BzatOXf0YgtQj0X+kQ=NSo_rFLAjQ0BHf-ZegFm+t43J3A@mail.gmail.com>
 <8294fca1-4d11-4c91-914a-c83d12f00ecc@oracle.com> <CAEf4BzbNQhga9bQuj73yE3Eg0KDuntsr-EqNOLCjSz+9GgY6Sg@mail.gmail.com>
 <0f3acfd2-4dc8-4059-bc08-aa1ec90b04cc@oracle.com>
In-Reply-To: <0f3acfd2-4dc8-4059-bc08-aa1ec90b04cc@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 16 Mar 2026 14:23:04 -0700
X-Gm-Features: AaiRm52163ROjK-hsL3aQfhsZuqARVFzNgSpxWz2OOroQNRyS0WuEewPYaLp5G0
Message-ID: <CAEf4BzZqJztLD9spavE_+xJ0k5QpJV7s=bvGJAz5+6x3X1L=XA@mail.gmail.com>
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

On Fri, Mar 13, 2026 at 1:15=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> On 11/03/2026 23:37, Andrii Nakryiko wrote:
> > On Wed, Mar 11, 2026 at 12:35=E2=80=AFPM Alan Maguire <alan.maguire@ora=
cle.com> wrote:
> >>
> >> On 11/03/2026 19:21, Andrii Nakryiko wrote:
> >>> On Wed, Mar 11, 2026 at 12:17=E2=80=AFPM Alan Maguire <alan.maguire@o=
racle.com> wrote:
> >>>>
> >>>> On 11/03/2026 18:16, Andrii Nakryiko wrote:
> >>>>> On Wed, Mar 11, 2026 at 11:10=E2=80=AFAM Alan Maguire <alan.maguire=
@oracle.com> wrote:
> >>>>>>
> >>>>>> On 11/03/2026 17:46, Andrii Nakryiko wrote:
> >>>>>>> On Fri, Mar 6, 2026 at 3:37=E2=80=AFAM Alan Maguire <alan.maguire=
@oracle.com> wrote:
> >>>>>>>>
> >>>>>>>> Support reading in layout fixing endian issues on reading;
> >>>>>>>> also support writing layout section to raw BTF object.
> >>>>>>>> There is not yet an API to populate the layout with meaningful
> >>>>>>>> information.
> >>>>>>>>
> >>>>>>>> As part of this, we need to consider multiple valid BTF header
> >>>>>>>> sizes; the original or the layout-extended headers.
> >>>>>>>> So to support this, the "struct btf" representation is modified
> >>>>>>>> to contain a "struct btf_header" and we copy the valid
> >>>>>>>> portion from the raw data to it; this means we can always safely
> >>>>>>>> check fields like btf->hdr.layout_len
> >>>>>>>>
> >>>>>>>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> >>>>>>>> ---
> >>>>>>>>  tools/lib/bpf/btf.c | 309 ++++++++++++++++++++++++++++---------=
-------
> >>>>>>>>  1 file changed, 200 insertions(+), 109 deletions(-)
> >>>>>>>>
> >>>>>>>
> >>>>>>> [...]
> >>>>>>>
> >>>>>>>>
> >>>>>>>> -       memcpy(p, hdr, hdr->hdr_len);
> >>>>>>>> +       memcpy(p, hdr, min((__u32)sizeof(struct btf_header), hdr=
->hdr_len));
> >>>>>>>
> >>>>>>> in all these cases where we have sizeof(struct btf_header), this
> >>>>>>> smells like a potential issue, tbh. We are silently truncating th=
e
> >>>>>>> original header here, potentially. Which is ok for read-only case=
, but
> >>>>>>> do we error out if someone is trying to modify/write such BTF whe=
re we
> >>>>>>> don't really understand all of it? Should we?
> >>>>>>>
> >>>>>>
> >>>>>> The kernel enforces that any additional data in the header beyond =
fields
> >>>>>> we know how to deal with is zero. We don't enforce this here, but =
we
> >>>>>> get a similar effect since we only copy the fields we care about. =
In effect
> >>>>>> we wind up removing the aspects of the BTF we don't know about, so=
 if we
> >>>>>> read in such BTF, writing it out would not preserve any additional=
 header
> >>>>>> information (say a new section offset/length) beyond the current s=
ize of
> >>>>>> struct btf_header. So writing such BTF after reading it in convert=
s it to
> >>>>>> the BTF representation libbpf knows about (header fields + section=
s).
> >>>>>
> >>>>> I don't think we should be doing this. Let's error out when someone
> >>>>> tries to modify BTF where we don't understand *all* aspects of it.
> >>>>>
> >>>>
> >>>> ok, so to do this I think we'd need to set a never_modifiable flag o=
r similar
> >>>> on parsing when we find non-zero unknown header data, and then fail
> >>>> btf_ensure_modifiable().
> >>>
> >>> yep, I'd like some better name that would mean "there are extra btf
> >>> bits we don't understand", but I can't come up with a better name :)
> >>> if you can, prefer that over not very semantically meaningful "never
> >>> modifiable"
> >>>
> >>
> >> would btf->unknown_hdr_data work?
> >
> > what about btf->has_hdr_extra ?
> >>
> >
>
> Perfect. BTW I've been exploring an approach to do libbpf sanitization co=
de testing
> on upstream kernels. The idea is we make kernel_supports() __weak in libb=
pf so that
> tests can override it to simulate old kernels lacking features using test=
_progs
> own version of kernel_supports() in btf_helpers.c. Tests set a thread-spe=
cific key
> (so no parallel test interference) if they want to override behaviour, ot=
herwise
> we call the real kernel_supports() in libbpf. Would give us some extra te=
st coverage
> around sanitization (and potentially other areas which check kernel suppo=
rt) since
> we'll have more to do in that area for inlines. What do you think? I can =
separate it
> from the current series if it seems useful.

ok, that seems contained enough. Just __weak on kernel_supports()
doesn't seem like a big deal to me
