From: Arnaldo Carvalho de Melo <acme-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: pahole DW_TAG_mutable_type
Date: Mon, 27 Apr 2015 21:45:50 -0300
Message-ID: <20150428004550.GG16849@kernel.org>
References: <CA+E_MsxY9sC2Eh2gSx5U1z7Ay-nPOnC3ZraaLzcopkSvwX6MJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CA+E_MsxY9sC2Eh2gSx5U1z7Ay-nPOnC3ZraaLzcopkSvwX6MJg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Cody Schafer <cody-QpQMm/NnEELQT0dZR+AlfA@public.gmane.org>
Cc: "Elliott, Robert (Server Storage)" <Elliott-VXdhtT5mjnY@public.gmane.org>, dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Em Mon, Apr 27, 2015 at 07:47:02PM -0400, Cody Schafer escreveu:
> On Mon, Apr 27, 2015 at 12:25 PM, Elliott, Robert (Server Storage)
> <Elliott-VXdhtT5mjnY@public.gmane.org> wrote:
> >
> > Recent versions of libdwarves have removed DW_TAG_mutable_type, which
> > affects dwarves_fprintf.c.
> >                 http://www.spinics.net/lists/dwarves/msg00121.html

This line you refer to doesn't remove DW_TAG_mutable_type, it removes a
line that references it.

> > This causes an error building pahole, which has a copy of dwarves_fprintf.c:
> >
> >
> > [  8%] Building C object CMakeFiles/dwarves.dir/dwarves_fprintf.o
> > /home/orange/sw/pahole/dwarves_fprintf.c:77:3: error: 'DW_TAG_mutable_type' undeclared here (not in a function)
> >   [DW_TAG_mutable_type]    = "mutable_type",
> >    ^

Not really, the problem lies elsewhere, i.e. DW_TAG_mutable_type not
being defined, Mark's solution was to just remove the only reference we
had to it, in dwarves_fprintf.c

> > /home/orange/sw/pahole/dwarves_fprintf.c:77:2: error: array index in initializer not of integer type
> >   [DW_TAG_mutable_type]    = "mutable_type",
> >   ^
> > /home/orange/sw/pahole/dwarves_fprintf.c:77:2: error: (near initialization for 'dwarf_tag_names')
> > make[2]: *** [CMakeFiles/dwarves.dir/dwarves_fprintf.o] Error 1
> >
> >
> > Deleting that line seems to fix the problem.

So yes, what you did seems to be what is required.
 
> I'm not upstream, I'm just some guy with a github repo of pahole :)

Are there any outstanding patches in your repo that you think I should
pull?
 
> Redirecting this to the right mailing list, might already be fixed
> upstream (https://git.kernel.org/cgit/devel/pahole/pahole.git), I
> haven't checked.
> 
> Probably a good idea to add the mailing list (and git url) to the
> README to make it more discover-able for folks that find the source
> code in other places.

Right, will try and do this tomorrow, make sure the github repo is in
synch with the kernel.org one, etc.

- Arnaldo
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
