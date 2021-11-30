Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 689A9C433F5
	for <linux-dwarves@archiver.kernel.org>; Tue, 30 Nov 2021 16:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbhK3QqU (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 30 Nov 2021 11:46:20 -0500
Received: from foss.arm.com ([217.140.110.172]:43148 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229975AbhK3QqU (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Tue, 30 Nov 2021 11:46:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 748C96D;
        Tue, 30 Nov 2021 08:43:00 -0800 (PST)
Received: from [10.57.36.40] (unknown [10.57.36.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 73ADC3F694;
        Tue, 30 Nov 2021 08:42:59 -0800 (PST)
Subject: Re: [PATCH v1 1/2] fprintf: Allow making struct/enum/union anonymous
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     acme@redhat.com, dwarves@vger.kernel.org
References: <20211019100724.325570-1-douglas.raillard@arm.com>
 <20211019100724.325570-2-douglas.raillard@arm.com>
 <YaEnHVi+i8mx54BB@kernel.org>
From:   Douglas Raillard <douglas.raillard@arm.com>
Message-ID: <cd9cfb2d-fc6c-9143-54da-8a29bc508e40@arm.com>
Date:   Tue, 30 Nov 2021 16:42:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YaEnHVi+i8mx54BB@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On 11/26/21 6:27 PM, Arnaldo Carvalho de Melo wrote:
> Em Tue, Oct 19, 2021 at 11:07:23AM +0100, Douglas RAILLARD escreveu:
>> From: Douglas Raillard <douglas.raillard@arm.com>
>>
>> Allow making inner struct enums and union anonymous.
> 
> So I had to apply it by hand due to changes in the areas it touches, see
> below, and I expanded a bit the commit message, please review:

Thanks for the review, it seems to be working as well as before. That said I found a couple of issues:

1. CLI options seem to abbreviate "anonymous" into "anon" so maybe we should do the same for this one ?
2. I just found a case that generates a broken header:

	struct /* hrtimer */ {
		struct /* timerqueue_node */ {
			struct /* rb_node */ {
				long unsigned int __rb_parent_color;                     /*  3328     8 */
				struct rb_node * rb_right;                               /*  3336     8 */
				struct rb_node * rb_left;                                /*  3344     8 */
			}node; /*  3328    24 */
			/* typedef ktime_t -> s64 -> __s64 */ long long int expires;     /*  3352     8 */
		}node; /*  3328    32 */
		/* typedef ktime_t -> s64 -> __s64 */ long long int      _softexpires;   /*  3360     8 */
		enum hrtimer_restart (*function)(struct hrtimer *);                      /*  3368     8 */
		struct hrtimer_clock_base * base;                                        /*  3376     8 */
		/* typedef u8 -> __u8 */ unsigned char      state;                       /*  3384     1 */
		/* typedef u8 -> __u8 */ unsigned char      is_rel;                      /*  3385     1 */
		/* typedef u8 -> __u8 */ unsigned char      is_soft;                     /*  3386     1 */
		/* typedef u8 -> __u8 */ unsigned char      is_hard;                     /*  3387     1 */
	}hrtick_timer; /*  3328    64 */

Here we can see that "struct rb_node" is a recursive type, so since the type
definition is now anonymous it will not compile. Detecting recursive types and
printing the name would avoid that but defeats the original purpose
of --inner_anonymous.

I can see two solutions:

1. Detecting recursive types and appending a user-defined prefix to create a
    unique name.
2. Detecting recursive types and replacing the recursive references by "void *".

Solution #2 is the least invasive but will require a bit more work for the
end-user of the header:

  struct hrtimer foo = *ptr;
  typeof(foo.node.node) node = foo.node.node;

  // Extra cast using typeof in order to change the type of tb_right from void*
  // to "struct rb_node*"
  ((typeof(node))node.rb_right)->rb_left


Thanks,
Douglas

> 
> ------ 8< ------------------------
> 
> fprintf: Allow making struct/enum/union anonymous
> 
> Allow making inner struct enums and union anonymous, so that when using
> -E to expand types we don't end up with multiple definitions for
> expanded inner structs, allowing the resulting expanded struct to be
> compilable.
> 
> Signed-off-by: Douglas Raillard <douglas.raillard@arm.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ------ 8< ------------------------
> 
> ⬢[acme@toolbox pahole]$ patch -p1 < ~/wb/1.patch
> patching file dwarves.h
> Hunk #1 succeeded at 105 (offset 6 lines).
> Hunk #2 succeeded at 1372 with fuzz 2 (offset 44 lines).
> patching file dwarves_emit.c
> patching file dwarves_fprintf.c
> Hunk #1 succeeded at 198 (offset 12 lines).
> Hunk #2 succeeded at 331 (offset 12 lines).
> Hunk #3 succeeded at 342 (offset 12 lines).
> Hunk #4 succeeded at 395 (offset 12 lines).
> Hunk #5 succeeded at 639 (offset 12 lines).
> Hunk #6 succeeded at 656 (offset 12 lines).
> Hunk #7 succeeded at 814 (offset 12 lines).
> Hunk #8 succeeded at 824 with fuzz 1 (offset 12 lines).
> Hunk #9 succeeded at 833 with fuzz 2 (offset 12 lines).
> Hunk #10 succeeded at 998 (offset 23 lines).
> Hunk #11 succeeded at 1013 (offset 23 lines).
> Hunk #12 succeeded at 1375 (offset 23 lines).
> Hunk #13 succeeded at 1396 (offset 23 lines).
> Hunk #14 succeeded at 1822 (offset 23 lines).
> Hunk #15 succeeded at 1909 (offset 23 lines).
> Hunk #16 succeeded at 1917 (offset 23 lines).
> Hunk #17 succeeded at 1929 (offset 23 lines).
> ⬢[acme@toolbox pahole]$
> 

