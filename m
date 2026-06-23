Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369D02D63E5
	for <dwarves@vger.kernel.org>; Tue, 23 Jun 2026 12:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782217688; cv=none; b=nDBv+CAB8Q6lFavDyPyJ2+eHJLkKvrAeWsTgAjbGIEBwI9unj9CnZqmIR8Yrk+IQhNpMBJlHBzkzdPQs2EOZGyz/TDQc13h4rpeY99LzYPImSHs03rV6/bY44DeaDfZAoTyaJaCsYPj2A8fxAgHyqRG3iGf5NVr5GNC6xj2DdTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782217688; c=relaxed/simple;
	bh=/bTu3MNTEVdHhZcO3jDEhKtUuHUkWLLNdyZJrdCdRe4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KUp4JfARzNCQ0WpiyR3/ZglHSK5y3GT3acAzTTPjiZfc0nSsPD8XeTkM1SyJCEII9Pj3auyO41rr0gbqCqGks8oaWnzuJWVXyXeIClgGJ1oaFgUN8GqF880h54c3UyeSpEEalqe+2sJ+czlFKmZvQaPzKiyHdib4xIHrsjAIxDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nNlzz+9Z; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNlzz+9Z"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490a76757e5so35152405e9.2
        for <dwarves@vger.kernel.org>; Tue, 23 Jun 2026 05:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782217682; x=1782822482; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i2mvJfLkr5SKzss4bphItGRk6l6vajlPI9RRqte5OEQ=;
        b=nNlzz+9ZQSuIuM6V5+liwwyak6f1tlanrfttkZpJd8FUyfRoYNXxhciU/oEbAjtDDn
         uYYRZLOgxg/el8qs2QqpE7YrklIDev75aXIySQPcoKQpP6lHS+I4eRc7DhRH8IMrkVNq
         G3jbAo7jDhhbeGGa3H+4BvLJTa21uXw2Wg+pgoHXgND1YHY84OOhQ+r1TrdJsXiYMUVG
         BAXK0ew73AkTZVxNJ72+aM4U/Bdg0kScYqEWX2r5++Ndpe0j3WDXqhtsdh+BdYIaTTFr
         DV77GOzgmtBQbXCMiikbznkFYHnv/I8M6/Q+m5MMdgcZ7R4E9UeFnSeUKmvapbeZN8EM
         3xAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782217682; x=1782822482;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i2mvJfLkr5SKzss4bphItGRk6l6vajlPI9RRqte5OEQ=;
        b=rY/YfJfww8b4CNjLi7X6OksGQGENVaR8vLbclZeEPezPUqh1n7PPHey83FlWvsi5GD
         t7V6TirdhzNhawHVdTLs42AcqZswyuJoA9AG5Qa6ROX6tOkqGIK1vqpOsa0d0pzUNjUq
         js/s1af14dQZFx7jIWc7wuFL9ZRMTx173CZWsyPrOVYcEOwdeEeuxzU5vQaFtRU6n4oN
         KQbuI7s0Sr5+FR/piUc6lqQDbnex332IyojKEaAFGHbVsXFBRhAWc4rMpgwsknD8FuZO
         Bf/pAaAehO9HFaRmNcoRZ/hqbg2NiHtxqSXYFFw4HiTUem0YpLYclCx25GB6h6SECJVI
         2aLw==
X-Forwarded-Encrypted: i=1; AFNElJ8p3NOqr+97ozGW/N5gekbjet+V9O8w3N2Xu6m2dDohPPaweIPnspYgFAlk1rs6CcCv8Lul+FeS@vger.kernel.org
X-Gm-Message-State: AOJu0YxcOlXuloPjfKBNXTMvHtcGX3ns2GLbkduEeSON9j6Y2zAIYeL9
	EPBAg8eDKNg4X/Gy52vz7SWQbLAdC2XK2BtRT7YXK9DZscWh8M7rFuOt
X-Gm-Gg: AfdE7cn2ZRP7oLj+K39Q2c1XhwHolE+lD6PpHnIiQPbxFsMXmxG5b9kRRpcH2JYTzDu
	iPktL+g+iOULSoy/I7+OgAq9v/gRJkGD4us7EPU9CGfF/TfJuoZEx4EI6/Lz/K+VoYi5OjckEYf
	ftiplDArZnWVsNGS7MsOZi/JDQD5fU5ZYNSI0x0MxvARbFLUTZgHrHsdNmwykd+QNaCvU53wNrq
	ybXJ3OujwEmt/gGfZcL2q8qlBQ9f9Wo1ovfVqd5PoT06y6/w/hk1FxYczGfU52Bjpa9B1Qk2VNF
	/+ll53nyn0pSCYoCCiYDlMStUzsujUhyuKvn/HnrydYqaSBNCVmeb+BRF5yBR/P6QJSypB+gH+G
	O9IP9x09ZX1Q5nTMDupWC9KlCzgKFQWwMOZoxD/madvIsdZLtzZhf+E8PI7h18NhofVDTz99zPt
	xs
X-Received: by 2002:a05:600c:698d:b0:490:bd66:e523 with SMTP id 5b1f17b1804b1-4925b52bf9emr29875095e9.20.1782217681963;
        Tue, 23 Jun 2026 05:28:01 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923ff821aasm395752095e9.12.2026.06.23.05.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 05:28:01 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 23 Jun 2026 14:28:00 +0200
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH dwarves v7 0/5] pahole: Encode true signatures in kernel
 BTF
Message-ID: <ajp70MRjHvCJNeyv@krava>
References: <20260623040704.2732530-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623040704.2732530-1-yonghong.song@linux.dev>

On Mon, Jun 22, 2026 at 09:07:04PM -0700, Yonghong Song wrote:
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
> I did experiment with latest bpf-next. For x86_64, there are 69103 kernel functions
> and 875 kernel functions having signature changed. A series of patches are intended
> to ensure true signatures are properly represented. Eventually, only 20 functions
> cannot have true signatures due to locations.

hi,
I tried to get the numbers from my setup and noticed that some new
functions were included in BTF compared to the current version
(functions diff attached below)

like for "arp_process" function the current pahole gives me:

  arp_process : skipping BTF encoding of function due to unexpected register usage for parameter

but it's included in BTF generated with the new pahole.

in addition to your explanation above also one of the commit says:

     - a parameter with no location, a constant value, or (for non-clang) no
       register found is marked optimized out

please check below, it seems like 2nd argument of arp_process has no location,
so iiuc it should not be included in BTF, right?

thanks,
jirka


---
the dwarf for arp_process:

0x0caa9fd5:   DW_TAG_subprogram
                DW_AT_low_pc    (0xffffffff82551d00)
                DW_AT_high_pc   (0xffffffff82552333)
                DW_AT_frame_base        (DW_OP_call_frame_cfa, DW_OP_consts -120, DW_OP_plus)
                DW_AT_call_all_calls    (true)
                DW_AT_name      ("arp_process")
                DW_AT_decl_file ("/home/jolsa/kernel/linux-qemu-1/net/ipv4/arp.c")
                DW_AT_decl_line (702)
                DW_AT_prototyped        (true)
                DW_AT_calling_convention        (DW_CC_nocall)
                DW_AT_type      (0x0ca8c76d "int")
                  
0x0caa9fed:     DW_TAG_variable
                  DW_AT_name    ("__UNIQUE_ID_addressable___SCK__WARN_trap_1227")
                  DW_AT_type    (0x0ca8ea97 "void *")
                  DW_AT_decl_file       ("/home/jolsa/kernel/linux-qemu-1/net/ipv4/arp.c")
                  DW_AT_decl_line       (774)
                  DW_AT_location        (DW_OP_addrx 0x1f)

0x0caa9ffb:     DW_TAG_variable
                  DW_AT_name    ("__UNIQUE_ID_addressable___SCK__WARN_trap_1228")
                  DW_AT_type    (0x0ca8ea97 "void *")
                  DW_AT_decl_file       ("/home/jolsa/kernel/linux-qemu-1/net/ipv4/arp.c")
                  DW_AT_decl_line       (785)
                  DW_AT_location        (DW_OP_addrx 0x20)

0x0caaa009:     DW_TAG_formal_parameter
                  DW_AT_location        (indexed (0x10d) loclist = 0x014fb1b5:
                     [0xffffffff82551d05, 0xffffffff82551e5e): DW_OP_reg5 RDI
                     [0xffffffff82551e5e, 0xffffffff82551f52): DW_OP_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value
                     [0xffffffff82551f52, 0xffffffff82551fc1): DW_OP_reg5 RDI
                     [0xffffffff82551fc1, 0xffffffff82552046): DW_OP_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value
                     [0xffffffff82552046, 0xffffffff8255204b): DW_OP_reg5 RDI
                     [0xffffffff8255204b, 0xffffffff8255206b): DW_OP_breg7 RSP+24
                     [0xffffffff8255206b, 0xffffffff82552333): DW_OP_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value)
                  DW_AT_name    ("net")
                  DW_AT_decl_file       ("/home/jolsa/kernel/linux-qemu-1/net/ipv4/arp.c")
                  DW_AT_decl_line       (702)
                  DW_AT_type    (0x0ca994c0 "net *")

0x0caaa016:     DW_TAG_formal_parameter
                  DW_AT_name    ("sk")
                  DW_AT_decl_file       ("/home/jolsa/kernel/linux-qemu-1/net/ipv4/arp.c")
                  DW_AT_decl_line       (702)
                  DW_AT_type    (0x0ca8dde2 "sock *")

0x0caaa020:     DW_TAG_formal_parameter
                  DW_AT_location        (indexed (0x10e) loclist = 0x014fb1f3:
                     [0xffffffff82551d05, 0xffffffff82551e3f): DW_OP_reg4 RSI
                     [0xffffffff82551e3f, 0xffffffff82551ef6): DW_OP_breg7 RSP+0
                     [0xffffffff82551f05, 0xffffffff82551f52): DW_OP_breg7 RSP+0
                     [0xffffffff82551f52, 0xffffffff82551fcb): DW_OP_reg4 RSI
                     [0xffffffff82551fcb, 0xffffffff82551ff2): DW_OP_entry_value(DW_OP_reg4 RSI), DW_OP_stack_value
                     [0xffffffff82551ff2, 0xffffffff825521ce): DW_OP_breg7 RSP+0
                     [0xffffffff825521e7, 0xffffffff825522ab): DW_OP_breg7 RSP+0
                     [0xffffffff825522c6, 0xffffffff8255232e): DW_OP_breg7 RSP+0
                     [0xffffffff8255232e, 0xffffffff82552333): DW_OP_entry_value(DW_OP_reg4 RSI), DW_OP_stack_value)
                  DW_AT_name    ("skb")
                  DW_AT_decl_file       ("/home/jolsa/kernel/linux-qemu-1/net/ipv4/arp.c")
                  DW_AT_decl_line       (702)
                  DW_AT_type    (0x0ca8d567 "sk_buff *")



--- funcs.base.pure	2026-06-22 12:59:25.552679284 +0200
+++ funcs.new.pure	2026-06-22 12:59:38.672655863 +0200
@@ -71,6 +71,7 @@ __aafs_profile_mkdir
 __aafs_profile_rmdir
 aafs_remove
 __aa_fs_remove_rawdata
+__aafs_setup_d_inode
 aafs_show_path
 aa_get_buffer
 aa_get_current_label
@@ -780,6 +781,7 @@ acpi_ex_create_processor
 acpi_ex_create_region
 acpi_ex_data_table_space_handler
 acpi_ex_do_concatenate
+acpi_ex_do_debug_object
 acpi_ex_do_logical_numeric_op
 acpi_ex_do_logical_op
 acpi_ex_do_match
@@ -1094,7 +1096,6 @@ acpi_irq_isa
 acpi_irq_nobalance_set
 acpi_irq_pci
 acpi_irq_penalty_init
-acpi_irq_penalty_update
 acpi_irq_stats_init
 acpi_isa_irq_available
 acpi_isa_irq_to_gsi
@@ -1296,6 +1297,7 @@ acpi_of_match_device
 acpi_old_suspend_ordering
 acpi_os_acquire_lock
 acpi_osc_error_check
+acpi_osc_handshake
 acpi_os_create_cache
 acpi_os_create_semaphore
 acpi_os_delete_cache
@@ -1310,6 +1312,7 @@ acpi_os_get_root_pointer
 acpi_os_get_timer
 acpi_osi_dmi_blacklisted
 acpi_osi_dmi_darwin
+acpi_osi_dmi_linux
 acpi_osi_handler
 acpi_osi_init
 acpi_osi_is_win8
@@ -2022,6 +2025,7 @@ add_acpi_hid_device
 add_addr
 add_addr_generate_hmac
 add_addr_hmac_valid
+add_bits
 __add_block_group_free_space
 add_bootloader_randomness
 add_boot_memory_ranges
