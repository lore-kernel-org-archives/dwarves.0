Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DCF39D3FD
	for <dwarves@vger.kernel.org>; Thu, 25 Jun 2026 10:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782385184; cv=none; b=BNOqJuKG6aetbhACB3Ki3wqjdvNKzHAT9zrhD9TSezioVo2TLDBApNUgosSabUjD5fMhNiMCI+1VhhoCkYnHGz0rnU3Bjh1pKYM5JIozkiXg4+3GTj2yWOVSSIeunym7mj0Ps8oFGP2QlzXfuVkkWWucZbpWexW/4+oVAfCwtXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782385184; c=relaxed/simple;
	bh=moIE8WbOhEUHpvRdK5YsoI+RWzG8UkN4U2u5ilig0s0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GIW93dcUW9EY05x1e86sGdo2EQnLDmJ6Isxjunl87UPKTpCuhyXCMiCXqEC/ofZv+VMl9Fp0lAkiHjjVC5B21xlXZHiDVanXVEO7hJxUXLK5/1p3ZBSxzo2ewt2a8ZFUnUT5OR4cI0Vz2wLH87JI/+QyUcIDZ8V2QT7/p3CI81E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PRJVGucR; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRJVGucR"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-46dcb6e55c6so521500f8f.2
        for <dwarves@vger.kernel.org>; Thu, 25 Jun 2026 03:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782385181; x=1782989981; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kYyoK0pGtkUSu+UWMOV/pLn1FeMe2RkvR+yVNGqpBWM=;
        b=PRJVGucRvSY3dCerKZdhYqyMaYsT30nSc3n+IhLLlpiCvFD/Orhehv/Khvms7UVpLt
         yo6qBI2cz5gLmVc+GeWlYwL9rueuPL2Mjpn7O0clo1w/ikcKbdA3Sa+4jnnOF8GMW3zK
         BRlpb8nLDbVAFXDJVk+rO1mwF/OJZ1TcNtu3oiKXlgwKOLc0zsptA5YyRmO3Lek/i35H
         6AqiLXgGNkAr7wWpSJRNsWmrgEpXcH7gR1ymzQyfr9rbDardZDSkL9BRJTLsodT+rGM0
         3cIwWr4s5QendsWlckKxBRH34ipfHvoGk4DyDdV2w77aqNoFrRMb4EaN9cX9cxUVDLtf
         HKQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782385181; x=1782989981;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kYyoK0pGtkUSu+UWMOV/pLn1FeMe2RkvR+yVNGqpBWM=;
        b=VuSfJs24U0hThxd5IcZ7fhCYsak3l+Ro4WoU0lPF7dz3eRD/MU0ASKKKfSX4qlaaTk
         2QLhJepFoKSAHRfHLIbYbv8ARDAZJxSHNCKYKbsHDPGkd4G5vr6LysbPvVxPxDHXT/g9
         MaPtSSiXHD004XYtj+y8uRP+AmUUE1OH2uiQ8fwX1mHf0dEeosjq6Vfa515P8E1+IfXV
         uEXLwaIoXFqv5WDXL3Igb1qjI1kgF9X0rQX2Zh3cHbBavPtSVB5MxJBlR1gDNavq9NVo
         NjdgenHbarXWrYOJ9g3f7m9szI2jLsM29cHRKOhl0Ebonrc5YiaybBDTM0xc47Bw14nh
         nzvQ==
X-Forwarded-Encrypted: i=1; AFNElJ8e5DWbK3yba8ghrp0PPRgWSJMtSWAYlyg9Yw7pekfofkGgaVXZMAU+YQ/M/jNKO3EtZS5S9uWT@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/3l6Ctx7Yt+mfoQD9Su4In7GuRtxlpyFPp+qqqalgYtQ5uVdh
	CkRGVhn6MPPanHy8g+idrVcndNYnVfSKrOi722SVioIUIJZCoXZwUuwg
X-Gm-Gg: AfdE7cnDk3uoYsC/eEckTwqfGVuE1LeKTdxdfb+UqI/lj7ciYfe+Ysg9+h3OD11TdCH
	0yp2wDRfjtoH3BhiEaQSkwuJxBTph+rC05pnqshi83newBJHtqqJfuTaAHTTYwtMQKuOS8MSXMp
	dlaTzL7EBxwY/GNi6u5WuIdODp3CFnkW0Rvx8NWSZAn6bZjPPnLxOpsa86fHKXFLcdRl/B37Dp3
	FvWG10pDEJjyKTBUwuMksoEWPyMGAhK3amCHI//wlIUz+zCzOFdqKJu0Qj07kNSIxG2zbkv+MjJ
	7Cb8SQtnSTLj3x4n3WHB4F09OGb0tHk+1uBjnvYjpzQlRTS1DgXrfoWR3VqYKgdTiEVZu6di+xb
	DqDJRlhoLVRkqhmvmA5k8RUaotpCQ9RiQYOO7GZ9CoD0xy4QwrP4wIzdDOdRXRWV2Exc20A7fsM
	yzzllk
