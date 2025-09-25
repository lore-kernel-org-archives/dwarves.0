Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED0C30C605
	for <dwarves@vger.kernel.org>; Thu, 25 Sep 2025 17:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758821015; cv=none; b=W2BpX7Nj/+AYlFmxDlAxfR5wlWO8hltLf8shGpMmnIjdm0AqEnBViiNJVCO6C2iuKSXrmjGYfvF5T3DcPiu8fryydopMV7n3fcSMkFF2y4mDXq5cj8xHqp5IogtAlCzNE4cYlz4mGmz2ekYzj0GNPcIsM8cbOMeGnUZ3X5xhQnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758821015; c=relaxed/simple;
	bh=AhXvAAkIXgTjpuDsrmYR5nA+Ez9WgoB6ZuPdJix6JYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nEd5Q4mFjTwDWIruZ2c5TTDxv1nOrAnrQDIH1yn8jfHDHi31IQR7k8lO+5fU1mx5uR18TsXwnLLGqy6lFK4DlCuXZMT5c4WugqhVuKVNDDUhiAnRduZRwiwbQbSO7v7CUftlaorBKOjoRB33ZdXiqzT+iY4AuKqWX8DjXIR3ZZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J8RV10dc; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8RV10dc"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3324523dfb2so1150610a91.0
        for <dwarves@vger.kernel.org>; Thu, 25 Sep 2025 10:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758821012; x=1759425812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jnexyCErLKcy5WawRVuhv+j/25Jkh/N/xDZ4CJ0zkpA=;
        b=J8RV10dcyERrbu30/6V52DOnIk4bnGnwhExoUvdyu3OsLwbVE89wA9r4VXORPxuOg3
         W0F2g0L8jMN6CfD4ney90Xsk31LNHLVY719Oa86U7thksVSjeJY/7Qn3Cj7boS+H0vEw
         jw7gCrbn4Apf+khTaj+ViWIrEXUu0eIwavPTQ9dcbrIx7tdQjRsSzlr9xIPgwebXXiPp
         BQLQJ/mNNq2kXdWn/kgJQcoNW1hgTerIEpw73s7HUqE8xOjV0S6EHg7eIaq4DdCbxmW9
         dxHJRyBMNXYOVc2Xzc3mdNoBAUXr7oRe30WDn+ztLH58CQRqyKfmSM7/8zEvz0tDU1LA
         xdCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758821012; x=1759425812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jnexyCErLKcy5WawRVuhv+j/25Jkh/N/xDZ4CJ0zkpA=;
        b=Cf9PnTQyoqz8915m8Fr29YdA0P7zcl3YjvSFvRL4EMuOmOUHsTwHH8nj3tfg8jtJBA
         DIbI1sdH8PTqdqBvUjSmg0ORE0WxzYrenJthdIoUwhE1+cnGHYNXxKpZETypmfZkoTKO
         J7uB31viqNUY+20joyQHDQLmWEDYNkw7Xccp1Lws4BPV7j+9ifNqXmXpLpJISoRf2cKV
         jNLZjTzwDjDtAYDAXH9QoFij6MK0ULMiyWyVE0yMGF0C/oeqzVJcxc8YndL82U5J6Wtq
         z4m8c6+RnS1Hm2k4DLv41Hs2DWFsue5e26hX4dTDH830Y++RRaWJFLPFvw9CS6ZWNZ5y
         7/KQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3OCe+l41F05kYl7o7JH7NSyATQFXQOGQayvkPAERPoYFsnZ2jxZpsdRzpUST9tlnyJ5+wKauD@vger.kernel.org
X-Gm-Message-State: AOJu0YwtKNXYVgvtjIbJxXtKk9dIiPQJIWt8Iz1wXvvS0nN1OqPoIuiL
	GP7W70KiKcq4INyO93m/QoPOm6EqHbSZVxVlfgzhzMMvxPCjm4FkpkAzEmGPmb63t2JT7aZ6ZN3
	Xta8cpO8i7VHC4A8+lgJGtjmdhYPs8zI=
X-Gm-Gg: ASbGnctL+MQxvOkaB0kEW3fm9lvU08wsCGtgtDGg58+qRWtlCKKXGVPkC8UNqIN73rz
	WbqfVHOMbsLV40Jf19YQ056uM6kHHuU8+j/LjO5BdkaFQAkad4aAPl4Iw43Sw5jM10PgUUV05OX
	ZccjQDIVEHnTmoG1CS+uDA1Df/yJmsckDxCe+DofwaH/pzO3ZdbfJxj/9V4ZmILB7IZ+yBcnokX
	pNVI6gtPRoLWZIwPpAqL0lXiE2iysr6cZ2fHTo+fYUPfYBpo7qG
