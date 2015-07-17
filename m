From: Bruce Korb <bkorb-mXXj517/zsQ@public.gmane.org>
Subject: Re: die__process_function: tag not supported (INVALID)!
Date: Fri, 17 Jul 2015 14:37:16 -0700
Message-ID: <55A9758C.4090600@gnu.org>
References: <559E9FA5.1090307@gnu.org> <2129979699.4572.1437162664096.JavaMail.open-xchange@ox1app> <55A96B38.7050103@gnu.org> <701123757.4784.1437167307775.JavaMail.open-xchange@ox1app>
Reply-To: bkorb-mXXj517/zsQ@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <701123757.4784.1437167307775.JavaMail.open-xchange@ox1app>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hagen Paul Pfeifer <hagen-GvnIQ6b/HdU@public.gmane.org>, DWARVES <dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: dwarves@vger.kernel.org

On 07/17/15 14:08, Hagen Paul Pfeifer wrote:
>> On July 17, 2015 at 10:53 PM Bruce Korb <bkorb-mXXj517/zsQ@public.gmane.org> wrote:
>>
>> Now that I've read the source, I don't know what to do.

> Can you post a minimal example and your exact build environment including
> compiler flags? This would speed up the process ...

Compiler flags?  Easy.  Minimal example?  Not so easy.  It's a 20KLOC program with lots of moving parts.
I tried pahole on all the .o and .a files (and .o files rolled into .a files), but the problems
rears it head only on the final executable.  If that means it is too hard, then it's too hard
and I'll have to forget about it and just say, "thank you for trying."

 >bash> cc -std=gnu99 -I. -Icommon/include -Ievt/include -Ifcd/include -Iftl/include -Iplatform/include \
	-Isch/include -Itests/include -MD -MP -MF_b/tests/main/dep-tests-opts.c -ggdb3 -gdwarf-2 -O0 \
	-DDEBUG_BUILD=1 -Wall -Werror -Wcast-align -Wpointer-arith -Wshadow -Wwrite-strings \
	-Wno-format-contains-nul -fno-strict-aliasing -Wstrict-aliasing=3 -Wextra -Wno-cast-qual \
	-Wmissing-prototypes -Wstrict-prototypes -o _b/tests/main/tests-opts.o -c tests/main/tests-opts.c
 >bash> cc -std=gnu99 -ggdb3 -gdwarf-2 -O0  -Wall -Werror -Wcast-align -Wpointer-arith \
	-Wshadow -Wwrite-strings -Wno-format-contains-nul -fno-strict-aliasing -Wstrict-aliasing=3 \
	-Wextra -Wno-cast-qual -fno-exceptions  -o _b/project_tests \
         _b/tests/main/test_registry.o _b/tests/main/tests.o _b/tests/main/tests_run.o \
	_b/tests/main/tests-opts.o _b/tests-common.a _b/tests-sch.a _b/tests-ftl.a \
	_b/libftl.a _b/sch-sim.a _b/sch-util.a _b/libevt.a _b/common.a _b/common-util.a \
	-lpthread -lopts -lffi

--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
