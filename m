Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEE314A82
	for <dwarves@vger.kernel.org>; Tue, 11 Feb 2025 00:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739232684; cv=none; b=pSVTznYMrTHxWARHCjbgpZaDLGCy4pR2kPm/Wp50F+/A6WcqtqsaUcrbfVbuS6xgkUoFf4O/vEUs4e/YP+R0rEeOT6CDFsSvYbsQPq/eXPq7zYF/6A/hwX2mEU4hpahrZ3KmE66dryJl6MZMFGLDv6SrS8oqiuPEobquQ81Z/i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739232684; c=relaxed/simple;
	bh=zwLzHCcwqz8/HxUAdZg0S41Jd6OTpDyTTMBxXXBmjCk=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=AmysJ5PeCIUg5mJNWwHnOsXh4Y9GbuZUE72214nKG7Cmd4Yb7FkwPK5fHUT1pe4SSXLQkRSItMBo9UxR1x+0jtoWfzYjVOWqPtn58vJva9FBZ09erD4EKsDj0SJbNGAA4idFgsmmHQ2Ww2hzHBaiwZAkPt5BTqhiLcBwuemniEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xfF0AZzQ; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xfF0AZzQ"
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739232680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OolEkZ/FdPUJ9j0mb0T7tBplyl7y+5t/7HL9VsccyGA=;
	b=xfF0AZzQJzREIFJcdJMof3kFvC4+2XUs6IjnkeL9XLG6WLQwXyIGLCFHUz0FVS84j5AFlw
	xUUD/FAbw2M26gr9C50ndMYby5K7OvZdxyXH2Q5SS5SiNpP0P2Wu86R0dLgzelURyQ4Bc5
	jIjTMwugzsFrFm5qaJe6IdCcWj3jYcw=
Date: Tue, 11 Feb 2025 00:11:15 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Message-ID: <a78e27341fbc150d767589f6dddbf932e91dc41c@linux.dev>
TLS-Required: No
Subject: Re: [PATCH dwarves 2/3] btf_encoder: emit type tags for bpf_arena
 pointers
To: "Alan Maguire" <alan.maguire@oracle.com>, dwarves@vger.kernel.org,
 bpf@vger.kernel.org
Cc: acme@kernel.org, ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com,
 mykolal@fb.com, kernel-team@meta.com
In-Reply-To: <f2b54a36-cea3-4729-bc5b-8524a5be50fa@oracle.com>
References: <20250207021442.155703-1-ihor.solodrai@linux.dev>
 <20250207021442.155703-3-ihor.solodrai@linux.dev>
 <f2b54a36-cea3-4729-bc5b-8524a5be50fa@oracle.com>
X-Migadu-Flow: FLOW_OUT