X-Google-Smtp-Source: AGHT+IGG5uoVfbp7FwsiRwIz6pAGZlzr7J4ef3zq4Fx6thCX7iURSahq5L/XRfYWgF+0KGRjieu+iHTkjavNvkvB0m8=
X-Received: by 2002:a17:90b:3b8f:b0:329:7285:6941 with SMTP id
 98e67ed59e1d1-3342a2bf43dmr5338412a91.19.1758821012281; Thu, 25 Sep 2025
 10:23:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924211716.1287715-1-ihor.solodrai@linux.dev>
 <20250924211716.1287715-2-ihor.solodrai@linux.dev> <CAADnVQLvuubey0A0Fk=bzN-=JG2UUQHRqBijZpuvqMQ+xy4W4g@mail.gmail.com>
 <6a6403ec-166a-4d48-8bf5-f43ae1759e5f@linux.dev>
In-Reply-To: <6a6403ec-166a-4d48-8bf5-f43ae1759e5f@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 25 Sep 2025 10:23:18 -0700
X-Gm-Features: AS18NWDYV_fz58AP8yJl3hBRjBsWtcU2jgD_0gTWZdKxn1dVVnv9OrgQzs3n_N8
Message-ID: <CAEf4BzbYXADoUge5C7zhzZAEDESE7YJFwW_jO4-F5L3j-bwPMw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/6] bpf: implement KF_IMPLICIT_PROG_AUX_ARG flag
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Eduard <eddyz87@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	dwarves <dwarves@vger.kernel.org>, Alan Maguire <alan.maguire@oracle.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Tejun Heo <tj@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 9:13=E2=80=AFAM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
>
>
> On 9/25/25 2:49 AM, Alexei Starovoitov wrote:
> > On Wed, Sep 24, 2025 at 10:17=E2=80=AFPM Ihor Solodrai <ihor.solodrai@l=
inux.dev> wrote:
> >>
> >> Define KF_IMPLICIT_PROG_AUX_ARG and handle it in the BPF verifier.
> >>
> >> The mechanism of patching is exactly the same as for __prog parameter
> >> annotation: in check_kfunc_args() detect the relevant parameter and
> >> remember regno in cur_aux(env)->arg_prog.
> >>
> >> Then the (unchanged in this patch) fixup_kfunc_call() adds a mov
> >> instruction to set the actual pointer to prog_aux.
> >>
> >> The caveat for KF_IMPLICIT_PROG_AUX_ARG is in implicitness. We have to
> >> separately check that the number of arguments is under
> >> MAX_BPF_FUNC_REG_ARGS.
> >>
> >> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> >> ---
> >>  include/linux/btf.h   |  3 +++
> >>  kernel/bpf/verifier.c | 43 ++++++++++++++++++++++++++++++++++++------=
-
> >>  2 files changed, 39 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/include/linux/btf.h b/include/linux/btf.h
> >> index f06976ffb63f..479ee96c2c97 100644
> >> --- a/include/linux/btf.h
> >> +++ b/include/linux/btf.h
> >> @@ -79,6 +79,9 @@
> >>  #define KF_ARENA_RET    (1 << 13) /* kfunc returns an arena pointer *=
/
> >>  #define KF_ARENA_ARG1   (1 << 14) /* kfunc takes an arena pointer as =
its first argument */
> >>  #define KF_ARENA_ARG2   (1 << 15) /* kfunc takes an arena pointer as =
its second argument */
> >> +/* kfunc takes a pointer to struct bpf_prog_aux as the last argument,
> >> + * passed implicitly in BPF */
> >
> > This is neither networking nor kernel comment style.
> > Pls use proper kernel comment style in a new code,
> > and reformat old net/bpf style when adjusting old comments.
> >
> >> +#define KF_IMPLICIT_PROG_AUX_ARG (1 << 16)
> >
> > The name is too verbose imo.
> > How about
> > KF_HIDDEN_PROG_ARG
> > or
> > KF_PROG_LAST_ARG
> >
> > "Implicit" is not 100% correct, since it's very explicit
> > in kfunc definition in C, but removed from BTF.
> > "Hidden" is also not an exact fit for the same reasons.
> > Hence my preference is KF_PROG_LAST_ARG.
> >
> > "aux" part is also an implementation detail.

+1, I'd consider even just naming it KF_PROG_ARG, where "last" is
implied, but that's minor.

