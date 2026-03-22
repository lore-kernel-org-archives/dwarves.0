Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADFA23A9B3
	for <dwarves@vger.kernel.org>; Sun, 22 Mar 2026 18:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774202620; cv=none; b=TzNWcxPBs1SRinbHeFV9IfsUIWSF8uki3RcgZRWaqvziUQBh5eO3CKb5g9zqJMuqsRITjE7sEXTmgPtIKShS1jE8JYN1zoalVz9EvatTb+n0/LJW4TgPGQ0breMDnJc7+0nkgRcNc4JDlRp+YbVsi7wK+h9iDmfNumLMS+CpXH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774202620; c=relaxed/simple;
	bh=hG0D0Y135bKPI0Dc6+MTMqeit29o7a6IWoFll3S9kio=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZrLGqYBAH+G5TznoZ8jJAZuSMvrLUKIa+Y4yFf52c3DBi3VCcuCtG1VLf3f4IONKJkYvbpqKxVDsTrBI80o/T03+eVDpV84u3ITMrlvItBfnlxJ6u0PSTAs8Dsamnum74ac0jE7pNBoOFWmbVSGr+7MrQIVVYidoVapBilLROIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pN9XwPFU; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pN9XwPFU"
Message-ID: <97086279-4796-4753-b718-3206cf524d04@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774202606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rNkRtlTdSJ11bqq+Scf3vzZi1dpTafX0a7JsAC0gyyw=;
	b=pN9XwPFUYwWpBFYd6jwnnIatEK6LiW0JaIlmLhIdJx/xKl+H3VRmZT0SO32pCESKyyfVb9
	mFOUoaYAFX1rjh/MrdtFi+3ugTPCU5GMaOOkZJXVdgUkiNfurLTOW44OpgixIwtSl6NA8o
	6pJOqpwR6IGGArL3P1CC81p6vXo+Wu8=
Date: Sun, 22 Mar 2026 11:03:19 -0700
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH dwarves v3 2/9] dwarf_loader: Handle signatures with dead
 arguments
Content-Language: en-GB
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>,
 Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, dwarves@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org, kernel-team@fb.com
References: <20260320190917.1970524-1-yonghong.song@linux.dev>
 <20260320190927.1970829-1-yonghong.song@linux.dev> <ab8lZBk2Z_1sPkZL@krava>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <ab8lZBk2Z_1sPkZL@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 3/21/26 4:10 PM, Jiri Olsa wrote:
> On Fri, Mar 20, 2026 at 12:09:27PM -0700, Yonghong Song wrote:
>> For llvm dwarf, the dead argument may be in the middle of
>> DW_TAG_subprogram. So we introduce skip_idx in order to
>> match expected registers properly.
>>
>> For example:
>>    0x00042897:   DW_TAG_subprogram
>>                    DW_AT_name      ("create_dev")
>>                    DW_AT_calling_convention        (DW_CC_nocall)
>>                    DW_AT_type      (0x0002429a "int")
>>                    ...
>>
>>    0x000428ab:     DW_TAG_formal_parameter
>>                      DW_AT_name    ("name")
>>                      DW_AT_type    (0x000242ed "char *")
>>                      ...
>>
>>    0x000428b5:     DW_TAG_formal_parameter
>>                      DW_AT_location        (indexed (0x3f) loclist = 0x000027f8:
>>                         [0xffffffff87681370, 0xffffffff8768137a): DW_OP_reg5 RDI
>>                         [0xffffffff8768137a, 0xffffffff87681392): DW_OP_reg3 RBX
>>                         [0xffffffff87681392, 0xffffffff876813ae): DW_OP_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value)
>>                      DW_AT_name    ("dev")
>>                      DW_AT_type    (0x00026859 "dev_t")
>>                      ...
>>
>> With skip_idx, we can identify that the second original argument
>> 'dev' becomes the first one after optimization.
> hi,
> this change removes for me functions below and some of them (ata_dev_select,
> dmi_save_type, perhaps more) seem to be removed because their last 2 arguments
> are constants IIUC, which does not seem to be what the changelog suggests,
> but I guess it's still correct (it's without +true_signature)

For this patch, without +true_signature, it can only get true signatures
when the dead arguments at the end of argument list. With +true_signature,
it allows dead arguments before non-dead arguments.

