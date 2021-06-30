Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2724CC11F65
	for <linux-dwarves@archiver.kernel.org>; Wed, 30 Jun 2021 12:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2E25613ED
	for <linux-dwarves@archiver.kernel.org>; Wed, 30 Jun 2021 12:27:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234444AbhF3M3b (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Wed, 30 Jun 2021 08:29:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:46090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234426AbhF3M3a (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Wed, 30 Jun 2021 08:29:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5F377613ED;
        Wed, 30 Jun 2021 12:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625056021;
        bh=JehOjbDRk397NL8eThwPKujHkFmNveFtYePcSDwItbA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EaPZJdsfRCUquXOjq3uPG9CsLDG9K0V9s5kASlA3M0Ss/zPiF0aiihwWTrRXyqdVh
         dZ+zVW3kxlOIwZz4Yffy7F8TXDTNnTgIfc76NUabp4x0Xe8ZYbkl5ke75NBQ0jKZPk
         Vmw2Ly3mwDgIWdBW/ebQoBs25A0r5f7TJCpugbSPXL1D5nOtqj7wv5+OoEqnFMuEvb
         t9Vz8KLpjmXlE83tKoW8R+XviRNGBzwOISBKhKgl3vlxCAInhk7bFITROCzilvPr8W
         b7r0jcNdfq+7M4t3pKQ9UOoOXjp+WOqJ0sNHPe2a8zW1vob8LzXvRPQmDq/ppKOpfc
         FN/Xtku8a3c3w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 04C4740B1A; Wed, 30 Jun 2021 09:26:58 -0300 (-03)
Date:   Wed, 30 Jun 2021 09:26:58 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Bernd Buschinski <b.buschinski@googlemail.com>
Cc:     dwarves@vger.kernel.org
Subject: Re: pahole vs isatty
Message-ID: <YNxjEtZHJbaMy7rp@kernel.org>
References: <CACN-hLVoz2tWrtgDLabOv6S1-H_8RD2fh8SV6EnADF1ikMxrmw@mail.gmail.com>
 <YNsUURu/O/fDJLKh@kernel.org>
 <YNtNx08GYT7vuAGJ@kernel.org>
 <CACN-hLXgHWdBkyMz+w58qX8DaV+WJ1mj1qheGBHbPv4fqozi5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACN-hLXgHWdBkyMz+w58qX8DaV+WJ1mj1qheGBHbPv4fqozi5w@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Wed, Jun 30, 2021 at 08:13:56AM +0200, Bernd Buschinski escreveu:
> I tested tmp.master c71cbe9918c40cad2ac8ae982aa8001e7766dd97
> and everything seems to work fine! Thanks! :)

added a "Tested-by: Bernd Buschinski <b.buschinski@googlemail.com>" to
the commit,

Please keep reporting, and if you have suggestions, please voice them
:-)

Thanks!

- Arnaldo
 
