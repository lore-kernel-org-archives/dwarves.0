Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795795930;
	b=4FymWosOsFtQywgjQ2hSZfXpizIxF5rxjXgE0bC+Kvfw2alBkeh296U13FQ69BCF453v
	 YzeiWMYIUeM2GSTNfVjNK5JM46Gml61q+oLAxdr8OI2XLogVQP9tQN1qfZadYj6K47x1e
	 4v9de/fFPjHdrpcAsq+BERp34lr7ylLrPNBZJ4AxM9ISGkdNjO0tSUlMosuJXvcARM1Rp
	 AUbVwqrkHIv619NngVUJJ8xZcGhgYEj6+6DZvIy3EOFz9Xxjvx/fzmxR4fSvMOez+cnkN
	 cRDz7PYeA0j7U58riNQh0juGkg5oZMC/cZtumWi5jSM+XukNf4dXk6Xr7K8qqkYVGqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795795930;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=l24Ft7fBp5vECB/C7KiHVFH6X5pwmAkl551+TanfgVU=;
	b=up/n/yYN8NflZDdKXNv3RTaTVkmwg97QlCVXZsRzxryeZyKUFWBcdTo1veTFVjSyqsjn
	 zpo/rbLHyFSdsFHCxiBzbEcxoPPX/ZqZWBOTf+awafTuAUleH1gLqKUuwtTqFg5lWn7gm
	 6fm/ayFqMRs56n6wKqLiunMxd1ZaFVBMYpsM070RFD40keETjBhXUeci2U4ZOfdQ/ybXt
	 yWw1V5r3IMQiMSZCjPmz+sqZ+9pQ/x0oTZxA09xWbkn/VeV/y1zC2oqcujw/R5WSVVty6
	 hXHf2kjhxMqp6Ixudmcr/AZNQcLUQDjrGNb/JLtXh8Jcr7MUTdhVRBgounOFgxu2oqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KMNXQs3F;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A17606A32D;
	Fri, 27 Nov 2026 16:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KMNXQs3F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A3431F00935;
	Fri, 27 Nov 2026 16:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795795929;
	bh=l24Ft7fBp5vECB/C7KiHVFH6X5pwmAkl551+TanfgVU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=KMNXQs3FjVr1zXJ/bS7u1xVwR8x5M3PEyKFATF7bGF4ZMiVkwURe0NGOYJvrf9Bkl
	 AtnfblyOpaq4DUNh+fWhsKvZa95p3YfeZnYCZkN+fDswaceKjkYWUVkzWbro7tmjGb
	 SyBwJELqU4Xk66n3u8zjKCNu8atvFt4S+mVz3/tyu4oBfnKxpR7ha5HIF++I3qfYeI
	 wAUX3sC2lDCIJkcvv9dp2ejszR/NW1law6qHaHMsC7yBoNFbIRcpwV4aO688W1Ga89
	 8Mv+jFA1J6ZvJPLkF7+OntcV5X2/u64iObJ8p+K4aRudqTzPyqZ2g60PuSwFsrMUo+
	 wluT1xwqm6m2Q==
Message-ID: <7b0e61e9-5b8f-49b8-afc0-a56be82ed0ee@kernel.org>
Date: Fri, 27 Nov 2026 16:12:06 +0000
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Post: <mailto:dwarves@vger.kernel.org>
List-Help: <mailto:dwarves+help@vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
List-Owner: <mailto:dwarves+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves 2/2] btf_encoder: fix DATASEC assignment for
 ET_REL files
To: Stephen Brennan <stephen.s.brennan@oracle.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: dwarves@vger.kernel.org, linux-debuggers@vger.kernel.org,
 Alan Maguire <alan.maguire@oracle.com>
References: <20261119185236.4113166-1-stephen.s.brennan@oracle.com>
 <20261119185236.4113166-3-stephen.s.brennan@oracle.com>
Content-Language: en-GB
From: Alan Maguire <almagui@kernel.org>
In-Reply-To: <20261119185236.4113166-3-stephen.s.brennan@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/19/26 6:52 PM, Stephen Brennan wrote:
> When building a kernel with the global_var feature, I encountered some
> kernel modules whose BTF encoded a DATASEC named ".debug_info" and
> assigned some variables, such as "__this_module" to this section.
> 
> For ET_REL files, libdwfl assigns a synthetic address to allocated
> sections, starting at around 0x10000. Non-allocated sections, like
> .debug_info, start at address 0. If large enough, a non-allocated
> section's address range can extend past 0x10000, into the synthetic
> address range of an allocated section. This can happen with Linux kernel
> modules, resulting in the above behavior.
> 
> Pahole iterates the sections in order, so if a variable's address falls
> into the overlapping range, and the non-allocated section appears first,
> pahole assigns it to the non-allocated section.
> 
> Currently, get_elf_section() has logic to filter which sections are
> actually considered for variables. It uses a cached value of sh_type,
> but we have no cached sh_flags. Rather than cache more data, we can just
> filter out ineligible sections when we initialize the secinfo array,
> allowing us to remove cached sh_type altogether. This keeps the
> eligibility logic in one place, and removes the need to cache a field.
> 
> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>

hi Stephen, this one needs a respin I think as the context in
btf_encoder.c has changed; did you build on top of github.com/acmel/dwarves
perhaps? Latest is always at https://git.kernel.org/pub/scm/devel/pahole/pahole.git/

Arnaldo, would you mind syncing next, master with pahole.git? Thanks!

