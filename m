Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA03328B5E
	for <dwarves@vger.kernel.org>; Wed, 17 Jun 2026 20:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781726925; cv=none; b=IqMaa4ZErciHtgb1fCZ/DsyL+4atMMBiLC8tcjfYUfgpHrj8SAQyrsnwnTaeR9O7BaFHYEWBmGodOF7WyDhAMPUo5mYJnU8P6Yo2OTT1HuPx/9KHmMhwaveEHKdgyhhJkA8ZvfpUD9T0gXlU5UJDpH6okA7eQI4jvWLefei4oCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781726925; c=relaxed/simple;
	bh=9U+xeJIdd1FouSj2NfVGFxUSAnufknUJjgvZGCu2bSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hIYIdteoOpyl9hUDk93fAMOrcV2dgAGBO1MjmoWnsNCABNtkuowbGOkY5nSK2DOD1dsItYVrlz78CwtUkhqRyuRnM4V2slF53UK04qKdmw8IEIgfn47Zv5A8nHTKPVjzKLs60B6302S8zJfkqREhoPTIsZsP9OQPMi1R4pPZLIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MBiBd4GK; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MBiBd4GK"
Message-ID: <2daeb438-e9b6-431b-8b74-49b09e055977@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781726911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t/7XyyGOJfzn0E7eOmoQZh8Xa0KHU5AgmtoKWj027x0=;
	b=MBiBd4GKX69nsH3Of435Ew7U8gguM+YUCqmClicS6363cxHWlT+gK1wl/HBUCdNmenQ6Bs
	5c2PuhDtFeiF2R+za1TkoEMWQTNma4x1INyJumXFEboD/wkmz9oXq6vf9SLMy8pNG0SrW1
	lXJ5D4cyO1PdcXo/G2jxDvoR2icIpZI=
Date: Wed, 17 Jun 2026 13:08:13 -0700
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PAHOLE v4 2/3] dwarf_loader: Add support for
 DW_TAG_GNU_annotation
To: Alan Maguire <alan.maguire@oracle.com>, dwarves@vger.kernel.org
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
 acme@kernel.org, Emil Tsalapatis <emil@etsalapatis.com>,
 jose.marchesi@oracle.com, David Faust <david.faust@oracle.com>
References: <20260602195512.1511013-1-vineet.gupta@linux.dev>
 <20260602195512.1511013-2-vineet.gupta@linux.dev>
 <e258ee1d-369c-46f7-a93b-ed665c276130@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <e258ee1d-369c-46f7-a93b-ed665c276130@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 6/7/26 2:54 AM, Alan Maguire wrote:
> Thanks for the respin! Sorry for the delay took me a while to get set
> up with latest gcc.

No worries, and then I disappeared for a PTO.


> Two things below, but in summary there are a few
> things we need to line things up between clang and gcc representations
> I think. To test these completely there are some existing btf_loader/pfunct
> issues below that I've outlined; I can send patches for those fixes as
> prerequisites, or feel free to roll into a respin, whatever you'd prefer.

I don't mind the respin but will appreciate you sending the actual 
patches as you have much more context on this than me and will have 
easier time fielding any review requests.
Also after reading the rest of email, these could even be follow ups to 
this series in spirit of incremental improvements (and the reason is not 
that I want to get the series out of the way ;-) but that these seem to 
be existing issues so might as well wait for something else to land - 
but your call really).

> I don't want to introduce scope creep - and I may be missing something -
> but it seems like the current changes don't cover decl tags for function
> parameters.

OK.

> On this topic, there is an existing bug where decl tags
> that have a component_idx reference are not rendered correctly by pfunct
> which makes testing that properly impossible today. Parameter decl tags are
> prepended to the function declaration rather than tied to the
> parameter referenced by the component_idx, so we should fix that first.

Hmm, it seems worthwhile putting this in a comment somewhere.

