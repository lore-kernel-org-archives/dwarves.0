From: Arnaldo de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: pahole BRAIN FART ALERT on F12
Date: Tue, 24 Nov 2009 12:52:12 -0200
Message-ID: <20091124145212.GC9654@ghostprotocols.net>
References: <20091123221703.GA10860@redhat.com> <20091123224921.GA9654@ghostprotocols.net> <20091123225615.GD10860@redhat.com> <20091124001047.GF15547@ghostprotocols.net> <20091124132831.GA31662@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20091124132831.GA31662-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mike Snitzer <snitzer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Em Tue, Nov 24, 2009 at 08:28:31AM -0500, Mike Snitzer escreveu:
> On Mon, Nov 23 2009 at  7:10pm -0500,
> Arnaldo de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> > Em Mon, Nov 23, 2009 at 05:56:15PM -0500, Mike Snitzer escreveu:
> > > On Mon, Nov 23 2009 at  5:49pm -0500,
> > > Arnaldo de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> > > > Em Mon, Nov 23, 2009 at 05:17:03PM -0500, Mike Snitzer escreveu:
> > > > > Unfortunately, when I run pahole against lvm2 I'm getting many BRAIN
> > > > > FART ALERTs on F12 x86_64 (dwarves-1.7-5.x86_64).  I had a look at your
> > > > > OLS 2007 "7 dwarves" paper and figured I'd try your minimalist
> > > > > swiss_cheese example, this is what I get:
> > > > > $ pahole swiss_cheese
> > > > > struct cheese {
> > > > >         char                       name[17];             /*     0    17 */
> > > > >         short int                  age;                  /*     0     2 */
> > > > >         char                       type;                 /*     0     1 */
> > <SNIP>
> > > > >         /* BRAIN FART ALERT! 48 != 17 + 0(holes), diff = 31 */
> > > > > };
> > > > You should, I think this is related to some recent elfutils changes that
> > > > Mark Wieelard warned me about it but I hadn't time yet to act upon, will
> > > > do so tomorrow, thanks for the report!
> >  
> > > BTW, I did try the latest git version from:
> > > git://git.kernel.org/pub/scm/linux/kernel/git/acme/pahole.git
> > > It didn't work either.
> > 
> > Can you try with the attached patch applied against the git repo
> > version?
> 
> Works great, thanks!
> 
> Would you still like me to file an F12 bug?

Please, as I'll have to go the process for updating the package... :-)

- Arnaldo
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
