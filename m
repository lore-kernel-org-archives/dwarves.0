Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0856CC433EF
	for <linux-dwarves@archiver.kernel.org>; Tue, 26 Oct 2021 15:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D977560E74
	for <linux-dwarves@archiver.kernel.org>; Tue, 26 Oct 2021 15:04:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbhJZPGZ (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 26 Oct 2021 11:06:25 -0400
Received: from foss.arm.com ([217.140.110.172]:60988 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230390AbhJZPGY (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Tue, 26 Oct 2021 11:06:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7330A1063;
        Tue, 26 Oct 2021 08:04:00 -0700 (PDT)
Received: from [10.57.45.169] (unknown [10.57.45.169])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 99ADD3F70D;
        Tue, 26 Oct 2021 08:03:59 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] btf_loader.c: Infer alignment info
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     acme@redhat.com, dwarves@vger.kernel.org
References: <20211018131621.212628-1-douglas.raillard@arm.com>
 <20211018131621.212628-4-douglas.raillard@arm.com>
 <YXIGaA1SYSx37EEV@kernel.org> <YXbj+gukL1fZx/Gb@kernel.org>
From:   Douglas Raillard <douglas.raillard@arm.com>
Message-ID: <550aad99-12b3-c594-9fb4-354b62cbaa5b@arm.com>
Date:   Tue, 26 Oct 2021 16:03:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YXbj+gukL1fZx/Gb@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On 10/25/21 6:06 PM, Arnaldo Carvalho de Melo wrote:
> Em Thu, Oct 21, 2021 at 09:31:36PM -0300, Arnaldo Carvalho de Melo escreveu:
>> Em Mon, Oct 18, 2021 at 02:16:21PM +0100, Douglas RAILLARD escreveu:
>>> From: Douglas Raillard <douglas.raillard@arm.com>
>>>
>>> BTF does not carry alignment information, but it carries the offset in
>>> structs. This allows inferring the original alignment, yielding a C
>>> header dump that is not identical to the original C code, but is
>>> guaranteed to lead to the same memory layout.
>>>
>>> This allows using the output of pahole in another program to poke at
>>> memory, with the assurance that we will not read garbage.
>>>
>>> Note: Since the alignment is inferred from the offset, it sometimes
>>> happens that the offset was already correctly aligned, which means the
>>> inferred alignment will be smaller than in the original source. This
>>> does not impact the ability to read existing structs, but it could
>>> impact creating such struct if other client code expects higher
>>> alignment than the one exposed in the generated header.
>>
>> this one makes btfdiff fail, example:
>>
>>
>> @@ -125578,7 +125640,7 @@ struct xt_entry_match {
>>   			struct xt_match * match;         /*     8     8 */
>>   		} kernel;                                /*     0    16 */
>>   		__u16              match_size;           /*     0     2 */
>> -	} u;                                             /*     0    32 */
>> +	} u;            /*     0    32 */
>>   	unsigned char              data[];               /*    32     0 */
>>
>>   	/* size: 32, cachelines: 1, members: 2 */
>>
>> Why the change in the generated source code comment alignment?
> 
> Since this is inferred and DWARF has the alignment info explicitely, we
> can't really compare, so I'll stick this to btfdiff.
> 
> diff --git a/btfdiff b/btfdiff
> index 77543630d1965b5e..cbdf65285cd90f62 100755
> --- a/btfdiff
> +++ b/btfdiff
> @@ -33,6 +33,7 @@ ${pahole_bin} -F dwarf \
>   	      --show_private_classes $dwarf_input > $dwarf_output
>   ${pahole_bin} -F btf \
>   	      --sort \
> +	      --suppress_aligned_attribute \
>   	      --suppress_packed \
>   	      $btf_input > $btf_output
>   
>   
>> There are some other differences, I'll check tomorrow.
> 
> I got sidetracked, will try to reduce the differences somehow, but
> probably as patches on top of yours, to test this the best is to use
> fullcircle from BTF info, which I'll also look into as I think you
> reported issues with pfunct's --compile option.

Thanks, let me know when you get something working on this front.
I also made the following Python script to validate the algorithm, assuming
the compiler will emit a layout according to natural alignment:

#! /usr/bin/env python3

import itertools
import math

class Member:
     def __init__(self, size, alignment=None):
         self.size = size
         self.alignment = size if alignment is None else alignment

         assert self.alignment >= self.size

     def __repr__(self):
         return f'Member(size={self.size}, alignment={self.alignment})'


def align(x, n):
     r = x % n
     padding = n - r if r else 0
     return x + padding


def next_power_of_2(x):
     return 2 ** math.ceil(math.log2(x)) if x else 1


def powers_of_2(from_, up_to):
     for i in itertools.count():
         x = 1 << i
         if x < from_:
             continue
         elif x <= up_to:
             yield x
         else:
             return

class Struct:
     def __init__(self, members, alignment=None):
         members = list(members)

         self.members = members
         self.alignment = alignment
         self.offsets = self._compute_offsets(members)
         self.size = self._compute_size(members, self.offsets, alignment)


     def __str__(self):
         members = ',\n    '.join(
             f'offset={offset}: {member}'
             for member, offset in self.members_offset
         )
         return f'Struct(\n    {members}\n)'

     @classmethod
     def from_offsets(cls, members, offsets):
         def compute(acc, member_spec):
             _, smallest_offset = acc
             member, offset = member_spec

             delta = offset - smallest_offset
             size = member.size

             # Get power of 2 that is strictly higher than delta
             alignment = next_power_of_2(delta + 1)

             # Minimum is natural alignment
             if alignment < size:
                 alignment = size

             member = Member(
                 size=size,
                 # Rather than using member.alignment to get the original
                 # alignment, infer it only from the offset
                 alignment=alignment,
             )
             return (member, offset + size)

         accs = itertools.accumulate(
             zip(members, offsets),
             compute,
             initial=(Member(0), 0),
         )
         members, _ = zip(*itertools.islice(accs, 1, None))

         return cls(
             members=members,
         )

     @staticmethod
     def _compute_offsets(members):
         def compute(acc, member):
             _, smallest_offset = acc

             offset = align(smallest_offset, member.alignment)
             next_offset = offset + member.size
             return (offset, next_offset)

         offsets = itertools.accumulate(
             members,
             compute,
             initial=(0, 0),
         )
         offsets, _ = zip(*itertools.islice(offsets, 1, None))
         return offsets

     @property
     def members_offset(self):
         return list(zip(self.members, self.offsets))

     @staticmethod
     def _compute_size(members, offsets, alignment):
         alignment = alignment or 1
         last = offsets[-1] + members[-1].size
         return align(last, alignment)


def test_align_infer(struct):

     # Reconstruct a struct by inferring alignment from offsets
     s2 = struct.from_offsets(struct.members, struct.offsets)

     errors = []
     for (m1, o1), (m2, o2) in zip(
         struct.members_offset,
         s2.members_offset,
     ):
         if o1 != o2:
             errors.append(
                 f'Wrong offset for {m1} (offset={o1}): {m2} (offset={o2})'
             )

     if errors:
         print()
         print(struct)
         print(s2)
         for error in errors:
             print(error)

# s1 = Struct(
#     [
#         Member(4),
#         Member(2),
#         Member(8),
#     ]
# )
# print(s1.members_offset)

members = [
     Member(size, alignment)
     for size in powers_of_2(1, 128)
     for alignment in powers_of_2(size, 256)
]

for nr_members in range(1, 4):
     for _members in itertools.permutations(members, nr_members):
         struct = Struct(list(_members))
         print(struct)
         res = test_align_infer(struct)


> - Arnaldo
> 

