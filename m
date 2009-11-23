From: Arnaldo de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: pahole BRAIN FART ALERT on F12
Date: Mon, 23 Nov 2009 20:49:21 -0200
Message-ID: <20091123224921.GA9654@ghostprotocols.net>
References: <20091123221703.GA10860@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20091123221703.GA10860-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mike Snitzer <snitzer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Em Mon, Nov 23, 2009 at 05:17:03PM -0500, Mike Snitzer escreveu:
> Hi,
> 
> I just found out about pahole today.  I'm looking to audit lvm2's data
> structures and pahole is perfect for helping me do so.
> 
> Unfortunately, when I run pahole against lvm2 I'm getting many BRAIN
> FART ALERTs on F12 x86_64 (dwarves-1.7-5.x86_64).  I had a look at your
> OLS 2007 "7 dwarves" paper and figured I'd try your minimalist
> swiss_cheese example, this is what I get:
> 
> $ pahole swiss_cheese
> struct cheese {
>         char                       name[17];             /*     0    17 */
>         short int                  age;                  /*     0     2 */
>         char                       type;                 /*     0     1 */
>         int                        calories;             /*     0     4 */
>         short int                  price;                /*     0     2 */
>         int                        barcode[4];           /*     0    16 */
> 
>         /* size: 48, cachelines: 1, members: 6 */
>         /* padding: 32 */
>         /* last cacheline: 48 bytes */
> 
>         /* BRAIN FART ALERT! 48 != 17 + 0(holes), diff = 31 */
> 
> };
> 
> When I compare the above to the output listed in your paper it is clear
> pahole is pretty unhappy on F12.  If I do the same on F11 (x86_64) all
> works fine.
> 
> Should I open a fedora (F12) bug?

You should, I think this is related to some recent elfutils changes that
Mark Wieelard warned me about it but I hadn't time yet to act upon, will
do so tomorrow, thanks for the report!

Some milliseconds ago I was almost going to suggest you using the git
version, but then I realized this is too strange to seem like something
I could have fixed in the git repository :-\

That also should be another reason for me to do the f11->f12 step :-)

Thanks!

- Arnaldo
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
