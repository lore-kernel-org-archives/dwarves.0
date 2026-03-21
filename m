Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F4C2DF13F
	for <dwarves@vger.kernel.org>; Sat, 21 Mar 2026 23:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774134635; cv=none; b=fxAdXfCDqCmbGT4R8uTozSr5wIl3l2/EzJBCnNNHTCNPScJZxa1qe7rLm6bRJIIiF61jO9wICOjCwxMDQZWXpUeQzQgK9kLuZn+O40c6ghJcc95q/n1XiRNnMO5R67qKd8/mPx/UGs/GkcIH14c6Xk6JaUF1dPs6Z6KyTpEnGJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774134635; c=relaxed/simple;
	bh=hfJzD2JlmYnPFsyg2Ej61GkvqvKsECIxyN2aYzydLiQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QMugtnHn5gw2sm61xZaM5vVh4Q98fLDnTnhL5DitxpLdoGcEsEzbsRlUaUsE02hV1GtbNitjKmkHcfCZKsuCaieJz6LCkvZw3cBNOz5XtxbtmMKhHtecTpubIq3Y1hRFU20u60DaKX+hSt8klHw0X6U5G5AiDvEKvqThxb5Xo0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lVesIdCb; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVesIdCb"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-439c9bdc1eeso3012680f8f.3
        for <dwarves@vger.kernel.org>; Sat, 21 Mar 2026 16:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774134631; x=1774739431; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yP8SXZwcE/V/cT9XIusmisooInFGfddf9R1Afv0fWwk=;
        b=lVesIdCb558qXmKXp9Uusy5aQ1tgS1x2ds1/rxLyEAIOSjPwYI5fk5+oiC2DwjOQfV
         +Bxq//Sn34p3MIjtuBxVVM/sr6+A0yGqv3C4pHZyM3xG/SmrthspThQ4DiUiOI715tk2
         YeoZbAfznRiKBu/M0yhdcdpn+zixGqpwWK0gW5ZjdUYGFLSnNsGbPXXeiH2wD8dncQ46
         QprxnXU2EF3mk8RwBHx1AE/6v5sO1GdhJ5UyI50707t7J6tywSU2mVCQS9EOelQCug0E
         Apj0DSI4TIhQFcRng99dHl01Lc/v6Kp/oZnw8qnM6WO/DZ6Co9AHS/Nr3zc7P56fv+8/
         jDEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774134631; x=1774739431;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yP8SXZwcE/V/cT9XIusmisooInFGfddf9R1Afv0fWwk=;
        b=OTo2BWT7M5X4OppxNyntJ64fW6uzxrRxPXIbkxqFJl/ZPnVqHKCkn5Mpj012ti82SU
         33XbqzHYr4DL5SzTCHQOfw1n79+d72ql1JEToFUij6IMDHW5wtCchz91qrKTGY5rDWjW
         ZQKPHtg3Ue+M8Wx+dB/G4S1rwNzMKBvn7eNo2Ykc2jVKrtKcEhen70plEY5WZb3+imrE
         YQ72dUwK7eUTTyeTfdnVCOdBEeJlyX+FO7CVt152oU/XDWUiQiykvKqkgpWXJG85Y+Rn
         xidRryoLUhwgU6S1/niZh40VU+wkDLcCnvlzgBtuv5fFnkwA+q83RI90zsafQ50gEB97
         kYEw==
X-Forwarded-Encrypted: i=1; AJvYcCUkzE2OGDdcV+/PER3B1Yvyq9M4n+0sC8vQR9m5FSfk08YYxsv1G0hlVgp8aznXR567KrgWSdC6@vger.kernel.org
X-Gm-Message-State: AOJu0YzhzgLADwHaKnwR6IqT1VZVem7TVF/WjT8OSQdwoSz24vvdYryw
	WE+/HAq8O+zvzsGz4aAhLrrzKxJpL/UwAoBr86vCR+0xqE6PM/pXxAwT
X-Gm-Gg: ATEYQzw8jACF6iWrM86yp47AfvlQeNowALmrgOFJnC93asiSylCouUZLZ6GW7D+Jn+P
	E6/izqYHDzQ7jYs+KG0c0WWwZCd42aEP2KjD5NC72trO+nnsX27oHu9ra2KkAypdx8xaGTGs395
	Ex5mDHz4zl29sa//HLe5g4/ncTOQFnuccoQcEzZVo+0//j1YTk58ZMi38SKoNNoboaLAQ3BOfUG
	dvbuepODgLNsxlbfWmu5ZQYvBnRpbfKA3S2Nv8ZDWJqq0ET27XEPJEW1fPcK62jCox8KKUILkvW
	UHzT4mdxrlmapcV0KjeF4tC9qGRRHUk4B8jT6ZmuWrwLSpKPSIfJFajFsklc0i9dS7AonaxNqKd
	V+10/JBuKTxItX9rN/vj9f6nBigBrgB/M0GWim8ebk1LMTJXkZangbQIWOD+xBxRh8hKICuUMMs
	G0515Ncu7tC8A=
X-Received: by 2002:a5d:588e:0:b0:43b:5767:8f2a with SMTP id ffacd0b85a97d-43b6423a596mr12110449f8f.22.1774134631017;
        Sat, 21 Mar 2026 16:10:31 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b647120a1sm17818122f8f.30.2026.03.21.16.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 16:10:30 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 22 Mar 2026 00:10:28 +0100
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH dwarves v3 2/9] dwarf_loader: Handle signatures with dead
 arguments