@@ -2190,6 +2194,7 @@ add_to_machine_keyring
 add_to_page_cache_lru
 add_to_pipe
 add_to_platform_keyring
+add_to_rb
 add_to_secondary_keyring
 add_tracer
 add_tracer_options
@@ -2413,7 +2418,6 @@ ahash_def_finup_done1
 ahash_def_finup_done2
 ahash_do_req_chain
 ahash_finup_done
-ahash_finup_finish
 ahash_free_singlespawn_instance
 ahash_nosetkey
 ahash_prepare_alg
@@ -2439,6 +2443,7 @@ ahci_enable_ahci
 ahci_enable_fbs
 ahci_error_handler
 ahci_error_intr
+ahci_exec_polled_cmd
 ahci_fill_cmd_slot
 ahci_freeze
 ahci_get_irq_vector
@@ -2686,6 +2691,7 @@ alloc_iova_fast
 alloc_irq_index
 alloc_irq_lookup_table
 alloc_irq_table
+alloc_isa_irq_from_domain
 alloc_large_system_hash
 alloc_lookup_fw_priv
 alloc_low_pages
@@ -2750,6 +2756,7 @@ alloc_slab_obj_exts
 alloc_sleep_millisecs_show
 alloc_sleep_millisecs_store
 alloc_stable_node_chain
+alloc_stripe
 alloc_surplus_hugetlb_folio
 alloc_swapdev_block
 alloc_swap_scan_cluster
@@ -3026,6 +3033,7 @@ amd_pstate_epp_resume
 amd_pstate_epp_set_policy
 amd_pstate_fast_switch
 amd_pstate_get_current_attrs
+amd_pstate_get_mode_string
 amd_pstate_get_status
 amd_pstate_init
 amd_pstate_init_floor_perf
@@ -3096,6 +3104,7 @@ amdv1_get_info
 amdv1_map_range
 amdv1_unmap_range
 amiga_partition
+analyse_superblocks
 analyze_sbs
 analyze_subprog
 announce_device
@@ -3311,6 +3320,7 @@ append_e820_table
 append_elf_note
 append_filter_err
 append_kcore_note
+append_mas_cp
 append_wr_mas_cp
 apple_airport_reset
 apply_alternatives
@@ -3607,6 +3617,7 @@ arp_mc_map
 arp_netdev_event
 arp_net_exit
 arp_net_init
+arp_process
 arp_rcv
 arp_req_delete
 arp_req_dev
@@ -3647,6 +3658,7 @@ array_state_show
 array_state_store
 ars_complete
 asn1_ber_decoder
+aspm_attr_store_common
 aspm_ctrl_attrs_are_visible
 aspm_l1_acceptable_latency
 assert_eb_folio_uptodate
@@ -4334,6 +4346,7 @@ auditsc_get_stamp
 audit_seccomp
 audit_seccomp_actions_logged
 audit_send_list_thread
+audit_send_reply
 audit_send_reply_thread
 audit_serial
 audit_set_backlog_limit
@@ -4670,6 +4683,7 @@ basic_dump
 basic_get
 basic_init
 basic_walk
+batcher_init
 battery_ac_is_broken_quirk
 battery_bix_broken_package_quirk
 battery_hook_exit
@@ -5178,7 +5192,6 @@ bh_pool_irq_work
 bh_pool_kick_highpri
 bh_pool_kick_normal
 __bh_read
-bh_read
 __bh_read_batch
 __bh_submit
 bh_submit
@@ -5256,6 +5269,7 @@ binder_get_object
 binder_get_thread
 binder_get_txn_from_and_acq_inner
 binder_has_work
+binder_inc_node
 binder_inc_node_nilocked
 binder_inc_ref_for_node
 binder_init
@@ -5297,6 +5311,7 @@ binder_transaction
 binder_transaction_buffer_release
 binder_translate_binder
 binder_translate_fd
+binder_translate_fd_array
 binder_translate_handle
 binder_txn_latency_free
 binder_update_ref_for_handle
@@ -6361,6 +6376,7 @@ bond_xdp_xmit
 bond_xmit_alb_slave_get
 bond_xmit_broadcast
 bond_xmit_get_slave
+__bond_xmit_hash
 bond_xmit_hash
 bond_xmit_roundrobin_slave_get
 bond_xmit_tlb_slave_get
@@ -6500,6 +6516,7 @@ bpf_core_apply
 bpf_core_calc_field_relo
 bpf_core_calc_relo
 bpf_core_calc_relo_insn
+bpf_core_composites_match
 bpf_core_essential_name_len
 bpf_core_find_cands
 bpf_core_format_spec
@@ -7897,6 +7914,7 @@ bpf_skb_get_tunnel_key
 bpf_skb_get_tunnel_opt
 bpf_skb_get_xfrm_info
 bpf_skb_get_xfrm_state
+bpf_skb_is_valid_access
 __bpf_skb_load_bytes
 bpf_skb_load_bytes
 bpf_skb_load_bytes_relative
@@ -10052,6 +10070,7 @@ btf_find_dtor_kfunc
 btf_find_field_one
 btf_find_func_proto
 btf_find_graph_root
+btf_find_kptr
 btf_find_next_decl_tag
 btf_find_struct_field
 btf_find_struct_member
@@ -10116,6 +10135,7 @@ btf_parse_graph_root
 btf_parse_hdr
 btf_parse_layout_sec
 btf_parse_str_sec
+btf_parse_struct_metas
 btf_parse_type_sec
 btf_parse_vmlinux
 btf_prepare_func_args
@@ -10153,6 +10173,7 @@ btf_struct_check_meta
 btf_struct_ids_match
 btf_struct_log
 btf_struct_resolve
+__btf_struct_show
 btf_struct_show
 btf_struct_walk
 btf_sysfs_vmlinux_mmap
@@ -10205,6 +10226,7 @@ btree_insert_fn
 btree_insert_key
 btree_insert_raw
 btree_invalidate_folio
+btree_lookup_raw
 btree_mergesort
 btree_migrate_folio
 btree_node_free
@@ -11652,6 +11674,7 @@ bus_uevent_filter
 bus_uevent_store
 bus_unregister
 bus_unregister_notifier
+busy_poll_stop
 bvec_npages
 bvec_try_merge_hw_page
 bvec_try_merge_page
@@ -11860,6 +11883,7 @@ call_hid_bpf_rdesc_fixup
 call_instance
 call_netdevice_notifiers
 call_netdevice_notifiers_info
+call_netdevice_notifiers_mtu
 call_netdevice_register_net_notifiers
 call_netevent_notifiers
 call_nexthop_notifiers
@@ -11867,6 +11891,7 @@ __call_nexthop_res_bucket_notifiers
 call_proc_get_link
 call_rcu
 call_rcu_hurry
+call_rcu_nocb
 __call_rcu_nocb_wake
 call_rcu_tasks
 call_rcu_tasks_generic
@@ -11906,6 +11931,7 @@ can_clear_store
 can_cow_file_range_inline
 can_demote
 can_do_mlock
+can_finish_ordered_extent
 can_follow_write_common
 can_free_region
 can_map_frag
@@ -12357,7 +12383,6 @@ check_attach_btf_id
 check_attach_modify_return
 check_bpf_snprintf_call
 __check_buffer_access
-check_buffer_access
 check_buffer_tree_ref
 check_can_switch
 check_cgroupfs_options
@@ -12524,7 +12549,6 @@ check_x2apic
 check_xattrs
 check_xstate_against_struct
 check_xtile_data_against_struct
-check_zeroed_sockptr
 check_zeroed_user
 check_zero_holes
 child_notify
@@ -12597,6 +12621,7 @@ cipso_v4_doi_putdef
 cipso_v4_doi_remove
 cipso_v4_doi_walk
 cipso_v4_error
+cipso_v4_genopt
 cipso_v4_getattr
 cipso_v4_init
 cipso_v4_map_cache_hash
@@ -12704,7 +12729,6 @@ clear_mce_nospec
 clear_nlink
 clear_node_memory_type
 clear_or_poison_free_pages
-clear_page
 clear_page_dirty_for_io
 __clear_page_guard
 ClearPageHWPoisonTakenOff
@@ -13363,6 +13387,7 @@ common_mmap
 common_nsleep
 common_nsleep_timens
 common_perm_cond
+common_perm_create
 common_perm_rm
 common_read
 common_rfc4106_set_authsize
@@ -13387,7 +13412,6 @@ compaction_suit_allocation_order
 compaction_unregister_node
 compaction_zonelist_suitable
 compact_lock_irqsave
-compact_node
 compact_store
 compact_zone
 companion_show
@@ -13862,7 +13886,6 @@ copy_sysctl_value
 copy_templates
 copy_thread
 copy_time_ns
-copy_to_bpfptr_offset
 _copy_to_iter
 copy_to_kernel_nofault
 copy_to_sk
@@ -13878,6 +13901,7 @@ copy_uabi_from_kernel_to_xstate
 copy_uabi_to_xstate
 copy_urb_data_to_user
 copy_user_flushcache
+copy_user_gigantic_page
 copy_user_large_folio
 copy_user_offload
 copy_user_syms
@@ -13936,7 +13960,6 @@ count_device
 count_dimms
 counter_set
 counter_show
-count_memcg_event_mm
 count_memcg_events
 count_mem_devices
 count_memory_range_altmaps_cb
@@ -15480,6 +15503,7 @@ cypress_disconnect
 cypress_init
 cypress_process_packet
 cypress_protocol_handler
+cypress_ps2_ext_cmd
 cypress_reconnect
 cypress_reset
 cypress_send_ext_cmd
@@ -15627,10 +15651,12 @@ dbg_get_reg
 dbg_io_get_char
 dbg_late_init
 dbg_notify_reboot
+dbgp_control_msg
 _dbgp_external_startup
 dbgp_external_startup
 dbg_pnp_show_option
 dbg_pnp_show_resources
+dbg_port_buf
 dbgp_reset_prep
 dbgp_wait_until_done
 dbg_release_bp_slot
@@ -15689,8 +15715,10 @@ dcbnl_ieee_set
 dcbnl_init
 dcbnl_netdevice_event
 dcbnl_notify
+__dcbnl_pg_getcfg
 dcbnl_pgrx_getcfg
 dcbnl_pgrx_setcfg
+__dcbnl_pg_setcfg
 dcbnl_pgtx_getcfg
 dcbnl_pgtx_setcfg
 dcbnl_setall
@@ -15933,7 +15961,6 @@ dec_bypass_depth
 dec_dl_tasks_cs
 dec_index
 dec_in_flight
-dec_mm_counter
 __dec_node_page_state
 dec_node_page_state
 __dec_node_state
@@ -15947,7 +15974,6 @@ decode_osc_control
 decode_register
 __decode_register_operand
 decode_rs8
-decode_tail
 decompress_method
 decompress_single
 decompress_threadfn
@@ -16701,6 +16727,7 @@ devlink_nl_health_reporter_get_dump_one
 devlink_nl_health_reporter_recover_doit
 devlink_nl_health_reporter_set_doit
 devlink_nl_health_reporter_test_doit
+devlink_nl_info_fill
 devlink_nl_info_get_doit
 devlink_nl_info_get_dumpit
 devlink_nl_info_get_dump_one
@@ -16713,6 +16740,7 @@ devlink_nl_msg_reply_and_new
 devlink_nl_nested_fill
 devlink_nl_notify_filter
 devlink_nl_notify_filter_set_doit
+devlink_nl_param_fill
 devlink_nl_param_get_doit
 devlink_nl_param_get_dumpit
 devlink_nl_param_get_dump_one
@@ -16751,6 +16779,7 @@ devlink_nl_rate_new_doit
 devlink_nl_rate_set
 devlink_nl_rate_set_doit
 devlink_nl_region_del_doit
+devlink_nl_region_fill
 devlink_nl_region_get_doit
 devlink_nl_region_get_dumpit
 devlink_nl_region_get_dump_one
@@ -16759,16 +16788,20 @@ devlink_nl_region_notify
 devlink_nl_region_notify_build
 devlink_nl_region_read_dumpit
 devlink_nl_region_read_fill
+devlink_nl_region_snapshots_id_put
+devlink_nl_reload_actions_performed_snd
 devlink_nl_reload_doit
 devlink_nl_resource_dump_doit
 devlink_nl_resource_dump_dumpit
 devlink_nl_resource_dump_one
 devlink_nl_resource_set_doit
+devlink_nl_sb_fill
 devlink_nl_sb_get_doit
 devlink_nl_sb_get_dumpit
 devlink_nl_sb_get_dump_one
 devlink_nl_sb_occ_max_clear_doit
 devlink_nl_sb_occ_snapshot_doit
+devlink_nl_sb_pool_fill
 devlink_nl_sb_pool_get_doit
 devlink_nl_sb_pool_get_dumpit
 devlink_nl_sb_pool_get_dump_one
