From: Mark Wielaard <mjw-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Brain fart alert
Date: Mon, 20 Aug 2012 00:16:36 +0200
Message-ID: <20120819221636.GC19422@toonder.wildebeest.org>
References: <CACHCVZ6oDyFwGbC4EwF_wsR9tCkoych5N6buLhRRLcyaL6iifw@mail.gmail.com>
 <20120815175647.GK2370@infradead.org>
 <20120816195224.GC10277@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120816195224.GC10277-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnaldo Carvalho de Melo <acme-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: Nicolas <nikos42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

On Thu, Aug 16, 2012 at 04:52:24PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, Aug 15, 2012 at 02:56:47PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Sat, Jul 21, 2012 at 08:22:33PM +0200, Nicolas escreveu:
> So the problem is that 'in' is (from the .cpp file):
> 
> static const _Ios_Openmode in = _S_in;
> 
>  <2><82>: Abbrev Number: 10 (DW_TAG_member)
>     <83>   DW_AT_name        : in       
>     <86>   DW_AT_decl_file   : 1        
>     <87>   DW_AT_decl_line   : 15       
>     <88>   DW_AT_type        : <0x9b>   
>     <8c>   DW_AT_external    : 1        
>     <8d>   DW_AT_declaration : 1        
>     <8e>   DW_AT_const_value : 8

Although I cannot find it said explicitly in the DWARF spec I think
you can assume that any member with a const_value (and without a
data_member_location) doesn't occupy space.

> I need to capture the fact that it is a static const, and investigate
> the C++ structure encoding rules, why is that it takes 1 byte when it
> has no per instance members?

That is by definition in C++, in C it is a GNU extension to allow empty
structs. Depending on whether you compile an empty struct with gcc or g++
it will have a size on zero or one.
http://gcc.gnu.org/onlinedocs/gcc/Empty-Structures.html

Cheers,

Mark
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
