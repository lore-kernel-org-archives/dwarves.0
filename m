From: Arnaldo Carvalho de Melo <acme-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: Brain fart alert
Date: Wed, 15 Aug 2012 14:56:47 -0300
Message-ID: <20120815175647.GK2370@infradead.org>
References: <CACHCVZ6oDyFwGbC4EwF_wsR9tCkoych5N6buLhRRLcyaL6iifw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CACHCVZ6oDyFwGbC4EwF_wsR9tCkoych5N6buLhRRLcyaL6iifw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicolas <nikos42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Em Sat, Jul 21, 2012 at 08:22:33PM +0200, Nicolas escreveu:
> Hello,
> 
> I tried using pahole, but I get a brain fart alert with the file
> attached (which is an extract from stdio.h). I'm running dwarves 1.10,
> libdw1 0.152 and g++ 4.6.1, on i386.
> 
> Here is what I get:
> 
> $ g++ -Wall -g -c brainfart.cpp -o brainfart.o && pahole brainfart.o
> class ios_base {
> 	enum _Ios_Openmodeconst    in;                   /*     0     4 */
> 	typedef enum _Ios_Fmtflags fmtflags;
> 
> 
> 	/* size: 1, cachelines: 1, members: 1 */
> 	/* padding: 65533 */
> 	/* last cacheline: 1 bytes */
> 
> 	/* BRAIN FART ALERT! 1 != 4 + 0(holes), diff = -3 */
> 
> };
> 
> Moreover, on amd64, pahole segfaults if I do the same (with dwarves
> 1.10, libdw1 0.152, g++ 4.6.3).

that is strange, I just tried it on rhel6, x86_64, and just reproduced
what you describe on i386:

[acme@sandy pahole]$ uname -a
Linux sandy.ghostprotocols.net 3.6.0-rc1+ #13 SMP Fri Aug 10 12:42:33 BRT 2012 x86_64 x86_64 x86_64 GNU/Linux
[acme@sandy pahole]$ g++ -Wall -g -c brainfart.cpp -o brainfart.o && pahole brainfart.o
class ios_base {
	enum _Ios_Openmodeconst    in;                   /*     0     4 */
	typedef enum _Ios_Fmtflags fmtflags;


	/* size: 1, cachelines: 1, members: 1 */
	/* padding: 65533 */
	/* last cacheline: 1 bytes */

	/* BRAIN FART ALERT! 1 != 4 + 0(holes), diff = -3 */

};
[acme@sandy pahole]$ file brainfart.o
brainfart.o: ELF 64-bit LSB relocatable, x86-64, version 1 (SYSV), not stripped
[acme@sandy pahole]$

will try to fix this on the plane later today,

thanks for reporting and sorry for the late response,

- Arnaldo
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
