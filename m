From: jamal <hadi-fAAogVwAN2Kw5LPnMra/2Q@public.gmane.org>
Subject: Re: eat your own dog food?
Date: Thu, 10 Jan 2008 19:45:51 -0500
Message-ID: <1200012351.4467.16.camel@localhost>
References: <1199968968.4438.49.camel@localhost>
	 <20080110133926.GF22437@ghostprotocols.net>
	 <1199973341.4438.56.camel@localhost>
	 <20080110140635.GG22437@ghostprotocols.net>
	 <20080110163959.GJ22437@ghostprotocols.net>
	 <1200001034.4443.35.camel@localhost>
	 <20080110214438.GT22437@ghostprotocols.net>
Reply-To: hadi-fAAogVwAN2Kw5LPnMra/2Q@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080110214438.GT22437-f8uhVLnGfZaxAyOMLChx1axOck334EZe@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

On Thu, 2008-10-01 at 19:44 -0200, Arnaldo Carvalho de Melo wrote:


> good data point from you, that your laptop is 32 bits, I'll implement
> the small -> big transition now.

I'll take either incremental or full patch including one you sent
earlier.
 
Btw, thinking about this a little more, it may be trickier than i
thought initially and will have to including eabi considerations even
in the case of two machines of equivalent bit width. Tell me if i am bad
crack:

Consider ia32 and MIPS 32 bit (as per eabi defined here
http://sourceware.org/ml/binutils/2003-06/msg00436.html) 

consider this:

typedef unsigned int __u32;
typedef unsigned long long __u64;
struct tc_stats
{
  __u64 bytes; 
  __u32 packets;
  __u32 drops;                 
  __u32 overlimits; 
  __u32 bps;        
  __u32 pps;
  __u32 qlen;
  __u32 backlog;
};

On mips:
sizeof (struct tc_stats) == 40 and it is aligned 8 

On my laptop:
sizeof (struct tc_stats) == 36 aligned at 4

The mips alignment explains the padding because long long is
8-byte aligned.

i.e eventually you may need to have an eabi file per architecture

cheers,
jamal

-
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
