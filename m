From: Arnaldo Carvalho de Melo <acme-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: Brain fart alert
Date: Thu, 16 Aug 2012 16:52:24 -0300
Message-ID: <20120816195224.GC10277@infradead.org>
References: <CACHCVZ6oDyFwGbC4EwF_wsR9tCkoych5N6buLhRRLcyaL6iifw@mail.gmail.com>
 <20120815175647.GK2370@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120815175647.GK2370-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicolas <nikos42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Em Wed, Aug 15, 2012 at 02:56:47PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Sat, Jul 21, 2012 at 08:22:33PM +0200, Nicolas escreveu:
> > Hello,
> > 
> > I tried using pahole, but I get a brain fart alert with the file
> > attached (which is an extract from stdio.h). I'm running dwarves 1.10,
> > libdw1 0.152 and g++ 4.6.1, on i386.
> > 
> > Here is what I get:
> > 
> > $ g++ -Wall -g -c brainfart.cpp -o brainfart.o && pahole brainfart.o
> > class ios_base {
> > 	enum _Ios_Openmodeconst    in;                   /*     0     4 */
> > 	typedef enum _Ios_Fmtflags fmtflags;
> > 
> > 
> > 	/* size: 1, cachelines: 1, members: 1 */
> > 	/* padding: 65533 */
> > 	/* last cacheline: 1 bytes */
> > 
> > 	/* BRAIN FART ALERT! 1 != 4 + 0(holes), diff = -3 */
> > 
> > };
> > 
> > Moreover, on amd64, pahole segfaults if I do the same (with dwarves
> > 1.10, libdw1 0.152, g++ 4.6.3).
> 
> that is strange, I just tried it on rhel6, x86_64, and just reproduced
> what you describe on i386:
> 
> [acme@sandy pahole]$ uname -a
> Linux sandy.ghostprotocols.net 3.6.0-rc1+ #13 SMP Fri Aug 10 12:42:33 BRT 2012 x86_64 x86_64 x86_64 GNU/Linux
> [acme@sandy pahole]$ g++ -Wall -g -c brainfart.cpp -o brainfart.o && pahole brainfart.o
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

So the problem is that 'in' is (from the .cpp file):

static const _Ios_Openmode in = _S_in;

 <2><82>: Abbrev Number: 10 (DW_TAG_member)
    <83>   DW_AT_name        : in       
    <86>   DW_AT_decl_file   : 1        
    <87>   DW_AT_decl_line   : 15       
    <88>   DW_AT_type        : <0x9b>   
    <8c>   DW_AT_external    : 1        
    <8d>   DW_AT_declaration : 1        
    <8e>   DW_AT_const_value : 8

So 'in' type is...

 <1><9b>: Abbrev Number: 12 (DW_TAG_const_type)
    <9c>   DW_AT_type        : <0x49>

That links to:

 <2><49>: Abbrev Number: 3 (DW_TAG_enumeration_type)
    <4a>   DW_AT_name        : (indirect string, offset: 0xa9): _Ios_Openmode   
    <4e>   DW_AT_byte_size   : 4        
    <4f>   DW_AT_decl_file   : 1        
    <50>   DW_AT_decl_line   : 7        

So it thinks that the size is 4 bytes:

65533 == (unsigned short)((short)(1 - 4))

I need to capture the fact that it is a static const, and investigate
the C++ structure encoding rules, why is that it takes 1 byte when it
has no per instance members?

- Arnaldo
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