> Am Di., 29. Juni 2021 um 18:43 Uhr schrieb Arnaldo Carvalho de Melo
> <acme@kernel.org>:
> >
> > Em Tue, Jun 29, 2021 at 09:38:41AM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Em Tue, Jun 29, 2021 at 10:13:38AM +0200, Bernd Buschinski escreveu:
> > > > It seems the output is now only available if it is a real tty, which
> >
> > > if stdin is a real tty, stdout can be a real tty or be redirected, as
> > > before.
> >
> > > > doesn't work for my scripts.
> >
> > > Sorry about that, I should have added a explicit command line option,
> > > like with 'perf', where '-' means stdin. As this is a relatively new
> > > feature I guess I'll do just that, i.e. stop unconditionally checking
> > > for isatty(0) and only use the pretty printer when --printer is used.
> >
> > > > So, just as a question: Is this change really intentional?
> > > > Is there any easy way to restore the old behavior?
> >
> > > > FYI: my scripts are using perl and python, I do no really favor
> > > > changing them, but if there is no other way.. I will do it :)
> >
> > > Well, you'll at least need to update pahole to 1.22, or, in the
> > > meantime, use a patch, I'm working on it now, thanks for the report!
> >
> > So, while fixing this I ran into bugs, fixed those and at the end I
> > committed the patch at the end of this message.
> >
> > Please try building it from the tmp.master branch and please let me know
> > if your scripts are back working.
> >
> > There is quite a lot of refactorings in this branch, as I'm paving the
> > way for multithreading DWARF loading and BTF encoding, so if you find
> > anything you find suspicious, please, please report here.
> >
> > Thanks,
> >
> > - Arnaldo
> >
> > commit c71cbe9918c40cad2ac8ae982aa8001e7766dd97
> > Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> > Date:   Tue Jun 29 13:22:00 2021 -0300
> >
> >     pahole: Introduce --prettify option
> >
> >     The use of isatty(0) to switch into pretty printing is problematic as
> >     reported by Bernd Buschinski, that ran into problems with his scripts:
> >
> >     ========================================================================
> >       I am using pahole 1.21 and I recently noticed that I no longer have
> >       any pahole output in several scripts.
> >
> >       Using (on the command line):
> >
> >         $ pahole -V -E -C my_struct /path/to/my/debug.o
> >
> >       works fine and gives the expected output.
> >
> >       But:
> >
> >         $ parallel -j 1 pahole -V -E -C my_struct ::: /path/to/my/debug.o
> >
> >       gives nothing, no stderr, no stdout and ret code 0.
> >
> >       After testing some versions, it works fine in 1.17 and no longer works in 1.18.
> >     ========================================================================
> >
> >     Since the pretty printer broke existing scripts, and its a relatively
> >     new feature, lets switch to using a explicit command line option to
> >     activate the pretty printer, i.e. where we used:
> >
> >       $ pahole --header elf64_hdr < /bin/bash
> >
> >     We now use one of:
> >
> >       ⬢[acme@toolbox pahole]$ pahole --header elf64_hdr --prettify=/bin/bash
> >       {
> >             .e_ident = { 127, 69, 76, 70, 2, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
> >             .e_type = 3,
> >             .e_machine = 62,
> >             .e_version = 1,
> >             .e_entry = 204016,
> >             .e_phoff = 64,
> >             .e_shoff = 1388096,
> >             .e_flags = 0,
> >             .e_ehsize = 64,
> >             .e_phentsize = 56,
> >             .e_phnum = 13,
> >             .e_shentsize = 64,
> >             .e_shnum = 31,
> >             .e_shstrndx = 30,
> >       },
> >       ⬢[acme@toolbox pahole]$ pahole --header elf64_hdr --prettify /bin/bash
> >       {
> >             .e_ident = { 127, 69, 76, 70, 2, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
> >             .e_type = 3,
> >             .e_machine = 62,
> >             .e_version = 1,
> >             .e_entry = 204016,
> >             .e_phoff = 64,
> >             .e_shoff = 1388096,
> >             .e_flags = 0,
> >             .e_ehsize = 64,
> >             .e_phentsize = 56,
> >             .e_phnum = 13,
> >             .e_shentsize = 64,
> >             .e_shnum = 31,
> >             .e_shstrndx = 30,
> >       },
> >       ⬢[acme@toolbox pahole]$ pahole --header elf64_hdr --prettify - < /bin/bash
> >       {
> >             .e_ident = { 127, 69, 76, 70, 2, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
> >             .e_type = 3,
> >             .e_machine = 62,
> >             .e_version = 1,
> >             .e_entry = 204016,
> >             .e_phoff = 64,
> >             .e_shoff = 1388096,
> >             .e_flags = 0,
> >             .e_ehsize = 64,
> >             .e_phentsize = 56,
> >             .e_phnum = 13,
> >             .e_shentsize = 64,
> >             .e_shnum = 31,
> >             .e_shstrndx = 30,
> >       },
> >       ⬢[acme@toolbox pahole]$ pahole --header elf64_hdr --prettify=- < /bin/bash
> >       {
> >             .e_ident = { 127, 69, 76, 70, 2, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
> >             .e_type = 3,
> >             .e_machine = 62,
> >             .e_version = 1,
> >             .e_entry = 204016,
> >             .e_phoff = 64,
> >             .e_shoff = 1388096,
> >             .e_flags = 0,
> >             .e_ehsize = 64,
> >             .e_phentsize = 56,
> >             .e_phnum = 13,
> >             .e_shentsize = 64,
> >             .e_shnum = 31,
> >             .e_shstrndx = 30,
> >       },
> >       ⬢[acme@toolbox pahole]$
> >
> >     Reported-by: Bernd Buschinski <b.buschinski@googlemail.com>
> >     Report-Link: https://lore.kernel.org/dwarves/CACN-hLVoz2tWrtgDLabOv6S1-H_8RD2fh8SV6EnADF1ikMxrmw@mail.gmail.com/
> >     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> >
> > diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
> > index 5cb356b9f8064139..a2bb920bc13bf250 100644
> > --- a/man-pages/pahole.1
> > +++ b/man-pages/pahole.1
> > @@ -21,7 +21,7 @@ It also uses these structure layouts to pretty print data feed to its standard
> >  input, e.g.:
> >  .PP
> >  .nf
> > -$ pahole --header elf64_hdr < /lib/modules/5.8.0-rc6+/build/vmlinux
> > +$ pahole --header elf64_hdr --prettify /lib/modules/5.8.0-rc6+/build/vmlinux
> >  {
> >         .e_ident = { 127, 69, 76, 70, 2, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
> >         .e_type = 2,
> > @@ -566,8 +566,8 @@ $
> >
> >  .SH PRETTY PRINTING
> >  .P
> > -pahole can also use the data structure types to pretty print raw data coming
> > -from its standard input.
> > +pahole can also use the data structure types to pretty print raw data specified via --prettify.
> > +To consume raw data from the standard input, just use '--prettify -'
> >  .P
> >  It can also pretty print raw data from stdin according to the type specified:
> >  .PP
> > @@ -585,7 +585,7 @@ $
> >  $ ls -la versions
> >  -rw-rw-r--. 1 acme acme 7616 Jun 25 11:33 versions
> >  $
> > -$ pahole --count 3 -C modversion_info drivers/scsi/sg.ko < versions
> > +$ pahole --count 3 -C modversion_info drivers/scsi/sg.ko --prettify versions
> >  {
> >        .crc = 0x8dabd84,
> >        .name = "module_layout",
> > @@ -599,7 +599,7 @@ $ pahole --count 3 -C modversion_info drivers/scsi/sg.ko < versions
> >        .name = "param_ops_int",
> >  },
> >  $
> > -$ pahole --skip 1 --count 2 -C modversion_info drivers/scsi/sg.ko < versions
> > +$ pahole --skip 1 --count 2 -C modversion_info drivers/scsi/sg.ko --prettify - < versions
> >  {
> >        .crc = 0x45e4617b,
> >        .name = "no_llseek",
> > @@ -611,7 +611,7 @@ $ pahole --skip 1 --count 2 -C modversion_info drivers/scsi/sg.ko < versions
> >  $
> >  This is equivalent to:
> >
> > -$ pahole --seek_bytes 64 --count 1 -C modversion_info drivers/scsi/sg.ko < versions
> > +$ pahole --seek_bytes 64 --count 1 -C modversion_info drivers/scsi/sg.ko --prettify versions
> >  {
> >         .crc = 0x45e4617b,
> >         .name = "no_llseek",
> > @@ -662,7 +662,7 @@ $
> >  Now we can use this to show the first record from offset zero:
> >  .PP
> >  .nf
> > -$ pahole -C elf64_hdr --count 1 < /lib/modules/5.8.0-rc3+/build/vmlinux
> > +$ pahole -C elf64_hdr --count 1 --prettify /lib/modules/5.8.0-rc3+/build/vmlinux
> >  {
> >         .e_ident = { 127, 69, 76, 70, 2, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
> >         .e_type = 2,
> > @@ -685,7 +685,7 @@ $
> >  This is equivalent to:
> >  .PP
> >  .nf
> > -$ pahole --header elf64_hdr < /lib/modules/5.8.0-rc3+/build/vmlinux
> > +$ pahole --header elf64_hdr --prettify /lib/modules/5.8.0-rc3+/build/vmlinux
> >  .fi
> >  .P
> >  The --header option also allows reference in other command line options to fields in the header.
> > @@ -693,7 +693,7 @@ This is useful when one wants to show multiple records in a file and the range w
> >  are located is specified in header fields, such as for perf.data files:
> >  .PP
> >  .nf
> > -$ pahole --hex ~/bin/perf --header perf_file_header < perf.data
> > +$ pahole --hex ~/bin/perf --header perf_file_header --prettify perf.data
> >  {
> >         .magic = 0x32454c4946524550,
> >         .size = 0x68,
> > @@ -718,7 +718,7 @@ $
> >  So to display the cgroups records in the perf_file_header.data section we can use:
> >  .PP
> >  .nf
> > -$ pahole ~/bin/perf --header=perf_file_header --seek_bytes '$header.data.offset' --size_bytes='$header.data.size' -C 'perf_event_header(sizeof,type,type_enum=perf_event_type,filter=type==PERF_RECORD_CGROUP)' < perf.data
> > +$ pahole ~/bin/perf --header=perf_file_header --seek_bytes '$header.data.offset' --size_bytes='$header.data.size' -C 'perf_event_header(sizeof,type,type_enum=perf_event_type,filter=type==PERF_RECORD_CGROUP)' --prettify perf.data
> >  {
> >         .header = {
> >                 .type = PERF_RECORD_CGROUP,
> > @@ -770,7 +770,7 @@ $
> >  For the common case of the header having a member that has the 'offset' and 'size' members, it is possible to use this more compact form:
> >  .PP
> >  .nf
> > -$ pahole ~/bin/perf --header=perf_file_header --range=data -C 'perf_event_header(sizeof,type,type_enum=perf_event_type,filter=type==PERF_RECORD_CGROUP)' < perf.data
> > +$ pahole ~/bin/perf --header=perf_file_header --range=data -C 'perf_event_header(sizeof,type,type_enum=perf_event_type,filter=type==PERF_RECORD_CGROUP)' --prettify perf.data
> >  .fi
> >  .P
> >  This uses ~/bin/perf to get the type definitions, the defines 'struct perf_file_header' as the header,
> > @@ -844,7 +844,7 @@ If we remove that type_enum=perf_event_type, we will lose the conversion of 'str
> >  more descriptive 'struct perf_record_cgroup', and also the beautification of the header.type field:
> >  .PP
> >  .nf
> > -$ pahole ~/bin/perf --header=perf_file_header --seek_bytes '$header.data.offset' --size_bytes='$header.data.size' -C 'perf_event_header(sizeof,type,filter=type==19)' < perf.data
> > +$ pahole ~/bin/perf --header=perf_file_header --seek_bytes '$header.data.offset' --size_bytes='$header.data.size' -C 'perf_event_header(sizeof,type,filter=type==19)' --prettify perf.data
> >  {
> >         .type = 19,
> >         .misc = 0,
> > @@ -876,7 +876,7 @@ $
> >  Some of the records are not found in 'type_enum=perf_event_type' so some of the records don't get converted to a type that fully shows its contents. For perf we know that those are in another enumeration, 'enum perf_user_event_type', so, for these cases, we can create a 'virtual enum', i.e. the sum of two enums and then get all those entries decoded and properly casted, first few records with just 'enum perf_event_type':
> >  .PP
> >  .nf
> > -$ pahole ~/bin/perf --header=perf_file_header --seek_bytes '$header.data.offset' --size_bytes='$header.data.size' -C 'perf_event_header(sizeof,type,type_enum=perf_event_type)' --count 4 < perf.data
> > +$ pahole ~/bin/perf --header=perf_file_header --seek_bytes '$header.data.offset' --size_bytes='$header.data.size' -C 'perf_event_header(sizeof,type,type_enum=perf_event_type)' --count 4 --prettify perf.data
> >  {
> >         .type = 79,
> >         .misc = 0,
> > @@ -907,7 +907,7 @@ $
> >  Now with both enumerations, i.e. with 'type_enum=perf_event_type+perf_user_event_type':
> >  .PP
> >  .nf
> > -$ pahole ~/bin/perf --header=perf_file_header --seek_bytes '$header.data.offset' --size_bytes='$header.data.size' -C 'perf_event_header(sizeof,type,type_enum=perf_event_type+perf_user_event_type)' --count 5 < perf.data
> > +$ pahole ~/bin/perf --header=perf_file_header --seek_bytes '$header.data.offset' --size_bytes='$header.data.size' -C 'perf_event_header(sizeof,type,type_enum=perf_event_type+perf_user_event_type)' --count 5 --prettify perf.data
> >  {
> >         .header = {
> >                 .type = PERF_RECORD_TIME_CONV,
> > @@ -966,7 +966,7 @@ data range with the following command:
> >  .PP
> >  .nf
> >  pahole ~/bin/perf --header=perf_file_header \
> > -         -C 'perf_file_attr(range=attrs),perf_event_header(range=data,sizeof,type,type_enum=perf_event_type+perf_user_event_type)' < perf.data
> > +         -C 'perf_file_attr(range=attrs),perf_event_header(range=data,sizeof,type,type_enum=perf_event_type+perf_user_event_type)' --prettify perf.data
> >  .fi
> >
> >  .SH SEE ALSO
> > diff --git a/pahole.c b/pahole.c
> > index 06c4025549396fbf..520ddef93494d84f 100644
> > --- a/pahole.c
> > +++ b/pahole.c
> > @@ -35,6 +35,9 @@ static bool skip_encoding_btf_vars;
> >  static bool btf_encode_force;
> >  static const char *base_btf_file;
> >
> > +static const char *prettify_input_filename;
> > +static FILE *prettify_input;
> > +
> >  static uint8_t class__include_anonymous;
> >  static uint8_t class__include_nested_anonymous;
> >  static uint8_t word_size, original_word_size;
> > @@ -854,6 +857,7 @@ ARGP_PROGRAM_VERSION_HOOK_DEF = dwarves_print_version;
> >  #define ARGP_with_flexible_array   324
> >  #define ARGP_kabi_prefix          325
> >  #define ARGP_btf_encode_detached   326
> > +#define ARGP_prettify_input_filename 327
> >
> >  static const struct argp_option pahole__options[] = {
> >         {
> > @@ -1202,6 +1206,12 @@ static const struct argp_option pahole__options[] = {
> >                 .key  = ARGP_numeric_version,
> >                 .doc  = "Print a numeric version, i.e. 119 instead of v1.19"
> >         },
> > +       {
> > +               .name = "prettify",
> > +               .key  = ARGP_prettify_input_filename,
> > +               .arg  = "PATH",
> > +               .doc  = "Path to the raw data to pretty print",
> > +       },
> >         {
> >                 .name = NULL,
> >         }
> > @@ -1332,6 +1342,8 @@ static error_t pahole__options_parser(int key, char *arg,
> >                 btf_gen_floats = true;                  break;
> >         case ARGP_with_flexible_array:
> >                 show_with_flexible_array = true;        break;
> > +       case ARGP_prettify_input_filename:
> > +               prettify_input_filename = arg;          break;
> >         default:
> >                 return ARGP_ERR_UNKNOWN;
> >         }
> > @@ -2586,7 +2598,7 @@ static enum load_steal_kind pahole_stealer(struct cu *cu,
> >                         class_id = 0;
> >                 }
> >
> > -               if (!isatty(0)) {
> > +               if (prettify_input) {
> >                         prototype->class = class;
> >                         prototype->cu    = cu;
> >                         continue;
> > @@ -2624,7 +2636,7 @@ static enum load_steal_kind pahole_stealer(struct cu *cu,
> >
> >         // If we got here with pretty printing is because we have everything solved except for type_enum or --header
> >
> > -       if (!isatty(0)) {
> > +       if (prettify_input) {
> >                 // Check if we need to continue loading CUs to get those type_enum= and --header resolved
> >                 if (header == NULL && conf.header_type)
> >                         return LSK__KEEPIT;
> > @@ -2637,7 +2649,7 @@ static enum load_steal_kind pahole_stealer(struct cu *cu,
> >                 // All set, pretty print it!
> >                 list_for_each_entry_safe(prototype, n, &class_names, node) {
> >                         list_del_init(&prototype->node);
> > -                       if (prototype__stdio_fprintf_value(prototype, header, stdin, stdout) < 0)
> > +                       if (prototype__stdio_fprintf_value(prototype, header, prettify_input, stdout) < 0)
> >                                 break;
> >                 }
> >
> > @@ -2783,9 +2795,6 @@ int main(int argc, char *argv[])
> >  {
> >         int err, remaining, rc = EXIT_FAILURE;
> >
> > -       if (!isatty(0))
> > -               conf.hex_fmt = 0;
> > -
> >         if (argp_parse(&pahole__argp, argc, argv, 0, &remaining, NULL)) {
> >                 argp_help(&pahole__argp, stderr, ARGP_HELP_SEE, argv[0]);
> >                 goto out;
> > @@ -2801,6 +2810,19 @@ int main(int argc, char *argv[])
> >                 goto out;
> >         }
> >
> > +       if (prettify_input_filename) {
> > +               if (strcmp(prettify_input_filename, "-") == 0) {
> > +                       prettify_input = stdin;
> > +               } else {
> > +                       prettify_input = fopen(prettify_input_filename, "r");
> > +                       if (prettify_input == NULL) {
> > +                               fprintf(stderr, "Failed to read input '%s': %s\n",
> > +                                       prettify_input_filename, strerror(errno));
> > +                               goto out_dwarves_exit;
> > +                       }
> > +               }
> > +       }
> > +
> >         if (base_btf_file) {
> >                 conf_load.base_btf = btf__parse(base_btf_file, NULL);
> >                 if (libbpf_get_error(conf_load.base_btf)) {
> > @@ -2825,7 +2847,7 @@ int main(int argc, char *argv[])
> >         conf_load.steal = pahole_stealer;
> >
> >         // Make 'pahole --header type < file' a shorter form of 'pahole -C type --count 1 < file'
> > -       if (conf.header_type && !class_name && !isatty(0)) {
> > +       if (conf.header_type && !class_name && prettify_input) {
> >                 conf.count = 1;
> >                 class_name = conf.header_type;
> >                 conf.header_type = 0; // so that we don't read it and then try to read the -C type
> > @@ -2923,6 +2945,10 @@ out_cus_delete:
> >         conf_load.base_btf = NULL;
> >  #endif
> >  out_dwarves_exit:
> > +       if (prettify_input && prettify_input != stdin) {
> > +               fclose(prettify_input);
> > +               prettify_input = NULL;
> > +       }
> >  #ifdef DEBUG_CHECK_LEAKS
> >         dwarves__exit();
> >  #endif

-- 

- Arnaldo
