Received: from mta1.migadu.com (out-118.mta1.migadu.com [95.215.58.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12722471D00
	for <dwarves@vger.kernel.org>; Fri,  2 Oct 2026 09:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790934022; cv=none; b=so1KgfNQNME69vyzpLlm7tUhVGcCnn5T7nDJYYP4mfDb58MAaeVZ1yqL1aypu4sT1ODLp2ajgojSsJNvU8VAQu/M2hSkX7lgQTiwOMhu/Dr6W59JnaqsjQ8UJYaTgKsidBVjUQFLXDPdDeoo/kwedtcKE0JyWrTVlk4sgo8vwaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790934022; c=relaxed/simple;
	bh=cD63NCinN+edm4dUpZCBPhcw0BIXJiBGV/bXG8fg1Ig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MFAaHWfkXldgovtjiywzz807ql+DucCV2Ai8n7osgicJ+QXbDTQfXjKreoNTvjqgl67iZ1YQJypoD+cjrRZn7ddmeDuMsur+wJ8JhMH6IQLUdKPCESFAHI9XGXJJUtZ0VQJfPb1o0OrVxKfI5ceqvQ7nh/5UHjsfBAzaCE60oBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cVgU/iX9; arc=none smtp.client-ip=95.215.58.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cVgU/iX9"
X-Envelope-To: dwarves@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=cD63NCinN+edm4dUpZCBPhcw0BIXJiBGV/bXG8fg1Ig=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790934017; v=1; x=1791538817;
 b=cVgU/iX9seZSLkgmSz6/lVMNnKPEEHPLaGW5Ew7hFIZtBNnyoVyxY27461CajoMnC6vhFaEq
 mjXrmNL4CvwN/MurYiGLyr3U/7zxQYnQwqSYFh2CHG7vjsCCluiqFgKnhMrOCChpmA7BxzIhA94
 +x6hgyxt3w3CXhwel7WMVJfU=
X-Envelope-To: dwarves@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b1a5c01cc692eb45;
	Fri, 02 Oct 2026 09:40:15 +0000
X-Mizu-Trace-ID: b1a5c01cc692eb45
X-Migadu-Flow: FLOW_OUT
Message-ID: <efa1ae47-3ccf-4689-9fde-a0294985ccfb@linux.dev>
Date: Fri, 2 Oct 2026 10:40:12 +0100
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Many instances of "no BTF func for kfunc ..." and "unresolved
 symbol ..." from resolve_btfids after pahole 1.32 upgrade
Content-Language: en-GB
To: Nathan Chancellor <nathan@kernel.org>,
 Alan Maguire <alan.maguire@oracle.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org,
 dwarves@vger.kernel.org
References: <20261001224346.GA576434@ax162>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20261001224346.GA576434@ax162>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/1/26 3:43 PM, Nathan Chancellor wrote:
> Hi pahole/btf folks,
>
> I have not seen this reported yet, my apologies if it has and I missed
> it. In my LLVM build tests, I am seeing many instances of warnings along
> the lines of
>
>    WARN: resolve_btfids: no BTF func for kfunc bpf_xdp_get_xfrm_state in xfrm_state_kfunc_set
>    WARN: resolve_btfids: no BTF func for kfunc bpf_xdp_xfrm_state_release in xfrm_state_kfunc_set
>    ...
>    WARN: resolve_btfids: unresolved symbol bpf_xdp_xfrm_state_release
>    WARN: resolve_btfids: unresolved symbol bpf_xdp_get_xfrm_state
>    ...
>
> in various configurations across a few different architectures (such as
> arm, powerpc, and riscv). I have attached a full warning log (since it
> is over 3000 lines long) and the configuration that it came from, in
> case they are relevant.
>
> I bisected this to
>
>    commit e96290426e180703fb34d904df3772a2389c6df3
>    Author: Yonghong Song <yonghong.song@linux.dev>
>
>        dwarf_loader: Analyze per-parameter information for true signatures
>
> in pahole 1.32. If there is any other information I can provide or
> patches I can test, I am more than happy to do so.

Could you try the following patch to see whether it solved the issue.
I didn't have environment to test arm, powerpc, riscv, etc.

diff --git a/btf_encoder.c b/btf_encoder.c
index d6b9be6..2f137ee 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -2913,7 +2913,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
                 encoder->tag_kfuncs      = conf_load->btf_decl_tag_kfuncs;
                 encoder->gen_distilled_base = conf_load->btf_gen_distilled_base;
                 encoder->encode_attributes = conf_load->btf_attributes;
-               encoder->true_signature = conf_load->true_signature;
+               encoder->true_signature = conf_load->true_signature && cu->param_loc_supported;
                 encoder->verbose         = verbose;
                 encoder->has_index_type  = false;
                 encoder->need_index_type = false;
diff --git a/dwarf_loader.c b/dwarf_loader.c
index 1e5363a..9f9b9c9 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -1518,6 +1518,22 @@ static bool arch__arg_align_two_regs(const GElf_Ehdr *ehdr)
         }
  }
  