>
> jirka
>
>
> ata_dev_select
> __cgroup1_procs_write
> check_buffer_access
> dax_disassociate_entry
> devlink_nl_sb_port_pool_fill
> dmi_format_ids
> dmi_save_type
> dmi_save_uuid
> get_buffer
> get_net_track
> gue_remcsum
> icmpv4_xrlim_allow
> insert_vmap_area_augment
> __intel_pmu_enable_all
> ip6addrlbl_fill
> ip6_dst_store
> kernelmode_fixup_or_oops
> merge_note_headers_elf32
> merge_note_headers_elf64
> mt_destroy_walk
> __mutex_lock
> __netdev_walk_all_lower_dev
> pci_create_device_link
> populate_kprobe_blacklist
> proc_get_long
> rt_mutex_adjust_prio_chain
> rt_set_nexthop
> run_lwt_bpf
> simple_attr_write_xsigned
> __skb_gro_checksum_validate_needed
> tclass_notify
> tg_set_conf
> toggle_bp_slot
> trace_event_get_offsets_aer_event
> trace_event_get_offsets_br_fdb_external_learn_add
> trace_event_get_offsets_br_fdb_update
> trace_event_get_offsets_cache_tag_flush
> trace_event_get_offsets_devlink_health_recover_aborted
> trace_event_get_offsets_iommu_error
> trace_event_get_offsets_prq_report
> virtio_net_hdr_from_skb
> writeback_inodes_wb
> xfs_file_dio_write_aligned
>
>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   dwarf_loader.c | 19 +++++++++++++++++--
>>   1 file changed, 17 insertions(+), 2 deletions(-)
>>
>> diff --git a/dwarf_loader.c b/dwarf_loader.c
>> index 21f8bf1..a6e6587 100644
>> --- a/dwarf_loader.c
>> +++ b/dwarf_loader.c
>> @@ -1192,6 +1192,7 @@ static ptrdiff_t __dwarf_getlocations(Dwarf_Attribute *attr,
>>   
>>   struct func_info {
>>   	bool signature_changed;
>> +	int skip_idx;
>>   };
>>   
>>   /* For DW_AT_location 'attr':
>> @@ -1264,6 +1265,7 @@ static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
>>   	if (parm != NULL) {
>>   		bool has_const_value;
>>   		Dwarf_Attribute attr;
>> +		int reg_idx;
>>   
>>   		tag__init(&parm->tag, cu, die);
>>   		parm->name = attr_string(die, DW_AT_name, conf);
>> @@ -1273,7 +1275,18 @@ static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
>>   		if (!info->signature_changed) {
>>   			if (cu->producer_clang || param_idx >= cu->nr_register_params)
>>   				return parm;
>> +		} else {
>> +			/* if true_signature is not enabled, mark parameter as
>> +			 * unexpected_reg since there is a skipped parameter before.
>> +			 */
>> +			if (!conf->true_signature && info->skip_idx) {
>> +				parm->unexpected_reg = 1;
>> +				return parm;
>> +			}
>>   		}
>> +		reg_idx = param_idx - info->skip_idx;
>> +		if (reg_idx >= cu->nr_register_params)
>> +			return parm;
>>   		/* Parameters which use DW_AT_abstract_origin to point at
>>   		 * the original parameter definition (with no name in the DIE)
>>   		 * are the result of later DWARF generation during compilation
>> @@ -1311,7 +1324,7 @@ static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
>>   		parm->has_loc = dwarf_attr(die, DW_AT_location, &attr) != NULL;
>>   
>>   		if (parm->has_loc) {
>> -			int expected_reg = cu->register_params[param_idx];
>> +			int expected_reg = cu->register_params[reg_idx];
>>   			int actual_reg = parameter__reg(&attr, expected_reg);
>>   
>>   			if (actual_reg < 0)
>> @@ -1324,8 +1337,10 @@ static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
>>   				 * contents.
>>   				 */
>>   				parm->unexpected_reg = 1;
>> -		} else if (has_const_value) {
>> +		} else if (has_const_value || info->signature_changed) {
>>   			parm->optimized = 1;
>> +			if (info->signature_changed)
>> +				info->skip_idx++;
>>   		}
>>   	}
>>   
>> -- 
>> 2.52.0
>>
>>

