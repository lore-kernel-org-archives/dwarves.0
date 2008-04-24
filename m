From: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: "File has no CTF section."
Date: Thu, 24 Apr 2008 12:56:48 -0300
Message-ID: <20080424155648.GE27147@ghostprotocols.net>
References: <20080325152403.GK3247@iris.iucha.org> <20080325164103.GC22421@ghostprotocols.net> <20080325172413.GN3247@iris.iucha.org> <20080325175749.GE22421@ghostprotocols.net> <20080424152511.GB19740@iris.iucha.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080424152511.GB19740-8+3tsXFunua1C7ntjtBYng@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Florin Iucha <florin-zX39fKdjKLBeoWH0uzbU5w@public.gmane.org>
Cc: Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Em Thu, Apr 24, 2008 at 10:25:11AM -0500, Florin Iucha escreveu:
> On Tue, Mar 25, 2008 at 02:57:49PM -0300, Arnaldo Carvalho de Melo wrote:
> > > See the attached file.  If you just compile it with 'gcc -g -c hello.c',
> > > pahole works fine on the resulting object file.  If at line 17 you change
> > > '#if 0' to '#if 1', pahole will complain about the lack of CTF (sorry,
> > > I didn't have time to pull your updates).
> > 
> > ACK, reproduced here, will investigate, strange indeed.
> 
> Pinnnggg!

Poooong, sorry for the delay, will try again to fix this today.

- Arnaldo
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