Message-ID: <ab8lZBk2Z_1sPkZL@krava>
References: <20260320190917.1970524-1-yonghong.song@linux.dev>
 <20260320190927.1970829-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320190927.1970829-1-yonghong.song@linux.dev>

On Fri, Mar 20, 2026 at 12:09:27PM -0700, Yonghong Song wrote:
> For llvm dwarf, the dead argument may be in the middle of
> DW_TAG_subprogram. So we introduce skip_idx in order to
> match expected registers properly.
> 
> For example:
>   0x00042897:   DW_TAG_subprogram
>                   DW_AT_name      ("create_dev")
>                   DW_AT_calling_convention        (DW_CC_nocall)
>                   DW_AT_type      (0x0002429a "int")
>                   ...
> 
>   0x000428ab:     DW_TAG_formal_parameter
>                     DW_AT_name    ("name")
>                     DW_AT_type    (0x000242ed "char *")
>                     ...
> 
>   0x000428b5:     DW_TAG_formal_parameter
>                     DW_AT_location        (indexed (0x3f) loclist = 0x000027f8:
>                        [0xffffffff87681370, 0xffffffff8768137a): DW_OP_reg5 RDI
>                        [0xffffffff8768137a, 0xffffffff87681392): DW_OP_reg3 RBX
>                        [0xffffffff87681392, 0xffffffff876813ae): DW_OP_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value)
>                     DW_AT_name    ("dev")
>                     DW_AT_type    (0x00026859 "dev_t")
>                     ...
> 
> With skip_idx, we can identify that the second original argument
> 'dev' becomes the first one after optimization.

hi,
this change removes for me functions below and some of them (ata_dev_select,
dmi_save_type, perhaps more) seem to be removed because their last 2 arguments
are constants IIUC, which does not seem to be what the changelog suggests,
but I guess it's still correct (it's without +true_signature)

jirka


ata_dev_select
__cgroup1_procs_write
check_buffer_access
dax_disassociate_entry
devlink_nl_sb_port_pool_fill
dmi_format_ids
dmi_save_type
dmi_save_uuid
get_buffer
get_net_track
gue_remcsum
icmpv4_xrlim_allow
insert_vmap_area_augment
__intel_pmu_enable_all
ip6addrlbl_fill
ip6_dst_store
kernelmode_fixup_or_oops
merge_note_headers_elf32
merge_note_headers_elf64
mt_destroy_walk
__mutex_lock
__netdev_walk_all_lower_dev
pci_create_device_link
populate_kprobe_blacklist
proc_get_long
rt_mutex_adjust_prio_chain
rt_set_nexthop
run_lwt_bpf
simple_attr_write_xsigned
__skb_gro_checksum_validate_needed
tclass_notify
tg_set_conf
toggle_bp_slot
trace_event_get_offsets_aer_event
trace_event_get_offsets_br_fdb_external_learn_add
trace_event_get_offsets_br_fdb_update
trace_event_get_offsets_cache_tag_flush
trace_event_get_offsets_devlink_health_recover_aborted
trace_event_get_offsets_iommu_error
trace_event_get_offsets_prq_report
virtio_net_hdr_from_skb
writeback_inodes_wb
xfs_file_dio_write_aligned


> 
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  dwarf_loader.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index 21f8bf1..a6e6587 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -1192,6 +1192,7 @@ static ptrdiff_t __dwarf_getlocations(Dwarf_Attribute *attr,
>  
>  struct func_info {
>  	bool signature_changed;
> +	int skip_idx;
>  };
>  
>  /* For DW_AT_location 'attr':
> @@ -1264,6 +1265,7 @@ static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
>  	if (parm != NULL) {
>  		bool has_const_value;
>  		Dwarf_Attribute attr;
> +		int reg_idx;
>  
>  		tag__init(&parm->tag, cu, die);
>  		parm->name = attr_string(die, DW_AT_name, conf);
> @@ -1273,7 +1275,18 @@ static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
>  		if (!info->signature_changed) {
>  			if (cu->producer_clang || param_idx >= cu->nr_register_params)
>  				return parm;
> +		} else {
> +			/* if true_signature is not enabled, mark parameter as
> +			 * unexpected_reg since there is a skipped parameter before.
> +			 */
> +			if (!conf->true_signature && info->skip_idx) {
> +				parm->unexpected_reg = 1;
> +				return parm;
> +			}
>  		}
> +		reg_idx = param_idx - info->skip_idx;
> +		if (reg_idx >= cu->nr_register_params)
> +			return parm;
>  		/* Parameters which use DW_AT_abstract_origin to point at
>  		 * the original parameter definition (with no name in the DIE)
>  		 * are the result of later DWARF generation during compilation
> @@ -1311,7 +1324,7 @@ static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
>  		parm->has_loc = dwarf_attr(die, DW_AT_location, &attr) != NULL;
>  
>  		if (parm->has_loc) {
> -			int expected_reg = cu->register_params[param_idx];
> +			int expected_reg = cu->register_params[reg_idx];
>  			int actual_reg = parameter__reg(&attr, expected_reg);
>  
>  			if (actual_reg < 0)
> @@ -1324,8 +1337,10 @@ static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
>  				 * contents.
>  				 */
>  				parm->unexpected_reg = 1;
> -		} else if (has_const_value) {
> +		} else if (has_const_value || info->signature_changed) {
>  			parm->optimized = 1;
> +			if (info->signature_changed)
> +				info->skip_idx++;
>  		}
>  	}
>  
> -- 
> 2.52.0
> 
> 