> >
> >>  /*
> >>   * Tag marking a kernel function as a kfunc. This is meant to minimiz=
e the
> >> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> >> index e892df386eed..f1f9ea21f99b 100644
> >> --- a/kernel/bpf/verifier.c
> >> +++ b/kernel/bpf/verifier.c
> >> @@ -11948,6 +11948,11 @@ static bool is_kfunc_rcu_protected(struct bpf=
_kfunc_call_arg_meta *meta)
> >>         return meta->kfunc_flags & KF_RCU_PROTECTED;
> >>  }
> >>
> >> +static bool is_kfunc_with_implicit_prog_aux_arg(struct bpf_kfunc_call=
_arg_meta *meta)
> >> +{
> >> +       return meta->kfunc_flags & KF_IMPLICIT_PROG_AUX_ARG;
> >> +}
> >> +
> >>  static bool is_kfunc_arg_mem_size(const struct btf *btf,
> >>                                   const struct btf_param *arg,
> >>                                   const struct bpf_reg_state *reg)
> >> @@ -12029,6 +12034,18 @@ static bool is_kfunc_arg_prog(const struct bt=
f *btf, const struct btf_param *arg
> >>         return btf_param_match_suffix(btf, arg, "__prog");
> >>  }
> >>
> >> +static int set_kfunc_arg_prog_regno(struct bpf_verifier_env *env, str=
uct bpf_kfunc_call_arg_meta *meta, u32 regno)
> >> +{
> >> +       if (meta->arg_prog) {
> >> +               verifier_bug(env, "Only 1 prog->aux argument supported=
 per-kfunc");
> >> +               return -EFAULT;
> >> +       }
> >> +       meta->arg_prog =3D true;
> >> +       cur_aux(env)->arg_prog =3D regno;
> >> +
> >> +       return 0;
> >> +}
> >> +
> >>  static bool is_kfunc_arg_scalar_with_name(const struct btf *btf,
> >>                                           const struct btf_param *arg,
> >>                                           const char *name)
> >> @@ -13050,6 +13067,21 @@ static int check_kfunc_args(struct bpf_verifi=
er_env *env, struct bpf_kfunc_call_
> >>                 return -EINVAL;
> >>         }
> >>
> >> +       /* KF_IMPLICIT_PROG_AUX_ARG means that the kfunc has one less =
argument in BTF,
> >> +        * so we have to set_kfunc_arg_prog_regno() outside the arg ch=
eck loop.
> >> +        */
> >
> > Use kernel comment style.
> >
> >> +       if (is_kfunc_with_implicit_prog_aux_arg(meta)) {
> >> +               if (nargs + 1 > MAX_BPF_FUNC_REG_ARGS) {
> >> +                       verifier_bug(env, "A kfunc with KF_IMPLICIT_PR=
OG_AUX_ARG flag has %d > %d args",
> >> +                                    nargs + 1, MAX_BPF_FUNC_REG_ARGS)=
;
> >> +                       return -EFAULT;
> >> +               }
> >> +               u32 regno =3D nargs + 1;
> >
> > Variable declaration should be first in the block
> > followed by a blank line.
> >
> > Also I would remove this double "> MAX_BPF_FUNC_REG_ARGS" check.
> > Move if (is_kfunc_with_prog_last_arg(meta))
> > couple lines above before the check,
> > and actual_nargs =3D nargs + 1;
> > if (actual_nargs > MAX_BPF_FUNC_REG_ARGS)
> > to cover both cases.
> > I wouldn't worry that verbose() isn't too specific.
> > If it prints nargs and actual_nargs whoever develops a kfunc
> > can get an idea.
> > Also in the future there is a good chance we will add more
> > KF_FOO_LAST_ARG flags to cleanup other *_impl() kfuncs
> > that have a special last argument, like bpf_rbtree_add_impl.
> > If all of them copy paste "> MAX_BPF_FUNC_REG_ARGS" check
> > it will be too verbose. Hence one nargs check for them all.
>
> Hi Alexei, thank you for the review.
>
> Sorry for the styling mistakes, forgot to run patches through
> checkpatch.pl
>
> In the other thread Eduard proposes a different approach to the
> implementation [1].  Basically, leave BTF unmodified and move argument
> hiding logic to bpftool's vmlinux.h generation.
>
> IMO modifying BTF is more straightforward, but if the main goal is to
> have a nice BPF C interface, maybe Eduard is onto something.
>
> Curious to hear yours and Andrii's opinion on that.
>

I explicitly really-really don't want to modify BPF CO-RE type
matching rules for these special kfuncs. So that's why I think it's
better overall to hide those special arguments from the BTF
information altogether.

I do see the benefit of having the generic "KF_MAGIC_ARG(s)" flag on
the kernel side of things and having access to full BTF information
for parameters to let verifier know what specific kind of magic
argument that kfunc has, though. So as an alternative, maybe we can
create both a kfunc definition *meant for BPF programs* (i.e., without
magic argument(s)), and then have a full original definition (produced
by pahole, it will need to understand KF_MAGIC_ARGS anyways) with full
type information *for internal BPF verifier needs*. I don't know
what's the best way to do that, maybe just a special ".magic" suffix,
just to let the verifier easily find that? On the kernel side, if
kfunc has BPF_MAGIC_ARGS kflag we just look up "my_fancy_kfunc.magic"
FUNC definition?

Thoughts?

> Thanks.
>
> [1] https://lore.kernel.org/bpf/b92d892f6a09fc7a411838ccf03dfebbba96384b.=
camel@gmail.com/
>
> >
> > pw-bot: cr
>
