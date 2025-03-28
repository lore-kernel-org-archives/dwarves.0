Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862523C0C
	for <dwarves@vger.kernel.org>; Fri, 28 Mar 2025 20:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743193524; cv=none; b=P6HYFISrXMxgpx7oLZIIgSO4Bi6N0blOpUPru6NvSA9j03Ku1R29Y438afpHd11l8rWnhnuwtTMi7HPAtLpfLz6epLz5xQmSOH1uMUuF7MRXvxLwXNA3+M4+/UT7fvvbaQPruEl/Rc/fGoBdeYzsXEPRTrMKuLIwiWY3UR3fhv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743193524; c=relaxed/simple;
	bh=I1MZd3ctv0xxtRHXWceS++h4ZmYZxbz4tD2i3fzkXs8=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=rS3B8umTnLVVx33ARscAZCkC9jneoIsRHU+MAKwQ4vMl4eORHHjIrxQev8Ye3w6lrTezFu0yzj+iznUroDM0/JJ9GVyBVqLbN77dR8Av1WvlluQPbMgTet7TMbF1ljlGrlf8W/SGRaHCzmnNFYKtoV6iiVO5dXmUDNt2TfLgtvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vf45mxMW; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vf45mxMW"
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743193518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gELwOsfg9Jc2cU0XqNsKOLgPXn2UDRW97s76TiWdZcs=;
	b=vf45mxMWhsbnHD25yop7/j7eCT41keYpByZgNMvuunA9su2iPryeEetkP8KOKGbtgO3Za4
	r2SxfJDfxp4FjNh1iTWIHfHpXuyZTVh1RCaUmG35udeFh1nxHobopaKTn+NI0kUviIH5xk
	RbZc7DshEfzg0YOUPBjdaIeYWxubVOE=
Date: Fri, 28 Mar 2025 20:25:08 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Message-ID: <310663685bc9fcc1e16490ca9f08b25825ddea91@linux.dev>
TLS-Required: No
Subject: Re: parallel pahole hangs while building modules from
 nvidia-open-kernel-dkms
To: "Domenico Andreoli" <domenico.andreoli@linux.com>,
 alan.maguire@oracle.com, acme@kernel.org
Cc: dwarves@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <Z-JzFrXaopQCYd6h@localhost>
References: <Z-JzFrXaopQCYd6h@localhost>
X-Migadu-Flow: FLOW_OUT

On 3/25/25 2:10 AM, Domenico Andreoli wrote:
> Hi,
>
>   This a forward of Debian bug report [0] where you can find more
> details. At [1] and [2] you can get the kernel and module to reproduce.
> I could reproduce on both amd64 and arm64 using pahole 1.29.
>
> This is marked as serious severity because it makes the autobuilder han=
g
> as well [3].
>
> Could you please help?
>
> Regards,
> Domenico
>
>
> The command to succeed:
>
> This simplified (sequential) command succeeds:
>
> cp nvidia-modeset.base.ko nvidia-modeset.ko
> LLVM_OBJCOPY=3D"x86_64-linux-gnu-objcopy" pahole -J --btf_features=3Den=
code_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_f=
unc,decl_tag_kfuncs --btf_features=3Ddistilled_base --btf_base vmlinux nv=
idia-modeset.ko -j1
> echo $?
>
> producing this output:
> =3D=3D=3D=3D=3D 8< =3D=3D=3D=3D=3D
> dwarf_expr: unhandled 0x12 DW_OP_ operation
> Unsupported DW_TAG_reference_type(0x10): type: 0x28172

Domenico, Alan, Arnaldo,

I was able to reproduce this error using the input files provided by
Domenico [1][2].

    ./build/pahole -J --btf_features=3Dencode_force,var,float,enum64,decl=
_tag,type_tag,optimized_func,consistent_func,decl_tag_kfuncs --btf_featur=
es=3Ddistilled_base --btf_base debian-repro/vmlinux debian-repro/nvidia-m=
odeset.base.ko -j1
    dwarf_expr: unhandled 0x12 DW_OP_ operation
    Unsupported DW_TAG_reference_type(0x10): type: 0x28172
    Error while encoding BTF.
    libbpf: failed to find '.BTF' ELF section in debian-repro/nvidia-mode=
set.base.ko
    pahole: debian-repro/nvidia-modeset.base.ko: Invalid argument


The unhandled tag points to src/common/displayport/src/dp_auxretry.cpp
[3] of nvidia-modeset.base.ko

Now, as far as I know, BTF can't represent C++-style references
directly (maybe indirectly with tags?).

According to the code, pahole simply bails out in case it encounters
`DW_TAG_reference_type` during BTF encoding. So the question is why
BTF generation is even attempted for a module written in C++? It does
not appear to be a supported use-case.

Please correct me if I'm wrong about this.

Alan, sorry for jumping into this uninvited. I trust you'll take over
from here. Thanks!

I've sent a patch with a fix for the hanging [4].

[1] https://bugs.debian.org/cgi-bin/bugreport.cgi?att=3D1;bug=3D1100503;f=
ilename=3Dvmlinux.zst;msg=3D19
[2] https://bugs.debian.org/cgi-bin/bugreport.cgi?att=3D1;bug=3D1100503;f=
ilename=3Dnvidia-modeset.base.ko.zst;msg=3D12
[3] https://github.com/NVIDIA/open-gpu-kernel-modules/blob/main/src/commo=
n/displayport/src/dp_auxretry.cpp
[4] https://lore.kernel.org/bpf/20250328174003.3945581-1-ihor.solodrai@li=
nux.dev/

> Error while encoding BTF.
> 0
> =3D=3D=3D=3D=3D >8 =3D=3D=3D=3D=3D
>
> [...]