+/*
+ * Architectures whose argument register mapping has been validated for
+ * matching clang parameter locations and reconstructing true signatures.
+ * Other architectures keep only the basic optimized-out detection.
+ */
+static bool arch__param_loc_supported(const GElf_Ehdr *ehdr)
+{
+       switch (ehdr->e_machine) {
+       case EM_X86_64:
+       case EM_AARCH64:
+               return true;
+       default:
+               return false;
+       }
+}
+
  static struct template_type_param *template_type_param__new(Dwarf_Die *die, struct cu *cu, struct conf_load *conf)
  {
         struct template_type_param *ttparm = tag__alloc(cu, sizeof(*ttparm));
@@ -3777,7 +3793,8 @@ static void function__analyze_parameter_locations(struct function *fn, struct cu
  {
         struct ftype *ftype = &fn->proto;
         struct parameter *pos;
-       bool true_sig_enabled = conf->true_signature && ftype->signature_changed;
+       bool true_sig_enabled = cu->param_loc_supported && conf->true_signature &&
+                               ftype->signature_changed;
         bool check_locations = !cu->producer_clang || ftype->signature_changed;
         int reg_idx = 0;
  
@@ -3785,7 +3802,8 @@ static void function__analyze_parameter_locations(struct function *fn, struct cu
                 /* Producer is clang and the signature was not changed: match
                  * each parameter against its expected ABI argument register.
                  */
-               function__match_clang_parameter_locations(ftype, cu);
+               if (cu->param_loc_supported)
+                       function__match_clang_parameter_locations(ftype, cu);
                 return;
         }
  
@@ -4533,6 +4551,7 @@ static int cu__set_common(struct cu *cu, struct conf_load *conf,
         cu->nr_register_params = arch__nr_register_params(&ehdr);
         cu->agg_use_two_regs = arch__agg_use_two_regs(&ehdr);
         cu->arg_align_two_regs = arch__arg_align_two_regs(&ehdr);
+       cu->param_loc_supported = arch__param_loc_supported(&ehdr);
         arch__set_register_params(&ehdr, cu);
         return 0;
  }
diff --git a/dwarves.h b/dwarves.h
index f3453ed..6b75ece 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -305,6 +305,7 @@ struct cu {
         uint8_t          producer_clang:1;
         uint8_t          agg_use_two_regs:1;    /* An aggregate like {long a; long b;} */
         uint8_t          arg_align_two_regs:1;  /* An over-aligned arg starts on an even register */
+       uint8_t          param_loc_supported:1; /* Parameter location analysis is validated for this arch */
         uint8_t          nr_register_params;
         int              register_params[ARCH_MAX_REGISTER_PARAMS];
         int              functions_saved;

