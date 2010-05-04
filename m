From: Arnaldo Carvalho de Melo <acme-f8uhVLnGfZaxAyOMLChx1axOck334EZe@public.gmane.org>
Subject: Re: [PATCH] pfunct: Introduced --all/-A
Date: Tue, 4 May 2010 13:18:03 -0300
Message-ID: <20100504161803.GD970@ghostprotocols.net>
References: <g2wb401d2531004050031q14f3fb12y39f4e7b0316526c0@mail.gmail.com>
 <l2nb401d2531005032356q9d0e569fh6f69d57e9f5784e6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <l2nb401d2531005032356q9d0e569fh6f69d57e9f5784e6-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rakesh Pandit <rakesh.pandit-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Em Tue, May 04, 2010 at 12:26:52PM +0530, Rakesh Pandit escreveu:
> On 5 April 2010 13:01, Rakesh Pandit <rakesh.pandit-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > Hello,
> >
> > I have a request for enhancement (new option in pfunct) via which I
> > want pfunct to print signatures for all symbols in one go. To add to
> > it and as expected I want source code information per symbol if -l
> > option is specified.
> >
> 
> ping for review ?

Isn't:

pfunct -V ~/bin/perf | grep \;$

equivalent?

Perhaps have a new flag to ask that no C comment like lines be issued?

so it would be:

pfunct -V --no-comments objfile

But ok, I'll add a '-P'/'--prototypes' option for that.

- Arnaldo
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
