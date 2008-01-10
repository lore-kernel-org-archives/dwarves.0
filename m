From: jamal <hadi-fAAogVwAN2Kw5LPnMra/2Q@public.gmane.org>
Subject: eat your own dog food?
Date: Thu, 10 Jan 2008 07:42:48 -0500
Message-ID: <1199968968.4438.49.camel@localhost>
Reply-To: hadi-fAAogVwAN2Kw5LPnMra/2Q@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org


Hey Arnaldo,

You ever tasted what you are cooking?;->

---
hadi@lilsol:~/git-trees/arnaldo/jamal/build$ pahole ./pahole| grep XXX
        /* XXX last struct has 1 byte of padding */
        /* XXX 1 bit hole, try to pack */
        /* XXX 1 byte hole, try to pack */
        /* XXX 2 bytes hole, try to pack */
        /* XXX 2 bits hole, try to pack */
        /* XXX 1 byte hole, try to pack */
        /* XXX last struct has 2 bytes of padding */
        /* XXX 1 byte hole, try to pack */
hadi@lilsol:~/git-trees/arnaldo/jamal/build$
---

On a serious note, feature request:

I am trying to put words to what i am looking for and it's a little hard
without providing a lot of boring context. For brevity, lets say i have
an inherited 500K lines of code. Assume i compiled a program for 32-bit
target and now i have to move it to a 128-bit playstation 3 with
whatever strange alignment rules. 
I want to do achieve 2 and a half things:

a) 
i) check the structure for holes for X-bit access alignment where X is
16 (old 680xx), 64, 128. I want to do this without compiling the program
for any of those targets i.e i want to do this on my x86 32-bit
laptop ;-> i.e call this cross-pahole

ii) If i can do the above; i should then be able to say "optimize" (what
you call --reorganize) for X-bit

b) I want to do a multiple of these example "optimize for 32-bit and
64-bit" or "check if it is safe for 128-bit and 16-bit alignemnt"

Note, clearly if i can make it read config files with rules for
something like the MIPS EABI in the first part of this email:
 http://sourceware.org/ml/binutils/2003-06/msg00436.html
then i can say "check if it safe for mips 32 bit and x86_64" ;->
And i can make sure my apps will run on that new cpu i dont have access
to.

I could ask for more, but let me start/stop here incase you are going to
lynch me;->

cheers,
jamal

-
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