@@ -16808,6 +16841,7 @@ devlink_nl_trap_set_doit
 devlink_notify
 devlink_notify_register
 devlink_notify_unregister
+devlink_param_notify
 devlink_params_driverinit_load_new
 devlink_params_notify_register
 devlink_params_notify_unregister
@@ -16879,12 +16913,14 @@ devlink_remote_reload_actions_performed
 devlink_remove_symlinks
 devlink_resource_dump_fill_one
 __devlink_resource_find
+devlink_resource_put
 devlink_resource_size_params_put
 devlink_resources_unregister
 devlink_resources_validate
 devlink_resource_unregister
 devlink_sb_register
 devlink_sb_unregister
+devlink_selftest_result_put
 devlink_shd_get
 devlink_shd_get_priv
 devlink_shd_put
@@ -16943,6 +16979,7 @@ devl_region_destroy
 devl_register
 devl_resource_occ_get_register
 devl_resource_occ_get_unregister
+__devl_resource_register
 devl_resource_register
 devl_resource_size_get
 devl_resources_unregister
@@ -17504,6 +17541,7 @@ dev_pm_set_wake_irq
 dev_pm_skip_resume
 dev_pm_skip_suspend
 dev_port_show
+dev_prep_valid_name
 __dev_printk
 _dev_printk
 dev_printk_emit
@@ -17892,6 +17930,7 @@ dl_task_timer
 dma_addressing_limited
 dma_alloc_attrs
 dma_alloc_contiguous
+dma_alloc_from_contiguous
 dma_alloc_from_pool
 dma_alloc_noncontiguous
 __dma_alloc_pages
@@ -19332,9 +19371,11 @@ do_set_acl
 do_setattr
 do_set_cpus_allowed
 do_setitimer
+do_setlink
 do_set_master
 do_set_mempolicy
 do_set_msr
+do_set_pmd
 do_set_proto_down
 do_set_thread_area
 do_settimeofday64
@@ -19342,7 +19383,6 @@ do_shmat
 do_shm_rmid
 do_shrink_slab
 do_sigaction
-do_sigaltstack
 do_sigbus
 do_signalfd4
 do_signal_stop
@@ -19625,6 +19665,7 @@ dr_node_free
 dr_node_release
 drop_caches_sysctl_handler
 drop_collected_paths
+drop_delayed_ref
 drop_inode_items
 drop_links
 drop_mm_ref_this_cpu
@@ -19693,6 +19734,7 @@ dst_cache_set_ip4
 dst_cache_set_ip6
 dst_clone
 dst_cow_metrics_generic
+dst_destroy
 __dst_destroy_metrics_generic
 dst_destroy_rcu
 dst_dev_put
@@ -19999,6 +20041,7 @@ early_calculate_totalpages
 early_check_pages
 early_cma
 early_coherent_pool
+earlycon_init
 earlycon_print_info
 early_console_register
 early_cpu_init
@@ -20011,6 +20054,7 @@ early_dump_pci_device
 early_ehci_bios_handoff
 early_enable_events
 early_enable_iommu
+early_event_add_tracer
 early_fixup_exception
 early_hostname
 early_identify_cpu
@@ -20298,6 +20342,7 @@ efi_enter_virtual_mode
 efi_esrt_init
 efifb_add_links
 efifb_check_and_swap_width_height
+efifb_set_system
 efifb_set_system_callback
 efifb_setup_from_dmi
 efifb_swap_width_height
@@ -20342,6 +20387,7 @@ efi_mokvar_sysfs_read
 efi_mokvar_table_init
 efi_native_runtime_setup
 efi_partition
+efi_pa_va_lookup
 efipostcore_init
 efi_power_off
 efi_poweroff_required
@@ -20584,9 +20630,11 @@ em_iret
 emit_bpf_dispatcher
 emit_fiemap_extent
 emit_ldx
+emit_ldx_index
 emit_mov_imm64
 emit_spectre_bhb_barrier
 emit_stx
+emit_stx_index
 em_jcxz
 em_jmp_abs
 em_jmp_far
@@ -20935,6 +20983,7 @@ error_context
 error_retry_list
 errors_show
 errors_store
+error_tg_ok
 err_pos
 err_ptr
 errseq_check
@@ -21211,9 +21260,11 @@ ethtool_get_phy_stats
 ethtool_get_regs
 ethtool_get_ringparam
 ethtool_get_rxfh
+ethtool_get_rxfh_fields
 ethtool_get_rxfh_indir
 ethtool_get_rxnfc
 ethtool_get_rx_ring_count
+ethtool_get_rxrings
 ethtool_get_settings
 ethtool_get_sset_info
 ethtool_get_stats
@@ -21273,6 +21324,7 @@ ethtool_set_per_queue
 ethtool_set_per_queue_coalesce
 ethtool_set_ringparam
 ethtool_set_rxfh
+ethtool_set_rxfh_fields
 ethtool_set_rxfh_indir
 ethtool_set_rxnfc
 ethtool_set_settings
@@ -22001,6 +22053,7 @@ ext4_journalled_dirty_folio
 __ext4_journalled_invalidate_folio
 ext4_journalled_invalidate_folio
 ext4_journalled_write_end
+ext4_journalled_zero_new_buffers
 __ext4_journal_start_reserved
 __ext4_journal_start_sb
 __ext4_journal_stop
@@ -22700,6 +22753,7 @@ fib4_semantics_exit
 fib4_semantics_init
 fib4_seq_read
 fib6_add
+fib6_add_1
 fib6_add_rt2node
 fib6_age_exceptions
 fib6_check_nexthop
@@ -22750,6 +22804,7 @@ fib6_notifier_exit
 fib6_notifier_init
 fib6_purge_rt
 fib6_remove_prefsrc
+fib6_repair_tree
 fib6_rt_update
 fib6_rule_action
 fib6_rule_compare
@@ -22809,7 +22864,6 @@ fib_info_notify_update
 fib_info_update_nhc_saddr
 fib_insert_alias
 __fib_lookup
-fib_lookup
 fib_lookup_good_nhc
 fib_magic
 fib_metrics_match
@@ -23013,6 +23067,7 @@ filesystems_proc_show_fallback
 filesystems_thaw
 filesystems_thaw_callback
 file_to_blk_mode
+file_tty_write
 file_update_time
 file_update_time_flags
 file_write_and_wait_range
@@ -23103,7 +23158,9 @@ find_candidate
 find_cap
 __find_child
 find_cma_memrange
+find_cpio_data
 find_css_set
+_find_current_opp
 __find_dbgp
 find_dbgp
 find_deepest_state
@@ -23194,6 +23251,7 @@ find_mboard_resource
 find_mci_by_dev
 find_memory_area
 find_mergeable_anon_vma
+find_microcode_in_initrd
 find_module
 find_module_all
 find_module_sections
@@ -23468,6 +23526,8 @@ flow_offload_hash_obj
 flow_offload_ipv6_mangle
 flow_offload_lookup
 flow_offload_netdev_event
+flow_offload_port_dnat
+flow_offload_port_snat
 flow_offload_redirect
 flow_offload_refresh
 flow_offload_route_init
@@ -23582,6 +23642,7 @@ __flush_workqueue
 flush_workqueue_prep_pwqs
 __flush_write_list
 fl_walk
+fmt_reg_mask
 fmt_spis_mask
 fn_bare_num
 fn_boot_it
@@ -24238,6 +24299,7 @@ free_root_pointers
 free_rs
 free_rt_sched_group
 free_sched_domains
+free_scratch_buffer
 free_shared_cgroup_storage_rcu
 free_shrinker_info
 free_signal_struct
@@ -24635,7 +24697,6 @@ fsp_detect
 fsp_disconnect
 fsp_get_sn
 fsp_init
-fsp_onpad_hscr
 fsp_opc_tag_enable
 fsp_page_reg_write
 fsp_process_byte
@@ -24765,6 +24826,7 @@ ftrace_graph_get_ret_stack
 ftrace_graph_init_idle_task
 ftrace_graph_init_task
 ftrace_graph_notrace_open
+__ftrace_graph_open
 ftrace_graph_open
 ftrace_graph_probe_sched_switch
 ftrace_graph_release
@@ -25249,6 +25311,7 @@ fuse_uring_register
 fuse_uring_remove_pending_req
 fuse_uring_req_end
 fuse_uring_request_expired
+fuse_uring_send
 fuse_uring_send_in_task
 fuse_uring_stop_list_entries
 fuse_uring_stop_queues
@@ -25680,6 +25743,7 @@ geneve_link_config
 geneve_lookup
 geneve_netdevice_event
 geneve_newlink
+geneve_nl2info
 geneve_offload_rx_ports
 geneve_open
 geneve_setup
@@ -25702,6 +25766,7 @@ genl_bind
 genl_ctrl_event
 genl_done
 genl_dumpit
+genl_family_rcv_msg_attrs_parse
 genl_family_rcv_msg_doit
 genl_family_rcv_msg_dumpit
 genl_get_cmd
@@ -25978,6 +26043,7 @@ get_kthread_comm
 get_kvmclock
 get_kvmclock_ns
 get_l4proto
+get_last_crashkernel
 get_last_extent
 get_linear_data
 get_links
@@ -26021,7 +26087,6 @@ get_net_ns
 get_net_ns_by_fd
 get_net_ns_by_id
 get_net_ns_by_pid
-get_net_track
 get_next_block
 get_next_ino
 get_next_modinfo
@@ -26475,6 +26540,8 @@ gpio_set_debounce_timeout
 gpio_set_open_drain_value_commit
 gpio_set_open_source_value_commit
 gpio_to_desc
+gp_try_fixup_and_notify
+gp_user_force_sig_segv
 grab_mapping_entry
 grab_requested_mnt_ns
 grab_requested_root
@@ -26613,6 +26680,7 @@ haltpoll_init
 haltpoll_reflect
 haltpoll_select
 haltpoll_uninit
+handle_active_stripes
 handle_bad_irq
 handle_bad_prq_event
 handle_bug
@@ -26963,6 +27031,7 @@ hid_device_probe
 hid_device_release
 hid_device_remove
 hiddev_ioctl
+hiddev_ioctl_string
 hiddev_ioctl_usage
 hiddev_lookup_report
 hiddev_open
@@ -27061,6 +27130,8 @@ hidraw_poll
 hidraw_read
 hidraw_release
 hidraw_report_event
+hidraw_ro_variable_size_ioctl
+hidraw_rw_variable_size_ioctl
 hidraw_send_report
 hidraw_write
 __hid_register_driver
@@ -27278,6 +27349,7 @@ hrtimer_nanosleep
 hrtimer_nanosleep_restart
 hrtimer_next_event_without
 __hrtimer_rearm_deferred
+__hrtimer_reprogram
 hrtimer_reprogram
 __hrtimer_run_queues
 hrtimer_run_queues
@@ -27567,6 +27639,7 @@ hugetlb_cgroup_uncharge_file_region
 __hugetlb_cgroup_uncharge_folio
 hugetlb_cgroup_uncharge_folio
 hugetlb_cgroup_uncharge_folio_rsvd
+hugetlb_cgroup_write
 hugetlb_cgroup_write_dfl
 hugetlb_cgroup_write_legacy
 hugetlb_change_protection
@@ -28659,6 +28732,7 @@ icl_set_topdown_event_period
 icl_update_topdown_event
 icmp6_checkentry
 icmp6_dst_alloc
+icmp6_ext_append
 icmp6_ext_objs_append
 icmp6_match
 icmp6_send
@@ -28705,6 +28779,8 @@ icmpv6_pkt_to_tuple
 icmpv6_push_pending_frames
 icmpv6_rcv
 icmpv6_route_lookup
+icmpv6_rt_has_prefsrc
+icmpv6_xrlim_allow
 ida_alloc_range
 ida_destroy
 ida_find_first_range
@@ -28778,6 +28854,7 @@ idt_setup_apic_and_irq_gates
 idt_setup_early_handler
 idt_setup_early_pf
 idt_setup_early_traps
+idt_setup_from_table
 idt_setup_traps
 idVendor_show
 if6_proc_exit
@@ -28972,6 +29049,7 @@ ima_lsm_policy_change
 ima_match_policy
 ima_measure_critical_data
 ima_measurements_next
+_ima_measurements_open
 ima_measurements_open
 ima_measurements_release
 ima_measurements_show
@@ -29028,6 +29106,7 @@ ima_update_binary_runtime_size
 ima_update_policy
 ima_update_policy_flags
 ima_validate_range
+ima_write_policy
 im_explorer_detect
 impl_proc_make_permanent
 __import_iovec
@@ -29089,6 +29168,7 @@ inet4_pton
 inet6_add_offload
 inet6_add_protocol
 inet6_addr_add
