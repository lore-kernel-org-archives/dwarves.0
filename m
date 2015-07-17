From: Bruce Korb <bkorb-mXXj517/zsQ@public.gmane.org>
Subject: Re: die__process_function: tag not supported (INVALID)!
Date: Fri, 17 Jul 2015 16:01:40 -0700
Message-ID: <55A98954.8080202@gnu.org>
References: <559E9FA5.1090307@gnu.org> <2129979699.4572.1437162664096.JavaMail.open-xchange@ox1app> <20150717213300.GA2352@blokker.redhat.com>
Reply-To: bkorb-mXXj517/zsQ@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150717213300.GA2352-iA3+RHPOETwf7BdofF/totBPR1lH4CV8@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Wielaard <mjw-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Hagen Paul Pfeifer <hagen-GvnIQ6b/HdU@public.gmane.org>
Cc: DWARVES <dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: dwarves@vger.kernel.org

On 07/17/15 14:33, Mark Wielaard wrote:
> On Fri, Jul 17, 2015 at 09:51:03PM +0200, Hagen Paul Pfeifer wrote:
>>> On July 9, 2015 at 6:21 PM Bruce Korb <bkorb-mXXj517/zsQ@public.gmane.org> wrote:
>>>
>>> 1. What is that message trying to say?
>>
>> Take a look here:
>>
>> https://github.com/acmel/dwarves/blob/master/dwarf_loader.c#L1462
>
> Note that as far as I know the github repository is old and not
> up to date. I believe the repository to use is:
> https://git.kernel.org/cgit/devel/pahole/pahole.git/

Does this help any?  Should I go down to frame 6 and poke around?

Breakpoint 1, die__process_function (die=0x7fffffffb670, ftype=0x629b90,
     lexblock=0x629bc8, cu=0x60b430) at /u/bkorb/tools/pahole/dwarf_loader.c:1464
1464            if (!dwarf_haschildren(die) || dwarf_child(die, &child) != 0)
(gdb) bt
#0  die__process_function (die=0x7fffffffb670, ftype=0x629b90,
     lexblock=0x629bc8, cu=0x60b430) at /u/bkorb/tools/pahole/dwarf_loader.c:1464
#1  0x00007ffff7bcffdd in die__create_new_function (die=0x7fffffffb670,
     cu=0x60b430) at /u/bkorb/tools/pahole/dwarf_loader.c:1544
#2  0x00007ffff7bd0136 in __die__process_tag (die=0x7fffffffb670, cu=0x60b430,
     top_level=1, fn=0x7ffff7bd5680 <__FUNCTION__.7998> "die__process_unit")
     at /u/bkorb/tools/pahole/dwarf_loader.c:1583
#3  0x00007ffff7bd0209 in die__process_unit (die=0x7fffffffb670, cu=0x60b430)
     at /u/bkorb/tools/pahole/dwarf_loader.c:1612
#4  0x00007ffff7bd1076 in die__process (die=0x7fffffffb730, cu=0x60b430)
     at /u/bkorb/tools/pahole/dwarf_loader.c:2037
#5  0x00007ffff7bd10fb in die__process_and_recode (die=0x7fffffffb730,
     cu=0x60b430) at /u/bkorb/tools/pahole/dwarf_loader.c:2052
#6  0x00007ffff7bd1968 in cus__load_module (cus=0x608060,
     conf=0x607320 <conf_load>, mod=0x609e10, dw=0x609f90, elf=0x6080f0,
     filename=0x7fffffffe162 "skyhawk_tests")
     at /u/bkorb/tools/pahole/dwarf_loader.c:2276
#7  0x00007ffff7bd1aa6 in cus__process_dwflmod (dwflmod=0x609e10,
     userdata=0x609e20, name=0x609f50 "skyhawk_tests", base=4194304,
     arg=0x7fffffffd970) at /u/bkorb/tools/pahole/dwarf_loader.c:2324
#8  0x00007ffff73e85e1 in dwfl_getmodules () from /usr/lib64/libdw.so.1
#9  0x00007ffff7bd1b66 in cus__process_file (cus=0x608060,
     conf=0x607320 <conf_load>, fd=3, filename=0x7fffffffe162 "skyhawk_tests")
     at /u/bkorb/tools/pahole/dwarf_loader.c:2377
#10 0x00007ffff7bd1be2 in dwarf__load_file (cus=0x608060,
     conf=0x607320 <conf_load>, filename=0x7fffffffe162 "skyhawk_tests")
     at /u/bkorb/tools/pahole/dwarf_loader.c:2394
#11 0x00007ffff7bc1a8c in cus__load_file (cus=0x608060,
     conf=0x607320 <conf_load>, filename=0x7fffffffe162 "skyhawk_tests")
     at /u/bkorb/tools/pahole/dwarves.c:1476
#12 0x00007ffff7bc1b06 in cus__load_files (cus=0x608060,
     conf=0x607320 <conf_load>, filenames=0x7fffffffdbb0)
     at /u/bkorb/tools/pahole/dwarves.c:1490
#13 0x000000000040436c in main (argc=2, argv=0x7fffffffdba8)
     at /u/bkorb/tools/pahole/pahole.c:1250

--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