X-Received: by 2002:a05:600c:4e90:b0:492:4c9e:c95d with SMTP id 5b1f17b1804b1-4926687e737mr25869805e9.18.1782385181030;
        Thu, 25 Jun 2026 03:59:41 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200:b655:ff13:e355:16a3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49266062fd6sm28644475e9.1.2026.06.25.03.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 03:59:40 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 25 Jun 2026 12:59:39 +0200
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH dwarves v10 0/5] pahole: Encode true signatures in kernel
 BTF
Message-ID: <aj0KGx-5FwUbwGHc@krava>
References: <20260625020148.1883082-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625020148.1883082-1-yonghong.song@linux.dev>

On Wed, Jun 24, 2026 at 07:01:48PM -0700, Yonghong Song wrote:
> Current vmlinux BTF encoding is based on the source level signatures.
> But the compiler may do some optimization and changed the signature.
> If the user tried with source level signature, their initial implementation
> may have wrong results and then the user need to check what is the
> problem and work around it, e.g. through kprobe since kprobe does not
> need vmlinux BTF.
> 
> Majority of changed signatures are due to dead argument elimination.
> The following is a more complex one. The original source signature:
>   typedef struct {
>         union {
>                 void            *kernel;
>                 void __user     *user;
>         };
>         bool            is_kernel : 1;
>   } sockptr_t;
>   typedef sockptr_t bpfptr_t;
>   static int map_create(union bpf_attr *attr, bpfptr_t uattr) { ... }
> After compiler optimization, the signature becomes:
>   static int map_create(union bpf_attr *attr, bool uattr__is_kernel) { ... }
> In the above, uattr__is_kernel corresponds to 'is_kernel' field in sockptr_t.
> This makes it easier for developers to understand what changed.
> 
> The new signature needs to properly follow ABI specification based on
> locations. Otherwise, that signature should be discarded. For example,
> 
>     0x0242f1f7:   DW_TAG_subprogram
>                     DW_AT_name      ("memblock_find_in_range")
>                     DW_AT_calling_convention        (DW_CC_nocall)
>                     DW_AT_type      (0x0242decc "phys_addr_t")
>                     ...
>     0x0242f22e:     DW_TAG_formal_parameter
>                       DW_AT_location        (indexed (0x14a) loclist = 0x005595bc:
>                          [0xffffffff87a000f9, 0xffffffff87a00178): DW_OP_reg5 RDI
>                          [0xffffffff87a00178, 0xffffffff87a001be): DW_OP_reg14 R14
>                          [0xffffffff87a001be, 0xffffffff87a001c7): DW_OP_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value
>                          [0xffffffff87a001c7, 0xffffffff87a00214): DW_OP_reg14 R14)
>                       DW_AT_name    ("start")
>                       DW_AT_type    (0x0242decc "phys_addr_t")
>                       ...
>     0x0242f239:     DW_TAG_formal_parameter
>                       DW_AT_location        (indexed (0x14b) loclist = 0x005595e6:
>                          [0xffffffff87a000f9, 0xffffffff87a00175): DW_OP_reg4 RSI
>                          [0xffffffff87a00175, 0xffffffff87a001b8): DW_OP_reg3 RBX
>                          [0xffffffff87a001b8, 0xffffffff87a001c7): DW_OP_entry_value(DW_OP_reg4 RSI), DW_OP_stack_value
>                          [0xffffffff87a001c7, 0xffffffff87a00214): DW_OP_reg3 RBX)
>                       DW_AT_name    ("end")
>                       DW_AT_type    (0x0242decc "phys_addr_t")
>                       ...
>     0x0242f245:     DW_TAG_formal_parameter
>                       DW_AT_location        (indexed (0x14c) loclist = 0x00559610:
>                          [0xffffffff87a001e3, 0xffffffff87a001ef): DW_OP_breg4 RSI+0)
>                       DW_AT_name    ("size")
>                       DW_AT_type    (0x0242decc "phys_addr_t")
>                       ...
>     0x0242f250:     DW_TAG_formal_parameter
>                       DW_AT_const_value     (4096)
>                       DW_AT_name    ("align")
>                       DW_AT_type    (0x0242decc "phys_addr_t")
>                       ...
> 
> The third argument should correspond to RDX for x86_64. But the location suggests that
> the parameter value is stored in the address with 'RSI + 0'. It is not clear whether
> the parameter value is stored in RDX or not. So we have to discard this funciton in
> vmlinux BTF to avoid incorrect true signatures.
> 
> For llvm, any function having
>   DW_AT_calling_convention        (DW_CC_nocall)
> in dwarf DW_TAG_subprogram will indicate that this function has signature changed.
> But for non DW_CC_nocall functions, it is possible that true signature still not
> available due to locations. So every functions will be checked.
> 
> I did experiment with latest bpf-next. For x86_64, there are 69103 kernel functions
> and 875 kernel functions having signature changed. A series of patches are intended
> to ensure true signatures are properly represented. Eventually, only 20 functions
> cannot have true signatures due to locations.
> 
> For arm64, there are 863 kernel functions having signature changed, and
> 108 functions cannot have true signatures due to locations. I checked those
> functions and look like llvm arm64 backend more relaxed to compute parameter
> values.
> 
> For full testing, I enabled true signature support in kernel scripts/Makefile.btf like below:
>   -pahole-flags-$(call test-ge, $(pahole-ver), 131) += --btf_features=attributes
>   +pahole-flags-$(call test-ge, $(pahole-ver), 131) += --btf_features=attributes --btf_features=+true_signature
> 
> See individual patches for details.

