From: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: pahole displays type incorrectly
Date: Sat, 12 Sep 2009 10:24:05 -0300
Message-ID: <20090912132405.GB3545@ghostprotocols.net>
References: <alpine.LSU.2.00.0908171610490.31821@fbirervta.pbzchgretzou.qr> <20090817154228.GI12303@ghostprotocols.net> <20090910203517.GA2289@ghostprotocols.net> <alpine.LSU.2.00.0909120340020.444@obet.zrqbmnf.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.00.0909120340020.444-SHaQjdQMGhDmsUXKMKRlFA@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jan Engelhardt <jengelh-nopoi9nDyk+ELgA04lAiVw@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Em Sat, Sep 12, 2009 at 03:41:56AM +0200, Jan Engelhardt escreveu:
> 
> On Thursday 2009-09-10 22:35, Arnaldo Carvalho de Melo wrote:
> >
> >Sorry for the delay, should be fixed by the latest commit, please give
> >it a try!
> >
> >http://git.kernel.org/?p=linux/kernel/git/acme/pahole.git;a=commitdiff;h=846927a3f87f730e0ae201b5f0b3b46212a7bb8e
> 
> Yes it does work. The testcase seems to be reducable to just the
> struct without a function, but still with a non-static definition
> (instance) of the struct. I.e. on the file level:
> 
> struct foo {
> 	const char *const z;
> };
> struct foo x;

Thanks for testing! I'll update the test case to reduce it.

- Arnaldo
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