+inet6_addr_del
 inet6_addr_modify
 inet6addr_notifier_call_chain
 inet6addr_validator_notifier_call_chain
@@ -29357,6 +29437,8 @@ ingress_unbind_filter
 ingress_walk
 in_group_or_capable
 in_group_p
+inherit_event
+inherit_task_group
 inhibited_show
 inhibited_store
 init_8259A
@@ -29412,6 +29494,7 @@ init_clocksource_sysfs
 init_cma_pageblock
 init_cma_reserved_pageblock
 init_compat_elf_binfmt
+init_conntrack
 init_control_block
 init_counter_refs
 init_cp_src
@@ -29720,6 +29803,7 @@ init_x86_sysctl
 init_xfs_fs
 init_xstate_size
 init_zhaoxin
+__init_zone_device_page
 inject_emulated_exception
 in_lock_functions
 __inode_add_bytes
@@ -29948,6 +30032,7 @@ insert_inline_extent_backref
 __insert_inode_hash
 insert_inode_locked
 insert_inode_locked4
+insert_new_ablock
 insert_new_root
 insert_one_name
 insert_page
@@ -30002,6 +30087,7 @@ insn_get_prefixes
 insn_get_seg_base
 insn_get_sib
 insn_has_rep_prefix
+insn_init
 insn_is_nop
 insn_rip_relative
 install_breakpoint
@@ -30496,6 +30582,8 @@ inval_wq_set
 invent_group_ids
 inverse_translate
 invert_screen
+invoke_bpf
+invoke_bpf_prog
 invoke_need_callbacks
 invoke_rcu_core
 ioa_add_path
@@ -30660,6 +30748,7 @@ ioctl_get_cycle_timer2
 ioctl_getflags
 ioctl_get_info
 ioctl_get_speed
+ioctl_has_perm
 io_ctl_init
 ioctl_initiate_bus_reset
 ioctl_internal_command
@@ -31082,6 +31171,7 @@ __iommu_unmap
 iommu_unmap
 iommu_unmap_fast
 iommu_unmap_mmio_space
+io_msg_copy_hdr
 io_msg_ring
 io_msg_ring_cleanup
 __io_msg_ring_data
@@ -31167,6 +31257,7 @@ io_prep_write_fixed
 io_prep_writev
 io_prep_writev_fixed
 ioprio_check_cap
+io_probe
 io_provide_buffers_prep
 io_put_bpf_filters
 __io_put_kbufs
@@ -31242,6 +31333,7 @@ ioremap_prot
 ioremap_uc
 ioremap_wc
 ioremap_wt
+io_remove_buffers_legacy
 io_remove_buffers_prep
 io_renameat
 io_renameat_cleanup
@@ -31381,6 +31473,7 @@ io_tlb_hiwater_set
 iotlb_lookup_is_visible
 io_tlb_used_get
 io_try_cancel
+io_tx_ubuf_complete
 io_type_show
 io_unaccount_mem
 io_unlinkat
@@ -31455,8 +31548,12 @@ iov_iter_alignment_iovec
 iov_iter_bvec
 iov_iter_bvec_advance
 iov_iter_discard
+iov_iter_extract_bvec_pages
 iov_iter_extract_bvecs
+iov_iter_extract_folioq_pages
+iov_iter_extract_kvec_pages
 iov_iter_extract_pages
+iov_iter_extract_xarray_pages
 iov_iter_folioq_advance
 iov_iter_folio_queue
 iov_iter_gap_alignment
@@ -31608,9 +31705,7 @@ ip6_dst_ifdown
 ip6_dst_lookup
 ip6_dst_lookup_flow
 ip6_dst_lookup_tail
-ip6_dst_mtu_maybe_forward
 ip6_dst_neigh_lookup
-ip6_dst_store
 IP6_ECN_decapsulate
 ip6_err_gen_icmpv6_unreach
 ip6erspan_changelink
@@ -31644,6 +31739,7 @@ ip6_fragment
 ip6_frag_next
 ip6_frag_reasm
 ip6gre_changelink
+ip6gre_changelink_common
 ip6gre_dellink
 ip6gre_dev_free
 ip6gre_err
@@ -31764,6 +31860,7 @@ ip6_pol_route
 ip6_pol_route_input
 ip6_pol_route_lookup
 ip6_pol_route_output
+ip6_protocol_deliver_rcu
 ip6_push_pending_frames
 ip6_ra_control
 ip6_rcv_core
@@ -31813,6 +31910,7 @@ ip6_tnl_dev_uninit
 ip6_tnl_encap_add_ops
 ip6_tnl_encap_del_ops
 ip6_tnl_encap_setup
+ip6_tnl_err
 ip6_tnl_exit_rtnl_net
 ip6_tnl_fill_forward_path
 ip6_tnl_fill_info
@@ -31888,7 +31986,6 @@ __ip_dev_find
 ip_do_fragment
 __ip_do_redirect
 ip_do_redirect
-ip_dst_mtu_maybe_forward
 ip_error
 ip_exceeds_mtu
 ip_expire
@@ -31925,6 +32022,7 @@ ipgre_init
 ipgre_init_net
 ipgre_link_update
 ipgre_mpls_encap_hlen
+ipgre_netlink_parms
 ipgre_newlink
 ipgre_open
 __ipgre_rcv
@@ -32124,7 +32222,6 @@ ip_rt_send_redirect
 __ip_rt_update_pmtu
 ip_rt_update_pmtu
 __ip_select_ident
-ip_select_ident
 ip_send_check
 ip_send_skb
 ip_send_unicast_reply
@@ -32145,6 +32242,7 @@ ip_tun_cmp_encap
 ip_tun_destroy_state
 ip_tun_encap_nlsize
 ip_tun_fill_encap_info
+ip_tun_fill_encap_opts
 ip_tunnel_bind_dev
 ip_tunnel_changelink
 __ip_tunnel_change_mtu
@@ -33992,6 +34090,7 @@ __kmalloc_noprof
 kmalloc_pfmemalloc
 kmalloc_reserve
 kmalloc_size_roundup
+kmap_get_pte
 kmap_local_fork
 __kmap_local_page_prot
 __kmap_local_pfn_prot
@@ -34005,7 +34104,6 @@ kmem_cache_alloc_lru_noprof
 kmem_cache_alloc_node_noprof
 kmem_cache_alloc_noprof
 kmem_cache_charge
-__kmem_cache_create
 __kmem_cache_create_args
 kmem_cache_destroy
 __kmem_cache_do_shrink
@@ -34142,6 +34240,7 @@ k_pad
 kpagecgroup_read
 kpagecount_read
 kpageflags_read
+kpage_read
 k_po_show
 k_po_store
 kpp_register_instance
@@ -34397,7 +34496,6 @@ ktime_real_to_base_clock
 ktime_us_delta
 kt_serial_in
 kt_serial_setup
-__kunmap_atomic
 kunmap_local_indexed
 kvasprintf
 kvasprintf_const
@@ -34540,7 +34638,6 @@ kvm_check_and_clear_guest_paused
 kvm_check_async_pf_completion
 kvm_check_memslot_overlap
 kvm_check_nested_events
-kvm_clear_apicv_inhibit
 kvm_clear_async_pf_completion_queue
 kvm_clear_guest
 kvmclock_cpu_down_prep
@@ -34851,6 +34948,7 @@ kvm_mmu_create
 kvm_mmu_destroy
 kvm_mmu_do_page_fault
 kvm_mmu_faultin_pfn
+kvm_mmu_finish_page_fault
 kvm_mmu_free_guest_mode_roots
 kvm_mmu_free_memory_cache
 __kvm_mmu_free_obsolete_roots
@@ -35017,6 +35115,7 @@ kvm_requeue_exception
 kvm_require_dr
 kvm_reset_dirty_gfn
 kvm_restore_sched_clock_state
+kvm_rmap_age_gfn_range
 __kvm_rmap_zap_gfn_range
 kvm_rtc_eoi_tracking_restore_all
 kvm_rtc_eoi_tracking_restore_one
@@ -35107,6 +35206,7 @@ kvm_tdp_mmu_put_root
 kvm_tdp_mmu_recover_huge_pages
 kvm_tdp_mmu_test_age_gfn
 kvm_tdp_mmu_try_split_huge_pages
+kvm_tdp_mmu_unmap_gfn_range
 kvm_tdp_mmu_write_protect_gfn
 kvm_tdp_mmu_wrprot_slot
 kvm_tdp_mmu_zap_all
@@ -35133,6 +35233,7 @@ kvm_vcpu_after_set_cpuid
 kvm_vcpu_apicv_activated
 kvm_vcpu_block
 kvm_vcpu_check_block
+kvm_vcpu_check_hw_bp
 kvm_vcpu_compat_ioctl
 kvm_vcpu_deliver_sipi_vector
 kvm_vcpu_exit_request
@@ -35304,7 +35405,6 @@ kye_driver_exit
 kye_driver_init
 kye_probe
 kye_report_fixup
-_kzalloc_noprof
 l0s_aspm_show
 l0s_aspm_store
 l1_1_aspm_show
@@ -35649,6 +35749,7 @@ llc_count_cores
 llc_exit
 llc_init
 llc_mac_hdr_init
+llc_populate_cpu_shard_id
 llc_rcv
 llc_remove_pack
 llc_sap_close
@@ -35665,7 +35766,6 @@ load_ablock
 loadavg_proc_show
 __load_bitset_in_core
 load_builtin_intel_microcode
-load_cr3
 load_current_idt
 load_direct_gdt
 load_discard
@@ -35677,6 +35777,7 @@ load_global_roots_objectid
 load_image
 load_image_and_restore
 load_metalist
+_load_microcode_amd
 load_misc_binary
 load_mm_ldt
 load_module_cert
@@ -35968,6 +36069,7 @@ __lru_cache_activate_folio
 lru_cache_disable
 lru_deactivate
 lru_deactivate_file
+lru_evict
 lru_lazyfree
 lru_move_tail
 lru_note_cost_refault
@@ -36069,6 +36171,7 @@ lzma_len
 lzma_main
 lzo1x_1_compress
 lzo1x_1_compress_safe
+lzo1x_1_do_compress
 lzo1x_1_do_compress_safe
 lzo1x_decompress_safe
 lzo_alloc_ctx
@@ -36335,6 +36438,7 @@ map_vdso
 map_vdso_once
 map_vsyscall
 map_write
+mark_all_scalars_imprecise
 mark_btf_func_reg_size
 mark_btf_ld_reg
 mark_buffer_dirty
@@ -36357,6 +36461,7 @@ mark_page_accessed
 mark_page_dirty
 mark_page_dirty_in_slot
 mark_ptr_not_null_reg
+mark_ptr_or_null_reg
 mark_ptr_or_null_regs
 __mark_reg_const_zero
 mark_reg_graph_node
@@ -36921,6 +37026,7 @@ md_write_end
 md_write_inc
 md_write_metadata
 md_write_start
+measure_residency_fn
 mediated_pmu_account_event
 me_huge_page
 me_kernel
@@ -37174,6 +37280,7 @@ memory_low_show
 memory_low_write
 memory_lseek
 memory_map_bottom_up
+memory_map_top_down
 memory_max_show
 memory_max_write
 memory_min_show
@@ -37945,6 +38052,7 @@ mon_text_event
 mon_text_exit
 mon_text_init
 mon_text_open
+mon_text_read_data
 mon_text_read_t
 mon_text_read_u
 mon_text_read_wait
@@ -38002,6 +38110,7 @@ move_huge_pmd
 move_hugetlb_page_tables
 move_hugetlb_state
 move_linked_works
+move_local_task_to_local_dsq
 move_pages
 move_pages_and_store_status
 move_pages_huge_pmd
@@ -38105,6 +38214,7 @@ MP_lintsrc_info
 mpls_build_state
 mpls_cleanup_module
 mpls_conf_proc
+mpls_count_nexthops
 mpls_dev_destroy_rcu
 mpls_dev_mtu
 mpls_dev_notify
@@ -38229,7 +38339,7 @@ mptcp_diag_subflow_init
 mptcp_disconnect
 mptcp_do_fastclose
 mptcp_drop
-mptcp_early_fallback
+mptcp_dss_corruption
 mptcp_enter_memory_pressure
 __mptcp_error_report
 mptcp_established_options
@@ -38398,6 +38508,7 @@ mptcp_set_path_manager
 mptcp_set_rcvlowat
 mptcp_setsockopt
 mptcp_setsockopt_all_sf
+__mptcp_setsockopt_set_val
 __mptcp_setsockopt_sol_tcp_cork
 __mptcp_setsockopt_sol_tcp_nodelay
 mptcp_set_state
@@ -38575,6 +38686,7 @@ ms_event
 ms_ff_worker
 msg_add_dict_text
 msgctl_down
