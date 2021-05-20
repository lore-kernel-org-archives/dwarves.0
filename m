Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37478C433B4
	for <linux-dwarves@archiver.kernel.org>; Thu, 20 May 2021 11:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1335D60241
	for <linux-dwarves@archiver.kernel.org>; Thu, 20 May 2021 11:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241784AbhETLw5 (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 20 May 2021 07:52:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21038 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243721AbhETLu4 (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Thu, 20 May 2021 07:50:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621511373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bxTW4tmLiZW3BuOPHSGbcpXxycxA8e41CGqvoaRgfzk=;
        b=HSZ3VVct4sKT4gfo+E4J1+wm3hvqhDDO24+c8obyxzEh88dV+XP32MbnE0rmGdbgVXj8MY
        axEtLFCIwcJZJJrnhrfQSB9k2RWWNyUArv+iBDPjnoVcaQbcsL62ZCRsPtmt767RvPKMxj
        pwgvgtZHY0NApH7auNIo1/ktIcgR/7U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-i2FcP0NfMmWfRYFDSJSowg-1; Thu, 20 May 2021 07:49:26 -0400
X-MC-Unique: i2FcP0NfMmWfRYFDSJSowg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 03E978015F8;
        Thu, 20 May 2021 11:49:25 +0000 (UTC)
Received: from krava (unknown [10.40.194.160])
        by smtp.corp.redhat.com (Postfix) with SMTP id A0D825C5AE;
        Thu, 20 May 2021 11:49:23 +0000 (UTC)
Date:   Thu, 20 May 2021 13:49:22 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Shuyi Cheng <chengshuyi@linux.alibaba.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org, wenan.mao@linux.alibaba.com,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH v2] pahole: Add --kabi_prefix flag
Message-ID: <YKZMwmFVcYTTvEDW@krava>
References: <a249699a-7c6c-4d4a-71b0-87981c8d229e@linux.alibaba.com>
 <YKKA64WWqYN3P7YJ@kernel.org>
 <c3520803-77af-cc34-000a-de4ba6334bcb@linux.alibaba.com>
 <YKO34fq6P8G9IyMD@kernel.org>
 <CAEf4Bzazh4RNCY3rGRRXfO2wJ7DSiMx8w+61B_hjhu9FrOffpQ@mail.gmail.com>
 <ec80d351-ac2f-5c48-c339-c2c503d36d68@linux.alibaba.com>
 <YKVv57HsgJYmCTFi@krava>
 <30cc773d-779f-9440-2f79-1fd642287cc4@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30cc773d-779f-9440-2f79-1fd642287cc4@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Thu, May 20, 2021 at 06:27:48PM +0800, Shuyi Cheng wrote:
> 
> 
> On 5/20/21 4:07 AM, Jiri Olsa wrote:
> > On Wed, May 19, 2021 at 10:44:44AM +0800, Shuyi Cheng wrote:
> > > To solve problems similar to _RH_KABI_REPLACE. The _RH_KABI_REPLACE(_orig,
> > > _new) macros perserve size alignment and kabi agreement between _orig and
> > > _new.Below is the definition of this macro:
> > > 
> > > # define _RH_KABI_REPLACE(_orig, _new)            \
> > >      union {                        \
> > >          _new;                    \
> > >          struct {                \
> > >              _orig;                \
> > >          } __UNIQUE_ID(rh_kabi_hide);        \
> > >          __RH_KABI_CHECK_SIZE_ALIGN(_orig, _new);    \
> > >      }
> > 
> > hi,
> > that macro sounds familiar ;-) I think this should be already
> > solved directly in the header file by this one:
> > 
> >    https://gitlab.com/cki-project/kernel-ark/-/commit/331be9c5a436057ee852075c102d9d90a9046a30
> > 
> > jirka
> > 
> 
> Well, this patch solves this problem very well from the kernel level. But
> there are many mirrors [here](http://debuginfo.centos.org/7/x86_64/) that
> still have this problem. And these mirrors support ebpf, so it is very
> important to effectively extract the btf segment from these mirrors. :-)

hum, the link shows 3.10.* centos kernel, right?
AFAIK there's no BTF support in those kernels..

but maybe I'm missing some backporting channel,
could you please point me to related sources?

jirka

