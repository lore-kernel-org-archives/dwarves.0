Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8926C433F5
	for <linux-dwarves@archiver.kernel.org>; Thu, 28 Oct 2021 09:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0C0060E78
	for <linux-dwarves@archiver.kernel.org>; Thu, 28 Oct 2021 09:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbhJ1JeD (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 28 Oct 2021 05:34:03 -0400
Received: from foss.arm.com ([217.140.110.172]:52730 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229835AbhJ1JeD (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Thu, 28 Oct 2021 05:34:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35E631FB;
        Thu, 28 Oct 2021 02:31:36 -0700 (PDT)
Received: from [10.57.46.169] (unknown [10.57.46.169])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 44DF73F5A1;
        Thu, 28 Oct 2021 02:31:35 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] btf_loader.c: Infer alignment info
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     acme@redhat.com, dwarves@vger.kernel.org
References: <20211018131621.212628-1-douglas.raillard@arm.com>
 <20211018131621.212628-4-douglas.raillard@arm.com>
 <YXIGaA1SYSx37EEV@kernel.org> <YXbj+gukL1fZx/Gb@kernel.org>
 <550aad99-12b3-c594-9fb4-354b62cbaa5b@arm.com> <YXm69PIYcYckUVzP@kernel.org>
From:   Douglas Raillard <douglas.raillard@arm.com>
Message-ID: <985d273b-9c3e-0c5c-bf86-e73b8d2f6007@arm.com>
Date:   Thu, 28 Oct 2021 10:31:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YXm69PIYcYckUVzP@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On 10/27/21 9:47 PM, Arnaldo Carvalho de Melo wrote:
> Em Tue, Oct 26, 2021 at 04:03:57PM +0100, Douglas Raillard escreveu:
>> On 10/25/21 6:06 PM, Arnaldo Carvalho de Melo wrote:
>>> Em Thu, Oct 21, 2021 at 09:31:36PM -0300, Arnaldo Carvalho de Melo escreveu:
>>>> Em Mon, Oct 18, 2021 at 02:16:21PM +0100, Douglas RAILLARD escreveu:
>>>>> From: Douglas Raillard <douglas.raillard@arm.com>
> 
>>>>> BTF does not carry alignment information, but it carries the offset in
>>>>> structs. This allows inferring the original alignment, yielding a C
>>>>> header dump that is not identical to the original C code, but is
>>>>> guaranteed to lead to the same memory layout.
> 
>>>>> This allows using the output of pahole in another program to poke at
>>>>> memory, with the assurance that we will not read garbage.
> 
>>>>> Note: Since the alignment is inferred from the offset, it sometimes
>>>>> happens that the offset was already correctly aligned, which means the
>>>>> inferred alignment will be smaller than in the original source. This
>>>>> does not impact the ability to read existing structs, but it could
>>>>> impact creating such struct if other client code expects higher
>>>>> alignment than the one exposed in the generated header.
> 
>>>> this one makes btfdiff fail, example:
> 
>>>> @@ -125578,7 +125640,7 @@ struct xt_entry_match {
>>>>    			struct xt_match * match;         /*     8     8 */
>>>>    		} kernel;                                /*     0    16 */
>>>>    		__u16              match_size;           /*     0     2 */
>>>> -	} u;                                             /*     0    32 */
>>>> +	} u;            /*     0    32 */
>>>>    	unsigned char              data[];               /*    32     0 */
>>>>
>>>>    	/* size: 32, cachelines: 1, members: 2 */
>>>>
>>>> Why the change in the generated source code comment alignment?
> 
> The one above I fixed today, an old bug that gets exercised when you inferred
> alignment for types.
> 
>>> Since this is inferred and DWARF has the alignment info explicitely, we
>>> can't really compare, so I'll stick this to btfdiff.
> <SNIP>
>>> I got sidetracked, will try to reduce the differences somehow, but
>>> probably as patches on top of yours, to test this the best is to use
>>> fullcircle from BTF info, which I'll also look into as I think you
>>> reported issues with pfunct's --compile option.
>   
>> Thanks, let me know when you get something working on this front.
> 
> So, what is now in the 'next' branch (an alias for the tmp.master branch
> that is tested in the libbpf CI) produces:
> 
>    --- /tmp/btfdiff.dwarf.8098nf   2021-10-27 17:29:02.788601053 -0300
>    +++ /tmp/btfdiff.btf.eTagYI     2021-10-27 17:29:02.994606515 -0300
>    @@ -107,7 +107,7 @@ struct Qdisc {
>            /* XXX 24 bytes hole, try to pack */
>     
>            /* --- cacheline 2 boundary (128 bytes) --- */
>    -       struct sk_buff_head        gso_skb __attribute__((__aligned__(64))); /*   128    24 */
>    +       struct sk_buff_head        gso_skb __attribute__((__aligned__(32))); /*   128    24 */
>            struct qdisc_skb_head      q;                    /*   152    24 */
>            struct gnet_stats_basic_packed bstats;           /*   176    16 */
>            /* --- cacheline 3 boundary (192 bytes) --- */
>    
> The one above is a bit difficult to solve, perhaps we can use an
> heuristic for kernel files and assume this is dependend on the
> typical cacheline sizes? As it in the kernel sources is:
> 
>            struct sk_buff_head     gso_skb ____cacheline_aligned_in_smp;
> 
> I.e. if it is a multiple of both 64, then we use it instead of 32?
>    
>    @@ -117,18 +117,18 @@ struct Qdisc {
>            struct Qdisc *             next_sched;           /*   224     8 */
>            struct sk_buff_head        skb_bad_txq;          /*   232    24 */
>            /* --- cacheline 4 boundary (256 bytes) --- */
>    -       spinlock_t                 busylock __attribute__((__aligned__(64))); /*   256     4 */
>    +       spinlock_t                 busylock;             /*   256     4 */
> 
> Originally:
> 
>          spinlock_t              busylock ____cacheline_aligned_in_smp;

Sounds like a good idea, I can't think of another reason for large alignments anyway.
Larger power of 2 alignments are harmless anyway so we might as well try to guess.
I'll prepare a v3 with that update.

> 
> But since it is already naturally aligned (232 + 24 = 256), we can't
> infer it from what BTF carries.
> 
>            spinlock_t                 seqlock;              /*   260     4 */
>    -       struct callback_head       rcu __attribute__((__aligned__(8))); /*   264    16 */
>    +       struct callback_head       rcu;                  /*   264    16 */
> 
> Ditto
>     
>            /* XXX 40 bytes hole, try to pack */
>     
>            /* --- cacheline 5 boundary (320 bytes) --- */
>    -       long int                   privdata[] __attribute__((__aligned__(64))); /*   320     0 */
>    +       long int                   privdata[];           /*   320     0 */
> 
> But this one should've been inferred, right?

Assuming you talk about offset 320 aligned on 64, we cannot infer a specific alignment since
5 * 64 = 320.

If you mean the number of forced alignments, I'm not surprised that BTF finds less forced alignments,
as each some of the technically forced alignments (in the original source) also happens to be already
satisfied by the normal layout, so we don't infer anything special.

- Douglas

>            /* size: 320, cachelines: 5, members: 27 */
>            /* sum members: 256, holes: 2, sum holes: 64 */
>    -       /* forced alignments: 4, forced holes: 2, sum forced holes: 64 */
>    +       /* forced alignments: 1, forced holes: 1, sum forced holes: 24 */
>     } __attribute__((__aligned__(64)));
> 
> 
> Here both match, what was inferred for BTF is what DWARF produces, even
> with the source code having no explicit annotation for the type.
> 
>> I also made the following Python script to validate the algorithm, assuming
>> the compiler will emit a layout according to natural alignment:
> 
> Cool, I'll try and read it carefully.
> 
> - Arnaldo
>   
>> #! /usr/bin/env python3
>>
>> import itertools
>> import math
>>
>> class Member:
>>      def __init__(self, size, alignment=None):
>>          self.size = size
>>          self.alignment = size if alignment is None else alignment
>>
>>          assert self.alignment >= self.size
>>
>>      def __repr__(self):
>>          return f'Member(size={self.size}, alignment={self.alignment})'
>>
>>
>> def align(x, n):
>>      r = x % n
>>      padding = n - r if r else 0
>>      return x + padding
>>
>>
>> def next_power_of_2(x):
>>      return 2 ** math.ceil(math.log2(x)) if x else 1
>>
>>
>> def powers_of_2(from_, up_to):
>>      for i in itertools.count():
>>          x = 1 << i
>>          if x < from_:
>>              continue
>>          elif x <= up_to:
>>              yield x
>>          else:
>>              return
>>
>> class Struct:
>>      def __init__(self, members, alignment=None):
>>          members = list(members)
>>
>>          self.members = members
>>          self.alignment = alignment
>>          self.offsets = self._compute_offsets(members)
>>          self.size = self._compute_size(members, self.offsets, alignment)
>>
>>
>>      def __str__(self):
>>          members = ',\n    '.join(
>>              f'offset={offset}: {member}'
>>              for member, offset in self.members_offset
>>          )
>>          return f'Struct(\n    {members}\n)'
>>
>>      @classmethod
>>      def from_offsets(cls, members, offsets):
>>          def compute(acc, member_spec):
>>              _, smallest_offset = acc
>>              member, offset = member_spec
>>
>>              delta = offset - smallest_offset
>>              size = member.size
>>
>>              # Get power of 2 that is strictly higher than delta
>>              alignment = next_power_of_2(delta + 1)
>>
>>              # Minimum is natural alignment
>>              if alignment < size:
>>                  alignment = size
>>
>>              member = Member(
>>                  size=size,
>>                  # Rather than using member.alignment to get the original
>>                  # alignment, infer it only from the offset
>>                  alignment=alignment,
>>              )
>>              return (member, offset + size)
>>
>>          accs = itertools.accumulate(
>>              zip(members, offsets),
>>              compute,
>>              initial=(Member(0), 0),
>>          )
>>          members, _ = zip(*itertools.islice(accs, 1, None))
>>
>>          return cls(
>>              members=members,
>>          )
>>
>>      @staticmethod
>>      def _compute_offsets(members):
>>          def compute(acc, member):
>>              _, smallest_offset = acc
>>
>>              offset = align(smallest_offset, member.alignment)
>>              next_offset = offset + member.size
>>              return (offset, next_offset)
>>
>>          offsets = itertools.accumulate(
>>              members,
>>              compute,
>>              initial=(0, 0),
>>          )
>>          offsets, _ = zip(*itertools.islice(offsets, 1, None))
>>          return offsets
>>
>>      @property
>>      def members_offset(self):
>>          return list(zip(self.members, self.offsets))
>>
>>      @staticmethod
>>      def _compute_size(members, offsets, alignment):
>>          alignment = alignment or 1
>>          last = offsets[-1] + members[-1].size
>>          return align(last, alignment)
>>
>>
>> def test_align_infer(struct):
>>
>>      # Reconstruct a struct by inferring alignment from offsets
>>      s2 = struct.from_offsets(struct.members, struct.offsets)
>>
>>      errors = []
>>      for (m1, o1), (m2, o2) in zip(
>>          struct.members_offset,
>>          s2.members_offset,
>>      ):
>>          if o1 != o2:
>>              errors.append(
>>                  f'Wrong offset for {m1} (offset={o1}): {m2} (offset={o2})'
>>              )
>>
>>      if errors:
>>          print()
>>          print(struct)
>>          print(s2)
>>          for error in errors:
>>              print(error)
>>
>> # s1 = Struct(
>> #     [
>> #         Member(4),
>> #         Member(2),
>> #         Member(8),
>> #     ]
>> # )
>> # print(s1.members_offset)
>>
>> members = [
>>      Member(size, alignment)
>>      for size in powers_of_2(1, 128)
>>      for alignment in powers_of_2(size, 256)
>> ]
>>
>> for nr_members in range(1, 4):
>>      for _members in itertools.permutations(members, nr_members):
>>          struct = Struct(list(_members))
>>          print(struct)
>>          res = test_align_infer(struct)
>>
>>
>>> - Arnaldo
>>>
> 