+msgctl_info
 msgctl_stat
 msg_exit_ns
 msg_get
@@ -38717,6 +38829,7 @@ mtrr_add_page
 mtrr_attrib_to_str
 mtrr_bp_init
 mtrr_build_map
+mtrr_calc_range_state
 mtrr_cleanup
 mtrr_close
 mtrr_copy_map
@@ -39337,6 +39450,7 @@ netdev_adjacent_change_abort
 netdev_adjacent_change_commit
 netdev_adjacent_change_prepare
 __netdev_adjacent_dev_insert
+__netdev_adjacent_dev_remove
 __netdev_adjacent_dev_unlink_neighbour
 netdev_adjacent_get_private
 netdev_adjacent_rename_links
@@ -39438,7 +39552,6 @@ netdev_nl_qstats_get_dumpit
 netdev_nl_qstats_get_dump_one
 netdev_nl_queue_create_doit
 netdev_nl_queue_dump_one
-netdev_nl_queue_fill_lease
 netdev_nl_queue_fill_mp
 netdev_nl_queue_fill_one
 netdev_nl_queue_get_doit
@@ -39531,6 +39644,8 @@ netdev_xa_find_lock_ops_compat
 netdev_xmit_skip_txqueue
 net_dim
 net_dim_free_irq_moder
+net_dim_get_def_rx_moderation
+net_dim_get_def_tx_moderation
 net_dim_get_rx_irq_moder
 net_dim_get_rx_moderation
 net_dim_get_tx_irq_moder
@@ -40116,7 +40231,6 @@ nexthop_get
 nexthop_get_nhc_lookup
 nexthop_has_v4
 nexthop_init
-nexthop_mpath_fill_node
 nexthop_net_exit
 nexthop_net_exit_rtnl
 nexthop_net_init
@@ -40322,6 +40436,7 @@ nf_flow_offload_rule_alloc
 nf_flow_offload_stats
 nf_flow_offload_work_gc
 nf_flow_offload_xdp_setup
+nf_flow_queue_xmit
 nf_flow_register_bpf
 nf_flow_rule_route_common
 nf_flow_rule_route_inet
@@ -40662,6 +40777,7 @@ nft_chain_filter_init
 nft_chain_hash
 nft_chain_hash_cmp
 nft_chain_hash_obj
+nft_chain_lookup
 nft_chain_offload_cmd
 nft_chain_offload_support
 nft_chain_parse_hook
@@ -40716,6 +40832,8 @@ nft_do_chain_inet_ingress
 nft_do_chain_ipv4
 nft_do_chain_ipv6
 nft_do_chain_netdev
+nft_dump_basechain_hook
+nft_dump_basechain_hook_list
 nft_dump_basechain_trans_hook_list
 nft_dump_register
 nft_dump_stats
@@ -40851,6 +40969,7 @@ __nft_netdev_hook_free_rcu
 nft_netdev_register_hooks
 nft_nla_put_hook_dev
 nft_obj_del
+nft_object_dump
 nft_obj_init
 nft_obj_lookup
 nft_objname_hash
@@ -41009,6 +41128,7 @@ nft_set_lookup_global
 nft_stats_alloc
 nft_table_lookup
 nft_table_validate
+nft_tcp_header_pointer
 nft_trace_init
 nft_trace_notify
 __nft_trace_packet
@@ -41054,8 +41174,10 @@ nf_unregister_net_hooks
 nf_unregister_queue_handler
 nf_unregister_sockopt
 nf_xfrm_me_harder
+nh_check_attr_group
 nh_dump_filtered
 nh_fill_node
+nh_fill_res_bucket
 nh_grp_hw_stats_report_delta
 nhm_limit_period
 nh_netdev_event
@@ -41075,7 +41197,6 @@ nla_get_range_unsigned
 nla_get_via
 nla_memcmp
 nla_memcpy
-nla_memdup_noprof
 __nla_parse
 nla_policy_len
 __nla_put
@@ -41104,7 +41225,6 @@ nldsq_cursor_next_task
 nl_fib_input
 nlmsg_cancel
 nlmsg_notify
-nlmsg_populate_fdb_fill
 __nlmsg_put
 nmi_cpu_backtrace
 nmi_cpu_backtrace_handler
@@ -41147,6 +41267,7 @@ node_read_distance
 node_read_meminfo
 node_read_numastat
 node_read_vmstat
+__node_reclaim
 node_reclaim
 node_shift
 node_store
@@ -41273,6 +41394,7 @@ nr_free_buffer_pages
 nr_hugepages_mempolicy_show
 nr_hugepages_mempolicy_store
 nr_hugepages_show
+nr_hugepages_show_common
 nr_hugepages_store
 __nr_hugepages_store_common
 nr_hugepages_store_common
@@ -41612,6 +41734,7 @@ numa_init_array
 numa_init_sysfs
 numa_memblks_init
 numa_migrate_check
+numa_move_tail_memblk
 numa_nearest_node
 numa_node_dist
 numa_node_store
@@ -41796,6 +41919,7 @@ obj_cgroup_uncharge_zswap
 object_cpu_offline
 object_size_show
 objects_partial_show
+obj_exts_in_slab
 obj_malloc
 objpool_drop
 objpool_fini
@@ -41849,6 +41973,7 @@ ohci_bus_resume
 ohci_bus_suspend
 ohci_dump
 ohci_dump_intr_mask
+ohci_dump_roothub
 ohci_dump_status
 ohci_endpoint_disable
 ohci_get_frame
@@ -41927,6 +42052,7 @@ opal_erase_locking_range
 opal_generic_read_write_table
 opal_get_discv
 opal_get_geometry
+opal_get_key
 opal_get_status
 opal_get_sum_ranges
 opal_locking_range_status
@@ -41979,6 +42105,7 @@ _opp_free
 _opp_remove_all
 _opp_remove_all_static
 _opp_set_availability
+_opp_set_required_dev
 ops_complete_biofill
 ops_complete_check
 ops_complete_compute
@@ -42150,6 +42277,7 @@ ovl_dir_read
 ovl_dir_read_merged
 ovl_dir_real_file
 ovl_dir_release
+ovl_do_create
 ovl_do_mkdir
 ovl_do_parse_layer
 ovl_do_remove
@@ -42360,6 +42488,7 @@ p4d_clear_bad
 p4d_clear_huge
 p4d_clear_tests
 ___p4d_free_tlb
+p4d_populate_init
 p4d_populate_tests
 p4d_set_huge
 p4_hw_config
@@ -42631,7 +42760,6 @@ page_pool_enable_direct_recycling
 page_pool_ethtool_stats_get
 page_pool_ethtool_stats_get_count
 page_pool_ethtool_stats_get_strings
-page_pool_free_va
 page_pool_get_stats
 page_pool_inflight
 page_pool_list
@@ -42639,7 +42767,6 @@ page_pool_netdevice_event
 page_pool_nl_fill
 page_pool_nl_stats_fill
 page_pool_put_netmem_bulk
-page_pool_put_page
 page_pool_put_unrefed_netmem
 page_pool_put_unrefed_page
 page_pool_refill_alloc_cache
@@ -42696,12 +42823,14 @@ paging32_gpte_changed
 paging32_gva_to_gpa
 paging32_page_fault
 paging32_sync_spte
+paging32_update_accessed_dirty_bits
 paging32_walk_addr_generic
 paging64_fetch
 paging64_gpte_changed
 paging64_gva_to_gpa
 paging64_page_fault
 paging64_sync_spte
+paging64_update_accessed_dirty_bits
 paging64_walk_addr_generic
 paging_domain_alloc
 paging_domain_compatible
@@ -42862,7 +42991,6 @@ parse_lapic_timer_c2_ok
 parse_legacy
 parse_linerange
 parse_max_pools
-parse_memmap_one
 parse_memmap_opt
 parse_memopt
 parse_minix
@@ -42898,6 +43026,7 @@ parse_pci
 parse_pmtmr
 parse_policy
 parse_power
+parse_probe_arg
 parse_raid_params
 parse_ras_param
 parse_rcu_nocb_poll
@@ -43173,7 +43302,6 @@ pci_bus_resettable
 pci_bus_resource_n
 pci_bus_restore_locked
 pci_bus_save_and_disable_locked
-__pci_bus_set_current_state
 pci_bus_set_current_state
 pci_bus_set_ops
 __pci_bus_size_bridges
@@ -43885,6 +44013,7 @@ pci_reset_supported
 pci_resize_resource
 pci_resize_resource_set_size
 pci_resource_alignment_sysfs_init
+pci_resource_io
 pci_resource_is_optional
 pci_resource_name
 pci_resource_to_user
@@ -44198,6 +44327,7 @@ pdev_sort_resources
 pdu_read
 peak_open
 peak_release
+peak_write
 pebs_update_state
 pec_show
 pec_store
@@ -44285,6 +44415,7 @@ perf_callchain_kernel
 perf_callchain_store
 perf_callchain_user
 perf_cgroup_attach
+perf_cgroup_connect
 perf_cgroup_css_alloc
 perf_cgroup_css_free
 perf_cgroup_css_online
@@ -44332,6 +44463,7 @@ perf_event_enable
 perf_event_exec
 __perf_event_exit_context
 perf_event_exit_cpu
+perf_event_exit_event
 perf_event_exit_task
 perf_event_exit_task_context
 perf_event_fd_array_get_ptr
@@ -44506,6 +44638,7 @@ perf_pmu_nop_txn
 perf_pmu_nop_void
 __perf_pmu_output_stop
 perf_pmu_register
+__perf_pmu_remove
 perf_pmu_resched
 perf_pmu_sched_task
 perf_pmu_start_txn
@@ -45776,6 +45909,7 @@ perm_destroy
 perm_group_watchdog
 perm_hwaddr_show
 permission_fault
+perm_read
 perm_write
 persist_enabled_on_companion
 persistence_domain_show
@@ -46013,7 +46147,6 @@ __phy_resume
 phy_resume
 __phys_addr
 phys_addr_show
-__phys_addr_symbol
 phy_save_page
 phys_device_show
 phy_select_page
@@ -46222,6 +46355,7 @@ pim_rcv_v1
 pinctrl_add_gpio_range
 pinctrl_add_gpio_ranges
 pinctrl_bind_pins
+pinctrl_commit_state
 pinctrl_dev_get_devname
 pinctrl_dev_get_drvdata
 pinctrl_dev_get_name
@@ -46391,6 +46525,7 @@ pirq_sis497_get
 pirq_sis497_set
 pirq_sis503_get
 pirq_sis503_set
+pirq_try_router
 pirq_via586_get
 pirq_via586_set
 pirq_via_get
@@ -46698,7 +46833,6 @@ pm_runtime_enable
 pm_runtime_forbid
 pm_runtime_force_resume
 pm_runtime_force_suspend
-pm_runtime_get_active
 pm_runtime_get_conditional
 pm_runtime_get_if_active
 pm_runtime_get_if_in_use
@@ -46778,6 +46912,7 @@ pneigh_create
 pneigh_delete
 pneigh_destroy
 pneigh_enqueue
+pneigh_fill_info
 pneigh_get_first
 pneigh_lookup
 pneigh_queue_purge
@@ -47259,8 +47394,10 @@ pre_handler_kretprobe
 preinit_net
 prelim_ref_insert
 preload
+preload_this_cpu_lock
 prep_and_add_allocated_folios
 prep_and_add_bootmem_folios
+prepare_alloc_pages
 prepare_coming_module
 prepare_creds
 prepare_elf64_ram_headers_callback
@@ -49827,6 +49964,7 @@ process_bio_fail
 __process_bio_read_only
 process_bio_read_only
 process_bio_success
+process_bit0
 process_bit1
 process_bpf_exit_full
 process_buffer_measurement
@@ -50488,7 +50626,9 @@ pte_free_defer
 pte_free_now
 ___pte_free_tlb
 pte_is_uffd_marker
+pte_list_add
 pte_list_count
+pte_list_remove
 pte_marker_clear
 pte_mfn_to_pfn
 pte_mkwrite
@@ -50627,7 +50767,6 @@ pt_read_offset
 pt_regs_offset
 pt_regs_to_gdb_regs
 pt_regs_val
-ptr_ring_cleanup
 ptr_to_hashval
 pt_show
 pts_unix98_lookup
@@ -51048,6 +51187,8 @@ qtree_release_dquot
 qtree_write_dquot
 qtype_enforce_flag
 query_asymmetric_key
+query_data
+query_label
 query_matching_vma
 query_vma_teardown
 queue_add_random_show
@@ -51156,6 +51297,7 @@ queue_stack_map_push_elem
 queue_stack_map_update_elem
 queue_state_show
 queue_state_write
+queue_stop_cpus_work
 queue_task_work
 queue_trb
 queue_virt_boundary_mask_show
