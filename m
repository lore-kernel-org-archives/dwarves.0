Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CD51B85D2
	for <dwarves@vger.kernel.org>; Tue, 24 Sep 2024 19:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727204569; cv=none; b=aN5Agt6b13panfc1fbrNonXg5m3TL6rZh0deztBq2LCfKqpnkW1iSsAXp9j0/M3Ksnapk1eBsk/p7AhjsIeWymuVmbYg3Z3h/bh8cgoQwAqetitdkrJRuPiOltKBuBHb/x5vAvYb4W+aXKSf8Kn+1kMEQ98Tsb1SbcV+0H/eCBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727204569; c=relaxed/simple;
	bh=WrholbxJFaPGskWAuyb/iZZY/8m9Sx7XqqYZdPglWdo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GN/Z8pQ2JDC/2cEFAYAd4VibP7NKmwBjgsJz67YjyCht4x5tKQBZrJhpCUbvbeJGqrjxh0jX1FUaJnt+j9McDMkFL5tO5BhpoDEFXafwo8Do/+95uI8fz1cLBEGZAGy6cxxipj4Jc995wcVRjqHgekQHZGX0rCqjIN+hkrVA+iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=YrqFNDa2; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="YrqFNDa2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1727204558; x=1727463758;
	bh=WrholbxJFaPGskWAuyb/iZZY/8m9Sx7XqqYZdPglWdo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=YrqFNDa2RLjOWcvucwN3b73YlIP0nn/Skzgec5tojSybt/TjCksw+KBnZ2MbvAocU
	 Uv80Td+WgQP3iZOOyGUytZneGpNuajffPMsxamnaXJ4qwPIFzPMbkd2B6zeagqUXoz
	 9IfYjNGo8I8wJpLP7luLDo5La2Wq9vJKZsA1NgAhRB/lRDn8s8iW5gZzcQO9BISgb8
	 95MXvGP+B3gVj1OEbddKcXYMThPe/ABg5UCGkmbEv6uGWviP4HKv+RFLMpS8qFcN7P
	 5yHgu6V+Cdjd8cVJY/q0r13BxRr0Zr/AGjZHRa8fyBd4F+HoDIXdt+KEcm0urtbIBe
	 wsZ67qv3wQIaw==
Date: Tue, 24 Sep 2024 19:02:32 +0000
To: Alan Maguire <alan.maguire@oracle.com>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: Eduard Zingerman <eddyz87@gmail.com>, acme@kernel.org, dwarves@vger.kernel.org, olsajiri@gmail.com, shung-hsi.yu@suse.com, jirislaby@kernel.org
Subject: Re: [PATCH v2 dwarves 1/3] btf_encoder: record BTF-centric function state instead of DWARF-centric
Message-ID: <aQtEzThpIhRiwQpkgeZepPGr5Mt_zuGfPbxQxZgS6SSoPYoqM1afjDqEmIZkdH3YzvhWmWwqCS_8ZvFTcSZHvpkAeBpLRTAZEmrOhq0svfo=@pm.me>
In-Reply-To: <a78ff51c-059b-45b3-9c81-2c2d5a5b5e9d@oracle.com>
References: <20240916134946.3893204-1-alan.maguire@oracle.com> <20240916134946.3893204-2-alan.maguire@oracle.com> <2be35785218e6df18d3e05ddcaf0406227e05109.camel@gmail.com> <a78ff51c-059b-45b3-9c81-2c2d5a5b5e9d@oracle.com>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 65b1e68a875fdfc8700c56e9729117e763935015
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tuesday, September 24th, 2024 at 7:31 AM, Alan Maguire <alan.maguire@ora=
cle.com> wrote:

[...]
>=20
> On 20/09/2024 20:18, Eduard Zingerman wrote:
>=20
> > [...]
> >=20
> > > @@ -669,18 +692,25 @@ static int32_t btf_encoder__tag_type(struct btf=
_encoder *encoder, uint32_t tag_t
> > > return encoder->type_id_off + tag_type;
> > > }
> > >=20
> > > -static int32_t btf_encoder__add_func_proto(struct btf_encoder *encod=
er, struct ftype *ftype)
> > > +static int32_t btf_encoder__add_func_proto(struct btf_encoder *encod=
er, struct ftype *ftype, struct elf_function *func)
> >=20
> > It is a bit unfortunate that we now have this "doubled" representation
> > and both ftype and elf_function pointers have to be passed through
> > several layers.
> > Ihor (in CC) is now working on having single btf_encoder for each
> > processed CU (in order to be able to sort btf's by CU names before
> > merging to a single BTF for dedup, thus making reproducible builds
> > cheaper). I wonder if this could be further extended to have a
> > separate BTF for functions and merge only consistent functions from
> > this BTF to a final BTF.
>=20
>=20
> If I recall, Arnaldo's work ordered the DWARF CUs to be consistently
> processed to allow for reproducibility. The only danger I see with the
> approach of having a BTF encoder per CU is that currently we create an
> ELF function table per encoder, whereas in reality all CUs are using the
> same ELF. So for this approach to work I think we'd need to share ELF
> representations across encoders where appropriate.

Hi Alan, Arnaldo, Eduard.

Yes, this is exactly the problem I ran into while experimenting last
week. On vmlinux with selftests config, the tables gathered by
btf_encoder__collect_symbols in btf_encoder__new take around 50Mb of
space (as measured by getrusage [1]). And so having a separate copies
of them for each encoder while creating an encoder for each CU is a
non-starter: there are 2k+ of CUs in vmlinux.

Currently this is not a big problem as the number of encoders equals
to a number of worker threads for non-reproducible builds. Although
it's still a couple of hundred megabytes of likely unnecessary memory
usage.

I talked about this with Eduard off-list, and I was going to try
making these tables shared/global, as they are used mostly for search.
The only write operations on these tables that Eduard and I could find
is in btf_encoder__save_func, and it should be easy to add a lock
there, or even use some kind of atomic write.

I think at this point making ELF function/variable tables shared
between BTF encoders is a good optimization by itself.

However, as I understand, Eduard suggests that these tables might be
unnecessary at all, if the way of checking for and merging
inconsistent functions is changed. Eduard, please feel free to correct
me or expand on the idea.

Alan, Arnaldo, what do you think?

[1] https://man7.org/linux/man-pages/man2/getrusage.2.html

>=20
> > [...]