Alan

> ---
>  btf_encoder.c        | 13 +++++-----
>  tests/btf_datasec.sh | 56 +++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 61 insertions(+), 8 deletions(-)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index d6b9be6..8907b25 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -116,7 +116,6 @@ struct elf_secinfo {
>  	uint64_t    addr;
>  	const char *name;
>  	uint64_t    sz;
> -	uint32_t    type;
>  	bool        include;
>  	struct gobuffer secinfo;
>  };
> @@ -2658,11 +2657,6 @@ static size_t get_elf_section(struct btf_encoder *encoder, uint64_t addr)
>  {
>  	/* Start at index 1 to ignore initial SHT_NULL section */
>  	for (size_t i = 1; i < encoder->seccnt; i++) {
> -		/* Variables are only present in PROGBITS or NOBITS (.bss) */
> -		if (!(encoder->secinfo[i].type == SHT_PROGBITS ||
> -		     encoder->secinfo[i].type == SHT_NOBITS))
> -			continue;
> -
>  		if (encoder->secinfo[i].addr <= addr &&
>  		    (addr - encoder->secinfo[i].addr) < encoder->secinfo[i].sz)
>  			return i;
> @@ -2977,10 +2971,15 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
>  			Elf_Scn *sec = elf_section_by_idx(cu->elf, &shdr, shndx, &secname);
>  			if (!sec)
>  				goto out_delete;
> +			/* Variables are only present in PROGBITS or NOBITS (.bss) */
> +			if (!(shdr.sh_type == SHT_PROGBITS || shdr.sh_type == SHT_NOBITS))
> +				continue;
> +			/* Variables are only present in runtime allocated sections. */
> +			if (!(shdr.sh_flags & SHF_ALLOC))
> +				continue;
>  			encoder->secinfo[shndx].addr = shdr.sh_addr;
>  			encoder->secinfo[shndx].sz = shdr.sh_size;
>  			encoder->secinfo[shndx].name = secname;
> -			encoder->secinfo[shndx].type = shdr.sh_type;
>  
>  			if (encoder->encode_vars & BTF_VAR_GLOBAL)
>  				encoder->secinfo[shndx].include = true;
> diff --git a/tests/btf_datasec.sh b/tests/btf_datasec.sh
> index 470c7f2..31d590f 100755
> --- a/tests/btf_datasec.sh
> +++ b/tests/btf_datasec.sh
> @@ -4,7 +4,8 @@
>  #
>  # Test BTF VAR and DATASEC encoding for global variables via
>  # btf_encoder__add_var() and btf_encoder__add_datasec() in btf_encoder.c,
> -# exercised through --btf_features=global_var on a small linked binary.
> +# exercised through --btf_features=global_var on a small linked binary
> +# and a relocatable object with overlapping non-allocated sections.
>  #
>  # External globals and statics must each produce a BTF_KIND_VAR entry with
>  # the correct linkage, and their ELF section must appear as a
> @@ -119,4 +120,57 @@ else
>  	info_log "DATASEC VAR references: skipped (old bpftool format)"
>  fi
>  
> +# For ET_REL files, libdwfl assigns synthetic addresses starting at 0x10000
> +# to allocated sections. Non-allocated sections retain address zero, so a
> +# sufficiently large one appears to overlap the variables' addresses.
> +# Put one before .late_data to catch lookups that ignore SHF_ALLOC.
> +cat > "$src" << 'EOF'
> +asm(".pushsection .debug_padding, \"\"\n"
> +    ".zero 0x20000\n"
> +    ".popsection\n");
> +int late_first __attribute__((section(".late_data"))) = 1;
> +int late_second __attribute__((section(".late_data"))) = 2;
> +EOF
> +
> +obj="$outdir/btf_datasec.o"
> +btf="$outdir/btf_datasec_rel.btf"
> +if ! $CC -g -O0 -c -o "$obj" "$src" 2>/dev/null; then
> +	error_log "FAIL: relocatable object compilation failed"
> +	test_fail
> +fi
> +
> +if ! pahole --btf_features=global_var --btf_encode_detached="$btf" "$obj" 2>/dev/null; then
> +	error_log "FAIL: relocatable object BTF encoding failed"
> +	test_fail
> +fi
> +
> +dump=$(bpftool btf dump file "$btf" 2>/dev/null)
> +if ! echo "$dump" | grep -q "DATASEC '\.late_data' size=8 vlen=2"; then
> +	error_log "FAIL: expected two variables in .late_data DATASEC"
> +	test_fail
> +fi
> +if echo "$dump" | grep -q "DATASEC '\.debug_padding'"; then
> +	error_log "FAIL: non-allocated .debug_padding encoded as a DATASEC"
> +	test_fail
> +fi
> +
> +for var in late_first late_second; do
> +	if ! echo "$dump" | grep -q "VAR '$var'"; then
> +		error_log "FAIL: BTF_KIND_VAR '$var' not found"
> +		test_fail
> +	fi
> +done
> +
> +if echo "$dump" | grep -q "(VAR '"; then
> +	for var in late_first late_second; do
> +		if ! echo "$dump" | grep -q "(VAR '$var')"; then
> +			error_log "FAIL: no DATASEC references VAR '$var'"
> +			test_fail
> +		fi
> +	done
> +else
> +	info_log "DATASEC VAR references: skipped (old bpftool format)"
> +fi
> +info_log "Relocatable object ignores non-allocated sections: ok"
> +
>  test_pass