> 
> > > 
> > > 
> > > __UNIQUE_ID uses the __COUNTER__ macro, and the __COUNTER__ macro is
> > > automatically incremented by 1 every time it is precompiled. Therefore, in
> > > different compilation units, the same structure has different names.Here is
> > > a concrete example:
> > > 
> > > struct acpi_dev_node {
> > >      union {
> > >          struct acpi_device *companion;
> > >          struct {
> > >              void *handle;
> > >          } __UNIQUE_ID_rh_kabi_hide29;
> > >          union {        };
> > >      };
> > > };
> > > struct acpi_dev_node {
> > >      union {
> > >          struct acpi_device *companion;
> > >          struct {
> > >              void *handle;
> > >          } __UNIQUE_ID_rh_kabi_hide31;
> > >          union {        };
> > >      };
> > > };
> > > 
> > > Finally, it will cause the btf algorithm to de-duplication efficiency is not
> > > high, and time-consuming. For example, running ./pahole -J
> > > vmlinux-3.10.0-1160.el7.x86_64 without --kabi_prefix flag, the running time
> > > is:
> > >                  real 8m28.912s
> > >                  user 8m27.271s
> > >                  sys 0m1.471s
> > > And the size of the generated btf segment is 30678240 bytes.
> > > 
> > > After adding the patch, running ./pahole
> > > --kabi_prefix=__UNIQUE_ID_rh_kabi_hide -J vmlinux-3.10.0-1160.el7.x86_64.
> > > The running time of the command is:
> > >                  real 0m19.634s
> > >                  user 0m18.457s
> > >                  sys 0m1.169s
> > > And the size of the generated btf segment is 3117719 bytes.
> > > 
> > > ---
> > > 
> > > v1:https://lore.kernel.org/dwarves/CAEf4Bzazh4RNCY3rGRRXfO2wJ7DSiMx8w+61B_hjhu9FrOffpQ@mail.gmail.com
> > > v1->v2:
> > > --Change btf_prefix to --kabi_prefix.
> > > --Add man page.
> > > --Add space after if and comma.
> > > 
> > >   man-pages/pahole.1 |  4 ++++
> > >   pahole.c           | 10 ++++++++++
> > >   pahole_strings.h   |  2 ++
> > >   strings.c          |  9 ++++++++-
> > >   4 files changed, 24 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
> > > index a10738f..2659fe6 100644
> > > --- a/man-pages/pahole.1
> > > +++ b/man-pages/pahole.1
> > > @@ -340,6 +340,10 @@ Show a traditional string version, i.e.: "v1.18".
> > >   Show a numeric only version, suitable for use in Makefiles and scripts
> > > where
> > >   one wants to know what if the installed version has some feature, i.e.: 118
> > > instead of "v1.18".
> > > 
> > > +.TP
> > > +.B \-\-kabi_prefix=STRING
> > > +When the prefix of the string is STRING, treat the string as STRING.
> > > +
> > >   .SH NOTES
> > > 
> > >   To enable the generation of debugging information in the Linux kernel build
> > > diff --git a/pahole.c b/pahole.c
> > > index dc40ccf..6a700d9 100644
> > > --- a/pahole.c
> > > +++ b/pahole.c
> > > @@ -24,6 +24,7 @@
> > >   #include "btf_encoder.h"
> > >   #include "libbtf.h"
> > >   #include "lib/bpf/src/libbpf.h"
> > > +#include "pahole_strings.h"
> > > 
> > >   static bool btf_encode;
> > >   static bool ctf_encode;
> > > @@ -855,6 +856,7 @@ ARGP_PROGRAM_VERSION_HOOK_DEF = dwarves_print_version;
> > >   #define ARGP_btf_gen_floats	   322
> > >   #define ARGP_btf_gen_all	   323
> > >   #define ARGP_with_flexible_array   324
> > > +#define ARGP_kabi_prefix   325
> > > 
> > >   static const struct argp_option pahole__options[] = {
> > >   	{
> > > @@ -1140,6 +1142,12 @@ static const struct argp_option pahole__options[] = {
> > >   		.doc  = "Path to the base BTF file",
> > >   	},
> > >   	{
> > > +		.name = "kabi_prefix",
> > > +		.key = ARGP_kabi_prefix,
> > > +		.arg = "STRING",
> > > +		.doc = "When the prefix of the string is STRING, treat the string as
> > > STRING.",
> > > +	},
> > > +	{
> > >   		.name = "btf_encode",
> > >   		.key  = 'J',
> > >   		.doc  = "Encode as BTF",
> > > @@ -1297,6 +1305,8 @@ static error_t pahole__options_parser(int key, char
> > > *arg,
> > >   		btf_encode_force = true;		break;
> > >   	case ARGP_btf_base:
> > >   		base_btf_file = arg;			break;
> > > +	case ARGP_kabi_prefix:
> > > +		kabi_prefix = arg;		break;
> > >   	case ARGP_numeric_version:
> > >   		print_numeric_version = true;		break;
> > >   	case ARGP_btf_gen_floats:
> > > diff --git a/pahole_strings.h b/pahole_strings.h
> > > index 522fbf2..a836ba8 100644
> > > --- a/pahole_strings.h
> > > +++ b/pahole_strings.h
> > > @@ -14,6 +14,8 @@ struct strings {
> > >   	struct btf *btf;
> > >   };
> > > 
> > > +extern const char *kabi_prefix;
> > > +
> > >   struct strings *strings__new(void);
> > > 
> > >   void strings__delete(struct strings *strings);
> > > diff --git a/strings.c b/strings.c
> > > index d37f49d..d1a54ec 100644
> > > --- a/strings.c
> > > +++ b/strings.c
> > > @@ -17,6 +17,8 @@
> > >   #include "dutil.h"
> > >   #include "lib/bpf/src/libbpf.h"
> > > 
> > > +const char *kabi_prefix;
> > > +
> > >   struct strings *strings__new(void)
> > >   {
> > >   	struct strings *strs = malloc(sizeof(*strs));
> > > @@ -48,7 +50,12 @@ strings_t strings__add(struct strings *strs, const char
> > > *str)
> > >   	if (str == NULL)
> > >   		return 0;
> > > 
> > > -	index = btf__add_str(strs->btf, str);
> > > +	if (kabi_prefix &&
> > > +		strncmp(str, kabi_prefix, strlen(kabi_prefix)) == 0)
> > > +		index = btf__add_str(strs->btf, kabi_prefix);
> > > +	else
> > > +		index = btf__add_str(strs->btf, str);
> > > +		
> > >   	if (index < 0)
> > >   		return 0;
> > > 
> > > -- 
> > > 1.8.3.1
> > > 
> 

