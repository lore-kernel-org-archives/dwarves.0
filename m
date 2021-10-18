Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38CEC433FE
	for <linux-dwarves@archiver.kernel.org>; Mon, 18 Oct 2021 10:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8636C6101B
	for <linux-dwarves@archiver.kernel.org>; Mon, 18 Oct 2021 10:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbhJRKgp (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Mon, 18 Oct 2021 06:36:45 -0400
Received: from foss.arm.com ([217.140.110.172]:35214 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230037AbhJRKgp (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Mon, 18 Oct 2021 06:36:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 30099ED1;
        Mon, 18 Oct 2021 03:34:34 -0700 (PDT)
Received: from [10.57.54.178] (unknown [10.57.54.178])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5970A3F70D;
        Mon, 18 Oct 2021 03:34:33 -0700 (PDT)
From:   Douglas Raillard <douglas.raillard@arm.com>
Subject: Re: [PATCH 1/2] fprintf: Fix nested struct printing
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     acme@redhat.com, dwarves@vger.kernel.org
References: <20211014114850.310575-1-douglas.raillard@arm.com>
 <YWl9SQG9qwm3Sz6U@kernel.org>
Message-ID: <03468910-80f8-e740-8008-2a8a08a11d20@arm.com>
Date:   Mon, 18 Oct 2021 11:34:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YWl9SQG9qwm3Sz6U@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On 10/15/21 2:08 PM, Arnaldo Carvalho de Melo wrote:
> Em Thu, Oct 14, 2021 at 12:48:49PM +0100, Douglas RAILLARD escreveu:
>> From: Douglas Raillard <douglas.raillard@arm.com>
>>
>> This code:
>>
>>      struct X {
>>         struct {
>>         } __attribute__((foo)) x __attribute__((bar));
>>      }
>>
>> Was wrongly printed as:
>>
>>      struct X {
>>         struct {
>>         } x __attribute__((foo)) __attribute__((bar));
>>      }
>>
>> This unfortunately matters a lot, since "bar" is suppose to apply to
>> "x", but "foo" to typeof(x). In the wrong form, both apply to "x",
>> leading to e.g. incorrect layout for __aligned__ attribute.
> 
> I couldn't quickly find a change in behaviour with a random vmlinux I
> have for testing:
> 
> ⬢[acme@toolbox pahole]$ build/pahole.old -F dwarf vmlinux > before
> ⬢[acme@toolbox pahole]$ build/pahole -F dwarf vmlinux > after
> ⬢[acme@toolbox pahole]$ diff -u before after
> ⬢[acme@toolbox pahole]$ grep "__attribute__.*__attribute__" before  | wc -l
> 40

That's strange, I get plenty of diff such as this one from struct cfs_rq:

-       } removed __attribute__((__aligned__(64))) __attribute__((__aligned__(64)));      /*   192   128 */
+       } __attribute__((__aligned__(64))) removed __attribute__((__aligned__(64)));      /*   192   128 */


> ⬢[acme@toolbox pahole]$
> 
> btdiff is happy tho:

Same on my side

> 
> ⬢[acme@toolbox pahole]$ btfdiff vmlinux
> ⬢[acme@toolbox pahole]$ cat btfdiff
> #!/bin/bash
> # SPDX-License-Identifier: GPL-2.0-only
> # Copyright © 2019 Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
> # Use pahole to produce output from BTF and from DWARF, then do a diff
> # Use --flat_arrays with DWARF as BTF, like CTF, flattens arrays.
> # Use --show_private_classes as BTF shows all structs, while pahole knows
> # if some struct is defined only inside another struct/class or in a function,
> # this information is not available when loading from BTF.
> 
> if [ $# -eq 0 ] ; then
> 	echo "Usage: btfdiff <filename_with_DWARF_and_maybe_BTF_info> [<filename_with_BTF_info>]"
> 	exit 1
> fi
> 
> dwarf_input=$1
> btf_input=$dwarf_input
> 
> if [ $# -eq 2 ] ; then
> 	btf_input=$2
> fi
> 
> btf_output=$(mktemp /tmp/btfdiff.btf.XXXXXX)
> dwarf_output=$(mktemp /tmp/btfdiff.dwarf.XXXXXX)
> pahole_bin=${PAHOLE-"pahole"}
> 
> ${pahole_bin} -F dwarf \
> 	      --flat_arrays \
> 	      --sort \
> 	      --jobs \
> 	      --suppress_aligned_attribute \
> 	      --suppress_force_paddings \
> 	      --suppress_packed \
> 	      --show_private_classes $dwarf_input > $dwarf_output
> ${pahole_bin} -F btf \
> 	      --sort \
> 	      --suppress_packed \
> 	      $btf_input > $btf_output
> 
> diff -up $dwarf_output $btf_output
> 
> rm -f $btf_output $dwarf_output
> exit 0
> ⬢[acme@toolbox pahole]$
> 
> As is fullcircle:

I tried fullcircle on the whole vmlinux and got a bunch of:
readelf: Error: LEB value too large
but beyond that it seems happy.

> ⬢[acme@toolbox pahole]$ fullcircle tcp.o
> ⬢[acme@toolbox pahole]$ cat fullcircle
> #!/bin/bash
> # SPDX-License-Identifier: GPL-2.0-only
> # Copyright © 2019 Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
> # Use pfunct to produce compilable output from a object, then do a codiff -s
> # To see if the type information generated from source code generated
> # from type information in a file compiled from the original source code matches.
> 
> if [ $# -eq 0 ] ; then
> 	echo "Usage: fullcircle <filename_with_type_info>"
> 	exit 1
> fi
> 
> file=$1
> 
> nr_cus=$(readelf -wi ${file} | grep DW_TAG_compile_unit | wc -l)
> if [ $nr_cus -gt 1 ]; then
> 	exit 0
> fi
> 
> c_output=$(mktemp /tmp/fullcircle.XXXXXX.c)
> o_output=$(mktemp /tmp/fullcircle.XXXXXX.o)
> pfunct_bin=${PFUNCT-"pfunct"}
> codiff_bin=${CODIFF-"codiff"}
> 
> # See how your DW_AT_producer looks like and find the
> # right regexp to get after the GCC version string, this one
> # seems good enough for Red Hat/Fedora/CentOS that look like:
> #
> #   DW_AT_producer    : (indirect string, offset: 0x3583): GNU C89 8.2.1 20181215 (Red Hat 8.2.1-6) -mno-sse -mno-mmx
> #
> # So we need from -mno-sse onwards
> 
> CFLAGS=$(readelf -wi $file | grep -w DW_AT_producer | sed -r      's/.*\)( -[[:alnum:]]+.*)+/\1/g')
> 
> # Check if we managed to do the sed or if this is something like GNU AS
> [ "${CFLAGS/DW_AT_producer/}" != "${CFLAGS}" ] && exit
> 
> ${pfunct_bin} --compile $file > $c_output
> gcc $CFLAGS -c -g $c_output -o $o_output
> ${codiff_bin} -q -s $file $o_output
> 
> rm -f $c_output $o_output
> exit 0
> ⬢[acme@toolbox pahole]$
> 
> - Arnaldo
>   
>> Signed-off-by: Douglas Raillard <douglas.raillard@arm.com>
>> ---
>>   dwarves_fprintf.c | 22 ++++++++++++++++++----
>>   1 file changed, 18 insertions(+), 4 deletions(-)
>>
>> diff --git a/dwarves_fprintf.c b/dwarves_fprintf.c
>> index c35868a..1c1d949 100644
>> --- a/dwarves_fprintf.c
>> +++ b/dwarves_fprintf.c
>> @@ -787,7 +787,7 @@ print_default:
>>   					   (type->tag == DW_TAG_class_type &&
>>   					    !tconf.classes_as_structs) ? "class" : "struct",
>>   					   tconf.type_spacing - 7,
>> -					   type__name(ctype), name);
>> +					   type__name(ctype), name ?: "");
>>   		} else {
>>   			struct class *cclass = tag__class(type);
>>   
>> @@ -802,7 +802,7 @@ print_default:
>>   		ctype = tag__type(type);
>>   
>>   		if (type__name(ctype) != NULL && !expand_types) {
>> -			printed += fprintf(fp, "union %-*s %s", tconf.type_spacing - 6, type__name(ctype), name);
>> +			printed += fprintf(fp, "union %-*s %s", tconf.type_spacing - 6, type__name(ctype), name ?: "");
>>   		} else {
>>   			tconf.type_spacing -= 8;
>>   			printed += union__fprintf(ctype, cu, &tconf, fp);
>> @@ -812,7 +812,7 @@ print_default:
>>   		ctype = tag__type(type);
>>   
>>   		if (type__name(ctype) != NULL)
>> -			printed += fprintf(fp, "enum %-*s %s", tconf.type_spacing - 5, type__name(ctype), name);
>> +			printed += fprintf(fp, "enum %-*s %s", tconf.type_spacing - 5, type__name(ctype), name ?: "");
>>   		else
>>   			printed += enumeration__fprintf(type, &tconf, fp);
>>   		break;
>> @@ -863,7 +863,21 @@ static size_t class_member__fprintf(struct class_member *member, bool union_memb
>>   	if (member->is_static)
>>   		printed += fprintf(fp, "static ");
>>   
>> -	printed += type__fprintf(type, cu, name, &sconf, fp);
>> +	/* For struct-like constructs, the name of the member cannot be
>> +	 * conflated with the name of its type, otherwise __attribute__ are
>> +	 * printed in the wrong order.
>> +	 */
>> +	if (tag__is_union(type) || tag__is_struct(type) ||
>> +	    tag__is_enumeration(type)) {
>> +		printed += type__fprintf(type, cu, NULL, &sconf, fp);
>> +		if (name) {
>> +			if (!type__name(tag__type(type)))
>> +				printed += fprintf(fp, " ");
>> +			printed += fprintf(fp, "%s", name);
>> +		}
>> +	} else {
>> +		printed += type__fprintf(type, cu, name, &sconf, fp);
>> +	}
>>   
>>   	if (member->is_static) {
>>   		if (member->const_value != 0)
>> -- 
>> 2.25.1
> 