On 2/10/25 2:11 PM, Alan Maguire wrote:
> On 07/02/2025 02:14, Ihor Solodrai wrote:
>> When adding a kfunc prototype to BTF, check for the flags indicating
>> bpf_arena pointers and emit a type tag encoding
>> __attribute__((address_space(1))) for them. This also requires
>> updating BTF type ids in the btf_encoder_func_state, which is done as
>> a side effect in the tagging functions.
>>
>> This feature depends on recent update in libbpf, supporting arbitrarty
>> attribute encoding [1].
>>
>> [1] https://lore.kernel.org/bpf/20250130201239.1429648-1-ihor.solodrai=
@linux.dev/
>>
>> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
>
> a few minor issues below, but
>
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
>
>> ---
>>  btf_encoder.c | 97 ++++++++++++++++++++++++++++++++++++++++++++++++++=
-
>>  1 file changed, 96 insertions(+), 1 deletion(-)
>>
>> diff --git a/btf_encoder.c b/btf_encoder.c
>> index e9f4baf..d7837c2 100644
>> --- a/btf_encoder.c
>> +++ b/btf_encoder.c
>> @@ -40,7 +40,13 @@
>>  #define BTF_SET8_KFUNCS		(1 << 0)
>>  #define BTF_KFUNC_TYPE_TAG	"bpf_kfunc"
>>  #define BTF_FASTCALL_TAG       "bpf_fastcall"
>> -#define KF_FASTCALL            (1 << 12)
>> +#define BPF_ARENA_ATTR         "address_space(1)"
>> +
>> +/* kfunc flags, see include/linux/btf.h in the kernel source */
>> +#define KF_FASTCALL   (1 << 12)
>> +#define KF_ARENA_RET  (1 << 13)
>> +#define KF_ARENA_ARG1 (1 << 14)
>> +#define KF_ARENA_ARG2 (1 << 15)
>>=20=20
>>=20 struct btf_id_and_flag {
>>  	uint32_t id;
>> @@ -743,6 +749,91 @@ static int32_t btf_encoder__tag_type(struct btf_e=
ncoder *encoder, uint32_t tag_t
>>  	return encoder->type_id_off + tag_type;
>>  }
>>=20=20
>>=20+static inline struct kfunc_info* btf_encoder__kfunc_by_name(struct =
btf_encoder *encoder, const char *name) {
>> +	struct kfunc_info *kfunc;
>> +
>> +	list_for_each_entry(kfunc, &encoder->kfuncs, node) {
>> +		if (strcmp(kfunc->name, name) =3D=3D 0)
>> +			return kfunc;
>> +	}
>> +	return NULL;
>> +}
>> +
>
> above function is only used within #if statement below, right? Should
> probably move it there to avoid warnings.

Right. I think some of these functions may go away, given Eduard's
suggestions.

>
>> +#if LIBBPF_MAJOR_VERSION >=3D 1 && LIBBPF_MINOR_VERSION >=3D 6
>> +static int btf_encoder__tag_bpf_arena_ptr(struct btf *btf, int ptr_id=
)
>> +{
>> +	const struct btf_type *ptr;
>> +	int tagged_type_id;
>> +
>> +	ptr =3D btf__type_by_id(btf, ptr_id);
>> +	if (!btf_is_ptr(ptr))
>> +		return -EINVAL;
>> +
>> +	tagged_type_id =3D btf__add_type_attr(btf, BPF_ARENA_ATTR, ptr->type=
);
>> +	if (tagged_type_id < 0)
>> +		return tagged_type_id;
>> +
>> +	return btf__add_ptr(btf, tagged_type_id);
>> +}
>> +
>> +static int btf_encoder__tag_bpf_arena_arg(struct btf *btf, struct btf=
_encoder_func_state *state, int idx)
>> +{
>> +	int id;
>> +
>> +	if (state->nr_parms <=3D idx)
>> +		return -EINVAL;
>> +
>> +	id =3D btf_encoder__tag_bpf_arena_ptr(btf, state->parms[idx].type_id=
);
>> +	if (id < 0) {
>> +		btf__log_err(btf, BTF_KIND_TYPE_TAG, BPF_ARENA_ATTR, true, id,
>> +			"Error adding BPF_ARENA_ATTR for an argument of kfunc '%s'", state=
->elf->name);
>
> nit: since we call this for arguments + return value, should we reflect
> that in the function name/error message? maybe pass in the KF_ARENA_*
> flag or something?

It is what's happening. btf_encoder__tag_bpf_arena_ptr is called from
btf_encoder__tag_bpf_arena_arg and separately for a return type:

	if (KF_ARENA_RET & kfunc->flags) {
		ret_type_id =3D btf_encoder__tag_bpf_arena_ptr(encoder->btf, state->ret=
_type_id);

In both cases the return value is checked and the error message is
different.

I factored out *_arg version of this operation because it has to be
done twice: for _ARG1 and _ARG2.

Maybe I misunderstood you question? lmk

>
>> +		return id;
>> +	}
>> +	state->parms[idx].type_id =3D id;
>> +
>> +	return id;
>> +}
>> +
>> +static int btf_encoder__add_bpf_arena_type_tags(struct btf_encoder *e=
ncoder, struct btf_encoder_func_state *state)
>> +{
>> +	struct kfunc_info *kfunc =3D NULL;
>> +	int ret_type_id;
>> +	int err =3D 0;
>> +
>> +	if (!state || !state->elf || !state->elf->kfunc)
>> +		goto out;
>> +
>> +	kfunc =3D btf_encoder__kfunc_by_name(encoder, state->elf->name);
>> +	if (!kfunc)
>> +		goto out;
>> +
>> +	if (KF_ARENA_RET & kfunc->flags) {
>> +		ret_type_id =3D btf_encoder__tag_bpf_arena_ptr(encoder->btf, state-=
>ret_type_id);
>> +		if (ret_type_id < 0) {
>> +			btf__log_err(encoder->btf, BTF_KIND_TYPE_TAG, BPF_ARENA_ATTR, true=
, ret_type_id,
>> +				"Error adding BPF_ARENA_ATTR for return type of kfunc '%s'", stat=
e->elf->name);
>> +			err =3D ret_type_id;
>> +			goto out;
>> +		}
>> +		state->ret_type_id =3D ret_type_id;
>> +	}
>> +
>> +	if (KF_ARENA_ARG1 & kfunc->flags) {
>> +		err =3D btf_encoder__tag_bpf_arena_arg(encoder->btf, state, 0);
>> +		if (err < 0)
>> +			goto out;
>> +	}
>> +
>> +	if (KF_ARENA_ARG2 & kfunc->flags) {
>> +		err =3D btf_encoder__tag_bpf_arena_arg(encoder->btf, state, 1);
>> +		if (err < 0)
>> +			goto out;
>> +	}
>> +out:
>> +	return err;
>
> not sure we need goto outs here; there are no resources to free etc so
> we can just return err/return 0 where appropriate.

ack

>
>> +}
>> +#endif // LIBBPF_MAJOR_VERSION >=3D 1 && LIBBPF_MINOR_VERSION >=3D 6
>> +
>>  static int32_t btf_encoder__add_func_proto(struct btf_encoder *encode=
r, struct ftype *ftype,
>>  					   struct btf_encoder_func_state *state)
>>  {
>> @@ -762,6 +853,10 @@ static int32_t btf_encoder__add_func_proto(struct=
 btf_encoder *encoder, struct f
>>  		nr_params =3D ftype->nr_parms + (ftype->unspec_parms ? 1 : 0);
>>  		type_id =3D btf_encoder__tag_type(encoder, ftype->tag.type);
>>  	} else if (state) {
>> +#if LIBBPF_MAJOR_VERSION >=3D 1 && LIBBPF_MINOR_VERSION >=3D 6
>> +		if (btf_encoder__add_bpf_arena_type_tags(encoder, state) < 0)
>
> kind of a nit I guess, but I think it might be clearer to make explicit
> the work we only have to do for kfuncs, i.e.
>
> 		if (state->elf && state->elf->kfunc) {
> 			/* do kfunc-specific work like arena ptr tag */
>
> 		}
>
> I know the function has checks for this internally but I think it makes
> it a bit clearer that it's only needed for a small subset of functions,
> what do you think?

Actually I did write it like that first. IIRC tagging has to be done
before `type_id =3D state->ret_type_id;` and only when `state` is
passed.

Anyways, I agree it should be clearer that this happens just for some
functions.

>
>
>> +			return -1;
>> +#endif
>>  		encoder =3D state->encoder;
>>  		btf =3D state->encoder->btf;
>>  		nr_params =3D state->nr_parms;
