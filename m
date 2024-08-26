Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C25DB66C
	for <dwarves@vger.kernel.org>; Mon, 26 Aug 2024 23:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724716665; cv=none; b=AfwbioXq5W21YGwQxhldJ0xouR5yJLvQDvZG4cXaonHmyL7u32tiK2NoIb+q8fOvCRm+fbbAiHFcyHWJLkn7eE7rhiDK/PcHGNP/lWh4NWYip3KxdBR9hMU2Y4YDYuNXDuB9Qw2u+4KQB3Utf48rGyd8q7eZC1rXgUhr3+DjpyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724716665; c=relaxed/simple;
	bh=p0X7e5UVC7yBZiFlacJjqMwqkGNezhKUGvX36FuzR0w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LSHpL1buuRjW7HviC8KIdH6e1IcHI5Ot01whJnoLzy1EG5VtSfA+SgjYIL8sGDeOpx8oGSdIzaxGqAtKkMNiQfqxglpJQfPMOhPpvzqJAWtZGXsbRIOOECawYt61dD23BRrkYm1OATooLkH1AJz2622J84JmFYbycITF/E8QaYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fee6435a34so32171805ad.0
        for <dwarves@vger.kernel.org>; Mon, 26 Aug 2024 16:57:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724716663; x=1725321463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YLKS/PrWJmxRZk/mhl/iWjjlyiwnhvsyWzJhgZZFdzQ=;
        b=a0BST6SLmhxiVnHSUFuwwn0eaaa9hduJy4hKFT0MjErAgYH8WPV7+FAFJKQHyRAo0A
         u1ZCx++b3RhfBPzwDGfOVX8Ap1ZgaSz+j4NH/RQxsViyeJqgRzrMKPE4jT5+6nGX/BgR
         LJscfNHwTGll0wcH54FIdv4fRmoumAlZ7CiXBq7hbFVTnSc2mxg/HQZNRY7VfAOUC/ut
         XZtR8BHTtWl8PSvcpeQ7pJNMcfSDI8vMNRdG6MPSIG0dcdUovQzwBhjNk4cxKbFvk0pA
         UfkKYpUMVxpODYQR5N3iPRXx5QDX15QZE6whG8GtABrYO7OrF776j+7/Mzkw9wplNW1L
         vROw==
X-Forwarded-Encrypted: i=1; AJvYcCUbXXW7ufxx2x0peg3tiDfWQHBHjMiYBs2uePQRLeyIsGBPwOM9AnDay041HU/AG2oxmtC7F2Wq@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu4QPJrBbC4uE8dZGIrpl/ExN5XlroHdoXalmtEzamfWGrvY/5
	wjukVLecXNb6dEN3wCAdR1Pfyo+SmTcbv7AaXP/BCfHmcRH0FAqp0iF5bPbwi9ntJvBY9Yg8wsR
	WzYFVKw7UecuOr2yeAuesDjbbS0w=
X-Google-Smtp-Source: AGHT+IH74lJm53Pfs+P3evZKZCxVV11aAzoCdhwMr9jScAtWWAO8L0MvN+YYKyGPTLBp8BKn4uXCbzZJj0ji92La3Xc=
X-Received: by 2002:a17:90a:98b:b0:2c9:888a:7a7b with SMTP id
 98e67ed59e1d1-2d646c197eamr10942466a91.25.1724716662980; Mon, 26 Aug 2024
 16:57:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zs0QVVZZfN9H7wQC@x1>
In-Reply-To: <Zs0QVVZZfN9H7wQC@x1>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 26 Aug 2024 16:57:32 -0700
Message-ID: <CAM9d7chKrHJE0Mp2pad8syQqG-vGv-7k0C_=Op+KMXFvsUPUHQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] pfunct: Print DW_AT_external=1 functions once
To: arnaldo.melo@gmail.com
Cc: Alan Maguire <alan.maguire@oracle.com>, Jiri Olsa <jolsa@kernel.org>, dwarves@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arnaldo,

On Mon, Aug 26, 2024 at 4:31=E2=80=AFPM <arnaldo.melo@gmail.com> wrote:
>
> Namhyung mentioned that 'set_task_cpu' wasn't being printed with pfunct,
> that was because those functions (with DW_AT_external=3D1) were not being
> printed at all, out of some wrong expectations, this was added to avoid
> printing it multiple times to allow for things like --compile to work,
> but that was too much of a big hammer.
>
> So add fn_stats->printed and use it to determine if functions were
> already printed.
>
> Also don't print definitions for functions marked as declarations, as it
> clashes with the ones in system headers, like __builtin_memcpy, etc.
>
> This all needs a more thorough love and care, but at least for now
> --compile works with 'fullcircle tcp.o' (generating the functions and
> the types it uses and then compiling it to get the original types and
> functions and prints the external functions:
>
>   $ pfunct -F dwarf -f set_task_cpu vmlinux
>   void set_task_cpu(struct task_struct * p, unsigned int new_cpu);
>   $ pfunct -F btf -f set_task_cpu vmlinux
>   void set_task_cpu(struct task_struct * p, unsigned int new_cpu);
>   $
>
> Reported-by: Namhyung Kim <namhyung@kernel.org>
> Cc: Alan Maguire <alan.maguire@oracle.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Tested-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  pfunct.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/pfunct.c b/pfunct.c
> index 938dd724e44a9416..bc3026b384284cb4 100644
> --- a/pfunct.c
> +++ b/pfunct.c
> @@ -49,6 +49,7 @@ struct fn_stats {
>         uint32_t         nr_expansions;
>         uint32_t         size_expansions;
>         uint32_t         nr_files;
> +       bool             printed;
>  };
>
>  static struct fn_stats *fn_stats__new(struct tag *tag, const struct cu *=
cu)
> @@ -95,11 +96,13 @@ static void fn_stats__delete_list(void)
>         }
>  }
>
> -static void fn_stats__add(struct tag *tag, const struct cu *cu)
> +static struct fn_stats *fn_stats__add(struct tag *tag, const struct cu *=
cu)
>  {
>         struct fn_stats *fns =3D fn_stats__new(tag, cu);
>         if (fns !=3D NULL)
>                 list_add(&fns->node, &fn_stats__list);
> +
> +       return fns;
>  }
>
>  static void fn_stats_inline_exps_fmtr(const struct fn_stats *stats)
> @@ -366,7 +369,12 @@ static void function__show(struct function *func, st=
ruct cu *cu)
>  {
>         struct tag *tag =3D function__tag(func);
>
> -       if (func->abstract_origin || func->external)
> +       if (func->abstract_origin || func->declaration)
> +               return;
> +
> +       struct fn_stats *fstats =3D fn_stats__find(func->name);
> +
> +       if (fstats && fstats->printed)
>                 return;
>
>         if (expand_types)
> @@ -393,6 +401,11 @@ static void function__show(struct function *func, st=
ruct cu *cu)
>         putchar('\n');
>         if (show_variables || show_inline_expansions)
>                 function__fprintf_stats(tag, cu, &conf, stdout);
> +
> +       if (!fstats)
> +               fstats =3D fn_stats__add(tag, cu);
> +       if (fstats)
> +               fstats->printed =3D true;
>  }
>
>  static int cu_function_iterator(struct cu *cu, void *cookie)
> --
> 2.46.0
>