@@ -51868,6 +52010,7 @@ rbtree_debugfs_init
 rbtree_open
 rbtree_show
 rb_update_pages
+__rb_validate_buffer
 rb_wait_once
 rb_wake_up_waiters
 rb_watermark_hit
@@ -51983,7 +52126,6 @@ rcu_nocb_cb_kthread
 rcu_nocb_cpu_deoffload
 rcu_nocb_cpu_offload
 rcu_nocb_cpu_toggle_offload
-rcu_nocb_do_flush_bypass
 rcu_nocb_flush_deferred_wakeup
 rcu_nocb_gp_kthread
 rcu_nocb_rdp_deoffload
@@ -52283,6 +52425,7 @@ read_sel_8bit_indexed_io
 read_superblock_fields
 read_super_common
 read_swap_cache_async
+read_swap_header
 read_symlink
 read_table_data
 read_table_data_cont
@@ -53161,6 +53304,7 @@ remove_migration_ptes
 __remove_nexthop
 remove_nexthop
 remove_node_from_stable_tree
+remove_nodes
 remove_notification
 __remove_pages
 remove_pagetable
@@ -53292,6 +53436,7 @@ request_resource_conflict
 request_threaded_irq
 requeue_delayed_entity
 requeue_pi_wake_futex
+requeue_task_rt
 _required_opps_available
 rescan_store
 resched_cpu
@@ -53643,6 +53788,7 @@ __rhashtable_init_noprof
 rhashtable_insert_slow
 rhashtable_jhash2
 rhashtable_next_key
+rhashtable_rehash_alloc
 rhashtable_walk_enter
 rhashtable_walk_exit
 __rhashtable_walk_find_next
@@ -53793,6 +53939,7 @@ rlock_ABBA2
 rlock_ABBA3
 rlock_chaincache_ABBA1
 __rmap_add
+__rmap_clear_dirty
 rmap_walk
 rmap_walk_anon
 __rmap_walk_file
@@ -54010,6 +54157,7 @@ __rss_prepare_ctx
 rss_prepare_data
 rss_reply_size
 rss_set_ctx_update
+rss_set_prep_hkey
 rss_set_prep_indir
 r_start
 r_stop
@@ -54239,7 +54387,6 @@ rtm_to_fib_config
 rtm_to_nh_config_grp_res
 rtm_to_route_config
 rt_mutex_adjust_pi
-rt_mutex_adjust_prio_chain
 rt_mutex_base_init
 rt_mutex_cleanup_proxy_lock
 rt_mutex_debug_task_free
@@ -54247,6 +54394,7 @@ __rt_mutex_futex_trylock
 rt_mutex_futex_trylock
 __rt_mutex_futex_unlock
 rt_mutex_futex_unlock
+rt_mutex_handle_deadlock
 __rt_mutex_init
 rt_mutex_init_proxy_locked
 rt_mutex_lock
@@ -54258,6 +54406,8 @@ rt_mutex_pre_schedule
 rt_mutex_proxy_unlock
 rt_mutex_schedule
 rt_mutex_setprio
+rt_mutex_slowlock
+rt_mutex_slowlock_block
 __rt_mutex_start_proxy_lock
 rt_mutex_start_proxy_lock
 rt_mutex_trylock
@@ -54300,6 +54450,7 @@ rtnl_fill_link_ifmap
 rtnl_fill_link_netnsid
 rtnl_fill_proto_down
 rtnl_fill_stats
+rtnl_fill_statsinfo
 rtnl_fill_vf
 rtnl_fill_vfinfo
 rtnl_getlink
@@ -54796,7 +54947,6 @@ schedule_on_each_cpu
 schedule_page_work_fn
 schedule_preempt_disabled
 schedule_reconstruction
-schedule_reenq_local
 schedule_tail
 schedule_timeout
 schedule_timeout_idle
@@ -54856,6 +55006,7 @@ scrub_enumerate_chunks
 scrub_find_fill_first_stripe
 scrub_free_ctx
 scrub_pause_off
+scrub_print_common_warning
 scrub_print_warning_inode
 scrub_put_ctx
 scrub_raid56_cached_parity
@@ -55518,6 +55669,7 @@ search_process_keyrings_rcu
 seccomp_actions_logged_handler
 seccomp_assign_mode
 seccomp_attach_filter
+seccomp_cache_prepare_bitmap
 seccomp_check_filter
 __seccomp_filter
 __seccomp_filter_release
@@ -55525,6 +55677,7 @@ seccomp_filter_release
 seccomp_get_filter
 seccomp_get_metadata
 seccomp_log
+seccomp_names_from_actions_logged
 seccomp_notify_detach
 seccomp_notify_ioctl
 seccomp_notify_poll
@@ -56321,6 +56474,7 @@ sel_write_relabel
 sel_write_user
 sel_write_validatetrans
 semctl_down
+semctl_info
 semctl_main
 semctl_setval
 semctl_stat
@@ -56834,11 +56988,13 @@ __se_sys_pkey_alloc
 __se_sys_pkey_free
 __se_sys_ppoll
 __se_sys_prctl
+__se_sys_preadv2
 __se_sys_prlimit64
 __se_sys_process_madvise
 __se_sys_process_mrelease
 __se_sys_pselect6
 __se_sys_ptrace
+__se_sys_pwritev2
 __se_sys_quotactl
 __se_sys_quotactl_fd
 __se_sys_reboot
@@ -57021,7 +57177,6 @@ set_hardened_usercopy
 set_hashdist
 set_hello_time
 set_huge_pmd
-set_huge_pte_at
 set_huge_zero_folio
 set_ignore_ce
 set_ignore_seg
@@ -57175,6 +57330,7 @@ set_port_led
 set_posix_acl
 set_power_ctl_ee_state
 set_precision
+set_preempt_buddy
 set_primary_fwnode
 __set_print_fmt
 __set_printk_clr_event
@@ -57259,7 +57415,6 @@ set_translate
 set_trigger
 set_trigger_filter
 set_tsc_mode
-set_tsk_thread_flag
 set_tun_src
 set_uhash_entries
 setup_acpi_rsdp
@@ -57431,6 +57586,7 @@ set_x2apic_phys_mode
 setxattr_copy
 set_xfrm_gro_udp_encap_rcv
 set_zone_contiguous
+SetZsPageMovable
 severities_coverage_open
 severities_coverage_write
 severities_debugfs_init
@@ -57467,6 +57623,7 @@ sfb_leaf
 sfb_module_exit
 sfb_module_init
 sfb_peek
+sfb_rate_limit
 sfb_reset
 sfb_swap_slot
 sfb_tcf_block
@@ -57540,6 +57697,7 @@ sg_nents
 sg_nents_for_dma
 sg_nents_for_len
 sg_new_read
+sg_new_write
 sg_open
 __sg_page_iter_dma_next
 __sg_page_iter_next
@@ -57919,6 +58077,7 @@ show_isolated
 show_kprobe_addr
 show_ldttss
 show_learning
+show_list
 show_local_boost
 show_log_height
 show_log_width
@@ -58314,6 +58473,7 @@ sis_router_probe
 sis_tlbflush
 si_swapinfo
 sit_cleanup
+sitd_slot_ok
 sit_exit_rtnl_net
 sit_gro_complete
 sit_gso_segment
@@ -58418,8 +58578,6 @@ __skb_get_poff
 skb_get_poff
 skb_get_tx_timestamp
 __skb_gro_checksum_complete
-__skb_gro_checksum_validate_complete
-__skb_gro_checksum_validate_needed
 skb_gro_incr_csum_unnecessary
 skb_gro_receive
 skb_gro_receive_list
@@ -58502,8 +58660,8 @@ skb_set_owner_edemux
 skb_set_owner_r
 skb_set_owner_w
 skb_setup_tx_timestamp
-skb_share_check
 skb_shift
+__skb_splice_bits
 skb_splice_bits
 skb_splice_from_iter
 skb_split
@@ -58708,6 +58866,7 @@ sk_wait_data
 sk_wake_async
 sk_wmem_schedule
 skx_set_max_freq_ratio
+___slab_alloc
 slab_args_unmergeable
 slab_attr_show
 slab_attr_store
@@ -59899,6 +60058,7 @@ string_registers_quirk
 string_to_av_perm
 string_to_context_struct
 string_to_security_class
+string_unescape
 stripe_ahead_of_reshape
 stripe_cache_active_show
 stripe_can_batch
@@ -60028,6 +60188,8 @@ subtree_dec
 subtree_equal
 subtree_inc
 success_show
+suffix_kstrtoint
+suffix_kstrtoull
 sugov_effective_cpu_perf
 sugov_exit
 sugov_init
@@ -60065,7 +60227,6 @@ super_s_dev_set
 super_s_dev_test
 super_setup_bdi
 super_setup_bdi_name
-super_set_uuid
 super_sync
 super_trylock_shared
 super_validate
@@ -60157,6 +60318,7 @@ swap_dup_entry_direct
 swap_entry_swapped
 swap_events_show
 swap_ex
+swap_extend_table_alloc
 swap_extend_table_try_free
 swapfile_init
 swap_folio_sector
@@ -60207,6 +60369,7 @@ swiotlb_create_default_debugfs
 swiotlb_dev_init
 swiotlb_exit
 swiotlb_init
+swiotlb_init_io_tlb_pool
 swiotlb_init_late
 swiotlb_init_remap
 swiotlb_map
@@ -60430,6 +60593,7 @@ synproxy_tg4_check
 synproxy_tg4_destroy
 synproxy_tg4_exit
 synproxy_tg4_init
+synproxy_tstamp_adjust
 synthesize_relcall
 synthesize_reljump
 __sys_accept4
@@ -60437,6 +60601,7 @@ __sys_bind
 __sys_bind_socket
 __sys_bpf
 syscall_copy_user
+syscall_copy_user_array
 syscall_enter_define_fields
 syscall_enter_register
 syscall_exit_register
@@ -60446,6 +60611,7 @@ syscall_get_enter_fields
 syscall_init
 syscall_prog_func_proto
 syscall_prog_is_valid_access
+syscall_put_data
 syscall_regfunc
 syscall_unregfunc
 syscall_user_dispatch
@@ -60496,6 +60662,7 @@ sysctl_u2k_int_conv_userhz
 sysctl_vm_numa_stat_handler
 sys_dmi_field_show
 sys_dmi_modalias_show
+sys_enter_openat_print_fmt
 sysfb_apply_efi_quirks
 sysfb_disable
 sysfb_handles_screen_info
@@ -60771,6 +60938,7 @@ target_message
 target_unblock
 task_active_pid_ns
 task_avdcache_reset
+task_blocks_on_rt_mutex
 task_bp_pinned
 task_cache_work
 task_call_func
@@ -60810,7 +60978,6 @@ task_file_seq_stop
 task_fork_dl
 task_fork_fair
 task_get_cgroup1
-task_get_css
 task_gtime
 task_hot
 task_iter_init
@@ -61292,6 +61459,7 @@ tcp_grow_window
 tcp_gso_segment
 tcp_gso_tstamp
 tcp_inbound_hash
+tcp_inbound_md5_hash
 tcp_init
 tcp_init_congestion_control
 tcp_init_cwnd
@@ -61314,7 +61482,6 @@ __tcp_md5_do_add
 tcp_md5_do_add
 tcp_md5_do_del
 __tcp_md5_do_lookup
-tcp_md5_do_lookup
 tcp_md5_do_lookup_exact
 tcp_md5_hash_key
 tcp_md5_hash_skb_data
@@ -61345,6 +61512,7 @@ tcp_oow_rate_limited
 tcp_openreq_init_rwin
 tcp_options
 tcp_options_fit_accecn
+tcp_options_write
 tcp_orphan_count_sum
 tcp_orphan_update
 tcp_out_of_resources
@@ -61408,6 +61576,7 @@ tcp_retransmit_skb
 tcp_retransmit_timer
 tcp_retrans_try_collapse
 tcp_rto_min
+tcp_rtx_probe0_timed_out
 tcp_rtx_synack
 tcp_sack_compress_send_ack
 tcp_sacktag_one
@@ -61629,6 +61798,7 @@ tdp_mmu_link_sp
 tdp_mmu_next_root
 tdp_mmu_set_spte_atomic
 tdp_mmu_split_huge_page
+tdp_mmu_zap_leafs
 __tdp_mmu_zap_root
 tdp_mmu_zap_root
 td_submit_urb
@@ -61697,6 +61867,7 @@ test_taint
 test_therm_status
 test_wakealarm
 test_write_file
+textify_hooks
 __text_poke
 text_poke
 text_poke_apply_relocation
@@ -62076,11 +62247,14 @@ time_init
 time_in_state_ms_show
 timekeeper_lock_irqsave
 timekeeper_unlock_irqrestore
+__timekeeping_advance
 timekeeping_clocksource_has_base
 timekeeping_forward_now
 timekeeping_get_mg_floor_swaps
 timekeeping_init
 timekeeping_init_ops