hi,
I tried this version and had to choose another function, because "arp_process"
suddenly started to show args registers in proper order ;-)

now I checked "stop_cpus" function which is added to btf after this change,
I attached the dwarf dump below

"stop_cpus" has DW_CC_nocall set, so it has signature_changed=true and I see the
function ends up in the btf_encoder with optimized_parms=1

but we do not skip such functions now, it seems like we should?

I tried the attached change below and it removes all the extra functions
that were added in the btf with this change

btw I can't see any other use for optimized_parms flag, it seems to be
just set and never used.. so I wonder I'm missing something

jirka


dwarfdump:

0x016f4b1b:   DW_TAG_subprogram
                DW_AT_low_pc    (0xffffffff813e0fc0)
                DW_AT_high_pc   (0xffffffff813e1133)
                DW_AT_frame_base        (DW_OP_reg7 RSP)
                DW_AT_GNU_all_call_sites        (true)
                DW_AT_name      ("stop_cpus")
                DW_AT_decl_file ("/home/jolsa/kernel/linux-qemu-2/kernel/stop_machine.c")
                DW_AT_decl_line (464)
                DW_AT_prototyped        (true)
                DW_AT_calling_convention        (DW_CC_nocall)
                DW_AT_type      (0x016e94c5 "int")

0x016f4b36:     DW_TAG_formal_parameter
                  DW_AT_location        (0x0065ad9e:
                     [0xffffffff813e0fc5, 0xffffffff813e0fed): DW_OP_reg5 RDI
                     [0xffffffff813e0fed, 0xffffffff813e111e): DW_OP_reg14 R14
                     [0xffffffff813e111e, 0xffffffff813e1127): DW_OP_GNU_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value
                     [0xffffffff813e1127, 0xffffffff813e1133): DW_OP_reg14 R14)
                  DW_AT_name    ("cpumask")
                  DW_AT_decl_file       ("/home/jolsa/kernel/linux-qemu-2/kernel/stop_machine.c")
                  DW_AT_decl_line       (464)
                  DW_AT_type    (0x016f3242 "const cpumask *")

0x016f4b46:     DW_TAG_formal_parameter
                  DW_AT_name    ("fn")
                  DW_AT_decl_file       ("/home/jolsa/kernel/linux-qemu-2/kernel/stop_machine.c")
                  DW_AT_decl_line       (464)
                  DW_AT_type    (0x016f2ca5 "cpu_stop_fn_t")

0x016f4b52:     DW_TAG_formal_parameter
                  DW_AT_location        (0x0065ae0d:
                     [0xffffffff813e0fc5, 0xffffffff813e0ff2): DW_OP_reg4 RSI
                     [0xffffffff813e0ff2, 0xffffffff813e10e4): DW_OP_reg3 RBX
                     [0xffffffff813e10e4, 0xffffffff813e1127): DW_OP_GNU_entry_value(DW_OP_reg4 RSI), DW_OP_stack_value
                     [0xffffffff813e1127, 0xffffffff813e112e): DW_OP_reg3 RBX
                     [0xffffffff813e112e, 0xffffffff813e1133): DW_OP_GNU_entry_value(DW_OP_reg4 RSI), DW_OP_stack_value)
                  DW_AT_name    ("arg")
                  DW_AT_decl_file       ("/home/jolsa/kernel/linux-qemu-2/kernel/stop_machine.c")
                  DW_AT_decl_line       (464)
                  DW_AT_type    (0x016e858f "void *")




---
diff --git a/btf_encoder.c b/btf_encoder.c
index 38455a4c6b6b..cbc5063a6280 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -1564,7 +1564,8 @@ static int btf_encoder__add_true_signature(struct btf_encoder *encoder,
 		 */
 		if (true_state->unexpected_reg ||
 		    true_state->uncertain_parm_loc ||
-		    true_state->ambiguous_addr)
+		    true_state->ambiguous_addr ||
+		    true_state->optimized_parms)
 			continue;
 		err = btf_encoder__add_func(encoder, true_state);
 		if (err < 0)
@@ -1656,6 +1657,8 @@ static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder, bool skip_e
 			skip_reason = "reordered parameters\n";
 		if (state->elf->ambiguous_addr)
 			skip_reason = "ambiguous address\n";
+		if (state->optimized_parms)
+			skip_reason = "optimized parms\n";
 
 		if (skip_reason) {
 			btf_encoder__log_func_skip(encoder, saved_fns[i].elf,
