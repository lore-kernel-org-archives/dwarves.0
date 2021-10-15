Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDC3C433F5
	for <linux-dwarves@archiver.kernel.org>; Fri, 15 Oct 2021 13:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 285986108E
	for <linux-dwarves@archiver.kernel.org>; Fri, 15 Oct 2021 13:08:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239281AbhJONKf (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Fri, 15 Oct 2021 09:10:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:60242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239264AbhJONKf (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Fri, 15 Oct 2021 09:10:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 36DDF60F9D;
        Fri, 15 Oct 2021 13:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634303308;
        bh=pQqOKCDItQqJSLssrJQNI4uoQvh4kbabKraHW2vd30w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LLP4HOjHv8agSXFUjo8D4+vgUSyEKzNNaCscbSDk34Z2ZXuHFf8WVGkjYQH/XQToF
         sHzu/tmhaNQMIyLS+9DQDs9yg76Vit1PuqCxwDWznP3+XMiFMKRMOFWNOfQ/q8bzs2
         W3PcFbFm7/sioNHN1PkSG86NRNlu7zbwSUV0zC4IxCV/8Ke60jUdgF8KEw0eJoX4BZ
         vwiWoODqGAKhc+C0dOWFYwQkfGmibIAbjvR+Fc0znLc9t+YdcmyT5gIRuC4QvXxGtl
         6aX4q6W4GLaQC0w6ZOBeI9VnnwahcFex2a0edO4pZM14K3s51ZJUOg3UlpUt/mOdbr
         vYrMGbzd+F3aQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 17714410A1; Fri, 15 Oct 2021 10:08:25 -0300 (-03)
Date:   Fri, 15 Oct 2021 10:08:25 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Douglas RAILLARD <douglas.raillard@arm.com>
Cc:     acme@redhat.com, dwarves@vger.kernel.org
Subject: Re: [PATCH 1/2] fprintf: Fix nested struct printing
Message-ID: <YWl9SQG9qwm3Sz6U@kernel.org>
References: <20211014114850.310575-1-douglas.raillard@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211014114850.310575-1-douglas.raillard@arm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Thu, Oct 14, 2021 at 12:48:49PM +0100, Douglas RAILLARD escreveu:
> From: Douglas Raillard <douglas.raillard@arm.com>
> 
> This code:
> 
>     struct X {
>        struct {
>        } __attribute__((foo)) x __attribute__((bar));
>     }
> 
> Was wrongly printed as:
> 
>     struct X {
>        struct {
>        } x __attribute__((foo)) __attribute__((bar));
>     }
> 
> This unfortunately matters a lot, since "bar" is suppose to apply to
> "x", but "foo" to typeof(x). In the wrong form, both apply to "x",
> leading to e.g. incorrect layout for __aligned__ attribute.

I couldn't quickly find a change in behaviour with a random vmlinux I
have for testing:

⬢[acme@toolbox pahole]$ build/pahole.old -F dwarf vmlinux > before
⬢[acme@toolbox pahole]$ build/pahole -F dwarf vmlinux > after
⬢[acme@toolbox pahole]$ diff -u before after
⬢[acme@toolbox pahole]$ grep "__attribute__.*__attribute__" before  | wc -l
40
⬢[acme@toolbox pahole]$

btdiff is happy tho:

⬢[acme@toolbox pahole]$ btfdiff vmlinux
⬢[acme@toolbox pahole]$ cat btfdiff
#!/bin/bash
# SPDX-License-Identifier: GPL-2.0-only
# Copyright © 2019 Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
# Use pahole to produce output from BTF and from DWARF, then do a diff
# Use --flat_arrays with DWARF as BTF, like CTF, flattens arrays.
# Use --show_private_classes as BTF shows all structs, while pahole knows
# if some struct is defined only inside another struct/class or in a function,
# this information is not available when loading from BTF.

if [ $# -eq 0 ] ; then
	echo "Usage: btfdiff <filename_with_DWARF_and_maybe_BTF_info> [<filename_with_BTF_info>]"
	exit 1
fi

dwarf_input=$1
btf_input=$dwarf_input

if [ $# -eq 2 ] ; then
	btf_input=$2
fi

btf_output=$(mktemp /tmp/btfdiff.btf.XXXXXX)
dwarf_output=$(mktemp /tmp/btfdiff.dwarf.XXXXXX)
pahole_bin=${PAHOLE-"pahole"}

${pahole_bin} -F dwarf \
	      --flat_arrays \
	      --sort \
	      --jobs \
	      --suppress_aligned_attribute \
	      --suppress_force_paddings \
	      --suppress_packed \
	      --show_private_classes $dwarf_input > $dwarf_output
${pahole_bin} -F btf \
	      --sort \
	      --suppress_packed \
	      $btf_input > $btf_output

diff -up $dwarf_output $btf_output

rm -f $btf_output $dwarf_output
exit 0
⬢[acme@toolbox pahole]$

As is fullcircle:

⬢[acme@toolbox pahole]$ fullcircle tcp.o
⬢[acme@toolbox pahole]$ cat fullcircle
#!/bin/bash
# SPDX-License-Identifier: GPL-2.0-only
# Copyright © 2019 Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
# Use pfunct to produce compilable output from a object, then do a codiff -s
# To see if the type information generated from source code generated
# from type information in a file compiled from the original source code matches.

if [ $# -eq 0 ] ; then
	echo "Usage: fullcircle <filename_with_type_info>"
	exit 1
fi

file=$1

nr_cus=$(readelf -wi ${file} | grep DW_TAG_compile_unit | wc -l)
if [ $nr_cus -gt 1 ]; then
	exit 0
fi

c_output=$(mktemp /tmp/fullcircle.XXXXXX.c)
o_output=$(mktemp /tmp/fullcircle.XXXXXX.o)
pfunct_bin=${PFUNCT-"pfunct"}
codiff_bin=${CODIFF-"codiff"}

# See how your DW_AT_producer looks like and find the
# right regexp to get after the GCC version string, this one
# seems good enough for Red Hat/Fedora/CentOS that look like:
#
#   DW_AT_producer    : (indirect string, offset: 0x3583): GNU C89 8.2.1 20181215 (Red Hat 8.2.1-6) -mno-sse -mno-mmx
#
# So we need from -mno-sse onwards

CFLAGS=$(readelf -wi $file | grep -w DW_AT_producer | sed -r      's/.*\)( -[[:alnum:]]+.*)+/\1/g')

# Check if we managed to do the sed or if this is something like GNU AS
[ "${CFLAGS/DW_AT_producer/}" != "${CFLAGS}" ] && exit

${pfunct_bin} --compile $file > $c_output
gcc $CFLAGS -c -g $c_output -o $o_output
${codiff_bin} -q -s $file $o_output

rm -f $c_output $o_output
exit 0
⬢[acme@toolbox pahole]$

- Arnaldo
 
> Signed-off-by: Douglas Raillard <douglas.raillard@arm.com>
> ---
>  dwarves_fprintf.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/dwarves_fprintf.c b/dwarves_fprintf.c
> index c35868a..1c1d949 100644
> --- a/dwarves_fprintf.c
> +++ b/dwarves_fprintf.c
> @@ -787,7 +787,7 @@ print_default:
>  					   (type->tag == DW_TAG_class_type &&
>  					    !tconf.classes_as_structs) ? "class" : "struct",
>  					   tconf.type_spacing - 7,
> -					   type__name(ctype), name);
> +					   type__name(ctype), name ?: "");
>  		} else {
>  			struct class *cclass = tag__class(type);
>  
> @@ -802,7 +802,7 @@ print_default:
>  		ctype = tag__type(type);
>  
>  		if (type__name(ctype) != NULL && !expand_types) {
> -			printed += fprintf(fp, "union %-*s %s", tconf.type_spacing - 6, type__name(ctype), name);
> +			printed += fprintf(fp, "union %-*s %s", tconf.type_spacing - 6, type__name(ctype), name ?: "");
>  		} else {
>  			tconf.type_spacing -= 8;
>  			printed += union__fprintf(ctype, cu, &tconf, fp);
> @@ -812,7 +812,7 @@ print_default:
>  		ctype = tag__type(type);
>  
>  		if (type__name(ctype) != NULL)
> -			printed += fprintf(fp, "enum %-*s %s", tconf.type_spacing - 5, type__name(ctype), name);
> +			printed += fprintf(fp, "enum %-*s %s", tconf.type_spacing - 5, type__name(ctype), name ?: "");
>  		else
>  			printed += enumeration__fprintf(type, &tconf, fp);
>  		break;
> @@ -863,7 +863,21 @@ static size_t class_member__fprintf(struct class_member *member, bool union_memb
>  	if (member->is_static)
>  		printed += fprintf(fp, "static ");
>  
> -	printed += type__fprintf(type, cu, name, &sconf, fp);
> +	/* For struct-like constructs, the name of the member cannot be
> +	 * conflated with the name of its type, otherwise __attribute__ are
> +	 * printed in the wrong order.
> +	 */
> +	if (tag__is_union(type) || tag__is_struct(type) ||
> +	    tag__is_enumeration(type)) {
> +		printed += type__fprintf(type, cu, NULL, &sconf, fp);
> +		if (name) {
> +			if (!type__name(tag__type(type)))
> +				printed += fprintf(fp, " ");
> +			printed += fprintf(fp, "%s", name);
> +		}
> +	} else {
> +		printed += type__fprintf(type, cu, name, &sconf, fp);
> +	}
>  
>  	if (member->is_static) {
>  		if (member->const_value != 0)
> -- 
> 2.25.1

-- 

- Arnaldo
