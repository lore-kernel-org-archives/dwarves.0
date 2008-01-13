From: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Changing the word-size was: Re: eat your own dog food?
Date: Sun, 13 Jan 2008 16:07:30 -0200
Message-ID: <20080113180730.GG17675@ghostprotocols.net>
References: <1200001276.4443.40.camel@localhost> <20080112152109.GA23567@ghostprotocols.net> <20080112155404.GB23567@ghostprotocols.net> <20080112162808.GC23567@ghostprotocols.net> <20080112172856.GD23567@ghostprotocols.net> <1200161321.31540.10.camel@localhost> <20080112184211.GA17675@ghostprotocols.net> <1200184926.31540.13.camel@localhost> <1200186955.31540.26.camel@localhost> <20080113163106.GE17675@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080113163106.GE17675-f8uhVLnGfZaxAyOMLChx1axOck334EZe@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jamal <hadi-fAAogVwAN2Kw5LPnMra/2Q@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Em Sun, Jan 13, 2008 at 02:31:06PM -0200, Arnaldo Carvalho de Melo escreveu:
> Em Sat, Jan 12, 2008 at 08:15:55PM -0500, jamal escreveu:
> > On Sat, 2008-12-01 at 19:42 -0500, jamal wrote:
> > 
> > In this case the tail padding should be 7.
> > 
> > The rules say:
> > 1) aggregates have alignment equal to that of their most aligned
> >   member - which happens to be 8 above
> > 2) aggregates have sizes which are a multiple of their alignment
> >   This may result in tail padding - the tail contains a char.
> > 
> > So the padding above should be 7.
> 
> Working on that, implementing type__most_aligned_member(), that will
> recursively find the member that is most aligned, but then how to deal
> with packed structs?

Should be fixed now for non-packed structs, please ACK.

Regards,

- Arnaldo
-
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