+__timekeeping_inject_offset
+__timekeeping_inject_sleeptime
 timekeeping_inject_sleeptime64
 timekeeping_max_deferment
 timekeeping_notify
@@ -62090,6 +62264,7 @@ timekeeping_rtc_skipsuspend
 timekeeping_suspend
 timekeeping_syscore_resume
 timekeeping_syscore_suspend
+timekeeping_update_from_shadow
 timekeeping_valid_for_hres
 timekeeping_warp_clock
 timeleft_show
@@ -62199,6 +62374,7 @@ tk_debug_account_sleep_time
 tk_debug_sleep_time_init
 tk_debug_sleep_time_open
 tk_debug_sleep_time_show
+tk_setup_internals
 tk_set_wall_to_mono
 tlb_choose_channel
 tlb_finish_mmu
@@ -62263,6 +62439,7 @@ tls_rx_msg_maybe_announce
 tls_rx_msg_size
 tls_rx_one_record
 tls_rx_reader_acquire
+tls_rx_reader_release
 tls_rx_rec_wait
 tls_server_hello_psk
 tls_server_hello_x509
@@ -62314,6 +62491,7 @@ tls_write_space
 tlv_put
 tlv_put_btrfs_timespec
 tlv_put_string
+tmigr_active_up
 tmigr_clear_cpu_available
 __tmigr_cpu_activate
 tmigr_cpu_activate
@@ -62377,6 +62555,7 @@ to_compat_ipc_perm
 to_current_namespace_index
 toggle_bp_slot
 token_create
+token_get_info_by_fd
 to_nd_btt
 to_ndd
 to_nd_dax
@@ -62472,6 +62651,7 @@ tpm2_bios_measurements_stop
 tpm2_calc_event_log_size
 tpm2_calc_ordinal_duration
 tpm2_commit_space
+tpm2_create_primary
 tpm2_del_space
 tpm2_do_selftest
 tpm2_end_auth_session
@@ -62736,6 +62916,7 @@ trace_event_get_offsets_br_fdb_external_
 trace_event_get_offsets_br_fdb_update
 trace_event_get_offsets_cache_tag_flush
 trace_event_get_offsets_cache_tag_log
+trace_event_get_offsets_cgroup_migrate
 trace_event_get_offsets_clk_parent
 trace_event_get_offsets_clk_rate_request
 trace_event_get_offsets_device_pm_callback_end
@@ -62743,10 +62924,17 @@ trace_event_get_offsets_device_pm_callba
 trace_event_get_offsets_devlink_health_recover_aborted
 trace_event_get_offsets_devlink_health_report
 trace_event_get_offsets_devlink_health_reporter_state_update
+trace_event_get_offsets_devlink_hwerr
+trace_event_get_offsets_devlink_hwmsg
+trace_event_get_offsets_devlink_trap_report
+trace_event_get_offsets_devres
+trace_event_get_offsets_dma_buf_attach_dev
 trace_event_get_offsets_dma_fence
 trace_event_get_offsets_dma_fence_ops
 trace_event_get_offsets_fdb_delete
+trace_event_get_offsets_hwmon_attr_show_string
 trace_event_get_offsets_iommu_error
+trace_event_get_offsets_mc_event
 trace_event_get_offsets_mm_setup_per_zone_lowmem_reserve
 trace_event_get_offsets_net_dev_xmit_timeout
 trace_event_get_offsets_pcie_ltssm_state_transition
@@ -62758,6 +62946,7 @@ trace_event_get_offsets_qdisc_reset
 trace_event_get_offsets_regcache_sync
 trace_event_get_offsets_sched_prepare_exec
 trace_event_get_offsets_sched_process_fork
+trace_event_get_offsets_selinux_audited
 trace_event_ignore_this_pid
 trace_event_init
 trace_event_printf
@@ -67602,8 +67791,6 @@ trace_regulator_bypass_enable_complete
 trace_release
 __trace_remove_event_call
 trace_remove_event_call
-trace_reschedule_entry
-trace_reschedule_exit
 tracer_init
 tracer_init_tracefs
 tracer_init_tracefs_work_func
@@ -68018,6 +68205,7 @@ try_restore_exclusive_pte
 try_rfc1123
 try_rfc959
 try_split_folio
+try_stop_module
 try_then_request_governor
 try_to_bring_up_aggregate_device
 try_to_claim_block
@@ -68048,6 +68236,7 @@ try_to_unmap_one
 try_to_unuse
 try_to_wake_up
 try_to_writeback_inodes_sb
+try_unregister_trigger
 try_wait_for_completion
 tsa_apply_mitigation
 tsa_parse_cmdline
@@ -68380,6 +68569,7 @@ tun_set_sndbuf
 tun_setup
 tun_sock_write_space
 tun_validate
+tun_vnet_hdr_tnl_to_skb
 tun_vnet_ioctl
 tun_wake_queue
 tun_xdp
@@ -68460,6 +68650,7 @@ uart_get_icount
 uart_get_info
 uart_get_info_user
 uart_get_iso7816_config
+uart_get_lsr_info
 uart_get_rs485_config
 uart_get_rs485_mode
 uart_handle_break
@@ -68689,7 +68880,6 @@ udp_v4_get_port
 __udpv4_gso_segment_csum
 udpv4_offload_init
 udp_v4_rehash
-udp_v6_check
 udpv6_connect
 udpv6_destroy_sock
 udpv6_destruct_sock
@@ -68743,6 +68933,7 @@ uhci_debug_open
 uhci_debug_read
 uhci_debug_release
 uhci_finish_suspend
+uhci_fixup_toggles
 uhci_free_qh
 uhci_free_td
 uhci_free_urb_priv
@@ -68772,6 +68963,7 @@ uhci_rh_resume
 uhci_rh_suspend
 uhci_scan_schedule
 uhci_show_qh
+uhci_show_td
 uhci_shutdown
 uhci_sprint_schedule
 uhci_start
@@ -69773,6 +69965,7 @@ usb_sg_init
 usb_sg_wait
 usb_show_dynids
 usb_shutdown_interface
+usb_speed_string
 usb_start_wait_urb
 usb_state_string
 usb_stop_hcd
@@ -70052,6 +70245,7 @@ v9fs_xattr_get
 v9fs_xattr_handler_get
 v9fs_xattr_handler_set
 v9fs_xattr_set
+va_alloc
 validate_change
 validate_coredump_safety
 validate_crypto_info
@@ -70077,6 +70271,7 @@ valid_mmap_phys_addr_range
 valid_phys_addr_range
 valid_zones_show
 val_is_negative
+val_to_string
 __var_waitqueue
 var_wake_function
 vbin_printf
@@ -70283,6 +70478,7 @@ veth_validate
 veth_xdp
 veth_xdp_flush_bq
 veth_xdp_get
+veth_xdp_rcv_bulk_skb
 veth_xdp_rx_hash
 veth_xdp_rx_timestamp
 veth_xdp_rx_vlan_tag
@@ -70419,6 +70615,7 @@ vgacon_startup
 vgacon_switch
 vga_default_device
 vga_get
+vga_pci_str_to_vars
 __vga_put
 vga_put
 vga_remove_vgacon
@@ -70493,7 +70690,9 @@ virtblk_freeze
 virtblk_get_cache_mode
 virtblk_getgeo
 virtblk_map_queues
+virtblk_name_format
 virtblk_poll
+virtblk_prep_rq
 virtblk_probe
 virtblk_remove
 virtblk_report_zones
@@ -70598,8 +70797,6 @@ virtio_irq_get_affinity
 virtio_max_dma_size
 virtio_net_driver_exit
 virtio_net_driver_init
-virtio_net_hdr_from_skb
-virtio_net_hdr_to_skb
 virtio_no_restricted_mem_acc
 virtio_pci_admin_dev_parts_get
 virtio_pci_admin_dev_parts_metadata_get
@@ -70741,6 +70938,7 @@ virtnet_receive_done
 virtnet_remove
 virtnet_restore
 virtnet_rq_bind_xsk_pool
+virtnet_rq_free_buf
 virtnet_rq_submit
 virtnet_rq_unmap_free_buf
 virtnet_rx_dim_work
@@ -70834,6 +71032,7 @@ virtrng_scan
 virtual_device_parent
 virtual_start_show
 visit_func_call_insn
+visit_groups_merge
 visit_node_for_delete
 visual_init
 vivaldi_function_row_physmap_show
@@ -70878,6 +71077,7 @@ vlan_filter_drop_vids
 vlan_filtering_show
 vlan_filtering_store
 vlan_filter_push_vids
+__vlan_find_dev_deep_rcu
 __vlan_flush
 vlan_for_each
 vlan_get_link_net
@@ -71020,7 +71220,6 @@ vma_shrink
 __vma_start_exclude_readers
 vma_start_read
 vma_start_read_locked
-vma_start_read_locked_nested
 __vma_start_write
 vma_state_init
 vma_thp_gfp_mask
@@ -71285,7 +71484,6 @@ vring_free_packed
 vring_interrupt
 vring_map_one_sg
 vring_mapping_error
-vring_map_single
 vring_new_virtqueue
 __vring_new_virtqueue_packed
 __vring_new_virtqueue_split
@@ -71326,12 +71524,14 @@ vsock_connect_timeout
 vsock_core_get_transport
 vsock_core_register
 vsock_core_unregister
+__vsock_create
 vsock_create
 vsock_create_connected
 vsock_data_ready
 __vsock_deliver_tap
 vsock_deliver_tap
 vsock_dev_compat_ioctl
+vsock_dev_do_ioctl
 vsock_dev_ioctl
 vsock_dgram_connect
 __vsock_dgram_recvmsg
@@ -71480,6 +71680,7 @@ vxlan_fdb_add
 vxlan_fdb_append
 vxlan_fdb_clear_offload
 vxlan_fdb_create
+__vxlan_fdb_delete
 vxlan_fdb_delete
 vxlan_fdb_delete_bulk
 vxlan_fdb_destroy
@@ -71580,6 +71781,7 @@ vxlan_vnigroup_uninit
 vxlan_vni_in_use
 vxlan_vnilist_update_group
 vxlan_vni_node_rcu_free
+vxlan_vni_update_group
 vxlan_vs_add_vnigrp
 vxlan_vs_del_vnigrp
 vxlan_xmit
@@ -71655,7 +71857,6 @@ wait_log_commit
 wait_next_period
 wait_nvdimm_bus_probe_idle
 __wait_on_bit
-wait_on_bit_io
 __wait_on_bit_lock
 __wait_on_buffer
 wait_on_buffer
@@ -71798,6 +71999,7 @@ walk_up_log_tree
 walk_up_proc
 walk_up_reloc_tree
 walk_up_tree
+walk_zones_in_node
 want_pages_array
 want_pmd_share
 want_replace
@@ -72080,6 +72282,7 @@ write_dirty_buffer
 __write_dirty_buffers_async
 write_dirty_finish
 write_enabled_file_bool
+write_end_fn
 write_endio
 __write_extent_buffer
 write_extent_buffer
@@ -72097,6 +72300,7 @@ write_ldt
 write_marker_to_buffer
 write_mem
 write_mem_msg
+write_metadata
 write_mmp_block
 write_mmp_block_thawed
 write_moving
@@ -72120,6 +72324,7 @@ write_priomap
 write_profile
 write_raw_marker_to_buffer
 write_regs
+write_relocate_add
 write_sb_page
 write_segment_descriptor
 write_shadow_mbr
@@ -72141,6 +72346,7 @@ ws_eq
 ws_inc
 __ww_mutex_check_waiters
 __ww_mutex_die
+__ww_mutex_lock
 ww_mutex_lock
 ww_mutex_lock_interruptible
 __ww_mutex_lock_interruptible_slowpath
@@ -72207,6 +72413,7 @@ x509_check_for_self_signed
 x509_decode_time
 x509_extract_key_data
 x509_extract_name_segment
+x509_fabricate_name
 x509_free_certificate
 x509_get_sig_params
 x509_key_exit
@@ -72787,6 +72994,7 @@ x86_sched_itmt_flags
 x86_schedule_events
 __x86_set_memory_region
 x86_setup_perfctr
+x86_setup_var_mtrrs
 x86_spec_ctrl_setup_ap
 x86_stepping
 x86_thermal_enabled
@@ -72812,7 +73020,6 @@ x86_vmx_init
 x86_wallclock_init
 __xa_alloc
 __xa_alloc_cyclic
-xa_alloc_cyclic
 xacct_add_tsk
 __xa_clear_mark
 xa_clear_mark
@@ -72968,6 +73175,9 @@ xchk_bmap_data
 xchk_bmap_dirattr_extent
 xchk_bmap_get_rmap
 xchk_bmap_iextent
