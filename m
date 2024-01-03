Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827001BDC4
	for <dwarves@vger.kernel.org>; Wed,  3 Jan 2024 16:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="evJsxT/r"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33674f60184so10651809f8f.1
        for <dwarves@vger.kernel.org>; Wed, 03 Jan 2024 08:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704298825; x=1704903625; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nTmw2+iVdS8ogQZe3NCKn/UpJ3GhZUJEv6WLGyTPS8M=;
        b=evJsxT/rWAvog6O2vEUsNjRfqDN7iErqhhSJwgT5h4Ek0Go+IlcJgvXIts7gTbM9ES
         XApN7iKGuOnzqIzeAoiTHogLU7E2ZTbXWK0IsT6HPqE6/IFgUbGVavt2wGi2DbcV5zPa
         xGARNvDd1LmXEiBjP64lWNWAX50n9FqJoVlLBikqX4QfLp/riUH6VLEFPV7rM4jPMUPF
         5VnAaH0qRNSbB+HDlLnPtObk3i4BGECLxZsH1v6RfGk52oAufl5s27DtRjKcwDFPsQw0
         GackdJWcdHAMx0BQEbTg5rGbZ3OZwJ381zEZAXmUkeHQDOBTtH7xre7dA/QTOBOqylUk
         zQYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704298825; x=1704903625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nTmw2+iVdS8ogQZe3NCKn/UpJ3GhZUJEv6WLGyTPS8M=;
        b=psy5c+l4hRQn2w5Hce0X8D2X33ue7WBZybvEUkbwVm/YgkN1OZ2U/IzJccts1A2gOg
         p8FyIPQ3xCjX2b4pXT6gO0qaws/k9TYO5SopewembZj0yXSlteJ0+W0jKS7XEXj66h4U
         0uUo3+z8JkClkrUybMIIE4zkma9gqLFouq7cX8v0TMLQeYtU9QkCgWGYZnyipz73jAAA
         /uxMZ2kfdgIA1WqBAn2s3MPTfgdMid/90VkXxCXol7v+2oaiptrdg5yDutk2TUgAnZYI
         AsQGcHsowTqX6H0ZMeuXhGys5eJB/PeKIEiY0Kp3fiFebGvstss5dDoAhI9ffi1r45RG
         3KBQ==
X-Gm-Message-State: AOJu0YydQLLOX8V0BXGkyyxmcxlPIMjvEoYLXXHbvvLERvnKgK5wggmh
	Qn8yQKGaVO8iLRlVsp1uiOEhgywGiQSr0UxOSOTGUyMGVOHY
X-Google-Smtp-Source: AGHT+IHfxuTaOBCg0jN9m2vHrKIYM9kBku6unbrT3PNPIC9Bme5F6ozo1UxVEQiGATU6TRybam7ND/gLdS4mIw7PJD8=
X-Received: by 2002:a5d:4ace:0:b0:336:8d41:5b03 with SMTP id
 y14-20020a5d4ace000000b003368d415b03mr8121259wrs.79.1704298824696; Wed, 03
 Jan 2024 08:20:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202312192107.wMIKiZWw-lkp@intel.com> <20231219205348.wvvxyicaatmljxm2@moria.home.lan>
 <CAKwvOdmrvwdbFrtzsOjoLJJZ1pDZOBWBiEb=Mx5bCHuKU2wPzQ@mail.gmail.com>
 <20231219210454.GA540439@dev-arch.thelio-3990X> <ZYKWxl9oQXODIoNe@yujie-X299>
 <20231227224338.GA267659@dev-arch.thelio-3990X> <ZY2EUr+EYzyro3NH@kernel.org>
 <20231228173404.GA412881@dev-arch.thelio-3990X> <ZZQ6CpBnqpBgxSgp@kernel.org> <20240102175342.GH26453@gnu.wildebeest.org>
In-Reply-To: <20240102175342.GH26453@gnu.wildebeest.org>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Wed, 3 Jan 2024 08:20:10 -0800
Message-ID: <CAKwvOd=AAuqKk4GXV0jWORwJKJ0gao2zVd_RYWXoA90A77c47A@mail.gmail.com>
Subject: Re: [bcachefs:header_cleanup 21/51] /bin/bash: line 1: 19420
 Segmentation fault LLVM_OBJCOPY="llvm-objcopy" pahole -J --btf_gen_floats -j
 --lang_exclude=rust --skip_encoding_btf_inconsistent_proto
 --btf_gen_optimized --btf_base vmlinux drivers/misc/eeprom/at24.ko
To: Nathan Chancellor <nathan@kernel.org>, Brian Cain <bcain@quicinc.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Yujie Liu <yujie.liu@intel.com>, 
	Kent Overstreet <kent.overstreet@linux.dev>, kernel test robot <lkp@intel.com>, llvm@lists.linux.dev, 
	oe-kbuild-all@lists.linux.dev, linux-hexagon@vger.kernel.org, 
	dwarves@vger.kernel.org, Mark Wielaard <mark@klomp.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 2, 2024 at 9:53=E2=80=AFAM Mark Wielaard <mark@klomp.org> wrote=
:
>
> This seems to need Qualcomm to upstream support for this processor
> type to bintuils and elfutils.

Probably should disable BTF for hexagon until then.
--=20
Thanks,
~Nick Desaulniers
