Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E2223909F
	for <dwarves@vger.kernel.org>; Tue, 11 Aug 2026 00:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786408222; cv=none; b=H4kEKoT5Bv2Mi/1iZgTLoI5HRYxB+4gGYnLiV+r7sX7BKoqAlAm2yYLWhwdQ92dZ6apUqzypm3pnHtLCVbbOHH3crUDoRFzWa06wKEVV3OCbiwEfwHw81B7LjSkyyDYDXY99oz8/EhxN+TM1/yxxyEvh9yVkmOjWUZoNfTBWT44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786408222; c=relaxed/simple;
	bh=LUBBKVRGeqFCJm7q74GJ4j9xUn3yL6l3DKhAQ+kucFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A+u4RtYb0b4lY7RQLbc6ukMI6km2oPZ/HpE/oQ8K3R6/+2o5gDXjspzdxTiU7s/H8RPUo2G8dtSzoDwb1sT8ZZddzKJcfGtMN/jJlrnd03J5ry7Ji+QIFM9zeM6oO8NItzeUqHfL4gRhhWN2BXs+OwfwcF6eGs1dhRwjyRe9vGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=abK8saoX; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="abK8saoX"
Message-ID: <76eba899-aad9-40ba-969f-bfec28031e12@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786408218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LSZlM8NCTNyE7SxPKVsihSoaRmvKqZHwLV8kGj4B6Ds=;
	b=abK8saoXSk9XuunmytzpgkCxPn+0LfpK4Ug5hVATjzsKTTbCaKYXLMF076XaHcgbCIvYdW
	0m3s64KLkuQ9WASSbJ+UacCuutYOAQY0d+lVYkKLUm+m9EpVm0BpCbqVkI2iXrOoSowENW
	nyReXFd5vDsrJlFdX7+tATGtcXosUko=
Date: Mon, 10 Aug 2026 17:29:56 -0700
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 04/12] btf_encoder: Encode variant parts as union members
 in BTF
Content-Language: en-GB
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Clark Williams <williams@redhat.com>,
 dwarves@vger.kernel.org, bpf@vger.kernel.org,
 Andrii Nakryiko <andrii@kernel.org>, Mark Wieelard <mjw@redhat.com>,
 Arnaldo Carvalho de Melo <acme@redhat.com>
References: <20260731193102.110693-1-acme@kernel.org>
 <20260731193102.110693-5-acme@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260731193102.110693-5-acme@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 7/31/26 12:30 PM, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> With the DWARF loader now populating DW_TAG_variant children (previous
> commit), wire them into BTF encoding so Rust discriminated unions
> (Option<T>, Result<T,E>, etc.) are no longer emitted as empty structs.
>
> Two changes:
>
> 1. Struct-to-union promotion: when a DW_TAG_structure_type has
>     variant_parts but no regular data members, encode it as BTF_KIND_UNION
>     instead of BTF_KIND_STRUCT, since the variants overlap at offset 0.
>
> 2. Variant member encoding: after encoding regular data members, iterate
>     the variant_parts and emit each variant as a BTF union field with the
>     variant's name and resolved type reference.
>
> Testing with the sashiko-cli Rust binary (a real-world async HTTP client
> using tokio, hyper, serde, etc.):
>
> Before:
>
>    $ bpftool btf dump file sashiko-cli | grep -c UNION
>    2073
>    $ bpftool btf dump file sashiko-cli | grep 'STRUCT.*vlen=0' | grep -vc 'size=0'
>    24335
>
> After:
>
>    $ bpftool btf dump file sashiko-cli | grep -c UNION
>    25750
>    $ bpftool btf dump file sashiko-cli | grep 'STRUCT.*vlen=0' | grep -vc 'size=0'
>    2236
>
> 22,099 types that were previously encoded as empty structs are now
> properly represented as unions with their variant members:
>
> Before:
>
>    $ bpftool btf dump file code_with_type.o | grep -A1 'Option<u32>'
>    [11] STRUCT 'Option<u32>' size=8 vlen=0
>
> After:
>
>    $ bpftool btf dump file code_with_type.o | grep -A3 'Option<u32>'
>    [11] UNION 'Option<u32>' size=8 vlen=2
>            'None' type_id=9 bits_offset=0
>            'Some' type_id=10 bits_offset=0

FYI, the below is for llvm bpf backend to handle DW_TAG_variant_part
to generate BTF.
   link: https://github.com/llvm/llvm-project/pull/155783
   
For a rust code like:

; Source:
;   #![no_std]
;   #![no_main]
;
;   pub enum MyEnum {
;       First { a: u32, b: i32 },
;       Second(u32),
;   }
;
;   #[unsafe(no_mangle)]
;   pub static X: MyEnum = MyEnum::First { a: 54, b: -23 };
;
;   #[cfg(not(test))]
;   #[panic_handler]
;   fn panic(_info: &core::panic::PanicInfo) -> ! {
;       loop {}
;   }

The BTF encoding:

; CHECK-BTF:      [1] STRUCT 'MyEnum' size=12 vlen=1
; CHECK-BTF-NEXT:         '(anon)' type_id=3 bits_offset=0
; CHECK-BTF-NEXT: [2] INT 'u32' size=4 bits_offset=0 nr_bits=32 encoding=(none)
; CHECK-BTF-NEXT: [3] UNION '(anon)' size=12 vlen=3
; CHECK-BTF-NEXT:         '(anon)' type_id=2 bits_offset=0
; CHECK-BTF-NEXT:         'First' type_id=4 bits_offset=0
; CHECK-BTF-NEXT:         'Second' type_id=6 bits_offset=0
; CHECK-BTF-NEXT: [4] STRUCT 'First' size=12 vlen=2
; CHECK-BTF-NEXT:         'a' type_id=2 bits_offset=32
; CHECK-BTF-NEXT:         'b' type_id=5 bits_offset=64
; CHECK-BTF-NEXT: [5] INT 'i32' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
; CHECK-BTF-NEXT: [6] STRUCT 'Second' size=12 vlen=1
; CHECK-BTF-NEXT:         '__0' type_id=2 bits_offset=32
; CHECK-BTF-NEXT: [7] VAR 'X' type_id=1, linkage=global
; CHECK-BTF-NEXT: [8] DATASEC '.rodata' size=0 vlen=1
; CHECK-BTF-NEXT:         type_id=7 offset=0 size=12

>
> Assisted-by: Claude:claude-sonnet-4-5
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>   btf_encoder.c | 37 +++++++++++++++++++++++++++++++++++--
>   1 file changed, 35 insertions(+), 2 deletions(-)
>
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 83ce21186ea7da36..acf0a5ade5e29014 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -1855,6 +1855,12 @@ static void dump_invalid_symbol(const char *msg, const char *sym,
>   	fprintf(stderr, "PAHOLE: Error: Use '--btf_encode_force' to ignore such symbols and force emit the btf.\n");
>   }
>   
> +static bool type__has_variant_parts(const struct type *type)
> +{
> +	return !list_empty(&type->variant_parts);
> +}
> +
> +
>   static int32_t btf_encoder__add_struct_type(struct btf_encoder *encoder, struct tag *tag)
>   {
>   	struct type *type = tag__type(tag);
> @@ -1863,8 +1869,18 @@ static int32_t btf_encoder__add_struct_type(struct btf_encoder *encoder, struct
>   	int32_t type_id;
>   	uint8_t kind;
>   
> -	kind = (tag->tag == DW_TAG_union_type) ?
> -		BTF_KIND_UNION : BTF_KIND_STRUCT;
> +	/*
> +	 * Rust discriminated unions (enums) are represented in DWARF as
> +	 * DW_TAG_structure_type with DW_TAG_variant_part children.
> +	 * If the struct has only variant parts and no regular data members,
> +	 * encode it as a BTF union since the variants overlap at offset 0.
> +	 */
> +	if (tag->tag == DW_TAG_union_type)
> +		kind = BTF_KIND_UNION;
> +	else if (type__has_variant_parts(type) && type->nr_members == 0)
> +		kind = BTF_KIND_UNION;
> +	else
> +		kind = BTF_KIND_STRUCT;
>   
>   	type_id = btf_encoder__add_struct(encoder, kind, name, type->size);
>   	if (type_id < 0)
> @@ -1882,6 +1898,23 @@ static int32_t btf_encoder__add_struct_type(struct btf_encoder *encoder, struct
>   			return -1;
>   	}
>   
> +	if (type__has_variant_parts(type) && kind == BTF_KIND_UNION) {
> +		struct variant_part *vpart;
> +
> +		type__for_each_variant_part(type, vpart) {
> +			struct variant *variant;
> +
> +			variant_part__for_each_variant(vpart, variant) {
> +				if (variant->tag.type == 0)
> +					continue;
> +
> +				uint32_t ref_type_id = btf_encoder__tag_type(encoder, variant->tag.type);
> +
> +				if (btf_encoder__add_field(encoder, variant->name, ref_type_id, 0, 0))
> +					return -1;
> +			}
> +		}
> +	}
>   
>   
>   	return type_id;