+xchk_bmap_iextent_delalloc
+xchk_bmap_iextent_xref
+xchk_bmap_rt_iextent_xref
 xchk_bmap_xref_rmap
 xchk_bmap_xref_rmap_cow
 xchk_btree
@@ -73009,6 +73219,7 @@ xchk_da_set_preen
 xchk_dinode
 xchk_dir_actor
 xchk_dir_check_ftype
+xchk_dir_check_pptr_fast
 xchk_directory
 xchk_directory_blocks
 xchk_directory_check_free_entry
@@ -73017,6 +73228,7 @@ xchk_directory_data_bestfree
 xchk_directory_free_bestfree
 xchk_directory_leaf1_bestfree
 xchk_dir_finish_slow_dirents
+xchk_dir_lock_child
 xchk_dir_looks_zapped
 xchk_dir_lookup
 xchk_dir_parent_pointer
@@ -73059,7 +73271,9 @@ xchk_fblock_xref_process_error
 xchk_fblock_xref_set_corrupt
 xchk_file_looks_zapped
 xchk_finobt_chunk_xref_inobt
+xchk_finobt_xref_inobt
 xchk_fscount_aggregate_agcounts
+xchk_fscount_count_frextents
 xchk_fscounters
 xchk_fscounters_cleanup
 xchk_fscounters_freeze
@@ -73090,6 +73304,7 @@ xchk_inode_check_unlinked
 xchk_inode_count_blocks
 xchk_inode_cowextsize
 xchk_inode_extsize
+xchk_inode_flags
 xchk_inode_flags2
 xchk_inode_is_allocated
 xchk_inode_is_dirtree_root
@@ -73156,6 +73371,7 @@ xchk_parent_dirent
 xchk_parent_finish_slow_pptrs
 xchk_parent_iget
 xchk_parent_ilock_dir
+xchk_parent_lock_dir
 xchk_parent_pptr
 xchk_parent_pptr_and_dotdot
 xchk_parent_revalidate_pptr
@@ -74177,6 +74393,7 @@ xfrm_pol_bin_obj
 xfrm_policy_addr_delta
 xfrm_policy_alloc
 xfrm_policy_byid
+__xfrm_policy_bysel_ctx
 xfrm_policy_bysel_ctx
 __xfrm_policy_check
 xfrm_policy_construct
@@ -74517,6 +74734,7 @@ xfs_attr_leaf_shrink
 xfs_attr_list
 xfs_attrlist_by_handle
 xfs_attr_list_ilocked
+xfs_attr_log_item
 xfs_attr_match
 xfs_attrmulti_by_handle
 xfs_attr_namecheck
@@ -74524,6 +74742,7 @@ xfs_attr_node_addname_find_attr
 xfs_attr_node_get
 xfs_attr_node_list
 xfs_attr_node_list_lookup
+xfs_attr_node_lookup
 xfs_attr_node_remove_attr
 xfs_attr_recover_work
 xfs_attr_relog_intent
@@ -74643,6 +74862,7 @@ xfs_bmap_update_create_done
 xfs_bmap_update_create_intent
 xfs_bmap_update_diff_items
 xfs_bmap_update_finish_item
+xfs_bmap_update_log_item
 xfs_bmap_validate_extent
 xfs_bmap_validate_extent_raw
 xfs_bmap_validate_ret
@@ -74675,6 +74895,7 @@ xfs_bmbt_keys_inorder
 xfs_bmbt_lookup_eq
 xfs_bmbt_lookup_first
 xfs_bmbt_maxlevels_ondisk
+xfs_bmbt_maxrecs
 xfs_bmbt_read_verify
 xfs_bmbt_recs_inorder
 xfs_bmbt_to_bmdr
@@ -74685,6 +74906,7 @@ xfs_bmbt_verify
 xfs_bmbt_write_verify
 xfs_bmdr_maxrecs
 xfs_bmdr_to_bmbt
+xfs_bmse_can_merge
 xfs_bmse_merge
 xfs_bnobt_cmp_key_with_cur
 xfs_bnobt_cmp_two_keys
@@ -74855,6 +75077,7 @@ xfs_buf_dquot_iodone
 xfs_buffered_write_delalloc_punch
 xfs_buffered_write_iomap_begin
 xfs_buffered_write_iomap_end
+xfs_buf_find_insert
 xfs_buf_find_lock
 xfs_buf_free
 xfs_buf_free_callback
@@ -74885,6 +75108,7 @@ xfs_buf_item_put
 xfs_buf_item_release
 xfs_buf_item_relse
 xfs_buf_item_size
+xfs_buf_item_size_segment
 xfs_buf_item_unpin
 xfs_buf_kill
 xfs_buf_lock
@@ -74944,6 +75168,7 @@ xfs_calc_buf_res
 xfs_calc_clear_agi_bucket_reservation
 xfs_calc_create_resv_modify
 xfs_calc_create_tmpfile_reservation
+xfs_calc_default_atomic_ioend_reservation
 xfs_calc_dquots_per_chunk
 xfs_calc_finish_bui_reservation
 xfs_calc_finish_cui_reservation
@@ -75374,6 +75599,7 @@ xfs_end_ioend_write
 xfs_eof_alignment
 xfs_error_get_cfg
 xfs_error_report
+xfs_error_sysfs_init_class
 xfs_errortag_add
 xfs_errortag_add_name
 xfs_errortag_attr_show
@@ -75438,6 +75664,7 @@ xfs_extent_free_create_intent
 xfs_extent_free_defer_add
 xfs_extent_free_diff_items
 xfs_extent_free_finish_item
+xfs_extent_free_log_item
 xfs_extent_free_recover_work
 xfs_extent_free_relog_intent
 xfs_extfree_intent_destroy_cache
@@ -75478,6 +75705,7 @@ xfs_file_sync_writes
 xfs_file_write_checks
 xfs_file_write_iter
 xfs_fill_fsxattr
+xfs_fill_statvfs_from_dquot
 xfs_find_handle
 xfs_find_trim_cow_extent
 xfs_finish_flags
@@ -75627,6 +75855,7 @@ xfs_healthmon_alloc_outbuf
 xfs_healthmon_attach
 xfs_healthmon_copybuf
 xfs_healthmon_detach
+xfs_healthmon_file_on_monitored_fs
 xfs_healthmon_format_v0
 xfs_healthmon_fs_mask
 xfs_healthmon_inode_mask
@@ -75639,6 +75868,7 @@ __xfs_healthmon_push
 xfs_healthmon_push
 xfs_healthmon_put
 xfs_healthmon_read_iter
+xfs_healthmon_reconfigure
 xfs_healthmon_release
 xfs_healthmon_report_file_ioerror
 xfs_healthmon_report_fs
@@ -75702,7 +75932,6 @@ xfs_iext_remove
 xfs_iext_set
 xfs_iext_state_to_fork
 xfs_iext_update_extent
-xfs_iflags_test_and_set
 xfs_iflush_abort
 xfs_iflush_cluster
 xfs_iflush_fork
@@ -75781,6 +76010,7 @@ xfs_inobt_irec_to_allocmask
 xfs_inobt_keys_contiguous
 xfs_inobt_keys_inorder
 xfs_inobt_lookup
+xfs_inobt_maxrecs
 xfs_inobt_read_verify
 xfs_inobt_rec_check_count
 xfs_inobt_rec_freecount
@@ -75863,6 +76093,7 @@ xfs_ioc_ag_geometry
 xfs_ioc_attr_list
 xfs_ioc_attrmulti_one
 xfs_ioc_attr_put_listent
+xfs_ioc_bulkstat
 xfs_ioc_commit_range
 xfs_ioc_exchange_range
 xfs_ioc_fsbulkstat
@@ -75874,6 +76105,7 @@ xfs_ioc_getlabel
 xfs_ioc_getparents
 xfs_ioc_getparents_by_handle
 xfs_ioc_health_monitor
+xfs_ioc_inumbers
 xfs_ioc_rtgroup_geometry
 xfs_ioc_scrub_metadata
 xfs_ioc_scrubv_metadata
@@ -75889,6 +76121,7 @@ xfs_ioc_verify_media
 xfs_iomap_end_fsb
 xfs_iomap_eof_align_last_fsb
 xfs_iomap_inode_sequence
+xfs_iomap_prealloc_size
 xfs_iomap_valid
 xfs_iomap_write_direct
 xfs_iomap_write_unwritten
@@ -76089,6 +76322,7 @@ xfs_qm_reset_dqcounts_all
 xfs_qm_reset_dqcounts_buf
 xfs_qm_resume_quotaon
 xfs_qm_scall_getquota
+xfs_qm_scall_getquota_fill_qc
 xfs_qm_scall_getquota_next
 xfs_qm_scall_quotaoff
 xfs_qm_scall_quotaon
@@ -76201,6 +76435,8 @@ xfs_refcount_update_create_done
 xfs_refcount_update_create_intent
 xfs_refcount_update_diff_items
 xfs_refcount_update_finish_item
+xfs_refcount_update_log_item
+xfs_reflink_ag_has_free_space
 xfs_reflink_allocate_cow
 xfs_reflink_cancel_cow_blocks
 xfs_reflink_cancel_cow_range
@@ -76320,6 +76556,7 @@ xfs_rmap_update_create_done
 xfs_rmap_update_create_intent
 xfs_rmap_update_diff_items
 xfs_rmap_update_finish_item
+xfs_rmap_update_log_item
 xfs_rtgroup_geom_health
 xfs_rtrefcountbt_broot_realloc
 xfs_rtrefcountbt_calc_reserves
@@ -76834,6 +77071,7 @@ xhci_segment_alloc
 xhci_set_interrupter_moderation
 xhci_set_link_state
 xhci_set_port_power
+xhci_set_remote_wake_mask
 xhci_setup_addressable_virt_dev
 xhci_setup_device
 xhci_setup_no_streams_ep_input_ctx
@@ -77213,6 +77451,7 @@ xt_match_seq_next
 xt_match_seq_show
 xt_match_seq_start
 xt_match_to_user
+xt_mttg_seq_next
 xt_mttg_seq_stop
 xt_nat_checkentry
 xt_nat_checkentry_v0
@@ -77336,7 +77575,10 @@ zap_vma_for_reaping
 __zap_vma_range
 zap_vma_range
 zap_vma_range_batched
+zcrx_arm_notif
 zcrx_box_release
+zcrx_export
+zcrx_flush_rq
 zcrx_notif_tw
 zcrx_register_netdev
 zcrx_send_notif
@@ -77350,6 +77592,7 @@ zerocopy_fill_skb_from_iter
 __zerocopy_sg_from_iter
 zerocopy_sg_from_iter
 zero_ctr
+zero_exception
 zero_fill_bio
 zeroing_mode_show
 zeroing_mode_store
@@ -77469,7 +77712,7 @@ ZSTD_buildEntropyStatisticsAndEstimateSu
 ZSTD_buildFSETable
 ZSTD_buildFSETable_body_bmi2
 ZSTD_buildSeqStore
-ZSTD_buildSeqTable
+ZSTD_buildSequencesStatistics
 ZSTD_CCtx_getParameter
 zstd_cctx_init
 ZSTD_CCtx_init_compressStream2
@@ -77590,6 +77833,7 @@ ZSTD_compress_usingCDict_advanced
 ZSTD_compress_usingDict
 ZSTD_convertBlockSequences
 ZSTD_copyBlockSequences
+ZSTD_copyCCtx
 ZSTD_copyDCtx
 ZSTD_copyDDictParameters
 ZSTD_cParam_getBounds
@@ -77700,6 +77944,7 @@ ZSTD_fillHashTable
 ZSTD_findDecompressedSize
 zstd_find_frame_compressed_size
 ZSTD_findFrameCompressedSize
+ZSTD_findFrameSizeInfo
 zstd_flush_stream
 ZSTD_flushStream
 ZSTD_frameHeaderSize
@@ -77718,8 +77963,14 @@ zstd_free_workspace
 zstd_free_workspace_manager
 ZSTD_fseBitCost
 ZSTD_generateSequences
+ZSTD_get1BlockSummary
 ZSTD_getBlockSize
 ZSTD_getcBlockSize
+zstd_get_cparams
+ZSTD_getCParams
+ZSTD_getCParamsFromCCtxParams
+ZSTD_getCParamsFromCDict
+ZSTD_getCParams_internal
 ZSTD_getDDict
 ZSTD_getDecompressedSize
 ZSTD_getDictID_fromCDict
@@ -77737,6 +77988,8 @@ ZSTD_getFrameHeader
 ZSTD_getFrameHeader_advanced
 ZSTD_getFrameProgression
 ZSTD_getOffsetInfo
+zstd_get_params
+ZSTD_getParams
 ZSTD_getSeqStore
 zstd_get_workspace
 ZSTD_HcFindBestMatch_dedicatedDictSearch_4