> The root cause is btf_loader.c always attaches attributes to the function,
> whereas it should use the component_idx to attach them to the parameter
> tag where component_idx >= 0.
>
> The following changes are needed to fix that I think:
>
> diff --git a/btf_loader.c b/btf_loader.c
> index b591219..9bb52c3 100644
> --- a/btf_loader.c
> +++ b/btf_loader.c
> @@ -477,12 +477,56 @@ static struct attributes *attributes__realloc(struct attributes *attributes, con
>          return result;
>   }
>   
> +static struct tag *ftype__parameter(const struct ftype *ftype, int component_idx)
> +{
> +       struct parameter *pos;
> +       int idx = 0;
> +
> +       ftype__for_each_parameter(ftype, pos) {
> +               if (idx == component_idx)
> +                       return &pos->tag;
> +               ++idx;
> +       }
> +
> +       return NULL;
> +}
> +
> +static struct tag *function__parameter(const struct function *func, struct cu *cu,
> +                                      int component_idx)
> +{
> +       struct tag *tag;
> +
> +       if (component_idx < 0)
> +               return NULL;
> +
> +       tag = cu__type(cu, func->proto.tag.type);
> +       if (tag == NULL)
> +               return NULL;
> +
> +       return ftype__parameter(tag__ftype(tag), component_idx);
> +}
> +
>   static int process_decl_tag(struct cu *cu, const struct btf_type *tp)
>   {
> +       int component_idx = btf_decl_tag(tp)->component_idx;
>          struct tag *tag = cu__type(cu, tp->type);
>          struct attributes *tmp;
>   
> -       if (tag == NULL)
> +       if (component_idx >= 0) {
> +               struct tag *func_tag = cu__function(cu, tp->type);
> +
> +               if (func_tag != NULL) {
> +                       tag = function__parameter(tag__function(func_tag), cu,
> +                                                 component_idx);
> +                       if (tag == NULL) {
> +                               fprintf(stderr, "WARNING: BTF_KIND_DECL_TAG for unknown parameter %d in BTF id %d\n",
> +                                       component_idx, tp->type);
> +                               return 0;
> +                       }
> +               }
> +       }
> +
> +       if (tag == NULL && component_idx < 0)
>                  tag = cu__function(cu, tp->type);
>   
>          if (tag == NULL)
> diff --git a/dwarves_fprintf.c b/dwarves_fprintf.c
> index 757e499..ab1c381 100644
> --- a/dwarves_fprintf.c
> +++ b/dwarves_fprintf.c
> @@ -1203,6 +1203,18 @@ const char *function__prototype(const struct function *func,
>                                          bf, len);
>   }
>   
> +static size_t tag__attributes_fprintf(const struct tag *tag, FILE *fp)
> +{
> +       size_t printed = 0;
> +       int i;
> +
> +       if (tag->attributes)
> +               for (i = 0; i < tag->attributes->cnt; ++i)
> +                       printed += fprintf(fp, "%s ", tag->attributes->values[i]);
> +
> +       return printed;
> +}
> +
>   size_t ftype__fprintf_parms(const struct ftype *ftype,
>                              const struct cu *cu, int indent,
>                              const struct conf_fprintf *conf, FILE *fp)
> @@ -1244,6 +1256,7 @@ size_t ftype__fprintf_parms(const struct ftype *ftype,
>                                  if (n)
>                                          return printed + n;
>                                  if (ptype->tag == DW_TAG_subroutine_type) {
> +                                       printed += tag__attributes_fprintf(&pos->tag, fp);
>                                          printed +=
>                                               ftype__fprintf(tag__ftype(ptype),
>                                                              cu, name, 0, 1, 0,
> @@ -1252,12 +1265,14 @@ size_t ftype__fprintf_parms(const struct ftype *ftype,
>                                  }
>                          }
>                  } else if (type->tag == DW_TAG_subroutine_type) {
> +                       printed += tag__attributes_fprintf(&pos->tag, fp);
>                          printed += ftype__fprintf(tag__ftype(type), cu, name,
>                                                    true, 0, 0, 0, conf, fp);
>                          continue;
>                  }
>                  stype = tag__name(type, cu, sbf, sizeof(sbf), conf);
>   print_it:
> +               printed += tag__attributes_fprintf(&pos->tag, fp);
>                  printed += fprintf(fp, "%s%s%s", stype, name ? " " : "",
>                                     name ?: "");
>          }
> @@ -1409,11 +1424,8 @@ static size_t function__fprintf(const struct tag *tag, const struct cu *cu,
>          struct ftype *ftype = func->btf ? tag__ftype(cu__type(cu, func->proto.tag.type)) : &func->proto;
>          size_t printed = 0;
>          bool inlined = !conf->strip_inline && function__declared_inline(func);
> -       int i;
>   
> -       if (tag->attributes)
> -               for (i = 0; i < tag->attributes->cnt; ++i)
> -                       printed += fprintf(fp, "%s ", tag->attributes->values[i]);
> +       printed += tag__attributes_fprintf(tag, fp);
>   
>          if (func->virtuality == DW_VIRTUALITY_virtual ||
>              func->virtuality == DW_VIRTUALITY_pure_virtual)
>
>   
> Now with that fix in place, we can add a decl tag parameter case to the pfunct test:
>
> diff --git a/tests/pfunct-btf-decl-tags.sh b/tests/pfunct-btf-decl-tags.sh
> index a46aa1f..520148b 100755
> --- a/tests/pfunct-btf-decl-tags.sh
> +++ b/tests/pfunct-btf-decl-tags.sh
> @@ -41,6 +41,7 @@ src=$(cat <<EOF
>   __tag(a) __tag(b) __tag(c) void foo(void) {}
>   __tag(a) __tag(b)          void bar(void) {}
>   __tag(a)                   void buz(void) {}
> +void qux(int __tag(param_a) arg) {}
>   
>   EOF
>   )
> @@ -48,13 +49,17 @@ EOF
>   # tags order is not guaranteed
>   sort_tags=$(cat <<EOF
>   {
> -match(\$0,/^(.*) (void .*)/,tags_and_proto);
> -tags  = tags_and_proto[1];
> -proto = tags_and_proto[2];
> -split(tags, tags_arr ,/ /);
> -asort(tags_arr);
> -for (t in tags_arr) printf "%s ", tags_arr[t];
> -print proto;
> +delete tags_arr;
> +if (match(\$0,/^(.*) (void .*)/,tags_and_proto)) {
> +       tags  = tags_and_proto[1];
> +       proto = tags_and_proto[2];
> +       split(tags, tags_arr ,/ /);
> +       asort(tags_arr);
> +       for (t in tags_arr) printf "%s ", tags_arr[t];
> +       print proto;
> +} else {
> +       print \$0;
> +}
>   }
>   EOF
>   )
> @@ -63,6 +68,7 @@ expected=$(cat <<EOF
>   a b c void foo(void);
>   a b void bar(void);
>   a void buz(void);
> +void qux(param_a int arg);
>   EOF
>   )
>   
> @@ -98,7 +104,8 @@ fi
>   
>   if [ "$use_clang" -eq 1 ]; then
>          tmpobj=$(make_tmpobj)
> -       echo "$src" | $CLANG --target=bpf -c -g -x c -o $tmpobj -
> +       echo "$src" | $CLANG -c -g -x c -o $tmpobj -
> +       pahole -J $tmpobj 2>/dev/null
>          run_test "$CLANG" "$tmpobj" || failed=1
>   fi
>   
> Running this we see:
>
>   ./pfunct-btf-decl-tags.sh
> Check that pfunct can print btf_decl_tags read from BTF.
>     Testing with gcc (version 17)
>     pfunct output does not match expected (gcc (version 17)):
>     --- /dev/fd/63 2026-06-07 10:42:19.711753983 +0100 +++ /dev/fd/62 2026-06-07 10:42:19.711753983 +0100 @@ -1,4 +1,4 @@ a b c void foo(void); a b void bar(void); a void buz(void); -void qux(param_a int arg); +void qux(int arg);
>     
>     Complete output:
>     a b c void foo(void); a b void bar(void); a void buz(void); void qux(int arg);
>     Testing with clang
>     passed
> Test ./pfunct-btf-decl-tags.sh failed
> Test data is in /tmp/pfunct-btf-decl-tags.sh.hXPG6r
>
> The following change to dwarf_loader.c fixes this:
>
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index c492b56..7f5b44d 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -1910,6 +1910,8 @@ static struct tag *die__create_new_parameter(Dwarf_Die *die,
>                  if (param_idx >= 0) {
>                          if (add_child_llvm_annotations(die, param_idx, conf, &(tag__function(&ftype->tag)->annots)))
>                                  return NULL;
> +                       if (add_gnu_annotation_chain(die, param_idx, conf, &(tag__function(&ftype->tag)->annots)))
> +                               return NULL;
>                  }
>          } else {
>                  /*

If you agree, I'd prefer you send this as an independent pre/post fix.

[snipped]

>> +check_gnu_attr:
>> +	if (tag != NULL)
>> +		goto out;
>> +
>> +	/* Handle GCC-style DW_AT_GNU_annotation attribute */
>> +	while (dwarf_attr(die, DW_AT_GNU_annotation, &attr) != NULL &&
>> +	       dwarf_formref_die(&attr, &annot_die) != NULL &&
>> +	       dwarf_tag(&annot_die) == DW_TAG_GNU_annotation) {
>> +		name = attr_string(&annot_die, DW_AT_name, conf);
>> +		if (strcmp(name, "btf_type_tag") != 0)
>> +			break;
>> +
>> +		tag = die__add_btf_type_tag(tag, die, &annot_die, cu, conf);
>
> I think there may be an issue here. die__add_btf_type_tag() will prepend
> discovered tags to give us the BTF representation we want.

Great catch. I would never have figured this out on my own.

> However a
> proof-of-concept test shows that gcc tested with latest master branch
> as of
>
> commit 0e634b961123280c17c1c651b1d8b1567b9b523c (HEAD -> master, origin/trunk, origin/master, origin/HEAD)
> Author: Marc Poulhiès <poulhies@adacore.com>
> Date:   Fri Mar 27 16:29:16 2026 +0100
>
>      ada: Fix bug when reading multibyte utf-8 character
>      
>
> ...shows that the DWARF representation already has the BTF-desired
> order, so we wind up reversing it. Test below, but I _think_ something
> like this may be needed:
>
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index 14f71c9..c492b56 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -1633,7 +1633,8 @@ static struct btf_type_tag_type *die__create_new_btf_type_tag_type(Dwarf_Die *di
>   
>   static struct btf_type_tag_ptr_type *die__add_btf_type_tag(struct btf_type_tag_ptr_type *tag,
>                                                              Dwarf_Die *die, Dwarf_Die *adie,
> -                                                           struct cu *cu, struct conf_load *conf)
> +                                                           struct cu *cu, struct conf_load *conf,
> +                                                           bool prepend)
>   {
>          struct btf_type_tag_type *annot;
>          uint32_t id;
> @@ -1656,10 +1657,38 @@ static struct btf_type_tag_ptr_type *die__add_btf_type_tag(struct btf_type_tag_p
>          cu__hash(cu, &annot->tag);
>   
>          /*
> -        * Prepends: for annotations tag1 -> tag2 -> tag3,
> -        * the tag->tags list ends up as tag3 -> tag2 -> tag1.
> +        * Consider the following set of type tags:
> +        *
> +        * #define __tag(x) __attribute__((btf_type_tag(#x)))

Bike shed, I'll just name it __type_tag.

> +        *
> +        * struct sample {
> +        *      int value;
> +        * };
> +        *
> +        * struct sample __tag(outer) __tag(inner) *global_ptr;
> +        *
> +        * The BTF chain should describe the pointer as:
> +        *
> +        * PTR -> TYPE_TAG "inner" -> TYPE_TAG "outer" -> STRUCT "sample"
> +        *
> +        * The tag nearest *global_ptr applies to the pointer’s immediate pointee
> +        * type first. So inner wraps outer struct sample.
> +        *
> +        * For clang DWARF, child annotation DIEs are seen as "outer, inner"
> +        * so to get the right final order we need to prepend.
> +        *
> +        * For GCC DWARF, the explicit DW_AT_GNU_annotation chain starts at the outermost
> +        * BTF wrapper:
> +        *
> +        * pointer DIE -> inner annotation -> outer annotation -> struct sample
> +        *
> +        * so in this case we preserve that traversal order and append.
>           */
> -       list_add(&annot->node, &tag->tags);
> +       if (prepend)
> +               list_add(&annot->node, &tag->tags);
> +       else
> +               list_add_tail(&annot->node, &tag->tags);
> +
>          return tag;
>   }
>   
> @@ -1690,7 +1719,7 @@ static struct tag *die__create_new_pointer_tag(Dwarf_Die *die, struct cu *cu,
>                  if (strcmp(name, "btf_type_tag") != 0)
>                          continue;
>   
> -               tag = die__add_btf_type_tag(tag, die, cdie, cu, conf);
> +               tag = die__add_btf_type_tag(tag, die, cdie, cu, conf, true);
>                  if (tag == NULL)
>                          return NULL;
>          } while (dwarf_siblingof(cdie, cdie) == 0);
> @@ -1707,7 +1736,7 @@ check_gnu_attr:
>                  if (strcmp(name, "btf_type_tag") != 0)
>                          break;
>   
> -               tag = die__add_btf_type_tag(tag, die, &annot_die, cu, conf);
> +               tag = die__add_btf_type_tag(tag, die, &annot_die, cu, conf, false);
>                  if (tag == NULL)
> :
>
>
> Here's a test (feel free to adapt it if needed) that fails until the above is applied:
>
> #!/bin/bash
> # SPDX-License-Identifier: GPL-2.0-only
>
> # Check that pahole preserves btf_type_tag order when emitting BTF from DWARF.
>
> source test_lib.sh
>
> outdir=$(make_tmpdir)
>
> # Comment this out to save test data.
> trap cleanup EXIT
>
> title_log "Check BTF type tag order."
>
> GCC=${GCC:-gcc}
> CLANG=${CLANG:-clang}
> PAHOLE=${PAHOLE:-pahole}
> BPFTOOL=${BPFTOOL:-bpftool}
>
> if ! command -v "$BPFTOOL" > /dev/null; then
> 	info_log "skip: bpftool not available"
> 	test_skip
> fi
>
> compiler_has_btf_type_tag()
> {
> 	local compiler=$1
>
> 	if ! command -v "$compiler" > /dev/null; then
> 		return 1
> 	fi
>
> 	"$compiler" -x c -E -P - <<'EOF' 2>/dev/null | grep -qx 1
> #ifndef __has_attribute
> #define __has_attribute(x) 0
> #endif
> #if __has_attribute(btf_type_tag)
> 1
> #else
> 0
> #endif
> EOF
> }
>
> use_gcc=0
> if compiler_has_btf_type_tag "$GCC"; then
> 	use_gcc=1
> fi
>
> use_clang=0
> if compiler_has_btf_type_tag "$CLANG"; then
> 	use_clang=1
> fi
>
> if [ "$use_gcc" -eq 0 ] && [ "$use_clang" -eq 0 ]; then
> 	error_log "Need gcc or clang with btf_type_tag support for test $0"
> 	test_fail
> fi
>
> src=$(cat <<EOF
> #define __tag(x) __attribute__((btf_type_tag(#x)))
>
> struct sample {
> 	int value;
> };
>
> struct sample __tag(outer) __tag(inner) *global_ptr;
>
> EOF
> )
>
> check_type_tag_order()
> {
> 	local btf=$1
> 	local dump
>
> 	if ! dump=$("$BPFTOOL" btf dump file "$btf"); then
> 		return 1
> 	fi
>
> 	printf '%s\n' "$dump" | awk '
> 	function parse_id(line, m) {
> 		if (match(line, /^\[([0-9]+)\]/, m))
> 			return m[1]
> 		return 0
> 	}
> 	function parse_name(line, m) {
> 		if (match(line, /\047([^\047]*)\047/, m))
> 			return m[1]
> 		return ""
> 	}
> 	function parse_type(line, m) {
> 		if (match(line, /type_id=([0-9]+)/, m))
> 			return m[1]
> 		return 0
> 	}
> 	function check_ptr(ptr, id, tags, seen) {
> 		id = type[ptr]
> 		while (id != 0 && !seen[id]) {
> 			seen[id] = 1
> 			if (kind[id] == "TYPE_TAG") {
> 				tags = tags (tags == "" ? "" : " -> ") name[id]
> 				id = type[id]
> 				continue
> 			}
> 			if (kind[id] == "STRUCT" && name[id] == "sample") {
> 				if (tags == "inner -> outer")
> 					exit 0
> 				candidates = candidates (candidates == "" ? "" : ", ") tags
> 			}
> 			return
> 		}
> 	}
> 	/^\[[0-9]+\]/ {
> 		id = parse_id($0)
> 		kind[id] = $2
> 		name[id] = parse_name($0)
> 		type[id] = parse_type($0)
> 		if (kind[id] == "PTR")
> 			ptrs[++nr_ptrs] = id
> 	}
> 	END {
> 		for (i = 1; i <= nr_ptrs; i++)
> 			check_ptr(ptrs[i])
> 		if (candidates != "") {
> 			print "type tag order mismatch; expected inner -> outer, found " candidates > "/dev/stderr"
> 			exit 1
> 		}
> 		print "could not find tagged pointer to struct sample" > "/dev/stderr"
> 		exit 1
> 	}'
> }
>
> run_test()
> {
> 	local compiler=$1
> 	local tmpobj=$2
> 	local btf=$3
>
> 	info_log "Testing with $compiler"
>
> 	if ! echo "$src" | "$compiler" -g -c -x c -o "$tmpobj" - 2>/dev/null; then
> 		error_log "Could not compile type tag order test with $compiler"
> 		return 1
> 	fi
>
> 	if ! "$PAHOLE" --btf_features=+type_tag --btf_encode_detached="$btf" "$tmpobj" 2>/dev/null; then
> 		error_log "Could not encode BTF for $tmpobj"
> 		return 1
> 	fi
>
> 	if check_type_tag_order "$btf"; then
> 		info_log "  passed"
> 		return 0
> 	fi
>
> 	error_log "BTF type tag order does not match expected order ($compiler)"
> 	return 1
> }
>
> failed=0
>
> if [ "$use_gcc" -eq 1 ]; then
> 	tmpobj=$(make_tmpobj)
> 	btf=${tmpobj%.o}.btf
> 	run_test "$GCC" "$tmpobj" "$btf" || failed=1
> fi
>
> if [ "$use_clang" -eq 1 ]; then
> 	tmpobj=$(make_tmpobj)
> 	btf=${tmpobj%.o}.btf
> 	run_test "$CLANG" "$tmpobj" "$btf" || failed=1
> fi
>
> if [ "$failed" -eq 0 ]; then
> 	test_pass
> else
> 	test_fail
> fi

This is definitely directly related to the series and I'm happy to fold 
this in - any preference if this wants to be a separate patch or just 
fold into into the main change.

Thx,
-Vineet
