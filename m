From: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: pahole displays type incorrectly
Date: Fri, 11 Sep 2009 01:54:14 -0300
Message-ID: <20090911045414.GA6927@ghostprotocols.net>
References: <alpine.LSU.2.00.0908171610490.31821@fbirervta.pbzchgretzou.qr> <20090817154228.GI12303@ghostprotocols.net> <20090910203517.GA2289@ghostprotocols.net> <20090910222256.GB2289@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090910222256.GB2289-f8uhVLnGfZaxAyOMLChx1axOck334EZe@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jan Engelhardt <jengelh-nopoi9nDyk+ELgA04lAiVw@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Em Thu, Sep 10, 2009 at 07:22:56PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Thu, Sep 10, 2009 at 05:35:17PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > So if we find a const at the start of the chain, we must render it
> > > first, then the type, but if we find it inside the chain, it has to be
> > > rendered at the end of the chain... I'm reworking the code that
> > > recursively traverses the chain to fix this, but I'm being sidetracked
> > > with some other work, stay tuned and I'll get this fixed today
> > > 
> > > Thanks for the report!
> > 
> > Sorry for the delay, should be fixed by the latest commit, please give
> > it a try!
> > 
> > http://git.kernel.org/?p=linux/kernel/git/acme/pahole.git;a=commitdiff;h=846927a3f87f730e0ae201b5f0b3b46212a7bb8e
> 
> Bogus patch, right fix should come soon.

Please do a git pull and see if it now works properly.

Thanks,

- Arnaldo
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
